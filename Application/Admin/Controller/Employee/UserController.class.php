<?php
namespace Admin\Controller\Employee;

use Think\Controller;
use Think\Log;

use Admin\Common\Model\OcModel;
use Admin\Common\Service;
/**
 * 用户管理类
 */
class UserController extends Controller
{
    private $parameter = [];
    private $base_model;

    public function __construct() {
        parent::__construct();
        $this->base_model = new OcModel('employee');
    }

    public function index()
    {
        $this->searchParameterCheck();
        $where = $this->composeParam();

        $counts = $this->base_model->where($where)->count();
        $page = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
        $page->show();

        $field = 'aa.*,'
            . '(select name from department where department_id=aa.department_id) department_name,'
            . '(select name from role where role_id=aa.role_id) role_name';
        $employees = $this->base_model->alias('aa')
            ->field($field)
            ->page(I('get.pg', 1, FILTER_VALIDATE_INT), C('ONE_PAGE_SIZE'))
            ->where($where)->order('department_id,role_id')->select();

        $this->setDepartment();
        $this->assign('pager', $page);
        $this->assign('counts', $counts);
        $this->assign('employees', $employees);
        $this->display();
    }

    /*
     * param $paramter array
     * 参数组装a
     */
    private function composeParam()
    {
        $where['_string'] = 'delete_time is null';

        if (!empty($this->parameter['department_id'])) {
            $where['department_id'] = $this->parameter['department_id'];
        }
        if (!empty($this->parameter['role_id'])) {
            $where['role_id'] = $this->parameter['role_id'];
        }
        if (!empty($this->parameter['name'])) {
            $where['name'] = ["LIKE","%".$this->parameter['name']."%"];
        }
        if (isset($this->parameter['status']) && '' != $this->parameter['status']) {
            $where['status'] = $this->parameter['status'];
        }

        return $where;
    }


    public function add()
    {
        if (IS_GET) {  // 获取页面
            $this->addPage();
            return;
        }

        // 提交数据
        $this->addSubmit();
    }

    /**
     * 修改
     */
    public function change()
    {
        if (IS_GET) {  // 获取页面
            $this->changePage();
            $this->display('add');
            return;
        }

        // 提交数据
        $this->changeSubmit();
    }

    /**
     * 修改me
     */
    public function changeme()
    {
        if (IS_GET) {  // 获取页面
            $this->display();
            return;
        }

        // 提交数据
        $this->changemeSubmit();
    }

    /**
     * 删除
     */
    public function delete()
    {
        $parameter = $this->deleteParameterCheck();

        $temp = I('post.batch', '');
        if (!empty($temp)) {
            // 批量删除
            $this->deleteBatch($parameter);
            return;
        }

        $this->deleteOne($parameter);
    }

    private function deleteOne($parameter)
    {
        // 特殊处理，自己不能删除自己
        if ($parameter['id'] == session('employee_id')) {
            $this->ajaxReturn(['status' => 'failed', 'message' => '不能删除自己']);
        }

        $this->base_model->startTrans();
        try {
            // 删除用户
            $this->base_model->where(['employee_id' => $parameter['id']])
                ->save(['delete_time' => date('Y-m-d H:i:s')]);

            $this->base_model->commit();
        } catch (\Exception $ex) {            
            $this->base_model->rollback();
            Log::write('删除失败：'.$ex->getMessage());

            $this->ajaxReturn(['status' => 'failed', 'message' => '失败：' . $ex->getMessage()]);
        }

        $this->ajaxReturn(['status' => 'success']);
    }

    /**
     * 批量删除角色
     */
    private function deleteBatch($parameter)
    {
        // 特殊处理，自己不能删除自己
        foreach ($parameter['ids'] as $id) {
            if ($id == session('employee_id')) {
                $this->ajaxReturn(['status' => 'failed', 'message' => '不能删除自己']);
            }
        }

        $this->base_model->startTrans();
        try {
            foreach ($parameter['ids'] as $id) {
                // 删除用户
                $this->base_model->where(['employee_id' => $id])
                ->save(['delete_time' => date('Y-m-d H:i:s')]);
            }
            $this->base_model->commit();
        } catch (\Exception $ex) {
            $this->base_model->rollback();
            Log::write('批量删除失败：'.$ex->getMessage());

            $this->ajaxReturn(['status' => 'failed', 'message' => '失败：' . $ex->getMessage()]);
        }

        $this->ajaxReturn(['status' => 'success']);
    }

    public function status()
    {
        $this->display();
    }

    private function changemeSubmit()
    {
        $param = $this->parameterCheck('changeme');  

        $data['thumbnail_url'] = $param['thumbnail_url'];
        $data['head_image'] = $param['head_image'];
        $data['employee_id'] = session('employee_id');

        $ret = $this->base_model->save($data);
        if(false === $ret) {
            Log::write('修改个人资料失败：'. $this->base_model->getDbError());

            $this->ajaxReturn(['status' => 'failed', 'message' => '修改失败！']);
        } 

        $this->ajaxReturn(['status' => 'success']);
    }

