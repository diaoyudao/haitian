<?php

namespace Admin\Controller\Work;

use Admin\Common\Parameter\Exception;
use Think\Controller;
use Admin\Common\Model\OcModel;
use Admin\Common\WeekList;
use Think\Think;

/**
 * 工作报告列表
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
		if (IS_GET) {
			$parameter = $this->checkParameter();
			$this->indexPage($parameter);
			$this->display();
			return;
		}
		
		// post

//		$this->indexPost($parameter);
	}
	
	private function indexPage($parameter)
	{
		$year_list = [];
		for ($i = 4; $i >= 0; $i--) {
			$year_list[] = date('Y', strtotime(-$i . ' year', time()));
		}
		krsort($year_list);
		$week_list = WeekList::lists($parameter['year']);
		if (!empty($parameter)) {
			$timesamp = strtotime('+1 year',strtotime($parameter['year'].'-01-01'));
			$next_year = date('Y', $timesamp);
			$where['aa.date'] = [['gt', $parameter['year']], ['lt', $next_year]];
		}
		$model = M('work_export');
		$where['aa.department_id'] = $this->department_id;
		$where['_string'] = 'aa.delete_time is null and bb.delete_time is null';
		$field = ['aa.employee_id', 'bb.thumbnail_url', 'bb.name'];
		$join = ['employee bb on bb.employee_id=aa.employee_id'];
		$list = [];
		$arr = ['', '一', '二', '三', '四', '五', '六'];
		foreach ($week_list as $k => $v) {
			$where['aa.week'] = $k + 1;
			$info = $model->alias('aa')->field($field)->join($join)->where($where)->distinct(true)->select();
			if (!empty($info)) {
				$list[$v['month']][$v['week_num']]['num'] = $arr[$v['week_num']];
				$list[$v['month']][$v['week_num']]['info'] = $info;
			}
		}
		$this->assign('year_list', $year_list);
		$this->assign('list', $list);
	}
	
	private function indexPost($parameter)
	{
		$week_list = WeekList::lists($parameter['year']);
		$model = M('work_export');
		$where['aa.department_id'] = $this->department_id;
		$where['_string'] = 'aa.delete_time is null and bb.delete_time is null';
		$field = ['aa.employee_id', 'bb.thumbnail_url', 'bb.name'];
		$join = ['employee bb on bb.employee_id=aa.employee_id'];
		$list = [];
		$j = 0;
		foreach ($week_list as $k => $v) {
			$where['week'] = $k + 1;
			$info = $model->alias('aa')->field($field)->join($join)->where($where)->distinct(true)->select();
			if (!empty($info)) {
				$list[$j] = $v;
				$list[$j]['info'] = $info;
				$j++;
			}
		}
		$this->ajaxReturn(['status' => 'success', 'list' => $list]);
		
	}
	
	private function checkParameter()
	{
		try {
			(new \Admin\Common\Parameter\Validator())->execute(I(''), [
				'year' => ['type' => 'Y', 'required' => false, 'allow_empty' => true],
			
			]);
		} catch (\Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
		}
		return I('');
	}
	
	
}