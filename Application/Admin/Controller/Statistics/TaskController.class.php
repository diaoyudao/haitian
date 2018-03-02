<?php

namespace Admin\Controller\Statistics;

use Think\Controller;
use Admin\Common\Model\OcModel;
use Admin\Common\Department;

/**
 * 任务统计类
 */
class TaskController extends Controller
{
	private $param = [];
	private $where = [];
	private $base_model;
	private $department_id;
	private $year;
	private $next_year;
	private $month;
	private $next_month;
	
	public function __construct()
	{
		parent::__construct();
		$this->department_id = session('employee')['department_id'];
		
		$this->base_model = M('task');
	}
	
	public function data()
	{
		$this->getYear();
		$this->monthList();
		$this->getMonth();
		$this->getDay();
		$this->finishList();
		
		$list = Department::lists();
		if ($this->param['action'] == 'export') {
			$this->export();
		}
		
		$this->assign('department', $list);
		
		$this->display();
	}
	
	//总览
	public function getYear()
	{
		
		$this->searchParameter();
		$this->composeParam();
		
		$res = $this->base_model->where($this->where)->select();
		$count = count($res);
		$pending_count = 0;
		$finish_count = 0;
		$finishs = [];
		$founds = [];
		foreach ($res as $v) {
			if (empty($v['over_time'])) {
				$pending_count += 1;
			} else {
				$finish_count += 1;
				$employee_id = json_decode($v['handler'], true);
//				dump($employee_id);
				foreach ($employee_id as $item) {
					$finishs[$item] += 1;
				}
				
			}
			$founds[$v['department_id']] += 1;
			
		}
		$found_key = array_search(max($founds), $founds);
		$finish_key = array_search(max($finishs), $finishs);
		
		//创建者名字
		$this->department_id = $found_key;
		$director = $this->getDepartment();
		
		//完成者名字
		$name = M('employee')->field('name,thumbnail_url')->where(['employee_id' => $finish_key])->find();
		
		$max_found = ['name' => $director['name'], 'num' => $founds[$found_key], 'thumbnail_url' => $director['thumbnail_url']];
		$max_finish = ['name' => $name['name'], 'num' => $finishs[$finish_key], 'thumbnail_url' => $name['thumbnail_url']];
		$ret['count'] = $count;
		$ret['pending_count'] = $pending_count;
		$ret['finish_count'] = $finish_count;
		$ret['max_found'] = $max_found;
		$ret['max_finish'] = $max_finish;
		if (IS_POST) {
			$this->ajaxReturn(['status' => 'success', 'overview' => $ret]);
		}
		$this->assign('overview', $ret);
	}
	
	public function monthList()
	{
		$this->searchParameter();
		$this->composeParam('year');
		$list = [];
		for ($i = 0; $i < 12; $i++) {
			$list[] = 0;
		}
		$res = $this->base_model->where($this->where)->select();
		
		foreach ($res as $v) {
			$month = (int)date('n', strtotime($v['create_time']));
			$list[$month - 1] += 1;
		}
		if (IS_POST) {
			$this->ajaxReturn(['status' => 'success', 'monthlist' => $list]);
		}
		$this->assign('monthlist', $list);
	}
	
	//月数据
	public function getMonth()
	{
		$this->searchParameter();
		$this->composeParam();
		$res = $this->base_model->where($this->where)->select();
		$where=$this->where;
		unset($where['create_time']);
		$where['over_time'] = [['gt', $this->year], ['lt', $this->next_year]];
		$ret = $this->base_model->where($where)->select();
		$list = [];
		for ($i = 0; $i < 12; $i++) {
			$list['finish'][$i] = 0;
			$list['found'][$i] = 0;
		}
		foreach ($res as $v) {
			$month = explode('-', date('Y-n', strtotime($v['create_time'])))[1];
//			if (!empty($v['over_context'])) {
//				$list['finish'][$month - 1] += 1;
//			}
			$list['found'][$month - 1] += 1;
			
		}
		foreach ($ret as $vv) {
			$month = explode('-', date('Y-n', strtotime($vv['over_time'])))[1];
			$list['finish'][$month - 1] += 1;
		}
		if (IS_POST) {
			$this->ajaxReturn(['status' => 'success', 'month' => $list]);
		}
		$this->assign('month', $list);
	}
	
