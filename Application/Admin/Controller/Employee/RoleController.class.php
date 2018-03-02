<?php
namespace Admin\Controller\Employee;

use Think\Controller;
use Think\Log;

use Admin\Common\Model\OcModel;

/**
 * 职位管理类
 */
class RoleController extends Controller
{
    private $parameter = [];

    public function index()
    {
        $model = new OcModel('Role');
        $this->searchParameterCheck();
        $where = $this->composeParam();

        $counts = $model->where($where)->count();
        $page = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
        $page->show();

        $datas = $model->alias('aa')
            ->field('aa.*')
            ->page(I('get.pg', 1, FILTER_VALIDATE_INT), C('ONE_PAGE_SIZE'))
            ->where($where)->order('role_type_code')->select();

        $this->setDepartment();
        $this->assign('pager', $page);
        $this->assign('counts', $counts);
        $this->assign('datas', $datas);
        $this->display();
    }

    /*
     * param $paramter array
     * 参数组装a
     */
    private function composeParam($paramter)
    {
        $where['_string'] = 'delete_time is null';
        if (!empty($this->parameter['role_type_code'])) {
            $where['role_type_code'] = $this->parameter['role_type_code'];
        }
        if ($this->parameter['name'] != null) {
            $where['name'] = ["LIKE", "%" . $this->parameter['name'] . "%"];
        }

        return $where;
    }

    /**
     * 新增
     */
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
        $this->changeSubmit();
    }

    /**
     * 删除职位
     * @request {
     *      role_id: (integer),
     * }
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
        $model = new OcModel('Role');
        $model->where(['role_id' => $parameter['role_id']])
                ->save(['delete_time' => date('Y-m-d H:i:s')]);

        $this->ajaxReturn(['status' => 'success']);
    }

    /**
     * 批量删除职位
     * @request {
     *      role_id: (integer),
     * }
     */
    private function deleteBatch($parameter)
    {
        $model = new OcModel('Role');
        $model->startTrans();
        try {
            foreach ($parameter['ids'] as $id) {
                $model->where(['role_id' => $id])
                    ->save(['delete_time' => date('Y-m-d H:i:s')]);;
            }
            $model->commit();
        } catch (\Exception $ex) {
            $model->rollback();

            $this->ajaxReturn([
                'status' => 'failed',
                'message' => '失败：' . $ex->getMessage()
            ]);
        }

        $this->ajaxReturn(['status' => 'success']);
    }

    /**
     * 数据提交
     */
    private function changeSubmit()
    {
        $this->parameterCheck('change');

        $this->duplicateCheck('change');

        try {
            $model = new OcModel('Role');
            $model->where(['role_id'  => $this->parameter['role_id']])
                ->save($this->parameter);

            (new \Admin\Common\Service)
                ->changeEmployeeLoginStatusByRoleId($this->parameter['role_id']);
        } catch (\Exception $ex) {
            Log::write('保存数据错误：' . $ex->getMessage());

            $this->ajaxReturn([
                'status' => 'failed',
                'message' => $ex->getMessage()
            ]);
        }

        $this->ajaxReturn(['status' => 'success']);
    }

    /**
     * 获取修改页面
     */
    private function changePage()
    {
        $role_id = I('get.id', 0, FILTER_VALIDATE_INT);
        if (!$role_id) {
            $this->show("参数错误");
            return;
        }

        $model = new OcModel('Role');
        $role = $model->find($role_id);
        $role['menus'] = json_decode($role['menus']);

        $this->setDepartment();
        $this->assign('role', $role);

        $this->display('add');
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

        $this->assign('department', $department);
    }

    /**
     * 添加数据提交
     */
    private function addSubmit()
    {
        $this->parameterCheck();

        $this->duplicateCheck();

        try {
            $model = new OcModel('Role');
            $model->add($this->parameter);            
        } catch (\Exception $ex) {
            $this->ajaxReturn([
                'status' => 'failed',
                'message' => $ex->getMessage()
            ]);
        }

        $this->ajaxReturn(['status' => 'success']);
    }


    /**
     * 通过职位获取用户姓名
     * @return string
     */
    private function getStaffNameByRole($role_id)
    {
        $staff_role = new OcModel('');
        $sql = "select name from staff_role a join staff on staff.staff_id=a.staff_id and role_id=%d ";
        $names = $staff_role->query($sql, $role_id);

        return implode(',', \Admin\Common\Base::array_column($names, 'name'));
    }

    /**
     * 重复检查
     * @param $type  类型，add是新增，change是修改
     */
    private function duplicateCheck($type = 'add')
    {
        $model = new OcModel('Role');

        $where['_string'] = 'delete_time is null';
        $where['name'] = $this->parameter['name'];

        if ($type == 'add') {
            $result = $model->where($where)->select();
        } else {
            $where['role_id'] = ['neq' , $this->parameter['role_id']];
            $result = $model->where($where)
                ->select();
        }

        if ($result) {
            $this->ajaxReturn([
                'status' => 'failed',
                'message' => '该职位已经存在，请检查！'
            ]);

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
        if ($type == 'change') {
            try {
                (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                    'role_id' => ['type' => 'integer'],
                ]);
            } catch (\Exception $ex) {

                $this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！.']);
            }
        }

        if ($type == 'add' || $type == 'change') {
            try {
                (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                    'name' => ['type' => 'string'],
                    'role_type_code' => [
                        'enum_eq' => array_keys(C('ROLE_TYPE'))
                    ],
                    'note' => [
                        'type' => 'string',
                        'required' => false,
                        'allow_empty' => true
                    ],
                    'privileges' => [
                        'type' => 'array',
                        'value' => [
                            'type' => 'string'
                        ]
                    ],
                ]);
            } catch (\Exception $ex) {

                $this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！']);
            }
        }

        $this->parameter = I('post.');
        $this->parameter['menus'] = json_encode($this->parameter['privileges']);

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
                            'type' => 'integer'
                        ]
                    ],
                ]);
            } else {
                (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                    'role_id' => ['type' => 'integer'],
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
                'name' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
            ]);

        } catch (\Exception $ex) {

            $this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！.']);
        }

        $this->parameter =  I('get.');
    }
}