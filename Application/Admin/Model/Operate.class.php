<?php
namespace Admin\Model;

use Think\Controller;
use Think\Log;
use Think\Model;

use Admin\Common\Model\OcModel;
use Admin\Common\Parameter\Validator;
/**
 * 记录客户项目操作日志
 */
class Operate extends Model
{
    protected $tableName = 'operate_log';

    public function __construct() {
        parent::__construct();
    }

    public function log($data) {
        $data['employee_id'] = session('employee_id');
        $data['employee_name'] = session('employee.name');
        $data['department_id'] = session('employee.department_id');
        $data['department_name'] = session('employee.department_name');

        $ret = $this->add($data);
        if(false === $ret) {
            E('记录日志失败！');
        }
    }
}