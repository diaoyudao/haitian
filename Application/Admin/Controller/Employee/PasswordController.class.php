<?php
namespace Admin\Controller\Employee;

use Think\Controller;
use Think\Log;
use Admin\Common\Model\OcModel;

/**
 * 密码
 * @package Admin\Controller
 */
class PasswordController extends Controller
{
    public function change()
    {
        if (IS_GET) {  // 获取页面
            $this->display();
            return;
        }

        // 提交数据
        $this->changeSubmit();
    }

    /**
     * 重置密码
     */
    public function reset()
    {
        $employee_id = I('post.employee_id', null, FILTER_SANITIZE_STRING);
        if (!$employee_id) {
            $this->ajaxReturn(['status' => 'failed', 'message' => '用户不正确']);
        }

        $model = M('employee');
        $new_passwd = md5(C('INIT_PASSWORD'));

        $employee = $model->find($employee_id);
        $model->where('employee_id = %d', $employee_id)->save(['password' => $new_passwd]);

        (new employeeLog)->add('重置密码，用户：' . $employee['name']);  // 日志记录

        $this->ajaxReturn(['status' => 'success']);
    }

    private function changeSubmit()
    {
        $parameter = $this->checkParameter();

        $old_passwd = md5($parameter['old_passwd']);
        $new_passwd = md5($parameter['new_passwd']);
        $employee_id = session('employee_id');

        $model = M('employee');
        $model->startTrans();
        try {
            $where['employee_id'] = $employee_id;
            $where['password'] = $old_passwd;
            $where['status'] = 1;
            $count = $model->where($where)->count();
            if (0 >= $count) {
                $this->ajaxReturn(['status' => 'failed', 'message' => '旧密码不正确，请检查!']);
            }

            $data['password'] = $new_passwd;
            $ret = $model->where(['employee_id' => $employee_id])->save($data);
            if ($ret === false) {
                $this->ajaxReturn(['status' => 'failed', 'message' => '执行失败！']);
            }

            $model->commit();
        } catch (\Exception $ex) {
            $model->rollback();
            $this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
        }

        $this->ajaxReturn(['status' => 'success']);
    }

    private function checkParameter()
    {
        try {
            (new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
                'old_passwd' => ['regexp' => '/^.{1,20}$/'],
                'new_passwd' => ['regexp' => '/^[0-9A-Za-z!@#\$%\^&\*]{8,20}$/'],
            ]);
        } catch (\Exception $ex) {
            $this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
        }

        if (C('INIT_PASSWORD') == I('post.new_passwd')) {
            $this->ajaxReturn(['status' => 'failed', 'message' => '新密码不能等于初始密码！']);
        }

        return I('post.');
    }
}