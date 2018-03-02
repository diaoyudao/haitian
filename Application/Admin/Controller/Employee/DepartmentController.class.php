<?php
namespace Admin\Controller\Employee;

use Think\Controller;
use Think\Log;
use Admin\Common\Model\OcModel;
use Admin\Common\Parameter\Validator;
/**
 * 用户管理类
 */
class DepartmentController extends Controller
{
    private $base_model = null;
    private $param = [];

    public function __construct() {
        parent::__construct();
        $this->base_model = new OcModel('department');
    }

    // 获取部门下的所有员工
    public function employee() {
        $this->parameterCheck('getemployee');

        $where['aa.department_id'] = $this->param['department_id'];
        $where['_string'] = 'aa.delete_time is null';
        $employee = M('employee')->where($where)->alias('aa')
            ->join('role bb on aa.role_id=bb.role_id')
            ->field('aa.*,bb.role_type_code')
            ->select();

        $this->ajaxReturn(['status' => 'success', 'data' => $employee]);
    }

    public function list() {
        $paramter = $this->searchParameterCheck();
        $where = $this->composeParam($paramter);

        $counts = $this->base_model->where($where)->count();
        $page = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
        $page->show();

        $department = $this->base_model
            ->page(I('get.pg', 1, FILTER_VALIDATE_INT), C('ONE_PAGE_SIZE'))
            ->where($where)->order('department_type_id')->select();

        $this->assign('pager', $page);
        $this->assign('counts', $counts);
        $this->assign('department', $department);    

        $this->display();
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
            return;
        }

        // 提交数据
        $this->addSubmit('change');
    }

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

    private function changePage()
    {
        $department_id = I('get.id', null, FILTER_SANITIZE_STRING);
        if (!$department_id) {
            $this->show("参数错误");
            return;
        }

        $department = $this->base_model->find($department_id);

        $this->assign('department', $department);
        $this->display('add');
    }

    private function deleteOne($parameter)
    {
        $this->base_model->where(['department_id' => I('post.id')])
            ->save(['delete_time' => date('Y-m-d H:i:s')]);

        $this->ajaxReturn(['status' => 'success']);
    }

    /**
     * 批量删除角色
     * @request {
     *      role_id: (integer),
     * }
     */
    private function deleteBatch($parameter)
    {
        $this->base_model->startTrans();
        try {
            foreach ($parameter['ids'] as $id) {

                $this->base_model->where(['department_id' => $id])
                    ->save(['delete_time' => date('Y-m-d H:i:s')]);
            }
            $this->base_model->commit();
        } catch (\Exception $ex) {
            $this->base_model->rollback();

            $this->ajaxReturn([
                'status' => 'failed',
                'message' => '失败：' . $ex->getMessage()
            ]);
        }

        $this->ajaxReturn(['status' => 'success']);
    }

    private function addPage() {
        $this->assign('type', C('DEPARTMENT_TYPE'));
        Log::write(json_encode(C('DEPARTMENT_TYPE')));
        $this->display();
    }

    private function addSubmit($type = 'add')
    {
        $paramter = $this->parameterCheck($type);

        $this->duplicateCheck($type);

        try {
            $model = new OcModel('department');
            if('add' == $type)
                $model->add($paramter);   
            else 
                $model->save($paramter);            
        } catch (\Exception $ex) {
            $this->ajaxReturn([
                'status' => 'failed',
                'message' => $ex->getMessage()
            ]);
        }

        $this->ajaxReturn(['status' => 'success']);
    }

    private function duplicateCheck($type = 'add')
    {
        $where['_string'] = 'delete_time is null';
        $where['name'] = $this->param['name'];

        $model = new OcModel('department');
        if ($type == 'add') {
            $result = $model->where($where)->select();
        } else {
            $where['department_id'] = ['neq' , $this->param['department_id']];
            $result = $model->where($where)->select();
        }

        if ($result) {
            $this->ajaxReturn([
                'status' => 'failed',
                'message' => '该部门已经存在，请检查！'
            ]);

            exit;
        }
    }

    private function composeParam() {
        $where['_string'] = 'delete_time is null';

        if(!empty($this->param['department_type_id'])) {
            $where['department_type_id'] = $this->param['department_type_id'];
        }
        if(!empty($this->param['name'])) {
            $where['name'] = ['like', '%' .$this->param['name']. '%'];
        }

        return $where;
    }

    private function parameterCheck($type = 'add') {
        if ($type == 'change') {
            try {
                (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                    'department_id' => ['type' => 'integer'],
                ]);
            } catch (\Exception $ex) {

                $this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！.']);
            }
        }

        if ($type == 'add' || $type == 'change') {
            try {
                (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                    'name' => ['type' => 'string'],
                    'note' => [
                        'type' => 'string',
                        'required' => false,
                        'allow_empty' => true
                    ],
                    'department_type_id' => [
                        'enum_eq' => array_keys(C('DEPARTMENT_TYPE'))
                    ],
                ]);
            } catch (\Exception $ex) {

                $this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！'.$ex->getMessage()]);
            }
        }

        try {
            if('getemployee' == $type) {
                (new Validator())->execute(I('post.'), [
                    'department_id' => ['type' => 'integer'],     
                    'role' => ['type' => 'string','required' => false,'allow_empty' => true]          
                ]);
            }
        } catch (\Exception $ex) {

            $this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！'.$ex->getMessage()]);
        }

        $this->param = I('post.');

        return I('post.');;
    }

    private function deleteParameterCheck()
    {
        try {
            if ('' != (I('post.batch', ''))) {
                (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                    'ids' => [
                        'type' => 'array',
                        'value' => [
                            'type' => 'integer'
                        ]
                    ],
                ]);
            } else {
                (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                    'id' => ['type' => 'integer'],
                ]);
            }
        } catch (\Exception $ex) {

            $this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！.']);
        }

        return I('post.');
    }

    private function searchParameterCheck() {

        $this->param = I('get.');
    }
}