    /**
     * 数据提交
     */
    private function changeSubmit()
    {
        $this->parameterCheck('change');        

        if(Service::isRootUser($this->parameter['employee'])) {
            $this->ajaxReturn(['status' => 'failed', 'message' => '不能修改超级管理员']);
        }

        $this->duplicateCheck('change');

        $where['employee_id'] = $this->parameter['employee_id'];
        $employee = $this->base_model->where($where)->find();
        if($employee['password'] == $this->parameter['password']) {
            unset($this->parameter['password']);
        } else {
            $this->parameter['password'] = md5($this->parameter['password']);
        }

        $this->base_model->startTrans();
        try {
            $this->base_model->where($where)
                ->save($this->parameter);  

            $this->base_model->commit();
        } catch (\Exception $ex) {
            $this->base_model->rollback();
            Log::write('修改employee失败：' . $ex->getMessage());

            $this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
        }

        $this->ajaxReturn(['status' => 'success']);
    }

    /**
     * 获取修改页面
     */
    private function changePage()
    {
        $employee_id = I('get.id', null, FILTER_SANITIZE_STRING);
        if (!$employee_id) {
            $this->show("参数错误");
            return;
        }

        if(Service::isRootUser($employee_id)) {
            $this->show('不能修改超级管理员');
            return;
        }

        $employee = $this->base_model->find($employee_id);

        $this->setDepartment();
        $this->assign('employee', $employee);
        
    }

    /**
     * 获取添加页面
     */
    private function addPage()
    {
        $this->setDepartment();

        $this->display();
    }

    private function setDepartment() {
        $where['_string'] = 'delete_time is null';

        $department = M('department')->where($where)->select();
        $role = M('role')->where($where)->field('role_id,department_id,name')->select();

        $this->assign('department', $department);
        $this->assign('role', $role);           
    }

    /**
     * 添加数据提交
     */
    private function addSubmit()
    {
        $this->parameterCheck();
        $this->duplicateCheck();

        $this->parameter['password'] = md5($this->parameter['password']);        

        $this->base_model->startTrans();
        try {
            $employee_id = $this->base_model->add($this->parameter);

            $this->base_model->commit();
        } catch (\Exception $ex) {
            $this->base_model->rollback();

            $this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
        }

        $this->ajaxReturn(['status' => 'success']);
    }

    /**
     * 重复检查
     * @param $type  类型，add是新增，change是修改
     */
    private function duplicateCheck($type = 'add')
    {
        $where['_string'] = 'delete_time is null';
        $where['employee_code'] = $this->parameter['phone'];

        if ($type == 'add') {
            $result = $this->base_model->where($where)->select();
        } else {
            $where['employee_id'] = ['neq', $this->parameter['employee_id']];
            $result = $this->base_model->where($where)
                ->select();
        }

        if ($result) {
            $this->ajaxReturn(['status' => 'failed', 'message' => '该手机号码已经存在，请检查！']);

            exit;
        }
    }

    /**
     * 入参检查
     * @param $type [add|change|delete|batchdelete]
     * @return  post参数数组
     */
    private function parameterCheck($type = 'add')
    {
        try {
            if ($type == 'change') {
                (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                    'employee_id' => ['type' => 'integer'],
                ]);            
            } else if('changeme' == $type) {
                (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                    'head_image' => ['type' => 'string'],
                    'thumbnail_url' => ['type' => 'string'],
                ]);
            }

            if ($type == 'add' || $type == 'change') {
                (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                    'name' => ['type' => 'string'],
                    'sex' => ['enum_eq' => [1, 2]],
                    'status' => ['enum_eq' => [1, 0]],
                    'phone' => ['type' => 'phone'],
                    'department_id' => ['type' => 'integer'],
                    'role_id' => ['type' => 'integer'],
                    'head_image' => ['type' => 'string', 'allow_empty' => true],
                    'thumbnail_url' => ['type' => 'string', 'allow_empty' => true],
                    'password' => ['type' => 'string'],
                ]);             

                $this->parameter = I('post.');
                if(empty($this->parameter['password'])) {
                    unset($this->parameter['password']);
                }
                if(empty($this->parameter['employee_id'])) {
                    unset($this->parameter['employee_id']);
                }
                // 
                if(empty($this->parameter['head_image'])) {
                    $this->parameter['head_image'] = C('DEFAULT_EMPLOYEE_IMAGE');
                }
                if(empty($this->parameter['thumbnail_url'])) {
                    $this->parameter['thumbnail_url'] = C('DEFAULT_EMPLOYEE_IMAGE');
                }
                $this->parameter['employee_code'] = $this->parameter['phone'];
            }
        } catch (\Exception $ex) {
            $this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！'.$ex->getMessage()]);
        }

        return I('post.');
    }

    /**
     * 入参检查
     * @param $type delete
     * @return  post参数数组
     */
    private function deleteParameterCheck()
    {
        try {
            if ('' != (I('post.batch', ''))) {
                (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                    'ids' => [
                        'type' => 'array',
                        'value' => [
                            'type' => 'string'
                        ]
                    ],
                ]);
            } else {
                (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                    'id' => ['type' => 'string'],
                ]);
            }
        } catch (\Exception $ex) {

            $this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！.']);
        }

        return I('post.');
    }

    /**
     * 入参检查
     * @return  get参数数组
     */
    private function searchParameterCheck()
    {
        try {
            (new \Admin\Common\Parameter\Validator())->execute(I('get.'), [
                'employee_code' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
                'name' => ['type' => 'string', 'required' => false, 'allow_empty' => true],

            ]);

        } catch (\Exception $ex) {

            $this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！.']);
        }

        $this->parameter = I('get.');
    }
}