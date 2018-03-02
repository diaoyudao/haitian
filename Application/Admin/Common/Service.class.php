<?php
namespace Admin\Common;
/**
 * @desc 公共函数操作类
 * Class Service
 * @package Admin\Common
 */
class Service
{
    static public function isRootUser($employee_id) {
        if(C('SELF_SYSTEMADMIN.role_id') == $employee_id) {
            return true;
        } else {
            return false;
        }
    }

    public function getemployeeByRoleId($role_id)
    {
        $employee_role = M();
        $sql = "select employee.* from employee_role a join employee on employee.employee_id=a.employee_id and role_id=%d ";
        $employees = $employee_role->query($sql, $role_id);

        return $employees;
    }

    public function getemployeeByMenuAuthor($menu_authority_id)
    {
        $employee = M();
        $sql = "select employee.* from employee_menu a ,employee where employee.employee_id=a.employee_id and menu_authority_id=%d ";
        $employees = $employee->query($sql, $menu_authority_id);

        return $employees;
    }


    public function changeemployeeLoginStatusByRoleId($role_id)
    {
        // $employees = $this->getemployeeByRoleId($role_id);
        // $model = M('employee');
        // $data['login_status'] = 2;

        // foreach ($employees as $item) {
        //     $data['employee_id'] = $item['employee_id'];
        //     $model->save($data);
        // }
        $data['login_status'] = 2;

        $where['role_id'] = $role_id;

        $ret = M('employee')->where($where)->save($data);
        if(false === $ret) {
            E('修改用户状态失败'. M('employee')->getDbError());
        }
    }

    public function changeemployeeLoginStatusByMenuAuthorId($menu_authority_id)
    {
        $employees = $this->getemployeeByMenuAuthor($menu_authority_id);
        $model = M('employee');
        $data['login_status'] = 2;

        foreach ($employees as $item) {
            $data['employee_id'] = $item['employee_id'];
            $model->save($data);
        }
    }
}