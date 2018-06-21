<?php

namespace Admin\Controller\Project;

use Think\Controller;
use Think\Log;
use Admin\Common\Model\OcModel;
use Admin\Common\Parameter\Validator;

/**
 * 项目查询类
 */
class SearchController extends Controller
{
	private $param = [];
	private $where = [];
	private $order;
	private $base_model;
	
	public function __construct()
	{
		parent::__construct();
		
		$this->base_model = new OcModel('project');
	}
	
	// 查询需要审批的项目
	public function approve()
	{
		$this->checkParameter('approve');
		$this->whereApprove();
		
		$counts = $this->base_model->alias('aa')->where($this->where)
			->join('customer bb on aa.customer_id=bb.customer_id and bb.delete_time is null')
			->count();
		$page = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
		$page->show();
		
		$field = "aa.other_cust,aa.project_id,aa.next_department_id,aa.customer_id,bb.name customer_name,bb.type,aa.level,bb.is_vip,(select province_name from province where province_id=bb.province_id) province_name,"
			. "(select city_name from city where city_id=bb.city_id) city_name,(select county_name from county where county_id=bb.county_id) county_name,bb.address,aa.name project_name,aa.status,aa.son_status,aa.approve,"
			. "aa.approve_status,aa.begin_date,aa.end_date,aa.scale_fee,aa.context,bb.business_id,bb.information_id,"
			. "(select name from department where department_id=bb.business_id) business_name,"
			. "(select name from department where department_id=bb.information_id) information_name";
		$result = $this->base_model->alias('aa')->where($this->where)
			->order($this->order)->field($field)
			->page(I('post.pg', 1, FILTER_VALIDATE_INT), C('ONE_PAGE_SIZE'))
			->join('customer bb on aa.customer_id=bb.customer_id and bb.delete_time is null')
			->select();
		
		// 获取审批流程数据
		if ($result) {
			$where_t['aa.project_id'] = ['in', array_column($result, 'project_id')];
			$where_t['is_over'] = 0;
			$field = "aa.*,bb.name operator_name,bb.thumbnail_url,(select name from department where department_id=aa.out_department_id) out_department_name"
				. ",(select name from department where department_id=aa.in_department_id) in_department_name";
			$approve = M('project_approve')->alias('aa')->where($where_t)
				->join('employee bb on aa.employee_id=bb.employee_id')
				->field($field)->order('project_id,aa.status,create_time')->select();
			
			// 组装审批流程
			$arr_temp = [];
			foreach ($approve as $value) {
				$arr_temp[$value['project_id']][]
					= $value;
			}
			foreach ($result as &$item) {
				$item['approve'] = $arr_temp[$item['project_id']];
				$item['status_name'] = C('SON_STATUS_LIST')[$item['son_status']];
			}
		}
		
		$this->ajaxReturn(['status' => 'success', 'data' => $result
			, 'total_page' => $page->totalPages]);
	}
	
