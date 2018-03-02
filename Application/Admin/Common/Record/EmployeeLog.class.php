<?php
namespace Admin\Common\Record;

class EmployeeLog
{
    static public function add($event)
    {
        $data['staff_code'] = session('login_id');
        $data['name'] = session('employee')['name'];
        $data['ip'] = get_client_ip();
        $data['controller'] = CONTROLLER_NAME;
        $data['action'] = ACTION_NAME;
        $data['menu_name'] = session('current_menu_name');
        $data['event'] = $event;

        $model = M('employee_log');
        $ret = $model->add($data);
        if (!$ret) {
            \Think\Log::write('write employee_log error,content=' + $event);
        }
    }
}
