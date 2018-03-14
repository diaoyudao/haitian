<?php
namespace Admin\Controller\Login;

use Think\Controller;

/**
 * 后台管理登录
 * @package Admin\Controller
 */
class EmployeeController extends Controller
{
	public function login()
	{
		if (IS_GET) {  // 获取页面

			$this->display();
			return;
		}

		// 提交数据
		$this->loginSumbit();
	}

	/**
	 * 用户退出登录
	 */
	public function loginout()
	{

		(new \Admin\Common\Session())->loginOut();
		redirect('/service/login/employee/login', 0, '');
	}

	/**
	 * 用户退出登录
	 */
	public function exceptionloginout()
	{
		(new \Admin\Common\Session())->loginOut();
	}

	private function loginSumbit()
	{
		$parameter = $this->checkParameter();

		// 验证码
		$ret = $this->check_verify($parameter['verify']);
		if (!$ret) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '验证码无效，请重试！']);
		}

		// 密码
		$model = M('employee');
		$where['aa.employee_code'] = $parameter['login_id'];
		$where['aa.password'] = md5($parameter['password']);
		$where['aa.status'] = 1;

		$field = "aa.*,cc.name department_name,bb.name role_name,bb.role_type_code,cc.department_type_id";
		$employee = $model->where($where)->alias('aa')->field($field)
			->join('role bb on aa.role_id =bb.role_id and bb.delete_time is null')
			->join('department cc on aa.department_id =cc.department_id and cc.delete_time is null')
			->find();
//		dump($employee);
		if (!$employee) {
        
			$this->ajaxReturn(['status' => 'failed', 'message' => '用户名或密码错误，请重试！','employee'=>$where]);
		}

		// root 用户特殊处理
		if(c('SELF_SYSTEMADMIN.role_id') == $employee['employee_id']) {
			$where_d['department_type_id'] = 'boss';
			$where_d['_string'] = 'delete_time is null';
			$where_r['role_type_code'] = 'boss';
			$where_r['_string'] = 'delete_time is null';
			$boss_department_id = M('department')->where($where_d)->getField('department_id');
			$boss_role_id = M('role')->where($where_r)->getField('role_id');
			if($boss_department_id) {
				$employee['department_id'] = $boss_department_id;
			}
			if($boss_role_id) {
				$employee['role_id'] = $boss_role_id;
			}

			$employee['role_type_code'] = 'boss';
			$employee['department_type_id'] = 'boss';
		}else{
			$is_login=$this->isOtherLogin($employee);
			if($is_login){
				$this->ajaxReturn(['status' => 'failed','message'=>'您的账户已经登录了，不能重复登录!']);
			}
		}

		(new \Admin\Common\Session())->loginStart($employee);

		// 修改登录状态
		$last_login_t = M('employee')
			->where(['employee_id' => $employee['employee_id']])
			->getField('login_time');
			
		$data_l['login_status'] = 1;
		$data_l['is_login'] = 1;
		$data_l['login_time'] = date('Y-m-d H:i:s');
		if($last_login_t < date('Y-m-d')) {
			$data_l['login_quantity'] = 1;
		} else {
			M('employee')->where(['employee_id' => $employee['employee_id']])
			->setInc('login_quantity',1);
		}

		M('employee')->where(['employee_id' => $employee['employee_id']])
			->save($data_l);		

		$this->ajaxReturn(['status' => 'ok']);
	}

	private function check_verify($code)
	{
		$config = [
			'seKey' => C('VERIFY_KEY'), // 加密
		];
		$verify = new \Think\Verify($config);

		return $verify->check($code, C('VERIFY_ID'));
	}
	
	private function isOtherLogin($employee)
	{
		if($employee['is_login'] == 0){
			return false;
		}
		$login_time = $employee['login_time'];
		if (date('Y-m-d H:i:s', time()-C('SESSION_OPTIONS.expire')) >= $login_time) {
			return false;
		}
		return true;
	}

	private function checkParameter()
	{
		try {
			(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
				'login_id' => ['regexp' => '/^.{2,20}$/'],
				'password' => ['regexp' => '/^.{2,20}$/'],
				'verify' => ['regexp' => '/^[0-9a-zA-z]{4}$/'],
			]);
		} catch (\Exception $ex) {

			$this->ajaxReturn(['status' => 'failed', 'message' => '参数格式错误，请检查！']);
			//$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}

		return I('post.');
	}
}