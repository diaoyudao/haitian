<?php

namespace Admin\Controller\Statistics;

use Think\Controller;
use Admin\Common\Model\OcModel;
use Admin\Common\Department;

/**
 * 用户统计类
 */
class UserController extends Controller
{
	public function data()
	{
		$model = M('customer_liaison');
		
		$parameter = $this->searchParameter();
		if (!empty($parameter['department_id'])) {
			$where['bb.department_id'] = $parameter['department_id'];
		}
		$where['aa.liaison_time'] = $parameter['liaison_time'];
		$days = date('t', strtotime($parameter['month']));
		$id = $parameter['department_id'];
		if (session('employee')['department_type_id'] != 'boss') {
			$where['bb.department_id'] = session('employee')['department_id'];
			$id = session('employee')['department_id'];
		}
		$where['_string'] = 'aa.delete_time is null and bb.delete_time is null';
		$field = 'aa.*,bb.name';
		$join = 'employee bb on bb.employee_id=aa.employee_id';
		$liaisons = $model->alias('aa')->where($where)
			->field($field)
			->join($join)
			->select();
		
		$employee_ids = $model->alias('aa')->where($where)
			->field('aa.employee_id')
			->join($join)
			->distinct(true)
			->select();
		if (empty($parameter['month'])) {
			$parameter['month'] = date('Y-m');
		}
		$list = [];
		$total_ok = 0;
		$total_failed = 0;
		foreach ($liaisons as $v) {
			$date = date('Y-m-j', strtotime($v['liaison_time']));
			$day = explode('-', $date)[2];
			$key = $this->getKey($employee_ids, $v['employee_id']);

//			dump($employee_ids);
//			dump( $v['employee_id']);
			$list[$key]['name'] = $v['name'];
			if ($v['status'] == 1) {
				$list[$key]['ok'][$day] += 1;
				$list[$key]['total']['ok'] += 1;
				$total_ok += 1;
			} else {
				$list[$key]['failed'][$day] += 1;
				$list[$key]['total']['failed'] += 1;
				$total_failed += 1;
			}
		}
		
		$this->departmentLists();
		
		$lists = Department::lists();
		if (!empty($parameter['action'])) {
			$this->export($list, $parameter['month'], $id,$total_ok,$total_failed);
		}
		
		$this->assign('department', $lists);
		$this->assign('days', $days);
		$this->assign('now_month', $parameter['month']);
		$this->assign('list', $list);
		$this->assign('total_ok', $total_ok);
		$this->assign('total_failed', $total_failed);
		$this->display();
	}
	
	private function getKey($arr, $id)
	{
		foreach ($arr as $k => $v) {
			if ($v['employee_id'] == $id) {
				return $k;
			}
		}
	}
	
	private function departmentLists()
	{
		$where['_string'] = 'delete_time is null';
		$department = M('department')->where($where)
			->field('department_id,name')->select();
		$this->assign('department', $department);
	}
	
	private function searchParameter()
	{
		try {
			(new \Admin\Common\Parameter\Validator())->execute(I('get.'), [
				'department_id' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
				'action' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
				'month' => ['type' => 'Y_m', 'required' => false, 'allow_empty' => true],
			]);
		} catch (\Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}
		
		$parameter = I('get.');
		
		if (!empty($parameter['month'])) {
			$month = $parameter['month'];
		} else {
			$month = date('Y-m');
			
		}
		$date = date_create($month);
		date_modify($date, '+1 month');
		$next_month = date_format($date, "Y-m");
//		if (!empty($parameter['department_id'])) {
//			$parameter['bb.department_id'] = $parameter['department_id'];
//		}
		
		$parameter['liaison_time'] = [['egt', $month], ['lt', $next_month]];
		return $parameter;
		
		
	}
	
	private function export($data, $month, $id,$total_ok,$total_failed)
	{
		if (empty($id)) {
			$department_name = '全部部门';
		} else {
			$department_name = M('department')->where(['department_id' => $id, ['_string' => 'delete_time is null']])->getField('name');
		}
		$length = date('t', strtotime($month));
		$month = date('Y年n月', strtotime($month));
		$str = "部门:," . $department_name .",时间:,".$month. "\n";
		$str .=  "成员,";
		for ($i = 1; $i <= $length; $i++) {
			$str .= $i . ",";
		}
		$str .= "总". "\n";
		$str = iconv('utf-8', 'gb2312', $str);
		
		foreach ($data as $v) {
			$row_str = "";
			$name = iconv('utf-8', 'gb2312', $v['name']);
			$row_str .=  $name. ",";
			for ($i = 1; $i <= $length; $i++) {
				$temp=0;
				if (!empty($v['ok'])) {
					foreach ($v['ok'] as $kk=>$vv) {
						if ($i == $kk) {
							$temp=$vv;
							break ;
						}
					}
				}
				$row_str .=$temp.",";
			}
			$row_str .= ($v['total']['ok'] ?? 0) . "\n";
			$row_str .=  ",";
			for ($i = 1; $i <= $length; $i++) {
				$tem = 0;
				if (!empty($v['failed'])) {
					foreach ($v['failed'] as $kkk=>$vvv) {
						if ($i == $kkk) {
							$tem= $vvv;
							break;
						}
					}
				}
				$row_str .=$tem.",";
			}
			$row_str .= ($v['total']['failed']??0) . "\n";
			$str .= $row_str;
		}
		for ($i = 0; $i <= $length; $i++) {
			$str .= ",";
		}
		$str .= $total_ok."\n";
		for ($i = 0; $i <= $length; $i++) {
			$str .= ",";
		}
		$str .= $total_failed."\n";
		$filename = date('Ymd') . '用户统计.csv'; //设置文件名
		$this->export_csv($filename,$str);
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
}