	//天数据
	public function getDay()
	{
		$this->searchParameter();
		$this->composeParam('month');
		$res = $this->base_model->where($this->where)->select();
		
		$where=$this->where;
		unset($where['create_time']);
		$where['over_time'] = [['gt', $this->month], ['lt', $this->next_month]];
		$ret = $this->base_model->where($where)->select();
		if (!empty($this->param['month'])) {
			$month = $this->param['month'];
		} else {
			$month = date('Y-m');
		}
		$days = date('t', strtotime($month));
		$now = date('n');
		$year = $this->param['year'] ?? date('Y');
		$day_list = [];
		for ($i = 1; $i <= $days; $i++) {
			$day_list[] = $i;
		}
		$list = [];
		for ($j = 0; $j < $days; $j++) {
			$list['found'][$j] = 0;
			$list['finish'][$j] = 0;
		}
		foreach ($res as $v) {
			$day = explode('-', date('Y-m-d', strtotime($v['create_time'])))[2];
//			if (!empty($v['over_context'])) {
//				$list['finish'][$day - 1] += 1;
//			}
			$list['found'][$day - 1] += 1;
		}
		foreach ($ret as $vv) {
			$day = explode('-', date('Y-m-d', strtotime($vv['over_time'])))[2];
			$list['finish'][$day - 1] += 1;
		}
		
		if (IS_POST) {
			$this->ajaxReturn(['status' => 'success', 'day' => $list, 'day_list' => $day_list]);
		}
		$this->assign('day', $list);
		$this->assign('day_list', $day_list);
		$this->assign('now_month', $now - 1);
		$this->assign('now_year', $year);
	}
	
	//完成榜
	public function finishList()
	{
		$this->searchParameter();
		$this->composeParam();
		$res = $this->base_model->where($this->where)->select();
		$where=$this->where;
		
		unset($where['create_time']);
		$where['over_time'] = [['gt', $this->year], ['lt', $this->next_year]];
		$ret = $this->base_model->where($where)->select();//完成的数据
		$list = [];
		
		$today = date('Y-m-d');
		$temp_expire = [];
		$temp_on = [];
		$temp_finish = [];
	
		
		foreach ($res as $v) {
			$employee_id = json_decode($v['handler'], true);
			
			foreach ($employee_id as $item) {
				$employee = M('employee')->where(['employee_id' => $item])->find();
				$list[$item]['name'] = $employee['name'];
				$list[$item]['thumbnail_url'] = $employee['thumbnail_url'];
				$list[$item]['department'] = M('department')->where(['department_id' => $v['department_id']])->getField('name');
				if (false == isset($temp_expire[$item])) {
					$temp_expire[$item] = 0;
				}
				if (false == isset($temp_on[$item])) {
					$temp_on[$item] = 0;
				}
				if (false == isset($temp_finish[$item])) {
					$temp_finish[$item] = 0;
				}
				if (empty($v['over_time'])) {
					if ($today > $v['end_date']) {
						$list[$item]['expire'] += 1;
						
						$temp_expire[$item] += 1;
					} else {
						$list[$item]['active'] += 1;
						
						$temp_on[$item] += 1;
					}
				}
			}
		}
		foreach ($ret as $vv) {
			$employee_id = json_decode($vv['handler'], true);
			
			foreach ($employee_id as $item1) {
				if (false == isset($temp_finish[$item1])) {
					$temp_finish[$item1] = 0;
				}
				$list[$item1]['finish'] += 1;
				
				$temp_finish[$item1] += 1;
				
			}
		}
		
		//默认按完成降序
		if (empty($this->param['finish_order']) && empty($this->param['expire_order']) && empty($this->param['on_order'])) {
			array_multisort($temp_finish, SORT_DESC, $list);
		}
		//按完成排序
		if (!empty($this->param['finish_order'])) {
			if (1 == $this->param['finish_order']) {
				array_multisort($temp_finish, SORT_DESC, $list);
			} else {
				array_multisort($temp_finish, SORT_ASC, $list);
			}
		}
		
		//按进行中排序
		if (!empty($this->param['on_order'])) {
			if (1 == $this->param['on_order']) {
				array_multisort($temp_on, SORT_DESC, $list);
			} else {
				array_multisort($temp_on, SORT_ASC, $list);
			}
		}
		//按过期排序
		if (!empty($this->param['expire_order'])) {
			if (1 == $this->param['expire_order']) {
				array_multisort($temp_expire, SORT_DESC, $list);
			} else {
				array_multisort($temp_expire, SORT_ASC, $list);
			}
		}
		
		if (IS_POST) {
			$this->ajaxReturn(['status' => 'success', 'finishlist' => $list]);
		}
		
		$this->assign('finishlist', $list);
	}
	
