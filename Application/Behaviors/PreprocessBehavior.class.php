<?php
namespace Behaviors;
/**
 * @privilege_group
 * Class Privilege
 * @package Admin\Behaviors
 */
class PreprocessBehavior extends \Think\Behavior
{
    //行为执行入口
    public function run(&$param)
    {
        echo 'Preprocess run2 --';
    }

    /**
     * 执行action前的逻辑操作
     * @param $param
     * @throws \Exception
     */
    public function action_begin(&$param)
    {
        $privilege = new \Admin\Common\Privilege();
        if (!$privilege->isPrivilegeByStaff()) {
            throw new \Exception('not privilege');
        }
    }

    /**
     * session 预处理
     */
    public function __MY_SESSION()
    {
        session_start();
        $_SESSION['login_id'] = '10000';
        $_SESSION['login_name'] = '10000';
    }
}