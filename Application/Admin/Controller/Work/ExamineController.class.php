<?php

namespace Admin\Controller\Work;

use Admin\Common\Parameter\Exception;
use Think\Controller;
use Admin\Common\WeekList;
use Admin\Common\Model\OcModel;
use Think\Think;

/**
 * 工作报告（审批）
 */
class ExamineController extends Controller
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
	
	//批复周报
	public function replyExport()
	{
		$parameter = $this->checkReplyParameter();
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
	
	//批复周计划
	public function add()
	{
		$model = new OcModel('work_plan');
		if (IS_GET) {
			$where['work_plan_id'] = I('get.id', 0, FILTER_VALIDATE_INT);
			$where['_string'] = 'delete_time is null';
			$reply = $model->where($where)->getField('reply');
			$this->assign('reply', $reply);
			$this->display('add');
			return;
		}
		$parameter = $this->checkReplyParameter('plan');
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
	
	//批复周总结
	public function replySummary()
	{
		$parameter = $this->checkReplyParameter('summary');
		$model = new OcModel('work_summary');
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
	
	private function indexPage($parameter)
	{
		$where = $parameter;
		
		if (session('employee')['role_type_code'] != 'boss') {
			$employee_where['aa.department_id'] = $this->department_id;
			$where['is_department'] = 0;
		} else {
			$employee_where['bb.role_type_code'] = "director";
			$where['is_department'] = 1;
		}
//		$employee_where['employee_id'] = ['neq', $this->employee_id];
//		$employee_where['bb.role_type_code'] = 'salesman';
		$employee_where['_string'] = 'aa.delete_time is null';
		$join1 = 'role bb on bb.role_id=aa.role_id and bb.delete_time is null';
		$employee = M('employee')->field('aa.*,(select name from department cc where cc.department_id=aa.department_id)department')->alias('aa')->where($employee_where)->join($join1)->select();
		
		if (empty($where['week'])) {
			$where['week'] = date('W', time());
		} else {
			$where['week'] += 1;
		}
		
		if (empty($where['employee_id'])) {
			$where['employee_id'] = $employee[0]['employee_id'];
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
//		dump($employee);
		
		$field = 'aa.*,
					(select name from project dd where  dd.project_id=aa.project_id and dd.delete_time is null) project,
					(select name from customer bb where  bb.customer_id=aa.customer_id and bb.delete_time is null) name,
					(select name from customer_contact cc where  cc.customer_contact_id=aa.customer_contact_id and cc.delete_time is null) contact,
					(select thumbnail_url from customer_contact cc where  cc.customer_contact_id=aa.customer_contact_id and cc.delete_time is null) thumbnail_url';
		$weekly_where['aa.date'] = $where['date'];
		$weekly_where['_string'] = 'aa.delete_time is null';
		$weekly_where['aa.week'] = $where['week'];
		$weekly_where['aa.employee_id'] = $where['employee_id'];
		
		$weekly = M('work_export')->alias('aa')->field($field)->where($weekly_where)
			->order('date desc')->select();
		$work_plan = M('work_plan')->where($where)->order('create_time desc')->select();
		$where['week'] -= 1;
		if ($where['week'] == 0) {
			$where['week'] = 52;
			$where['date'] = [['egt', $year], ['lt', (string)($year + 1)]];
		}
		
		$work_summary = M('work_plan')->where($where)->order('create_time desc')->select();
		$list = WeekList::lists();
		$this->assign('employee', $employee);
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
		$where['week'] = $parameter['week'];
		$where['employee_id'] = $parameter['employee_id'];
		$year = date('Y');
		
		$where['date'] = [['egt', $year], ['lt', (string)($year + 1)]];
		
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
	
	private function checkIndexParameter()
	{
		try {
			(new \Admin\Common\Parameter\Validator())->execute(I('get.'), [
				'week' => ['type' => 'integer', 'required' => false, 'allow_empty' => true],
				'employee_id' => ['type' => 'integer', 'required' => false, 'allow_empty' => true],
//				'year' => ['type' => 'Y',],
			]);
		} catch (\Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}
		
		return I('get.');
	}
	
	private function checkReplyParameter($type = "export")
	{
		if ($type == "export") {
			try {
				(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
					'work_export_id' => ['type' => 'integer',],
					'reply' => ['type' => 'string',],
				]);
			} catch (\Exception $ex) {
				$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
			}
		} else if ($type == "plan") {
			try {
				(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
					'work_plan_id' => ['type' => 'integer',],
					'reply' => ['type' => 'string',],
				]);
			} catch (\Exception $ex) {
				$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
			}
		} else {
			try {
				(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
					'work_summary_id' => ['type' => 'integer',],
					'reply' => ['type' => 'string',],
				]);
			} catch (\Exception $ex) {
				$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
			}
		}
		
		
		return I('post.');
	}
	
	
}