	// 查询普通的项目
	public function list()
	{
		$this->checkParameter('list');
		
		$this->whereList();
		$counts = $this->base_model->alias('aa')->where($this->where)
			->join('customer bb on aa.customer_id=bb.customer_id and bb.delete_time is null')
//			->join('customer_employee ce on aa.customer_id=ce.customer_id')
//			->join('employee cc on ce.employee_id=cc.employee_id')
			->count();
		$page = new \Think\Page($counts, I('post.pg_size', C('ONE_PAGE_SIZE'), FILTER_VALIDATE_INT));
		$page->show();
		$field = "aa.company,aa.other_cust,aa.project_id,aa.customer_id,aa.company,bb.name customer_name,bb.type,(select province_name from province where province_id=bb.province_id) province_name,aa.level,bb.is_vip,"
			. "(select city_name from city where city_id=bb.city_id) city_name,aa.name project_name,aa.status,aa.son_status,bb.address,"
//			."(SELECT max(pa.create_time) from project_approve  pa WHERE pa.project_id=aa.project_id and approve=1 and status=1 and pa.delete_time is null)  start,"
//			."(SELECT max(pa.create_time) from project_approve  pa WHERE pa.project_id=aa.project_id and approve=2 and status=1 and pa.delete_time is null)  return,"
//			."(SELECT max(pa.create_time) from project_approve  pa WHERE pa.project_id=aa.project_id and approve=3 and status=1 and pa.delete_time is null)  end,"
			. " aa.begin_date,aa.end_date,aa.scale_fee";
		$result = $this->base_model->alias('aa')->where($this->where)
//			->order($this->order)
			->field($field)
			->page(I('post.pg', 1, FILTER_VALIDATE_INT),I('post.pg_size', C('ONE_PAGE_SIZE'), FILTER_VALIDATE_INT))
			->join('customer bb on aa.customer_id=bb.customer_id and bb.delete_time is null')
			->order($this->order)
			->select();
		Log::write(json_encode(M()->_sql()));
		// 获取业务员数据
		if ($result) {
			$where_employee['customer_id'] = ['in', array_column($result, 'customer_id')];
			$field = "aa.customer_id,aa.employee_id,cc.thumbnail_url,cc.name employee_name";
			$employee = M('customer_employee')->alias('aa')->where($where_employee)
				->join('employee cc on aa.employee_id=cc.employee_id')
				->field($field)->select();
			
			$cust_employee = [];
			foreach ($employee as $value) {
//				$cust_employee[$value['customer_id']]['thumbnail_url'][]
//					= $value['thumbnail_url'];
//				$cust_employee[$value['customer_id']]['employee_id'][]
//					= $value['employee_id'];
				$cust_employee[$value['customer_id']]['employee_name'][]
					= $value['employee_name'];
				
			}
			$model = M('project_approve');
			foreach ($result as &$item) {
				$item['employee'] = $cust_employee[$item['customer_id']];
				$item['start'] = $model->where(['project_id'=>$item['project_id'],'approve'=>1,'status'=>1])->order('create_time desc')->getField('create_time');
				$item['return'] = $model->where(['project_id'=>$item['project_id'],'approve'=>2,'status'=>1])->order('create_time desc')->getField('create_time');
				$item['end'] = $model->where(['project_id'=>$item['project_id'],'approve'=>3,'status'=>1])->order('create_time desc')->getField('create_time');
				
				if ('待定' != $item['company']) {
					$item['status_name'] = C('SON_STATUS_LIST')[$item['son_status']];
				} else {
					$item['status_name'] = $item['other_status'] ?? '';
				}
			}
		}
		
		// 计算每个项目的三方客户
		foreach ($result as &$item) {
			// 特殊处理关联客户
			if (!empty($item['other_cust'])) {
				$arr = explode(',', $item['other_cust']);
				$where_c['customer_id'] = ['in', $arr];
				$other_cust = M('customer')->where($where_c)->field('customer_id,name')->select();
				$item['other_cust'] = $other_cust;
			}
		}
//		var_dump($result);
		$this->ajaxReturn(['status' => 'success', 'data' => $result, 'total_page' => $page->totalPages]);
	}
	
