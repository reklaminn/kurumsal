<?php
/**
 * /admin/opt/proxy_assistant.php
 *
 * - Merkezi assistant_task’a forward eder (tek RTT).
 * - Domain bazlı AYARLARI merkezden çeker: https://ai.cloudgrafike.com/aiassistant/src/logs/{domain}/proxy.config.json
 *   * 5 dk TTL + ETag ile lokal cache.
 * - Aylık sayaç (normal 10, lite 100): LOKALDE karar verir ve aiLite=0/1 enjekte eder.
 * - 2xx yanıtta LOKAL sayaç artırılır.
 * - Merkeze header’lar: X-Client-Domain, X-Quota-Mode, X-Usage-Record: 1
 */

header('Content-Type: application/json; charset=utf-8');

// === Sabitler ===
$CENTRAL_URL   = 'https://ai.cloudgrafike.com/aiassistant/src/assistant_task.php';
$CFG_TTL_SEC   = 300;                 // konfig cache TTL (5 dk)
$DEF_TIMEOUT   = 120;                 // sn (merkez çağrısı)
$DEF_MAX_BODY  = 2 * 1024 * 1024;     // 2MB (ilk okuma limiti)
$DEF_NORMAL    = 9999;                  // normal limit
$DEF_LITE      = 50;                 // lite limit

// === Yardımcılar ===
function jres($arr, $code=200){
  http_response_code($code);
  echo json_encode($arr, JSON_UNESCAPED_UNICODE);
  exit;
}
function sanitize_domain($h){
  $h = strtolower(trim((string)$h));
  $h = preg_replace('~^https?://~','',$h);
  $h = preg_replace('~/.*$~','',$h);
  $h = preg_replace('~^www\.~','',$h);
  $h = preg_replace('~[^a-z0-9\.\-]~','',$h);
  return $h ?: 'unknown';
}
function mkdirp($dir){ return is_dir($dir) ? true : @mkdir($dir, 0775, true); }
function now_ym(){ return gmdate('Y-m'); }

// cURL GET (headers almak için; header+body’yi en sondan ayır)
function curl_get_with_headers($url, $headers = [], $timeout = 15){
  $ch = curl_init($url);
  curl_setopt_array($ch, [
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_TIMEOUT        => $timeout,
    CURLOPT_CONNECTTIMEOUT => 10,
    CURLOPT_FOLLOWLOCATION => true,
    CURLOPT_HEADER         => true, // body + headers birlikte
    CURLOPT_HTTPHEADER     => $headers,
  ]);
  $resp = curl_exec($ch);
  $http = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  $err  = curl_error($ch);
  curl_close($ch);
  if ($resp === false) return [0, '', [], $err];

  // Header ve body’yi en sondaki boş satırdan ayır (redirect durumunda birden fazla header gelebilir)
  $pos = strrpos($resp, "\r\n\r\n");
  if ($pos === false) return [$http, $resp, [], $err];
  $rawHeaders = substr($resp, 0, $pos);
  $body       = substr($resp, $pos + 4);

  // Sondaki header bloğunu al
  $blocks = preg_split("/\r\n\r\n/", $rawHeaders);
  $lastHeader = end($blocks);
  $harr = [];
  foreach (explode("\r\n", $lastHeader) as $line) {
    $p = strpos($line, ':');
    if ($p !== false) {
      $k = strtolower(trim(substr($line, 0, $p)));
      $v = trim(substr($line, $p+1));
      $harr[$k] = $v;
    }
  }
  return [$http, $body, $harr, $err];
}

// cURL POST JSON
function curl_post_json($url, $payload, $headers = [], $timeout = 120){
  $ch = curl_init($url);
  curl_setopt_array($ch, [
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_POST           => true,
    CURLOPT_HTTPHEADER     => array_merge(['Content-Type: application/json'], $headers),
    CURLOPT_POSTFIELDS     => json_encode($payload, JSON_UNESCAPED_UNICODE),
    CURLOPT_TIMEOUT        => $timeout,
    CURLOPT_CONNECTTIMEOUT => 10,
  ]);
  $resp = curl_exec($ch);
  $http = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  $err  = curl_error($ch);
  curl_close($ch);
  return [$http, $resp, $err];
}

