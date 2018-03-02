<?php
namespace Admin\Common;
/**
 * @desc session 操作类
 * Class Privilege
 * @package Admin\Behaviors
 */
class Session
{
    public function start()
    {
        session_start();
    }

    /**
     * 启动登录session
     * @param $employee // 用户表记录数据
     * @throws \Exception
     */
    public function loginStart($employee)
    {
        if (empty($employee)) {
            throw new \Exception('illegal user');
        }
        
        session_start();
        session(null);  // 清空所有session
        session('employee_id', $employee['employee_id']);
        session('employee_code', $employee['employee_code']);
        session('employee', $employee);
        session('login_time', date('Y-m-d H:i:s'));

        // 登录时获取权限菜单，修改菜单权限后需要重新登录才能生效        
        session('menu_privileges', (new \Admin\Common\Privilege)->getPrivilegeMenu());
    }

    public function loginOut()
    {
        session_destroy();
    }
}