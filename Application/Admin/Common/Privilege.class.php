<?php
namespace Admin\Common;
/**
 * @privilege_group
 * Class Privilege
 * @package Admin\Behaviors
 */
class Privilege
{
    /**
     * 获取当前用户的操作权限菜单
     */
    public function getPrivilegeMenu()
    {

        if (!session('employee_id')) {
            throw new \Exception('非法用户');
            exit;
        }
        $employee_id = session('employee_id');

        // root用户,现在按照总经理的权限处理
        // if($employee_id == C('SELF_SYSTEMADMIN.role_id')) {
        //     return C('menu_privilege_list');
        // }

        // 获取用户角色
        $employee = session('employee');
        $role = $this->getRoleByRoleId($employee['role_id']);

        // 获取每个角色的权限
        $menu_name_list = json_decode($role['menus']);

        if (!$menu_name_list) {
            return [];
        }

        // 输出菜单权限
        return $this->matchPrivilegeMenu($menu_name_list);
    }

    /**
     * 未登录用户是否有访问权限
     * @param $current_menu
     * @return bool
     */
    public function isNoLoginPrivilege()
    {
        $current_menu = strtolower('/service/' . CONTROLLER_NAME . '/' . ACTION_NAME);
        if(in_array($current_menu, get_privilege())) {
            return true;
        }

        return false;
    }

    /**
     * @desc 判断当前员工是否有操作当前菜单的权限
     * @return bool
     */
    public function isOwnPrivilege()
    {
        $employee_id = $_SESSION['employee_id'] ?: 0;
        if (!$employee_id) {
            return false;
        }

        // root用户
        if($employee_id == C('SELF_SYSTEMADMIN.role_id')) {
            return true;
        }

        $current_menu = strtolower('/service/' . CONTROLLER_NAME . '/' . ACTION_NAME);

        // 权限依赖
        $depend_menus = $this->dependPrivilege($current_menu);
        if (!$depend_menus) {
            $depend_menus = [$current_menu];
        }

        // 菜单权限
        $ret = $this->checkPrivilege((new \Admin\Common\Base())->getMenu(), $depend_menus);
        //$ret = $this->requiredPrivilegeList($depend_menus);
        if (false === $ret) {
            return true;
        }

        // 检查用户权限 
        return $this->checkPrivilege(session('menu_privileges'), $depend_menus);
    }

    /**
     * 获取用户角色
     */
    public function getRoleByRoleId($role_id)
    {
        $result = M('role')->find($role_id);

        return $result;
    }

    /**
     * 检查员工角色
     * @param $employee_id
     * @return bool
     */
    private function checkStaffRole($employee_id, $controller)
    {
        // 获取员工权限
        $staff_role = M('StaffRole');
        $staff_role->field('employee_id,role_id')
            ->where('employee_id = %d and delete_time is null', $employee_id);
        $result = $staff_role->select();

        foreach ($result as $row) {
            // 系统管理员，第一次部署的时候手工创建，不能被删除
            if ($row['role_id'] == C('SELF_SYSTEMADMIN.role_id')) {
                return true;
            }

            if ($this->checkRolePrivilege($row['role_id'], $controller)) {
                return true;
            }
        }

        return false;
    }

    /**
     * 匹配权限菜单
     * @param $menu_name_list // 拥有的权限菜单名称数组
     * @return array
     */
    private function matchPrivilegeMenu($menu_name_list)
    {
        $menu_list = [];
        foreach (((new \Admin\Common\Base())->getMenu()) as $first_item) {
            $temp_first_item = [];
            if (in_array($first_item['link'], $menu_name_list)) {
                if (!$temp_first_item) {
                    $temp_first_item['iconfont'] = $first_item['iconfont'];
                    $temp_first_item['title'] = $first_item['title'];
                    $temp_first_item['link'] = $first_item['link'];
                }                
            }
            foreach ($first_item['children'] as $second_item) {
                $temp_second_item = [];
                if (in_array($second_item['link'], $menu_name_list)) {
                    if (!$temp_first_item) {
                        $temp_first_item['iconfont'] = $first_item['iconfont'];
                        $temp_first_item['title'] = $first_item['title'];
                        $temp_first_item['link'] = $first_item['link'];
                    }
                    $temp_first_item['children'][] = $second_item;
                    continue;
                }
                foreach ($second_item['children'] as $third_item) {
                    if (in_array($third_item['link'], $menu_name_list)) {
                        if (!$temp_second_item) {
                            $temp_second_item['title'] = $second_item['title'];
                            $temp_second_item['link'] = $second_item['link'];
                        }
                        $temp_second_item['children'][] = $third_item;
                    }
                }
                if ($temp_second_item) {
                    if (!$temp_first_item) {
                        $temp_first_item['iconfont'] = $first_item['iconfont'];
                        $temp_first_item['title'] = $first_item['title'];
                        $temp_first_item['link'] = $first_item['link'];
                    }
                    $temp_first_item['children'][] = $temp_second_item;
                }
            }

            if ($temp_first_item) {
                $menu_list[] = $temp_first_item;
            }
        }

        return $menu_list;
    }

    /**
     * 获取当前菜单的依赖菜单
     * @param $current_menu
     */
    function dependPrivilege($current_menu)
    {
        return [];
    }

    private function checkPrivilege($menus_list, $this_menu) {
        foreach ($menus_list as $key => $item1) {
            if(in_array($item1['link'], $this_menu)) {
                return true;
            }

            foreach ($menus_list['children']??[] as $key => $item2) {
                if(in_array($item2['link'], $this_menu)) {
                    return true;
                }
            }
        }
    }
}