// === İstek gövdesini al (ön limit) ===
$raw = file_get_contents('php://input', false, null, 0, $DEF_MAX_BODY+1);
if ($raw === false) jres(['error'=>'Empty body'], 400);
if (strlen($raw) > $DEF_MAX_BODY) jres(['error'=>'Payload Too Large (pre-limit)'], 413);
$body = json_decode($raw, true);
if (!is_array($body)) jres(['error'=>'Invalid JSON'], 400);

// === Görev doğrulama ===
$allowed = ['translate_text','rewrite_html_seo','translate_map','analyze_seo_url','generate_blog','generate_seo_content','tiny_ai','change_tone','freeform_edit','change_style','summarize_content','improve_writing','simplify_language','expand_upon','trim_content'];
if (!isset($body['task']) || !in_array($body['task'], $allowed, true)) {
  jres(['error'=>'Unknown or disallowed task'], 400);
}

// === Domain tespiti ===
$origin = $_SERVER['HTTP_ORIGIN'] ?? '';
$ref    = $_SERVER['HTTP_REFERER'] ?? '';
$host   = $_SERVER['HTTP_HOST'] ?? 'localhost';
$fromDomain = $origin ? sanitize_domain($origin) : ($ref ? sanitize_domain($ref) : sanitize_domain($host));

// === Lokal cache & sayaç dizinleri (proxy tarafında) ===
$baseDir   = __DIR__ . '/cache';
$domDir    = $baseDir . '/' . $fromDomain;
$cfgCache  = $domDir . '/proxy.config.cache.json'; // {fetched_at, etag, data:{...}}
$quotaDir  = $domDir . '/quotas';
mkdirp($domDir);
mkdirp($quotaDir);

// === Konfigi merkezden (TTL + ETag) çek veya cache kullan ===
$cfgUrl = 'https://ai.cloudgrafike.com/aiassistant/src/logs/' . $fromDomain . '/proxy.config.json';
$cfg = ['TIMEOUT'=>$DEF_TIMEOUT, 'MAX_BODY'=>$DEF_MAX_BODY, 'NORMAL_LIMIT'=>$DEF_NORMAL, 'LITE_LIMIT'=>$DEF_LITE];

$needFetch = true;
$etag = null;
$cacheState = 'miss';
if (is_file($cfgCache)) {
  $cached = json_decode(@file_get_contents($cfgCache), true);
  if (is_array($cached) && isset($cached['fetched_at'], $cached['data'])) {
    $age = time() - (int)$cached['fetched_at'];
    if ($age < $CFG_TTL_SEC) {
      $cfg = array_merge($cfg, (array)$cached['data']);
      $etag = $cached['etag'] ?? null;
      $needFetch = false;
      $cacheState = 'hit';
    } else {
      $etag = $cached['etag'] ?? null;
      $cacheState = 'stale';
    }
  }
}
if ($needFetch) {
  $headers = [];
  if ($etag) $headers[] = 'If-None-Match: ' . $etag;
  list($h, $b, $hs, $e) = curl_get_with_headers($cfgUrl, $headers, 12);
  if ($h === 200 && $b) {
    $dec = json_decode($b, true);
    if (is_array($dec)) {
      $cfg = array_merge($cfg, $dec);
      $newEtag = $hs['etag'] ?? null;
      @mkdir($domDir, 0775, true);
      @file_put_contents($cfgCache, json_encode(['fetched_at'=>time(),'etag'=>$newEtag,'data'=>$cfg], JSON_UNESCAPED_UNICODE), LOCK_EX);
      $cacheState = 'refreshed';
    }
  } elseif ($h === 304 && is_file($cfgCache)) {
    $cached = json_decode(@file_get_contents($cfgCache), true);
    if (is_array($cached)) {
      $cached['fetched_at'] = time();
      @file_put_contents($cfgCache, json_encode($cached, JSON_UNESCAPED_UNICODE), LOCK_EX);
      $cfg = array_merge($cfg, (array)$cached['data']);
      $cacheState = 'revalidated';
    }
  } else {
    // Merkeze ulaşılamadıysa ve cache varsa onu kullanmaya devam
    if (is_file($cfgCache)) {
      $cached = json_decode(@file_get_contents($cfgCache), true);
      if (is_array($cached) && isset($cached['data'])) {
        $cfg = array_merge($cfg, (array)$cached['data']);
        $cacheState = 'stale-fallback';
      }
    }
  }
}
header('X-Config-Cache: '.$cacheState);

