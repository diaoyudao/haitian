<?php
namespace Admin\Controller;

use Think\Controller;

/**
 * 后台管理主页
 * @package Admin\Controller
 */
class TestController extends Controller
{
    public function notice() {
        // 主任和业务员才会有提醒
        if('director' != session('employee.role_type_code')
            && 'salesman' != session('employee.role_type_code')) {
            return [];
        }

        $config = M('config')->field('name,value')->select();
        // 生日
        $where['_string'] = 'delete_time is null and birthday is not null';
        $where['status'] = 1; // 在职
        $where['is_remind'] = 1;

        $contact = M('customer_contact')->where($where)
            ->field('birthday,customer_contact_id,name,function,position')
            ->select();



        // 任务

        // 联络
    }

    
    private function whereRole() {
        
    }
}