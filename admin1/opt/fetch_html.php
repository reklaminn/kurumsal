<?php
// admin/opt/fetch_html.php
// Basit HTML fetch proxy (CORS yok, timeout kısa, boyut limiti var)

header('Content-Type: application/json; charset=utf-8');

try {
  $raw = file_get_contents('php://input');
  $in  = json_decode($raw, true);
  if (!is_array($in) || empty($in['url'])) {
    http_response_code(400);
    echo json_encode(['ok'=>false,'error'=>'url_required']); exit;
  }
  $url = (string)$in['url'];

  // Sadece http/https izin ver
  if (!preg_match('~^https?://~i', $url)) {
    http_response_code(400);
    echo json_encode(['ok'=>false,'error'=>'unsupported_scheme']); exit;
  }

  // cURL
  $ch = curl_init($url);
  curl_setopt_array($ch, [
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_FOLLOWLOCATION => true,
    CURLOPT_MAXREDIRS      => 5,
    CURLOPT_CONNECTTIMEOUT => 8,
    CURLOPT_TIMEOUT        => 12, // kısa tut
    CURLOPT_USERAGENT      => 'AI-SEO-Crawler/1.0 (+compatible)',
    CURLOPT_HEADER         => true, // header+body birlikte al
  ]);
  $resp = curl_exec($ch);
  $http = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  $err  = curl_error($ch);
  $ct   = curl_getinfo($ch, CURLINFO_CONTENT_TYPE);
  $hsz  = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
  curl_close($ch);

  if ($resp === false || $http >= 400) {
    http_response_code(502);
    echo json_encode(['ok'=>false,'error'=>$err?:('HTTP '.$http)]); exit;
  }

  $headers = substr($resp, 0, $hsz);
  $body    = substr($resp, $hsz);

  // Boyut limiti (ör: 700KB)
  $MAX = 700 * 1024;
  if (strlen($body) > $MAX) {
    // JSON-LD’yi kaçırmamak için kesmeden önce olduğu gibi döndürmek de bir seçenek.
    // İstersen sadece kıs: $body = substr($body, 0, $MAX);
    http_response_code(413);
    echo json_encode(['ok'=>false,'error'=>'page_too_large','bytes'=>strlen($body)]); exit;
  }

  echo json_encode([
    'ok'            => true,
    'status'        => $http,
    'content_type'  => $ct,
    'bytes'         => strlen($body),
    'html'          => $body
  ], JSON_UNESCAPED_UNICODE);

} catch (Throwable $e) {
  http_response_code(500);
  echo json_encode(['ok'=>false,'error'=>'internal','detail'=>$e->getMessage()]);
}
