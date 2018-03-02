<?php

namespace Admin\Controller\Send;

use Think\Controller;
use Think\Log;

use Admin\Common\Model\OcModel;
use Admin\Common\Parameter\Validator;

/**
 * 发送短信类
 */
class SmsController extends Controller
{
	const PAGE_SIZE = 100;
	
	private $param = [];
	private $where = [];
	
	public function index()
	{
		$province = M('province')->alias('aa')
			->order('province_id')->select();
		$sms_num = M('config')->where(['name' => 'sms_num'])->getField('value');
		$sms_model = M('sms_model')->order('sms_model_id')->select();
		
		$this->assign('sms_num', $sms_num);
		$this->assign('sms_model', $sms_model);
		$this->assign('province', $province);
		$this->display();
	}
	
	public function modelList()
	{
		$sms_model = M('sms_model')->order('sms_model_id')->select();
		$this->ajaxReturn(['status' => 'success', 'sms_model' => $sms_model]);
	}
	
	// 发送
	public function call()
	{
		$this->checkParameter('call');
		
		$model = new OcModel('sms');
		try {
			// 保存发送内容到数据库
			$this->saveDb();
			$this->saveTransfer();
			// 发送短信 单独用进程跑
			
			
			$model_c = M('config');
			
			$num = count($this->param['phones']);
			$ret = $model_c->where(['name' => 'sms_num'])->setDec('value', $num);
			if (false === $ret) {
				E('db err:' . $model_c->getDbError());
			}
			$sms_num = $model_c->where(['name' => 'sms_num'])->getField('value');
			
			$model->commit();
		} catch (\Exception $ex) {
			$model->rollback();
			Log::write('发送短信失败：' . $ex->getMessage());
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '发送短信失败']);
		}
		
		$this->ajaxReturn(['status' => 'success', 'num' => $sms_num]);
	}
	
	public function list()
	{
		if (IS_GET) {
			$this->display();
			return;
		}
		
		$model = new OcModel('sms');
		$counts = $model->alias('aa')
			->count();
		$page = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
		$page->show();
		
		$field = "aa.*";
		$data = $model->field($field)->alias('aa')
			->page(I('post.pg', 1, FILTER_VALIDATE_INT), C('ONE_PAGE_SIZE'))
			->order('aa.sms_id')
			->select();
		
		$this->ajaxReturn(['status' => 'success', 'data' => $data
			, 'counts' => $counts, 'total_page' => $page->totalPages]);
	}
	
	// 获取客户和联系人信息，获取全部
	public function customer()
	{
		$this->checkParameter('customer');
		$this->composeParam();
		
		$model = new OcModel('customer_contact');
		$counts = $model->where($this->where)->alias('aa')
			->join('customer cu on aa.customer_id=cu.customer_id and cu.delete_time is null')
			->count();
		$page = new \Think\Page($counts, self::PAGE_SIZE);
		$page->show();
		
		$field = "aa.customer_contact_id id,aa.function func,aa.name contact_name,"
			. "aa.thumbnail_url url,aa.position,aa.phone,aa.email,"
			. "cu.name cust_name";
		$data = $model->field($field)->alias('aa')
			->page(I('get.pg', 1, FILTER_VALIDATE_INT), self::PAGE_SIZE)
			->join('customer cu on aa.customer_id=cu.customer_id and cu.delete_time is null')
			->where($this->where)->order('cu.customer_id,aa.function,aa.position')
			->select();
		
		$this->ajaxReturn(['status' => 'success', 'data' => $data, 'counts' => $counts]);
	}
	
	private function saveDb()
	{
		$model = new OcModel('sms');
		$ret = $model->add($this->param);
		if (false === $ret) {
			E('db error:' . $model->getDbError());
		}
	}
	
	private function saveTransfer()
	{
		$model = new OcModel('sms_transfer');
		$field = '(select name from customer where aa.customer_id =customer_id and delete_time is null) name';
		$where['_string']='aa.delete_time is null';
		foreach ($this->param['phones'] as $v) {
			$where['aa.phone']=['like','%'.$v.'%'];
			$customer = M('customer_contact')->alias('aa')->field($field)->where($where)->find();
			$data['customer'] = $customer['name'];
			$data['mobile'] = $v;
			$data['sms_code'] = $this->param['sms_code'];
			$ret = $model->add($data);
			if (false === $ret) {
				E('db error:' . $model->getDbError());
			}
		}
		
	}
	
	private function composeParam()
	{
		$this->whereEmployee();
		
		if (empty($this->where['_string']))
			$this->where['_string'] = 'aa.delete_time is null';
		else
			$this->where['_string'] .= ' and aa.delete_time is null';
		
		$this->where['aa.status'] = 1;
		if (!empty($this->param['province_id'])) {
			$this->where['cu.province_id'] = $this->param['province_id'];
		}
		if (!empty($this->param['name'])) {
			$this->where['cu.name'] = ['like', '%' . $this->param['name'] . '%'];
		}
		if (isset($this->param['type']) && '' != $this->param['type']) {
			$this->where['cu.type'] = $this->param['type'];
		}
	}
	
	private function whereEmployee()
	{
		if ('salesman' == session('employee.role_type_code')) {
			$this->where['_string'] = ' exists(select 1 from customer_employee ce where ce.customer_id=cu.customer_id and ce.employee_id=' . session('employee_id') . ')';
		} else
			// 信息部和业务部特殊处理
			if ('information' == session('employee.department_type_id')) {
				$this->where['cu.information_id'] = session('employee.department_id');
			} else if ('business' == session('employee.department_type_id')) {
				$this->where['cu.business_id'] = session('employee.department_id');
			}
	}
	
	private function checkParameter(string $type)
	{
		$this->param = I('');
		
		try {
			if ('customer' == $type) {
				(new Validator())->execute(I('post.'), [
					'province_id' => [
						'type' => 'integer',
						'required' => false,
						'allow_empty' => true
					],
					'type' => [
						'type' => 'integer',
						'required' => false,
						'allow_empty' => true
					],
					'name' => [
						'type' => 'string',
						'required' => false,
						'allow_empty' => true
					],
				]);
				if (empty(I('post.'))) {
					$this->ajaxReturn(['status' => 'failed'
						, 'message' => '至少需要输入一个查询条件！']);
				}
			} else if ('call' == $type) {
				(new Validator())->execute(I('post.'), [
					'phones' => [
						'type' => 'array',
						'value' => [
							'type' => 'phone'
						]
					],
					'context' => ['type' => 'string'],
					'sms_code' => ['type' => 'string'],
				]);
				
				$this->param['mobiles'] = json_encode($this->param['phones']);
				$this->param['quantity'] = count($this->param['phones']);
			}
		} catch (\Exception $ex) {
			
			$this->ajaxReturn(['status' => 'failed'
				, 'message' => '参数错误，请检查！']);
		}
	}
}