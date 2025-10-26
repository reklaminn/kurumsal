<?php
header('Content-Type: application/json; charset=utf-8');
$CENTRAL_URL = 'https://ai.cloudgrafike.com/aiassistant/src/assistant_task.php';
$TIMEOUT=120; $MAX_BODY=1024*1024*2;
$raw=file_get_contents('php://input', false, null, 0, $MAX_BODY+1);
if($raw===false){ http_response_code(400); echo json_encode(['error'=>'Empty body']); exit; }
if(strlen($raw)>$MAX_BODY){ http_response_code(413); echo json_encode(['error'=>'Payload Too Large']); exit; }
$body=json_decode($raw,true); if(!is_array($body)){ http_response_code(400); echo json_encode(['error'=>'Invalid JSON']); exit; }
$allowed=['translate_text','rewrite_html_seo','translate_map','analyze_seo_url','generate_blog'];
if(!isset($body['task']) || !in_array($body['task'],$allowed,true)){ http_response_code(400); echo json_encode(['error'=>'Unknown or disallowed task']); exit; }
$host=$_SERVER['HTTP_HOST']??'unknown';
$ch=curl_init($CENTRAL_URL);
curl_setopt_array($ch,[CURLOPT_RETURNTRANSFER=>true,CURLOPT_HTTPHEADER=>['Content-Type: application/json','X-Client-Domain: '.$host],CURLOPT_POST=>true,CURLOPT_POSTFIELDS=>json_encode($body, JSON_UNESCAPED_UNICODE),CURLOPT_TIMEOUT=>$TIMEOUT,CURLOPT_CONNECTTIMEOUT=>10]);
$resp=curl_exec($ch); $http=curl_getinfo($ch,CURLINFO_HTTP_CODE); $err=curl_error($ch); curl_close($ch);
if($resp===false){ http_response_code(502); echo json_encode(['error'=>'Upstream error','detail'=>$err]); exit; }
http_response_code($http?:200); echo $resp;
?>