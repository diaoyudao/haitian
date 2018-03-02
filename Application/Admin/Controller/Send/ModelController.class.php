<?php

namespace Admin\Controller\Send;

use Think\Controller;
use Think\Log;

use Admin\Common\Model\OcModel;
use Admin\Common\Parameter\Validator;

/**
 * 发送短信类
 */
class ModelController extends Controller
{
	const PAGE_SIZE = 100;
	
	private $param = [];
	private $base_model;
	
	public function __construct()
	{
		parent::__construct();
		
		$this->base_model = M('sms_model');
	}
	
	public function lists()
	{
		$sms_model = $this->base_model->order('sms_model_id')->select();
		$this->assign('model', $sms_model);
		$this->display();
	}
	
	// 发送
	public function add()
	{
		if (IS_GET) {
			$this->display();
			return;
		}
		$this->checkParameter('add');
		$this->base_model->startTrans();
		try {
			$res = $this->base_model->add($this->param);
			if ($res === false) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '添加短信模板失败']);
			}
			$this->base_model->commit();
		} catch (\Exception $ex) {
			$this->base_model->rollback();
			$this->ajaxReturn(['status' => 'failed', 'message' => '添加短信模板失败']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	public function change()
	{
		if (IS_GET) {
			$where['sms_model_id'] = I('get.id');
			$data = $this->base_model->where($where)->find();
			$this->assign('model', $data);
			$this->display("add");
			return;
		}
		$this->checkParameter('change');
		$this->base_model->startTrans();
		try {
			$res = $this->base_model->save($this->param);
			if ($res === false) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '修改短信模板失败']);
			}
			$this->base_model->commit();
		} catch (\Exception $ex) {
			$this->base_model->rollback();
			$this->ajaxReturn(['status' => 'failed', 'message' => '修改短信模板失败']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	public function delete()
	{
	
		$this->checkParameter('delete');
		$this->base_model->startTrans();
		try {
			$res = $this->base_model->delete($this->param['sms_model_id']);
			if ($res === false) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '删除短信模板失败']);
			}
			$this->base_model->commit();
		} catch (\Exception $ex) {
			$this->base_model->rollback();
			$this->ajaxReturn(['status' => 'failed', 'message' => '删除短信模板失败']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	
	private function checkParameter(string $type)
	{
		$this->param = I('');
		
		try {
			if ('change' == $type || 'delete' == $type) {
				(new Validator())->execute(I('post.'), [
					'sms_model_id' => [
						'type' => 'string',
						'required' => true,
						'allow_empty' => false
					],
				]);
				
			}
			if ('add' == $type || 'change' == $type) {
				(new Validator())->execute(I('post.'), [
					'sms_model_code' => [
						'type' => 'string',
						'required' => false,
						'allow_empty' => true
					],
					'note' => [
						'type' => 'string',
						'required' => false,
						'allow_empty' => true
					],
				]);
				
			}
		} catch (\Exception $ex) {
			
			$this->ajaxReturn(['status' => 'failed'
				, 'message' => '参数错误，请检查！' . $ex->getMessage()]);
		}
	}
}