	private function whereApprove()
	{
		// 业务员特殊处理
		$this->where['_string'] = 'aa.delete_time is null';
		if ('salesman' == session('employee.role_type_code')) {
			$this->where['_string'] .= ' and exists(select 1 from customer_employee ce where ce.customer_id=aa.customer_id and ce.delete_time is null  and ce.employee_id=' . session('employee_id') . ')';
		} else if ('information' == session('employee.department_type_id') || 'business' == session('employee.department_type_id')) {
			// 信息部和业务部特殊处理
			$where_tt['bb.business_id'] = session('employee.department_id');
			$where_tt['bb.information_id'] = session('employee.department_id');
			$where_tt['_logic'] = 'or';
			$this->where['_complex'] = $where_tt;
		}
		
//		$this->where['aa.company'] = '本公司';
		
		if (!empty($this->param['status'])) {
			$this->where['aa.approve_status'] = $this->param['status'];
		}
		// 流程类型
		$this->where['aa.approve'] = $this->param['type'];
		
		if (1 == $this->param['order']) {
			$this->order = 'aa.create_time desc';
		} else if (2 == $this->param['order']) {
			$this->order = 'aa.level';
		} else if (3 == $this->param['order']) {
			$this->order = 'aa.scale_fee desc';
		} else if (4 == $this->param['order']) {
			$this->order = 'aa.begin_date desc';
		} else {
			$this->order = 'aa.begin_date desc';
		}
	}
	
	private function whereList()
	{
		$this->whereEmployee();
		if (!empty($this->param['name'])) {
			$where['ee.name'] = ['like', "%" . $this->param['name'] . "%"];
			$where['_string'] = 'ee.delete_time is null and ee.status=1';
			$customer_id = M('employee')->alias('ee')->where($where)
//				->join('customer_employee ce on ce.employee_id=ee.employee_id and ce.delete_time is null')
				->join('customer_employee ce on ce.employee_id=ee.employee_id')
				->getField('customer_id', true);
			if ($customer_id) {
				$this->where['aa.customer_id'] = ['in', $customer_id];
			}
		}
		if (!empty($this->param['province_id'])) {
			$this->where['bb.province_id'] = $this->param['province_id'];
		}
//		if (5 != $this->param['type']) {
		$this->where['aa.company'] = ['neq', '待定'];
//		}
		if (12 != $this->param['type']) {
			$this->where['aa.status'] = $this->param['type'];
		} else {
			$this->where['aa.status'] = ['in', [1, 2]];
			$this->where['aa.is_return'] = 1;
		}
		if (1 == $this->param['order']) {
			$this->order = 'aa.create_time';
		} else if (2 == $this->param['order']) {
			$this->order = 'aa.level';
		} else if (3 == $this->param['order']) {
			$this->order = 'aa.scale_fee desc';
		} else if (4 == $this->param['order']) {
			$this->order = "aa.begin_date is null,aa.begin_date";
		}else{
			$this->order = 'bb.province_id,bb.city_id,aa.project_id';
		}
	}
	
	
	private function whereEmployee()
	{
		$this->where['_string'] = "aa.delete_time is null";
		// 业务员
		if ('salesman' == session('employee.role_type_code')) {
			$this->where['_string'] .= ' and exists(select 1 from customer_employee ce where ce.customer_id=aa.customer_id  and ce.employee_id=' . session('employee_id') . ')';
			
			return;
		}
		
		// 信息部和业务部特殊处理
		if ('information' == session('employee.department_type_id')) {
			$this->where['information_id'] = session('employee.department_id');
		}
//		if ('business' == session('employee.department_type_id')) {
//			$this->where['business_id'] = session('employee.department_id');
//		}
	}
	
	private function checkParameter(string $type)
	{
		try {
			if ('approve' == $type) {
				(new Validator())->execute(I(''), [
					'order' => ['enum_eq' => [1, 2, 3, 4]], // 排序
					'status' => ['type' => 'integer',
						'required' => false, 'allow_empty' => true], // 状态
					'type' => ['enum_eq' => [1, 2, 3, 4, 5, 6]], // 流程类型
				]);
			} else if ('list' == $type) {
				(new Validator())->execute(I(''), [
					'order' => ['enum_eq' => [0,1, 2, 3, 4]],  // 排序
					'status' => [  // 状态
						'enum_eq' => [1, 2, 3, 4, 5],
						'required' => false, 'allow_empty' => true
					], //
					'type' => ['type' => 'integer'],  // 查询类型
				]);
			}
		} catch (\Exception $ex) {
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！']);
		}
		
		$this->param = I('');
		
	}
}