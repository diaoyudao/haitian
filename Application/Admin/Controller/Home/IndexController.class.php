<?php

namespace Admin\Controller\Home;

use Think\Controller;
use Admin\Common\Model\OcModel;

/**
 * 首页
 */
class IndexController extends Controller
{
	public function index()
	{
		$this->workingIndex();
		$this->work();
		$this->wait();
		$this->monthList();
		$this->notice();
		// var_dump(session('employee'));
		$this->display();
	}
	
	//工作指标
	public function workingIndex()
	{
		
		if (session('employee')['role_type_code'] == 'boss') {
			//今日联络次数,今日联络失败
			list($liaison, $failed_liaison) = $this->liaison();
			//今日登陆次数
			$login_num = $this->login();
			//待完成任务
			$unfinish = $this->unfinishedTask();
			//昨日新增客户,本月新增客户
			list($yesterday_customers, $month_customers) = $this->newCustomers();
			
			//昨日新签合同,本月新签合同
			list($yesterday_contract, $month_contract) = $this->newContract();
			if (IS_POST) {
				$this->ajaxReturn(['status' => 'success', 'liaison' => $liaison, 'failed_liaison' => $failed_liaison,
					'unfinish' => $unfinish, 'yesterday_customers' => $yesterday_customers, 'month_customers' => $month_customers,
					'yesterday_contract' => $yesterday_contract, 'month_contract' => $month_contract,
				]);
			}
			$this->assign('liaison', $liaison ?? 0);
			$this->assign('failed_liaison', $failed_liaison ?? 0);
			$this->assign('login_num', $login_num ?? 0);
			$this->assign('unfinish', $unfinish ?? 0);
			$this->assign('yesterday_customers', $yesterday_customers ?? 0);
			$this->assign('month_customers', $month_customers ?? 0);
			$this->assign('yesterday_contract', $yesterday_contract ?? 0);
			$this->assign('month_contract', $month_contract ?? 0);
		}
		
	}
	
	// 本周自己的工作内容 **业务员才有
	public function work()
	{
		if (session('employee')['role_type_code'] == 'salesman') {
			$week = date('W');
			$year = date('Y');
			$pre_year = date('Y', strtotime('-1 year', time()));
			$next_year = date('Y', strtotime('+1 year', time()));
			if ($week > 1) {
				$where['week'] = $week - 1;
				$where['create_time'] = [['lt', $next_year], ['gt', $year]];
			} else {
				$where['week'] = 52;
				$where['create_time'] = [['lt', $year], ['gt', $pre_year]];
			}
			$where['_string'] = 'delete_time is null';
			$model = M('work_plan');
			
			$res = $model->field('context')->where($where)->order('create_time desc')->select();
		}
		
		$res = $res ?? [];
		$work_count = count($res);
		if (IS_POST) {
			$this->ajaxReturn(['status' => 'success', 'work' => $res, 'work_count' => $work_count]);
		}
		$this->assign('work', $res);
		$this->assign('work_count', $work_count);
		
	}
	
