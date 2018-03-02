<?php
namespace Admin\Controller\Verify;
use Think\Controller;

/**
 * 后台管理主页
 * @package Admin\Controller
 */
class LoginController extends Controller {
    public function index(){
        $config = [
            'fontSize' => 30, // 验证码字体大小
            'length' => 4, // 验证码位数
            'useNoise' => true, // 验证码杂点
            'expire' => C('VERIFY_TIMEOUT'),  // 秒过期
            'seKey' => C('VERIFY_KEY'), // 加密
        ];
        $Verify = new \Think\Verify($config);
        $Verify->entry(C('VERIFY_ID'));
    }
}