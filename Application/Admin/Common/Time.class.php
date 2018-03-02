<?php
namespace Admin\Common;

class Time
{
    /**
     * 获取当前事件的毫秒数。
     * @return float，单位秒
     */
    static function microtime_float()
    {
        list($usec, $sec) = explode(" ", microtime());
        return ((float)$usec + (float)$sec);
    }
}