	// 待办事项
	public function wait()
	{
		//获取配置
		$config = $this->getConfig();
		$common_where = $this->getDepartmentWhere();
		$wait = [];
		//新分配客户
		$new_cust_where['employee_id'] = session('employee_id');
		$next_day = date("Y-m-d", strtotime("+1 day"));
		$new_cust_where['_string'] = "((aa.update_time is null) or (aa.update_time < '" . $next_day . "')) and aa.delete_time is null";
		$new_cust_where['aa.create_time'] = ['egt', date('Y-m-d')];
		$field = 'aa.*,(select name from customer where customer_id=aa.customer_id and delete_time is null) customer_name';
		$new_cust = M('customer_employee')->alias('aa')->field($field)->where($new_cust_where)->select();
		foreach ($new_cust as &$item) {
			$item['type'] = 'cust';
		}
		
		if (session('employee')['role_type_code'] == 'boss') {
			if (session('employee_id') != 1000) {
				$project_where['approve'] = ['in', [1, 2, 3]];
				$project_where['approve_status'] = 2;
				$project_where['_string'] = 'delete_time is null';
				$project = M('project')->where($project_where)->select();
				$wait = $project;
			}
		} else {
			$project = [];
			if (session('employee')['role_type_code'] == 'director') {
				$project_where['approve'] = ['neq', 0];
				$project_where['approve_status'] = ['in', [1, 3]];
				$project_where['next_department_id'] = session('employee')['department_id'];
				$project_where['_string'] = 'delete_time is null';
				$project = M('project')->where($project_where)->select();
//				dump($project);
				$task_where['department_id'] = session('employee')['department_id'];
			}
			//项目提醒
			$liaison_where = $common_where;
			$liaison_where['next_time'] = [['elt', date('Y-m-d', strtotime('+' . $config['liaison_limit'] . ' day'))], ['egt', date('Y-m-d')]];
			
			$liaison = M('customer_liaison')
//				->field('customer_id')
				->where($liaison_where)->select();
			foreach ($liaison as &$v) {
				$v['customer_name'] = M('customer')->where(['customer_id' => $v['customer_id'], '_string' => 'delete_time is null'])->getField('name');
				$v['project_name'] = M('project')->where(['project_id' => $v['project_id'], '_string' => 'delete_time is null'])->getField('name');
				$v['type'] = 'liaison';
			}
			
			//客户生日提醒
			$contact_where = $common_where;
			$contact_where['is_remind'] = 1;
			$contact_where['birthday'] = [['elt', date('m-d', strtotime('+' . $config['birthday_limit'] . ' day'))], ['egt', date('m-d')]];
			
			$contact = M('customer_contact')->where($contact_where)->select();
			foreach ($contact as &$vv) {
				$vv['customer_name'] = M('customer')->where(['customer_id' => $vv['customer_id'], '_string' => 'delete_time is null'])->getField('name');
				$vv['type'] = 'contact';
			}
			//任务提醒
//			$task_where = $common_where;
			$task_where['end_date'] = [['elt', date('Y-m-d', strtotime('+' . $config['task_limit'] . ' day'))], ['egt', date('Y-m-d')]];
			$task_where['_string'] .= 'delete_time is null and over_time is null';
			if (!isset($task_where['department_id'])) {
				$task_where['handler'] = ['like', "%" . session('employee_id') . "%"];
			}
			$task = M('task')->where($task_where)->select();
			foreach ($task as &$val) {
				$val['type'] = 'task';
			}
			$wait = array_merge($project, $liaison, $contact, $task, $new_cust);
			
		}
//		dump(M()->_sql());
		$count = count($wait);
		if (IS_POST) {
			$this->ajaxReturn(['status' => 'success', 'wait' => $wait, 'count' => $count]);
		}
		$this->assign('wait', $wait);
		$this->assign('task', $task);
		$this->assign('count', $count);

//		dump($contact_where);
//		dump($contact);
//		dump($task);
	}
	
