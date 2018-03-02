<?php
namespace Admin\Common;

use Think\Log;

use Admin\Common\Parameter\Validator;
/**
 * 操作权限判断
 */
class OperatePrivilege
{
    const URL_LIST = [
        'Customer/manage',
        'Customer/search',
        'Project/manage',
        'Project/search',
    ];

    public function before() {
        Log::write(CONTROLLER_NAME);
        // 需要判断的地址
        if(IS_GET || !in_array(CONTROLLER_NAME, self::URL_LIST)) {
            return;
        }
        // 需要判断的参数
        if(!empty(I('post.customer_id')) 
            && 'boss' != session('employee.role_type_code')) {
            // 用户是否有权限操作该客户
            $where_c['customer_id'] = I('post.customer_id');
            $where_c['_string'] = 'delete_time is null';
            $where_tmp['_logic'] = 'or';
            $where_tmp['business_id'] = session('employee.department_id');
            $where_tmp['information_id'] = session('employee.department_id');
            $where_c['_complex'] = $where_tmp;

            $find = M('customer')->where($where_c)->count();
            if(0 >= $find) {
                $this->failed('您没有权限！');
            }
        }

        if(!empty(I('post.project_id'))) {
            $where_p['project_id'] = I('post.project_id');
            $where_p['approve'] = ['neq', 0];
            $where_p['_string'] = 'delete_time is null';

            $find = M('project')->where($where_p)->find();
            if($find && $find['next_department_id'] != session('employee.department_id')
                && c('SELF_SYSTEMADMIN.role_id') != session('employee_id')) {
                // root用户特殊处理
                $this->failed('流程处理中，不能操作，请检查！');
            }
        }
    }

    private function failed($msg) {
        header('Content-Type:application/json; charset=utf-8');

        exit(json_encode(['status' => 'failed', 'message' => $msg]));
    }
}