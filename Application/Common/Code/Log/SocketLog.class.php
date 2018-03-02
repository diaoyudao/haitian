<?php
namespace Common\Code\Log;

/**
 * socket
 */
class SocketLog
{
    public static function error($string)
    {
        \Think\Log::write($string);
    }

    public static function warning()
    {
        \Think\Log::write($string, 'WARN');
    }

    public static function record()
    {
        \Think\Log::write($string, 'INFO');
    }

    public static function debug()
    {
        \Think\Log::write($string, 'DEBUG');
    }
}