<?php

 require 'vendor/autoload.php';

// phpinfo();

 echo "S1";

// PHP или Apache в httpd может достучаться до php по:
// http://proj3-php8.2-fpm:9000

// Maildev по SMTP:
// smtp://proj3-maildev:1025


 $memcached = new Memcached();
 $memcached->addServer('proj3-memcached', 11211);
 $memcached->set('key', 'value');
// var_dump($memcached);


$mail = new PHPMailer\PHPMailer\PHPMailer();
$mail->isSMTP();
$mail->Host = 'proj3-maildev'; // имя контейнера!
$mail->Port = 1025;
$mail->SMTPAuth = false;
$mail->setFrom('igor@aviaparts.kiev.ua');
$mail->addAddress('igor@aviaparts.kiev.ua');
$mail->Subject = '111';
$mail->Body = '123';
$mail->send();