// Etkin limitler
$TIMEOUT      = (int)($cfg['TIMEOUT'] ?? $DEF_TIMEOUT);
$MAX_BODY     = (int)($cfg['MAX_BODY'] ?? $DEF_MAX_BODY);
$NORMAL_LIMIT = (int)($cfg['NORMAL_LIMIT'] ?? $DEF_NORMAL);
$LITE_LIMIT   = (int)($cfg['LITE_LIMIT'] ?? $DEF_LITE);

// Son kez gövde boyutu kontrol (config daha düşük olabilir)
if (strlen($raw) > $MAX_BODY) jres(['error'=>'Payload Too Large'], 413);

// === Aylık sayaç dosyası (proxy yerel) ===
$month       = now_ym();
$counterFile = $quotaDir . '/' . $month . '.json';
$quota = ['month'=>$month,'normal_used'=>0,'lite_used'=>0];
if (is_file($counterFile)) {
  $q = json_decode(@file_get_contents($counterFile), true);
  if (is_array($q) && ($q['month'] ?? '') === $month) $quota = array_merge($quota, $q);
}

// === Mod seçimi ===
if ($quota['normal_used'] < $NORMAL_LIMIT) {
  $mode = 'normal';
} else if ($quota['lite_used'] < $LITE_LIMIT) {
  $mode = 'lite';
} else {
  header('X-Quota-Mode: blocked');
  header('X-Quota-Month: ' . $month);
  header('X-Quota-Normal: ' . $quota['normal_used'] . '/' . $NORMAL_LIMIT);
  header('X-Quota-Lite: '   . $quota['lite_used']   . '/' . $LITE_LIMIT);
  jres([
    'error'=>'quota_exceeded',
    'domain'=>$fromDomain,
    'month'=>$month,
    'limits'=>['normal'=>$NORMAL_LIMIT,'lite'=>$LITE_LIMIT],
    'usage'=>['normal'=>$quota['normal_used'],'lite'=>$quota['lite_used']],
    'message'=>'Aylık kota aşıldı: önce normal(10), sonra lite(100).'
  ], 429);
}

// İstemci yollasa bile, aiLite kararını proxy verir
$body['aiLite'] = ($mode === 'lite') ? '1' : '0';

// === Merkeze tek POST ===
$headers = [
  'X-Client-Domain: ' . $fromDomain,
  'X-Quota-Mode: ' . $mode,
  'X-Usage-Record: 1',
];

list($http, $resp, $err) = curl_post_json($CENTRAL_URL, $body, $headers, $TIMEOUT);

// Bilgi headerları
header('X-Quota-Mode: ' . $mode);
header('X-Quota-Month: ' . $month);
header('X-Quota-Normal: ' . $quota['normal_used'] . '/' . $NORMAL_LIMIT);
header('X-Quota-Lite: '   . $quota['lite_used']   . '/' . $LITE_LIMIT);

// Hata?
if (!is_string($resp)) jres(['error'=>'Upstream error','detail'=>$err ?: 'bad upstream'], 502);

// 2xx ise sayaç artır ve kaydet
if ($http >= 200 && $http < 300) {
  if ($mode === 'normal') $quota['normal_used']++;
  else $quota['lite_used']++;
  @file_put_contents($counterFile, json_encode($quota, JSON_UNESCAPED_UNICODE), LOCK_EX);
}

// Proxy yanıtı aynen geçir
http_response_code($http ?: 200);
echo $resp;
