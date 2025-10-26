<?php
echo 'PHP çalışıyor olarak kullanıcı: ' . get_current_user() . PHP_EOL;
echo '<br>';
echo 'Sistem kullanıcı adı: ' . exec('whoami');
