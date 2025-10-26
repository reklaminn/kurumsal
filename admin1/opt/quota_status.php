<?php
// /admin/opt/quota_status.php
header('Content-Type: application/json; charset=utf-8');

$CENTRAL = 'https://ai.cloudgrafike.com/aiassistant/src/quota_summary.php';
$domain  = $_GET['domain'] ?? ($_SERVER['HTTP_HOST'] ?? '');
$domain  = preg_replace('~^www\.~','',$domain);

$qs = http_build_query(['domain'=>$domain]);
$ch = curl_init($CENTRAL.'?'.$qs);
curl_setopt_array($ch, [
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_CONNECTTIMEOUT => 8,
  CURLOPT_TIMEOUT        => 12,
]);
$resp = curl_exec($ch);
$http = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$err  = curl_error($ch);
curl_close($ch);

if ($resp===false || $http>=400) {
  http_response_code(502);
  echo json_encode(['error'=>'central_unreachable','detail'=>$err, 'http'=>$http]);
  exit;
}
echo $resp;
