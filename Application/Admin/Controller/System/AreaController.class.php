<?php

namespace Admin\Controller\System;

use Think\Controller;
use Think\Log;

use Admin\Common\Model\OcModel;
use Admin\Common\Parameter\Validator;
use Think\Think;

/**
 * 区域配置类
 */
class AreaController extends Controller
{
	public function lists()
	{
		$paramter = $this->searchParameterCheck();
		$where = $this->composeParam($paramter);
		if (!empty($where['province_id'])) {
			$model = M('city');
			$order = 'city_id';
			$list_type = 'city';
		} elseif (!empty($where['city_id'])) {
			$model = M('county');
			$order = 'county_id';
			$list_type = 'county';
			
		} else {
			$model = M('province');
			$order = 'province_id';
			$list_type = 'province';
		}
		
		
		$count = $model->where($where)->count();
		$page = new \Think\Page($count, C('ONE_PAGE_SIZE'));
		$page->show();
		
		$result = $model->page(I('get.pg', 1, FILTER_VALIDATE_INT), C('ONE_PAGE_SIZE'))
			->where($where)->order($order)
			->select();
		$this->assign('lists', $result);
		$this->assign('list_type', $list_type);
		$this->assign('counts', $count);
		$this->assign('pager', $page);
		$this->display();
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
	 * 获取添加页面
	 */
	private function addPage()
	{
		$this->display();
	}
	
	/**
	 * 获取添加页面
	 */
	private function changePage()
	{
		$paramter = $this->changeParameterCheck();
		switch ($paramter['type']) {
			case 'province':
				$model = M('province');
				$area_id = $paramter['id'];
				break;
			case 'city':
				$model = M('city');
				$area_id = $paramter['id'];
				break;
			case 'county':
				$model = M('county');
				$area_id = $paramter['id'];
				break;
		}
		
		$area = $model->find($area_id);
		
		$this->assign('area', $area);
		$this->display('add');
	}
	
	/*
	* 添加数据提交
	*/
	private function addSubmit()
	{
		$paramter = $this->parameterCheck();
		$this->duplicateCheck($paramter);
		$model = M($paramter['type']);
		switch ($paramter['type']) {
			case 'city':
				$data['province_id'] = $paramter['pid'];
				break;
			case 'county':
				$data['city_id'] = $paramter['pid'];
				break;
			
		}
		$data[$paramter['type'] . '_name'] = $paramter['name'];
		$model->startTrans();
		try {
			
			$ret = $model->add($data);
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '执行错误']);
			}
			
			$model->commit();
		} catch (\Exception $ex) {
			$model->rollback();
			$this->ajaxReturn(['status' => 'failed', 'message' => $model->getDbError()]);
		}
		
		
		$this->ajaxReturn(['status' => 'success', 'data' => $data]);
	}
	
	/**
	 * 数据提交
	 */
	private function changeSubmit()
	{
		$paramter = $this->parameterCheck('change');
		$this->duplicateCheck($paramter, 'change');
		
		$model = M($paramter['type']);
		
		$data[$paramter['type'] . '_id'] = $paramter['id'];
		$data[$paramter['type'] . '_name'] = $paramter['name'];
		$model->startTrans();
		try {
			
			$ret = $model->save($data);
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '执行错误']);
			}
			
			$model->commit();
		} catch (\Exception $ex) {
			
			$model->rollback();
			$this->ajaxReturn(['status' => 'failed', 'message' => $model->getDbError()]);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	/**
	 * 区域删除
	 */
	public function delArea()
	{
		$paramter = $this->parameterCheck('del');
		
		$this->existence($paramter['type'],$paramter['id']);
		$model = M($paramter['type']);
		
		$data[$paramter['type'] . '_id'] = $paramter['id'];
		$data['delete_time'] = date('Y-m-d H:i:s');
		$model->startTrans();
		try {
			
			$ret = $model->save($data);
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '执行错误']);
			}
			
			$model->commit();
		} catch (\Exception $ex) {
			
			$model->rollback();
			Log::write($model->getDbError());
			$this->ajaxReturn(['status' => 'failed', 'message' => $model->getDbError()]);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	private function existence($key, $val)
	{
		$where[$key.'_id'] = $val;
		$where['_string'] = 'delete_time is null';
		$model = M('customer');
		
		$res = $model->where($where)->count();
		if ($res > 0) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '该区域下有客户，不能删除']);
		}
		
		switch ($key) {
			case 'province':
				$area_model=M('city');
				break;
			case 'city':
				$area_model=M('county');
				break;
			default:
				return;
				break;
		}
		$ret=$area_model->where($where)->count();
		if ($ret > 0) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '该区域下有下级区域，不能删除']);
		}
		
		return;
	}
	
	/**
	 * 入参检查
	 * @param $type [add|change]
	 * @return  post参数数组
	 */
	private function parameterCheck($type = 'add')
	{
		if ($type == 'change') {
			try {
				(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
					'id' => ['type' => 'integer'],
				]);
			} catch (\Exception $ex) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！.']);
				
			}
		}
		if ($type == 'change' || $type == 'add') {
			try {
				(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
					'pid' => ['type' => 'integer', 'required' => false, 'allow_empty' => true],
					'name' => ['type' => 'string'],
					'type' => ['type' => 'string'],
				]);
			} catch (\Exception $ex) {
				
				$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
			}
		} else {
			try {
				(new \Admin\Common\Parameter\Validator())->execute(I('post.'), [
					'id' => ['type' => 'integer',],
					'type' => ['type' => 'string'],
				]);
			} catch (\Exception $ex) {
				
				$this->ajaxReturn(['status' => 'failed', 'message' => $ex->getMessage()]);
			}
		}
		
		$paramter = I('post.');
		
		
		return $paramter;
		
	}
	
	
	private function searchParameterCheck()
	{
		try {
			(new \Admin\Common\Parameter\Validator())->execute(I('get.'), [
				'province_id' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
				'city_id' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
			
			]);
		} catch (\Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！.']);
		}
		return I('get.');
	}
	
	private function changeParameterCheck()
	{
		try {
			(new \Admin\Common\Parameter\Validator())->execute(I('get.'), [
				'id' => ['type' => 'integer',],
				'type' => ['type' => 'string',],
			
			]);
		} catch (\Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！.']);
		}
		return I('get.');
	}
	
	private function composeParam($paramter)
	{
		$where = [];
		
		if (!empty($paramter['province_id'])) {
			$where['province_id'] = $paramter['province_id'];
		} elseif (!empty($paramter['city_id'])) {
			$where['city_id'] = $paramter['city_id'];
		}
		$where['_string']='delete_time is null';
		return $where;
	}
	
	/**
	 * 重复检查
	 * @param $type  类型，add是新增，change是修改
	 */
	private function duplicateCheck($paramter, $type = 'add')
	{
		$model = M($paramter['type']);
		switch ($paramter['type']) {
			case 'city':
				$where['province_id'] = $paramter['pid'];
				break;
			case 'county':
				$where['city_id'] = $paramter['pid'];
				break;
			
		}
		$where[$paramter['type'] . '_name'] = $paramter['name'];
		if ($type == 'add') {
			$result = $model->where($where)->select();
		} else {
			
			$where[$paramter['type'] . '_id'] = ['NEQ', $paramter['type'] . '_id'];
			$result = $model->where($where)->select();
		}
		
		if ($result) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '该区域名已经存在，请检查！']);
		}
	}
	
}