	public function contactDetails()
	{
		
		$where['customer_contact_id'] = I('post.id', '', FILTER_SANITIZE_STRING);
		if (empty($where['customer_contact_id'])) {
			$this->show('参数错误！');
		}
		$where['_string'] = 'delete_time is null';
		$res = M('customer_contact')->field('name,department,position,phone')->where($where)->find();
		if ($res === false) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '查询数据库错误！']);
		}
		$this->ajaxReturn(['status' => 'success', 'wait' => $res, 'count' => count($res)]);
	}
	
	public function dayList()
	{
		$day = I('post.day', '', FILTER_SANITIZE_STRING);
		$liaison_where = $this->getDepartmentWhere();
		
		$liaison_where['next_time'] = [['lt', date('Y-m-d', strtotime('+1 day', strtotime($day)))], ['egt', $day]];
		$liaison = M('customer_liaison')
//				->field('customer_id')
			->where($liaison_where)->select();
		foreach ($liaison as &$v) {
			$v['customer_name'] = M('customer')->where(['customer_id' => $v['customer_id'], '_string' => 'delete_time is null'])->getField('name');
			$v['project_name'] = M('project')->where(['project_id' => $v['project_id'], '_string' => 'delete_time is null'])->getField('name');
		}
		if (IS_POST) {
			$this->ajaxReturn(['status' => 'success', 'list' => $liaison, 'day' => date('m-d', strtotime($day))]);
		}
	}
	
	//下次联系提醒
	public function monthList()
	{
		
		$parameter = $this->checkParameter();
		
		if (empty($parameter)) {
			$parameter['month'] = date('Y-m');
		}
		$list = [];
		$role_type_code = session('employee')['role_type_code'];
		if ($role_type_code == 'director' || $role_type_code == 'salesman') {
			switch ($role_type_code) {
				case 'director':
					$where['department_id'] = session('employee')['department_id'];
					break;
				case 'salesman':
					$where['employee_id'] = session('employee_id');
					break;
			}
			$where['next_time'] = [['egt', $parameter['month']], ['lt', date('Y-m', strtotime('+1 month', strtotime($parameter['month'])))]];
			$where['_string'] = 'delete_time is null';
			$temp = M('customer_liaison')->where($where)->select();
			foreach ($temp as $v) {
				$i = date('j', strtotime($v['next_time']));
				if (in_array($i, $list)) {
					continue;
				}
				$list[] = $i;
			}
		}
		if (IS_POST) {
			$this->ajaxReturn(['status' => 'success', 'list' => $list]);
		}
		$this->assign('list', $list);
		
	}
	
	// 通知
	public function notice()
	{
//		$boss_department_id = $this->getBossDepartment_id();

//		$where['department_id'] = [['eq', $boss_department_id], ['eq', session('employee')['department_id']], 'or'];
		if (session('employee')['role_type_code'] != 'boss') {
			$where['department_id'] = ['like', '%' . session('employee')['department_id'] . '%'];
		}
		$where['_string'] = 'delete_time is null';
		$model = M('notice');
		$res = $model->field('notice_id,title')->where($where)->limit(0, 5)->order('create_time desc')->select();
		$res = $res ?? [];
		if (IS_POST) {
			$this->ajaxReturn(['status' => 'success', 'notice' => $res]);
		}
		$this->assign('notice', $res);
	}
	
	//全部通知
	public function allNotice()
	{
//		$boss_department_id = $this->getBossDepartment_id();
//		$where['department_id'] = [['eq', $boss_department_id], ['eq', session('employee')['department_id']], 'or'];
		if (session('employee')['role_type_code'] != 'boss') {
			$where['department_id'] = ['like', '%' . session('employee')['department_id'] . '%'];
		}
		$where['_string'] = 'delete_time is null';
		$model = M('notice');
		$count = $model->field('notice_id,title,create_time')->where($where)->count();
		$page_size = 10;
		$page = new \Think\Page($count, $page_size);
		$page->show();
		$res = $model->field('notice_id,title,create_time')->page(I('param.pg', 1, FILTER_VALIDATE_INT), $page_size)->where($where)->order('create_time desc')->select();
		$res = $res ?? [];
		if (IS_POST) {
			$this->ajaxReturn(['status' => 'success', 'notice' => $res, 'totalPages' => $page->totalPages]);
		}
		$this->assign('allnotice', $res);
		$this->assign('totalPages', $page->totalPages);
		$this->display();
	}
	
	//通知详情
	public function detailNotice()
	{
		$notice_id = I('get.id', 1, FILTER_VALIDATE_INT);
		$where['notice_id'] = $notice_id;
		$where['_string'] = 'delete_time is null';
		$res = M('notice')->where($where)->find();
		$res['department_name'] = M('department')->where(['department_id' => $res['department_id'], '_string' => 'delete_time is null'])->getField('name');
		$res['employee_name'] = M('employee')->where(['employee_id' => $res['operator'], '_string' => 'delete_time is null'])->getField('name');
		$this->assign('notice', $res);
		$this->display();
	}
	
	//添加通知
	public function addNotice()
	{
		if (IS_GET) {
			$res = $this->getNoticeDepartment();
			$this->assign('department', $res);
			$this->display();
			return;
		}
		
		$parameter = $this->checkNoticeParameter();
		$parameter['department_id'] = json_encode($parameter['department_id']);
		$model = new OcModel('notice');
		$model->startTrans();
		
		try {
			$ret = $model->add($parameter);
			if (false === $ret) {
				\Think\Log::write("添加数据失败：" . $this->model->getDbError());
				$this->ajaxReturn(['status' => 'failed', 'message' => '添加数据失败']);
			}
			$model->commit();
		} catch (Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}
		$this->ajaxReturn(['status' => 'success']);
		
	}
	
	public function loginRepeat()
	{
		if (session('is_layer') == 'no_layer') {
			$this->ajaxReturn(['status' => 'failed']);
		}
		$time = session('login_time');
		$login_time = M('employee')->find(session('employee_id'))['login_time'];
		if (date('Y-m-d H:i:s', strtotime('+2 seconds', strtotime($time))) >= $login_time) {
			session('is_layer', 'no_layer');
			$this->ajaxReturn(['status' => 'failed']);
		} else {
			session('is_layer', 'no_layer');
			$this->ajaxReturn(['status' => 'success']);
		}
	}
	
	//任务详情
	public function addTask()
	{
		$id = I('get.id', 1, FILTER_VALIDATE_INT);
		$where['task_id'] = $id;
		$where['_string'] = 'delete_time is null';
		$res = M('task')->where($where)->find();
		$res['create'] = M('employee')->where(['employee_id' => $res['operator'], '_string' => 'delete_time is null'])->find();
		$handler = json_decode($res['handler']);
		$res['handler'] = M('employee')->where(['employee_id' => ['in', $handler], '_string' => 'delete_time is null'])->select();
		$this->assign('task', $res);
		$this->display();
	}
	
	//删除新分配用户提醒
	public function delNewCustomer()
	{
		$id = I('post.id', 1, FILTER_VALIDATE_INT);
		$data['customer_employee_id'] = $id;
		$model = new OcModel('customer_employee');
		$model->startTrans();
		
		try {
			$ret = $model->save($data);
			if (false === $ret) {
				\Think\Log::write("更新数据失败：" . $this->model->getDbError());
				$this->ajaxReturn(['status' => 'failed', 'message' => '更新数据失败']);
			}
			$model->commit();
		} catch (Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}
		$this->ajaxReturn(['status' => 'success']);
	}
	
	//获得总经理的部门id
	private function getBossDepartment_id()
	{
		$where['_string'] = 'delete_time is null';
		$where['department_type_id'] = 'boss';
		return M('department')->where($where)->getField('department_id');
	}
	
	private function getConfig()
	{
		$config = M('config')->where(['status' => 1])->getField('name,value', true);
		return $config;
	}
	
	private function getDepartmentWhere()
	{
		$department_type_id = session('employee')['role_type_code'];
//		dump(session('employee'));
//		exit();
		$res = [];
		$res['_string'] = 'delete_time is null';
		switch ($department_type_id) {
			case 'director':
				$res['department_id'] = session('employee')['department_id'];
				break;
			case 'salesman':
				$res['employee_id'] = session('employee_id');
				break;
			case 'boss':
				break;
			case 'other':
				$res['employee_id'] = session('employee_id');
				break;
		}
		return $res;
	}
	
	private function checkParameter()
	{
		try {
			(new \Admin\Common\Parameter\Validator())->execute(I(''), [
				'month' => ['type' => 'Y_m', 'required' => false, 'allow_empty' => true],
			
			]);
		} catch (\Exception $ex) {
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '参数格式错误，请检查！']);
			//$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}
		return I('');
	}
	
	private function liaison()
	{
		$where['liaison_time'] = [['egt', date('Y-m-d')], ['lt', date('Y-m-d', strtotime('+1 day'))]];
		$where['_string'] = 'delete_time is null';
		$res = M('customer_liaison')->where($where)->count();
		$where['status'] = 0;
		$ret = M('customer_liaison')->where($where)->count();
		return [$res, $ret];
	}
	
	private function login()
	{
		$where['login_time'] = [['egt', date('Y-m-d')], ['lt', date('Y-m-d', strtotime('+1 day'))]];
		$where['_string'] = 'delete_time is null';
		$res = M('employee')->where($where)->count();
		
		return $res;
	}
	
	private function unfinishedTask()
	{
		$where['end_date'] = [['egt', date('Y-m-d')]];
		$where['-string'] = 'delete_time is null';
		$res = M('task')->where($where)->count();
		return $res;
	}
	
	private function newCustomers()
	{
		$today_where['create_time'] = [['lt', date('Y-m-d')], ['egt', date('Y-m-d', strtotime('-1 day'))]];
		$today_where['_string'] = 'delete_time is null';
		
		$month_where['create_time'] = [['egt', date('Y-m')], ['lt', date('Y-m-d', strtotime('+1 month'))]];
		$month_where['_string'] = 'delete_time is null';
		
		$today_count = M('customer')->where($today_where)->count();
		$month_count = M('customer')->where($month_where)->count();
		return [$today_count, $month_count];
	}
	
	private function newContract()
	{
		$today_where['contract_date'] = [['lt', date('Y-m-d')], ['egt', date('Y-m-d', strtotime('-1 day'))]];
		$today_where['_string'] = 'delete_time is null';
		
		$month_where['contract_date'] = [['egt', date('Y-m')], ['lt', date('Y-m-d', strtotime('+1 month'))]];
		$month_where['_string'] = 'delete_time is null';
		
		$today_count = M('project')->where($today_where)->count();
		$month_count = M('project')->where($month_where)->count();
		return [$today_count, $month_count];
	}
	
	private function checkNoticeParameter()
	{
		try {
			(new \Admin\Common\Parameter\Validator())->execute(I(''), [
				'title' => ['type' => 'string',],
				'context' => ['type' => 'string',],
				'department_id' => ['type' => 'array', 'value' => [
					'type' => 'integer',
				],],
			
			]);
		} catch (\Exception $ex) {
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '参数格式错误，请检查！']);
			//$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}
		return I('');
	}
	
	//
	private function getNoticeDepartment()
	{
		$where['department_type_id'] = ['in', ['information', 'business']];
		$where['_string'] = 'delete_time is null';
		$res = M('department')->field('department_id,name')->where($where)->select();
		return $res;
	}
	
}