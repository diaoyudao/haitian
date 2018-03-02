<?php

namespace Admin\Controller\Work;

use Admin\Common\Parameter\Exception;
use Think\Controller;
use Admin\Common\Model\OcModel;
use Admin\Common\DeleteTime;
use Admin\Common\WeekList;
use Think\Think;

/**
 * 工作报告（提交）
 */
class SubmitController extends Controller
{
	private $employee_id;
	private $department_id;
	
	
	public function __construct()
	{
		parent::__construct();
		$this->employee_id = session('employee_id');
		$this->department_id = session('employee')['department_id'];
	}
	
	//列表页
	public function index()
	{
		if (IS_GET) {
			$parameter = $this->checkIndexParameter();
			
			$this->indexPage($parameter);
			$this->display();
			return;
		}

//		$parameter = $this->checkIndexParameter();
//		$this->indexPost($parameter);
		
		
	}
	
	private function customerLists()
	{
		if (session('employee')['role_type_code'] == 'director') {
			$where['aa.department_id'] = session('employee')['department_id'];
		} else {
			$where['aa.employee_id'] = $this->employee_id;
		}
		$where['_string'] = 'aa.delete_time is null and bb.delete_time is null';
		$field = 'bb.customer_id,bb.name';
		$join = 'customer bb on bb.customer_id=aa.customer_id';
		$res = M('customer_employee')->alias('aa')->field($field)->join($join)->where($where)->distinct(true)->select();
		return $res;
	}
	
	
	public function lists($customers = [])
	{
		
		if (!empty($customers)) {
			$where['customer_id'] = $customers[0]['customer_id'];
			
		}
		if (IS_POST) {
			$where = $this->checkListParameter();
		}
		$where['_string'] = 'delete_time is null';
		$field = 'project_id,name';
		$project = M('project')->field($field)->where($where)->select();
		
		unset($where['_string']);
		$field2 = 'customer_contact_id,name';
		$contact = M('customer_contact')->field($field2)->where($where)->select();
		if (IS_POST) {
			$this->ajaxReturn(['status' => 'success', 'project' => $project, 'contact' => $contact]);
		}
		
		$this->assign('project', $project);
		$this->assign('contact', $contact);
	}
	
	//添加周报
	public function addWeekly()
	{
		if (IS_GET) {
			$customers = $this->customerLists();
			
			$this->lists($customers);
			$this->assign('customers', $customers);
			$this->display();
			return;
		}
		$parameter = $this->checkWeeklyParameter();
		$parameter['employee_id'] = $this->employee_id;
		$parameter['department_id'] = $this->department_id;
		$parameter['week'] = date('W', strtotime($parameter['date']));
//		$parameter['which day'] = date('w', strtotime($parameter['date']));
		$model = new OcModel('work_export');
		$model->startTrans();
		try {
			\Think\Log::write(json_encode($parameter));
			$ret = $model->add($parameter);
			\Think\Log::write($model->_sql());
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '新增数据失败']);
			}
			$model->commit();
		} catch (Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => 'server failed']);
		}
		$this->ajaxReturn(['status' => 'success']);
	}
	
	//修改周报
	public function changeWeekly()
	{
		if (IS_GET) {
			$id = I('get.id', 0, FILTER_VALIDATE_INT);
			$res = M('work_export')->where(['work_export_id' => $id])->find();
			$customers = $this->customerLists();
			$param[] = $res;
			$this->lists($param);
			$this->assign('customers', $customers);
			$this->assign('export', $res);
			$this->display('addweekly');
			return;
		}
		$parameter = $this->checkWeeklyParameter('change');
		$parameter['employee_id'] = $this->employee_id;
		$parameter['department_id'] = $this->department_id;
		$model = new OcModel('work_export');
		$model->startTrans();
		try {
			$ret = $model->save($parameter);
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '修改数据失败']);
			}
			$model->commit();
		} catch (Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => 'server failed']);
		}
		$this->ajaxReturn(['status' => 'success']);
		
	}
	
	//删除周报
	public function delWeekly()
	{
		$parameter = $this->checkWeeklyParameter('del');
		$model = new OcModel('work_export');
		$model->startTrans();
		try {
			$ret = DeleteTime::delete($model, $parameter);
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '删除数据失败']);
			}
			$model->commit();
		} catch (Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => 'server failed']);
		}
		$this->ajaxReturn(['status' => 'success']);
		
	}