	private function getDepartment()
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
	
	private function export()
	{
		$data = $this->exportData();
		if (empty($this->param['department_id'])) {
			$department_name = '全部部门';
		} else {
			$department_name = M('department')->where(['department_id' => $this->param['department_id'], ['_string' => 'delete_time is null']])->getField('name');
		}
		$str = "部门:," . $department_name . ",时间:," . $this->param['year'] . "年\n";
		$str .= "月份,新增任务,完成任务,过期任务\n";
		
		foreach ($data as $k => $v) {
			$str .= $k . "," . $v['found'] . "," . $v['finish'] . "," . $v['expire'] . "\n";
		}
		$str = iconv('utf-8', 'gb2312', $str);
		
		$filename = date('Ymd') . '任务统计.csv'; //设置文件名
		$this->export_csv($filename, $str);
	}
	
	private function exportData()
	{
		$this->searchParameter();
		$this->composeParam();
		$res = $this->base_model->where($this->where)->select();
		$list = [];
		for ($i = 1; $i <= 12; $i++) {
			$list[$i]['finish'] = 0;
			$list[$i]['found'] = 0;
			$list[$i]['expire'] = 0;
		}
		$today = date('Y-m-d');
		$found = 0;
		$finish = 0;
		$expire = 0;
		foreach ($res as $v) {
			$month = date('n', strtotime($v['create_time']));
			if (!empty($v['over_context'])) {
				$list[$month]['finish'] += 1;
				$finish++;
			} else {
				if ($today > $v['end_date']) {
					$list[$month]['expire'] += 1;
					$expire++;
				}
			}
			$list[$month]['found'] += 1;
			$found++;
		}
		$list['合计']['found'] = $found;
		$list['合计']['finish'] = $finish;
		$list['合计']['expire'] = $expire;
		return $list;
	}
	
	private function export_csv($filename, $data)
	{
		header("Content-type:text/csv;");
		header("Content-Disposition:attachment;filename=" . $filename);
		header('Cache-Control:must-revalidate,post-check=0,pre-check=0');
		header('Expires:0');
		header('Pragma:public');
		
		echo $data;
		exit;
	}
	
	private function composeParam($type = 'year')
	{
		$this->where['_string'] = 'delete_time is null';
		
		if (!empty($this->param['department_id'])) {
			$this->where['department_id'] = $this->param['department_id'];
		}
		if ($type == 'year') { //年
			if (!empty($this->param['year'])) {
				$this->year = $this->param['year'];
			} else {
				$this->year = date('Y');
			}
			$date = date_create($this->year . '-01');
			date_modify($date, "+1 year");
			$this->next_year = date_format($date, 'Y');
			$this->where['create_time'] = [['gt', $this->year], ['lt', $this->next_year]];
			
		} else { //月
			if (!empty($this->param['month'])) {
				$this->month = $this->param['month'];
			} else {
				$this->month = date('Y-m');
			}
			$date = date_create($this->month);
			date_modify($date, "+1 month");
			$this->next_month = date_format($date, 'Y-m');
			$this->where['create_time'] = [['gt', $this->month], ['lt', $this->next_month]];
		}
		
	}
	
	private function searchParameter()
	{
		try {
			(new \Admin\Common\Parameter\Validator())->execute(I(''), [
				'year' => ['type' => 'Y', 'required' => false, 'allow_empty' => true],
				'month' => ['type' => 'Y_m', 'required' => false, 'allow_empty' => true],
				'department_id' => ['type' => 'integer', 'required' => false, 'allow_empty' => true],
				'action' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
				'finish_order' => ['enum_eq' => [1, 2], 'required' => false, 'allow_empty' => true],
				'expire_order' => ['enum_eq' => [1, 2], 'required' => false, 'allow_empty' => true],
				'on_order' => ['enum_eq' => [1, 2], 'required' => false, 'allow_empty' => true],
			]);
		} catch (\Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}
		
		$this->param = I('');
		if (session('employee')['department_type_id'] != 'boss') {
			$this->param['department_id'] = session('employee')['department_id'];
		}
	}
}