<?php
putenv("PATH=C:\\Users\\Administrator\\AppData\\Roaming\\npm;" . getenv("PATH"));
$protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? "https://" : "http://";
$host = $_SERVER['HTTP_HOST'];
$baseUrl = $protocol . $host;
// JSON post verisini al
$data = json_decode(file_get_contents("php://input"), true);

// Gerekli alanları kontrol et
if (!isset($data['url']) || !isset($data['ekad'])) {
    http_response_code(400);
    echo json_encode(["error" => "url and ekad fields are required."]);
    exit;
}

// Güvenli parametreler
$url = trim($data['url']);
$ekad = preg_replace('/[^a-zA-Z0-9_-]/', '', $data['ekad']);

// Critical CSS dosyalarının yazılacağı dizin
$targetDir = realpath(__DIR__ . '/../../contents/css/critical');
if ($targetDir === false) {
    $targetDir = __DIR__ . '/../../contents/css/critical';
    if (!is_dir($targetDir)) {
        mkdir($targetDir, 0755, true);
    }
    $targetDir = realpath($targetDir);
}

// CSS çıktılarının dosya adları
$desktopOutput = "{$targetDir}/{$ekad}-critical-desktop.css";
$mobileOutput  = "{$targetDir}/{$ekad}-critical-mobile.css";

// Komutları oluştur
$desktopCommand = "critical https://www.guidedephesustours.com/{$url} --width=1300 --height=900 --minify --extract --target=\"{$desktopOutput}\" 2>&1";
$mobileCommand  = "critical https://www.guidedephesustours.com/{$url} --width=375 --height=667 --minify --extract --target=\"{$mobileOutput}\" 2>&1";

// Komutları çalıştır
exec($desktopCommand, $desktopLog, $desktopStatus);
exec($mobileCommand, $mobileLog, $mobileStatus);

// Logları dosyaya da yaz (isteğe bağlı)
//file_put_contents(__DIR__ . '../../exec-log.txt', "Desktop:\n" . implode("\n", $desktopLog) . "\n\nMobile:\n" . implode("\n", $mobileLog));
$fullUrl = $baseUrl ."/". $url;
// JSON response
$response = [
    "targetDir" => $targetDir,
    "desktop" => [
        "status" => $desktopStatus === 0 ? "success" : "error",
        "command" => "<pre id='criticalCommand1'>critical {$fullUrl} --width=1300 --height=900 --extract --target=\"{$desktopOutput}\" 2>&1</pre><button class='btn btn-sm btn-outline-primary' type='button' onclick='copyCommand(criticalCommand1)'>Kopyala</button>",
        "outputFile" => "{$ekad}-critical-desktop.css",
        "log" => $desktopLog
    ],
    "mobile" => [
        "status" => $mobileStatus === 0 ? "success" : "error",
        "command" => "<pre id='criticalCommand2'>critical {$fullUrl} --width=375 --height=667 --extract --target=\"{$mobileOutput}\" 2>&1</pre><button class='btn btn-sm btn-outline-primary' type='button' onclick='copyCommand(criticalCommand2)'>Kopyala</button>",
        "outputFile" => "{$ekad}-critical-mobile.css",
        "log" => $mobileLog
    ]
];


header("Content-Type: application/json");
echo json_encode($response, JSON_PRETTY_PRINT);
