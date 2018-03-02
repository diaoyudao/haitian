<?php

namespace Admin\Controller\Task;

use Admin\Common\Parameter\Exception;
use Think\Controller;
use Admin\Common\Model\OcModel;
use Think\Think;

/**
 * 任务管理类
 */
class ManageController extends Controller
{
	private $employee_id;
	private $department_id;
	
	public function __construct()
	{
		parent::__construct();
		$this->employee_id = session('employee_id');
		$this->department_id = session('employee')['department_id'];
	}
	
	public function index()
	{
		$parameter = $this->checkListsParameter();
		$where = $this->composeParam($parameter);
		$model = M('task');
		try {
			$count = $model->where($where)->count();
			$page = new \Think\Page($count, C('ONE_PAGE_SIZE'));
			$page->show();
			$ret = $model->where($where)->page(I('get.pg', 1, FILTER_VALIDATE_INT), C('ONE_PAGE_SIZE'))->order('create_time desc')->select();
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '查询数据列表失败']);
			}
		} catch (Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}
		$today = date('Y-m-d');
		
		$model_employee = M('employee');
		
		$handler_where['_string'] = 'delete_time is null';
		$director = $this->getDirector();
		foreach ($ret as &$v) {
			if (!empty($v['over_time'])) {
				$v['status'] = '已完成';
			} else {
				if ($today > $v['end_date']) {
					$v['status'] = '已过期';
				} else {
					$v['status'] = '操作';
				}
			}
			
			
			$handler = json_decode($v['handler']);
			$handler_where['employee_id'] = ['in', $handler];
			$v['director'] = $director;
			$v['handler'] = $model_employee->where($handler_where)->select();
			
		}
		//获取部门内的业务员
		$department = $this->getDepartment();
//		dump(session());
		$this->assign('department', $department);
		$this->assign('totalPages', $page->totalPages);
		$this->assign('lists', $ret);
		
		$this->display();
	}
	
	
	public function add()
	{
//		if (IS_GET) {
//			$this->display();
//			return;
//		}
		
		$parameter = $this->checkParameter();
		$parameter['department_id'] = $this->department_id;
		$parameter['employee_id'] = $this->employee_id;
		$parameter['handler'] = json_encode($parameter['handler']);
		$model = new OcModel('task');
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
	
	public function change()
	{
		
		if (IS_GET) {
			$id = I('get.task_id', 0, FILTER_VALIDATE_INT);
			$res = M('task')->where(['task_id' => $id])->find();
			$handler = json_decode($res['handler']);
			$handler_where['employee_id'] = ['in', $handler];
			$res['director'] = $this->getDirector();
			$res['handler'] = M('employee')->field('employee_id,name,thumbnail_url')->where($handler_where)->select();
			$department = $this->getDepartment();
//			dump($res['handler']);
			$this->assign('task', $res);
			$this->assign('department', $department);
			$this->display('add');
			return;
		}
		
		$parameter = $this->checkSaveParameter();
		if (!empty($parameter['handler'])) {
			$parameter['handler'] = json_encode($parameter['handler']);
		}
		if (!empty($parameter['over_context'])) {
			if ($parameter['is_over'] == 1) {
				$parameter['over_time'] = (new \DateTime)->format('Y-m-d H:i:s');
			}
		}
		$model = new OcModel('task');
		$model->startTrans();
		
		try {
			$ret = $model->save($parameter);
			
			if (false === $ret) {
				\Think\Log::write("修改数据失败：" . $this->model->getDbError());
				$this->ajaxReturn(['status' => 'failed', 'message' => '修改数据失败']);
			}
			$model->commit();
		} catch (Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}
		$this->ajaxReturn(['status' => 'success']);
		
	}
	
	private function getDepartment()
	{
		$where['aa.department_id'] = $this->department_id;
		$where['_string'] = 'aa.delete_time is null';
		$where['aa.status'] = 1;
		$where['bb.role_type_code'] = 'salesman';
		$field = 'aa.employee_id,aa.thumbnail_url,aa.name';
		$join = 'role bb on bb.role_id=aa.role_id';
		$model = M('employee');
		$res = $model->alias('aa')->field($field)->where($where)->join($join)->select();
		return $res;
	}
	
	private function getDirector()
	{
		$where['aa.department_id'] = $this->department_id;
		$where['_string'] = 'aa.delete_time is null';
		$where['aa.status'] = 1;
		$where['bb.role_type_code'] = 'director';
		$field = 'aa.name,aa.thumbnail_url';
		$join = 'role bb on bb.role_id=aa.role_id';
		$model = M('employee');
		$res = $model->alias('aa')->field($field)->where($where)->join($join)->find();
		return $res;
	}
	
	private function composeParam($parameter)
	{
		$where['_string'] = 'delete_time is null';
		$where['department_id'] = $this->department_id;
		$tody = date('Y-m-d');
		if (1 == $parameter['select_type']) {
			$where['handler'] = ['like', '%' . $this->employee_id . '%'];
		}
		if (1 == $parameter['status_type']) {
			$where['_string'] .= ' and over_context is  null';
			$where['end_date'] = ['egt', $tody];
			if (session('employee')['role_type_code'] == 'salesman') {
				$where['handler'] = ['like', '%' . $this->employee_id . '%'];
			}
		}
		return $where;
	}
	
	private function checkParameter()
	{
		try {
			(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
				'end_date' => ['type' => 'date'],
				'context' => ['type' => 'string'],
				'handler' => ['type' => 'array',
					'value' => ['type' => 'integer'],
				],
			]);
		} catch (\Exception $ex) {
			\Think\Log::write(json_encode(I('post.')));
//			$this->ajaxReturn(['status' => 'failed', 'message' => '参数格式错误，请检查！']);
			$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}
		return I('post.');
	}
	
	private function checkListsParameter()
	{
		try {
			(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
				'select_type' => ['enum_eq' => [1], 'required' => false, 'allow_empty' => true],
				'status_type' => ['enum_eq' => [1], 'required' => false, 'allow_empty' => true],
			]);
		} catch (\Exception $ex) {
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '参数格式错误，请检查！']);
			//$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}
		return I('get.');
	}
	
	private function checkSaveParameter()
	{
		try {
			(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
				'over_context' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
				'handler' => ['type' => 'array', 'required' => false, 'allow_empty' => true,
					'value' => ['type' => 'integer'],
				],
				'end_date' => ['type' => 'date', 'required' => false, 'allow_empty' => true],
				'context' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
				'task_id' => ['type' => 'integer',],
			]);
		} catch (\Exception $ex) {
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '参数格式错误，请检查！']);
			//$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}
		return I('post.');
	}
}