//	//添加周总结
//	public function addSummary()
//	{
//		if (IS_GET) {
//			$this->display();
//			return;
//		}
//		$parameter = $this->checkSummaryParameter();
//		$parameter['employee_id'] = $this->employee_id;
//		$parameter['department_id'] = $this->department_id;
//		$parameter['week'] = date('W', time());
//		$model = new OcModel('work_summary');
//		$model->startTrans();
//		try {
//
//			$ret = $model->add($parameter);
//
//			if (false === $ret) {
//				$this->ajaxReturn(['status' => 'failed', 'message' => '新增数据失败']);
//			}
//			$model->commit();
//		} catch (Exception $ex) {
//			$this->ajaxReturn(['status' => 'failed', 'message' => 'server failed']);
//		}
//		$this->ajaxReturn(['status' => 'success']);
//
//	}
	
	//修改周总结
	public function changeSummary()
	{
		if (IS_GET) {
			$id = I('get.id', 0, FILTER_VALIDATE_INT);
			$res = M('work_plan')->where(['work_plan_id' => $id])->find();
			$this->assign('summary', $res);
			$this->display('addsummary');
			return;
		}
		
		$parameter = $this->checkSummaryParameter('change');
		$parameter['employee_id'] = $this->employee_id;
		$parameter['department_id'] = $this->department_id;
		$model = new OcModel('work_plan');
		$model->startTrans();
		try {
			$ret = $model->save($parameter);
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '修改数据失败']);
			}
			$model->commit();
		} catch (Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => 'server failed']);
		}
		$this->ajaxReturn(['status' => 'success']);
		
	}
	
	//删除周总结
	public function delSummary()
	{
		$parameter = $this->checkSummaryParameter('del');
		$model = new OcModel('work_summary');
		$model->startTrans();
		try {
			$ret = DeleteTime::delete($model, $parameter);
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '删除数据失败']);
			}
			$model->commit();
		} catch (Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => 'server failed']);
		}
		$this->ajaxReturn(['status' => 'success']);
		
	}
	
	//添加周计划
	public function addPlan()
	{
		if (IS_GET) {
			$this->display();
			return;
		}
		$parameter = $this->checkPlanParameter();
		$parameter['employee_id'] = $this->employee_id;
		$parameter['department_id'] = $this->department_id;
		$parameter['week'] = date('W', time());
		$model = new OcModel('work_plan');
		$model->startTrans();
		try {
			$ret = $model->add($parameter);
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '新增数据失败']);
			}
			$model->commit();
		} catch (Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => 'server failed']);
		}
		$this->ajaxReturn(['status' => 'success']);
		
	}
	
	//修改周计划
	public function changePlan()
	{
		if (IS_GET) {
			$id = I('get.id', 0, FILTER_VALIDATE_INT);
			$res = M('work_plan')->where(['work_plan_id' => $id])->find();
			$this->assign('plan', $res);
			$this->display('addplan');
			return;
		}
		$parameter = $this->checkPlanParameter('change');
		$parameter['employee_id'] = $this->employee_id;
		$parameter['department_id'] = $this->department_id;
		$model = new OcModel('work_plan');
		$model->startTrans();
		try {
			$ret = $model->save($parameter);
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '修改数据失败']);
			}
			$model->commit();
		} catch (Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => 'server failed']);
		}
		$this->ajaxReturn(['status' => 'success']);
		
	}
	
	//删除周计划
	public function delPlan()
	{
		$parameter = $this->checkPlanParameter('del');
		$model = new OcModel('work_plan');
		$model->startTrans();
		try {
			$ret = DeleteTime::delete($model, $parameter);
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '删除数据失败']);
			}
			$model->commit();
		} catch (Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => 'server failed']);
		}
		$this->ajaxReturn(['status' => 'success']);
		
	}
	
	private function indexPage($parameter)
	{
		
		$where = $parameter;
		$where['employee_id'] = $this->employee_id;
		if (empty($where['week'])) {
			$where['week'] = date('W', time());
		} else {
			$where['week'] += 1;
		}
		$year = date('Y');
		
		$list_num = $where['week'] - 1;
		$list = WeekList::lists();
		$list_next = $list;
		$next_num = $where['week'];
		if ($where['week'] == 52) {
			$list_next = WeekList::lists($year + 1);
			$next_num = 0;
		}
		
		$where['date'] = [['egt', $year], ['lt', (string)($year + 1)]];
		
		$where['_string'] = 'delete_time is null';
		$field = 'aa.*,
					(select name from project dd where  dd.project_id=aa.project_id and dd.delete_time is null) project,
					(select name from customer bb where  bb.customer_id=aa.customer_id and bb.delete_time is null) name,
					(select name from customer_contact cc where  cc.customer_contact_id=aa.customer_contact_id and cc.delete_time is null) contact,
					(select thumbnail_url from customer_contact cc where  cc.customer_contact_id=aa.customer_contact_id and cc.delete_time is null) thumbnail_url';
//		$join = ['customer bb on bb.customer_id=aa.customer_id', 'customer_contact cc on cc.customer_contact_id=aa.customer_contact_id'];
		$weekly_where['aa.date'] = $where['date'];
		$weekly_where['_string'] = 'aa.delete_time is null';
		$weekly_where['aa.week'] = $where['week'];
		$weekly_where['aa.employee_id'] = $where['employee_id'];
		
		$weekly = M('work_export')->alias('aa')->field($field)->where($weekly_where)
//			->join($join)
			->order('create_time desc')->select();
		$work_plan = M('work_plan')->where($where)->order('create_time desc')->select();
		
		$where['week'] -= 1;
		if ($where['week'] == 0) {
			$where['week'] = 52;
			$where['date'] = [['egt', $year], ['lt', (string)($year + 1)]];
		}
		
		$work_summary = M('work_plan')->where($where)->order('create_time desc')->select();
		
		$this->assign('weekly', $weekly);
		$this->assign('summary', $work_summary);
		$this->assign('plan', $work_plan);
		$this->assign('list', $list);
		$this->assign('list_next', $list_next);
		$this->assign('list_num', $list_num);
		$this->assign('next_num', $next_num);
		$this->assign('now_week', date('W', time()));
		
	}
	
	private function indexPost($parameter)
	{
		$where['employee_id'] = $this->employee_id;
		$where['week'] = $parameter['week'];
		$where['date'] = [['egt', $parameter['year']], ['lt', (string)($parameter['year'] + 1)]];
		$where['_string'] = 'delete_time is null';
		$weekly = M('work_export')->where($where)->order('date desc')->select();
		$work_summary = M('work_summary')->where($where)->order('create_time desc')->select();
		$work_plan = M('work_plan')->where($where)->order('create_time desc')->select();
		$list = WeekList::lists($parameter['year']);
		
		$this->ajaxReturn([
			'status' => 'success',
			'weekly' => $weekly,
			'summary' => $work_summary,
			'plan' => $work_plan,
			'list' => $list,
		]);
	}
	
	private function checkWeeklyParameter($type = "add")
	{
		if ($type == "add" || $type == 'change') {
			try {
				(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
					'customer_contact_id' => ['type' => 'integer'],
					'customer_id' => ['type' => 'integer'],
					'project_id' => ['type' => 'integer', 'required' => false, 'allow_empty' => true],
					'is_over' => ['enum_eq' => [1, 0],],
					'type' => ['type' => 'integer'],
					'context' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'desc' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'date' => ['type' => 'date'],
				]);
			} catch (\Exception $ex) {
				$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
			}
		} else if ($type == "del") {
			try {
				(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
					'work_export_id' => ['type' => 'integer'],
				]);
			} catch (\Exception $ex) {
				$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
			}
		} else {
			try {
				(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
					'work_export_id' => ['type' => 'integer'],
				]);
			} catch (\Exception $ex) {
				$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
			}
		}
		
		return I('post.');
	}
	
	private function checkSummaryParameter($type = "add")
	{
		if ($type == "add") {
			try {
				(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
					'cause' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'is_over' => ['enum_eq' => [1, 0],],
					'context' => ['type' => 'string'],
				]);
			} catch (\Exception $ex) {
				$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
			}
		} else if ($type == "del") {
			try {
				(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
					'work_summary_id' => ['type' => 'integer'],
				]);
			} catch (\Exception $ex) {
				$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
			}
		} else {
			try {
				(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
					'work_plan_id' => ['type' => 'integer'],
					'cause' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'is_over' => ['enum_eq' => [1, 0],],
					'context' => ['type' => 'string'],
				]);
			} catch (\Exception $ex) {
				$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
			}
		}
		
		return I('post.');
	}
	
	private function checkPlanParameter($type = "add")
	{
		if ($type == "add") {
			try {
				(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
					'note' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'context' => ['type' => 'string'],
				]);
			} catch (\Exception $ex) {
				$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
			}
		} else if ($type == "del") {
			try {
				(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
					'work_plan_id' => ['type' => 'integer'],
				]);
			} catch (\Exception $ex) {
				$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
			}
		} else {
			try {
				(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
					'work_plan_id' => ['type' => 'integer'],
					'note' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'context' => ['type' => 'string'],
				]);
			} catch (\Exception $ex) {
				$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
			}
		}
		
		return I('post.');
	}
	
	private function checkIndexParameter()
	{
		try {
			(new \Admin\Common\Parameter\Validator())->execute(I(''), [
				'week' => ['type' => 'integer', 'required' => false, 'allow_empty' => true],
//				'year' => ['type' => 'Y',],
			]);
		} catch (\Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}
		
		return I('');
	}
	
	private function checkListParameter()
	{
		try {
			(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
				'customer_id' => ['type' => 'integer'],
			]);
		} catch (\Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}
		
		return I('post.');
	}
	
}