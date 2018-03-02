<?php
namespace Admin\Common\Model;

use Think\Model;

/**
 * 数据库操作基类
 */
class OcModel extends Model
{
    public function __construct(string $name='', $tablePrefix='', $connection='')
    {
        parent::__construct($name, $tablePrefix, $connection);
    }

    protected function _before_write(&$data)
    {
        $data['operator'] = session('employee_id');
    }

    protected function _before_update(&$data,$options)
    {
        $data['update_time'] = (new \DateTime)->format('Y-m-d H:i:s');

        $event = '修改表数据' . $this->getTableName();
        $json = json_encode($data);
       // \Admin\Common\Record\EmployeeLog::add($event, $json);
    }

    protected function _before_insert(&$data,$options)
    {
        $event = '新增表数据' . $this->getTableName();
        $json = json_encode($data);
       // \Admin\Common\Record\EmployeeLog::add($event, $json);
    }
}