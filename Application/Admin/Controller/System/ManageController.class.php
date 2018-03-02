<?php

namespace Admin\Controller\System;

use Think\Controller;
use Think\Log;

use Admin\Common\Model\OcModel;
use Admin\Common\Parameter\Validator;

/**
 * 系统配置类
 */
class ManageController extends Controller
{
	private $param;
	
	public function profile()
	{
		$arr = M('config')->select();
		
		foreach ($arr as $item) {
			$data[$item['name']] = $item['value'];
		}
		
		$this->initConfigAuto('fee_type');
		$this->assign('models', M('model_config')->order('model_config_id')->select());
		$this->assign('data', $data);
		$this->display();
	}
	
	public function change()
	{
		$this->checkParameter('change');
		
		$where['name'] = $this->param['name'];
		$data['value'] = $this->param['value'];
		
		$model = new OcModel('config');
		$ret = $model->where($where)->save($data);
		if (false === $ret) {
			Log::write('修改配置失败：' . $model->getDbError());
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！.']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	public function addModel()
	{
		if (IS_GET) {  // 获取页面
			$this->display();
			return;
		}
		
		// 提交数据
		$this->addSubmit();
	}
	
	public function changeModel()
	{
		if (IS_GET) {  // 获取页面
			$this->changePage();
			return;
		}
		
		// 提交数据
		$this->addSubmit('changemodel');
	}
	
	public function delModel()
	{
		$id = I('post.id');
		$where['proj_type']=$id;
		$where['_string']='delete_time is null';
//		dump($id);
		$model = new OcModel('model_config');
		$count=M('project')->where($where)->count();
		if($count > 0){
			$this->ajaxReturn([
				'status' => 'failed',
				'message' => '该类型下面有项目不能删除'
			]);
		}
		$model->startTrans();
		try {
			$res = $model->delete($id);
			if ($res === false) {
				$this->ajaxReturn([
					'status' => 'failed',
					'message' => '删除失败'
				]);
			}
			$model->commit();
		} catch (\Exception $ex) {
			$model->rollback();
			$this->ajaxReturn([
				'status' => 'failed',
				'message' => $ex->getMessage()
			]);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	public function addFeeType()
	{
		if (IS_GET) {  // 获取页面
			$this->display();
			return;
		}
		
		$this->checkParameter('addmodel');
		// 提交数据
		$this->param['type'] = 'fee_type';
		$this->addFeeTypeSubmit();
	}
	
	public function changeFeeType()
	{
		if (IS_GET) {  // 获取页面
			$this->initConfigAutoById(I('get.id'));
			$this->display('addfeetype');
			return;
		}
		
		$this->checkParameter('changefeetype');
		// 提交数据
		$this->param['type'] = 'fee_type';
		$this->addFeeTypeSubmit('change');
	}
	
	private function initConfigAutoById($id)
	{
		$data = M('config_auto')->find($id);
		
		$this->assign('data', $data);
	}
	
	private function initConfigAuto($type)
	{
		$where['_string'] = 'delete_time is null';
		$where['type'] = $type;
		
		$data = M('config_auto')->where($where)->select();
		
		$this->assign($type, $data);
	}
	
	private function addFeeTypeSubmit($type = 'add')
	{
		$this->duplicateCheckFeeType($type);
		
		try {
			$model = new OcModel('config_auto');
			if ('add' == $type)
				$model->add($this->param);
			else
				$model->save($this->param);
		} catch (\Exception $ex) {
			$this->ajaxReturn([
				'status' => 'failed',
				'message' => $ex->getMessage()
			]);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	private function duplicateCheckFeeType($type = 'add')
	{
		$where['_string'] = 'delete_time is null';
		$where['name'] = $this->param['name'];
		$where['type'] = $this->param['type'];
		
		$model = new OcModel('config_auto');
		if ('add' == $type) {
			$result = $model->where($where)->select();
		} else {
			$where['config_auto_id'] = ['neq', $this->param['config_auto_id']];
			$result = $model->where($where)->select();
		}
		
		if ($result) {
			$this->ajaxReturn([
				'status' => 'failed',
				'message' => '该名称已经存在，请检查！'
			]);
		}
	}
	
	private function addSubmit($type = 'addmodel')
	{
		$this->checkParameter($type);
		
		$this->duplicateCheck($type);
		
		try {
			$model = new OcModel('model_config');
			if ('addmodel' == $type)
				$model->add($this->param);
			else
				$model->save($this->param);
		} catch (\Exception $ex) {
			$this->ajaxReturn([
				'status' => 'failed',
				'message' => $ex->getMessage()
			]);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	private function duplicateCheck($type = 'addmodel')
	{
		$where['_string'] = 'delete_time is null';
		$where['name'] = $this->param['name'];
		
		$model = new OcModel('model_config');
		if ($type == 'addmodel') {
			$result = $model->where($where)->select();
		} else {
			$where['model_config_id'] = ['neq', $this->param['model_config_id']];
			$result = $model->where($where)->select();
		}
		
		if ($result) {
			$this->ajaxReturn([
				'status' => 'failed',
				'message' => '该类型已经存在，请检查！'
			]);
		}
	}
	
	private function changePage()
	{
		$department_id = I('get.id', null, FILTER_SANITIZE_STRING);
		if (!$department_id) {
			$this->show("参数错误");
			return;
		}
		
		$department = M('model_config')->find($department_id);
		
		$this->assign('model', $department);
		$this->display('addmodel');
	}
	
	private function checkParameter($type)
	{
		try {
			if ('change' == $type) {
				(new Validator())->execute(I(''), [
					'name' => ['enum_eq' => ['liaison_limit', 'task_limit', 'birthday_limit','sms_num']],
					'value' => ['type' => 'integer'],
				]);
			} else if ('changemodel' == $type) {
				(new Validator())->execute(I(''), [
					'name' => ['type' => 'string'],
					'model_config_id' => ['type' => 'integer'],
				]);
			} else if ('addmodel' == $type) {
				(new Validator())->execute(I(''), [
					'name' => ['type' => 'string'],
				]);
			} else if ('changefeetype' == $type) {
				(new Validator())->execute(I(''), [
					'name' => ['type' => 'string'],
					'config_auto_id' => ['type' => 'integer'],
				]);
			}
		} catch (\Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！.']);
		}
		
		$this->param = I('');
	}
}