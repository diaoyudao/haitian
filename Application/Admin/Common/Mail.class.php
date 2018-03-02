<?php
namespace Admin\Common;

class Mail
{
    protected $config = [
        "Host" => 'mail2.agile.com.cn',
        'Port' => 25,
        'From' => 'webmaster@agile.com.cn',
        'FromName' => 'webmaster',
        'SMTPAuth' => false,
        'Username' => 'mailtest',
        'Password' => '123456',
        'CharSet' => "utf-8",
        'Timeout' => 5,
        'DEBUG' => false,
    ];

    private $context = '';

    private $mail;

    public function __construct($to_mail, $to_name)
    {
        require_once('./ThinkPHP/Library/Vendor/PhpMailer/class.phpmailer.php');

        $mail = new \PHPMailer();

        $mail->CharSet = $this->config['CharSet'];

        $mail->IsSMTP(); // telling the class to use SMTP
        //$mail->IsSendmail();  // 发送普通文件
        $mail->Host = $this->config['Host']; // SMTP server mail2.agile.com.cn
        $mail->Port = $this->config['Port'];

        $mail->From = $this->config['From'];
        $mail->FromName = $this->config['FromName'];  // webmaster@agile.com.cn
        $mail->SMTPAuth = $this->config['SMTPAuth'];
        $mail->Username = $this->config['Username'];  // SMTP服务器用户名
        $mail->Password = $this->config['Password'];
        $mail->Timeout = $this->config['Timeout'];

        $mail->AddAddress($to_mail, $to_name);  // wangxinglong@agile.com.cn

        $this->mail = $mail;
    }

    public function test2()
    {
        $fp = fsockopen("172.16.30.128", 25, $errno, $errstr, 20);
        if (!$fp)
            echo "$errstr ($errno) <br> ";
        else
            echo 'ok <br> ';
    }

    public function setContext($context)
    {
        $this->context = $context;
        // dump($body);
        //  $body = preg_replace("[\]", '', $body);
        //dump($this->context);
    }

    public function setFileContext($filename, $array = [])
    {
        $this->context = $this->mail->getFile($filename);
        // dump($body);
        //  $body = preg_replace("[\]", '', $body);
        //dump($this->context);
        foreach ($array as $key => $item) {
            $find = '{$'. $key .'}';
            $replace = $item;
            $this->context = str_replace($find, $replace, $this->context);
        }

        return $this->context;
    }

    public function addAttachment($filename)
    {
        $this->mail->AddAttachment($filename);             // attachment
    }

    public function sendmail($title, $context = null)
    {
        if($config['DEBUG']) {
            return ['ok', "debug"];
        }
        
        $context = $context ?? $this->context;
        if (!$context) {
            return ['failed', "Mailer Error: no send NULL!"];
        }

        $this->mail->Subject = $title;
        // $this->mail->AltBody = "To view the message, please use an HTML compatible email viewer!"; // optional, comment out and test

        $this->mail->MsgHTML($context);

        $ret = $this->mail->Send();
        if (!$ret) {
            return ['failed', "Mailer Error: " . $this->mail->ErrorInfo];
        } else {
            return ['ok', "ok"];
        }
    }

}