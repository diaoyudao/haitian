<?php
namespace Admin\Behaviors;
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
        session_start();

        $this->setTheme();

        // session(null);  // 清空所有session

        // $employee_id = 1001;
        // $employee = M('employee')->find($employee_id);
        // session('employee_id', $employee_id);
        // session('employee_code', $employee['employee_code']);
        // session('employee', $employee_code);

        // session('menu_privileges', C('menu_privilege_list'));

        // return;

        $ret = $this->privilege();
        if($ret) {  // 无需权限
            return;
        }

        if(!session('?employee_id')) {            
            redirect('/service/login/employee/login', 2, '未登录，跳转到登录页面，请稍等...');
            exit;
        }

        // 判断用户状态
        $staff = M('employee')->find(session('employee_id'));
        if(2 == $staff['login_status']) {
            (new \Admin\Common\Session())->loginOut();
            redirect('/service/login/employee/login', 4, '您的相关权限已被管理员修改，本地登录失效，请重新登录...');

            exit;
        }

        \Think\Log::write(json_encode(I('')),'DEBUG');
        \Think\Log::write(json_encode(session('employee')),'DEBUG');
        // $ret = (new \Admin\Common\Privilege())->isOwnPrivilege();
        // if(!$ret) {
        //     \Think\Log::write('已登录，没有权限');
        //     if(IS_GET) {
        //         echo '您没有操作权限';
        //     } else {
        //         header("Content-type:application/json;charset=utf-8");
        //         exit('{"status": "failed", "message": "您没有操作权限"}');
        //     }

        //     exit;
        // }
        $this->operatePrivilege();
    }

    private function privilege()
    {
        if('Login/employee' == CONTROLLER_NAME || 'Verify/login' == CONTROLLER_NAME) {
            return true;
        }

        return false;
    }

    private function setTheme()
    {        
        if ($this->isMobile()) {
            \Think\Log::write('mobile client');
            C('DEFAULT_THEME', 'mobile');
            $GLOBALS["client_theme"] = 'mobile';
        } else {
            \Think\Log::write('PC client');
            C('DEFAULT_THEME', 'default');
            $GLOBALS["client_theme"] = 'pc';
        }
    }

    private function isMobile()
    {
        //return true;
        $agent = $_SERVER['HTTP_USER_AGENT'];
        \Think\Log::write($agent);
//        $bIsIpad = stripos($agent, 'ipad');
        $bIsIphoneOs = stripos($agent, 'iphone os');
        $bIsMidp = stripos($agent, 'midp');
        $bIsUc7 = stripos($agent, 'rv:1.2.3.4');
        $bIsUc = stripos($agent, 'ucweb');
        $bIsAndroid = stripos($agent, 'android');
        $bIsCE = stripos($agent, 'windows ce');
        $bIsWM = stripos($agent, 'windows mobile');

        if (false !== $bIsIphoneOs || false !== $bIsMidp || false !== $bIsUc7 || false !== $bIsUc || false !== $bIsAndroid || false !== $bIsCE || false !== $bIsWM) {
            return true;
        }
        return false;
    }

    // 操作权限判断
    private function operatePrivilege() {
        (new \Admin\Common\OperatePrivilege)->before();
        
    }
}