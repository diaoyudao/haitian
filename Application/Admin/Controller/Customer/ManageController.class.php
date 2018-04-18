<?php

namespace Admin\Controller\Customer;

use Think\Controller;
use Think\Log;

use Admin\Common\Model\OcModel;
use Admin\Common\Parameter\Validator;

use Admin\Model\Operate;

/**
 * 客户管理类
 */
class ManageController extends Controller
{
	private $param = [];
	private $base_model;
	
	public function __construct()
	{
		parent::__construct();
		
		$this->base_model = new OcModel('customer');
	}
	
	// 添加客户部门
	public function addDepartment()
	{
		if (IS_GET) {
			$this->display();
			return;
		}
		$param = $this->checkDepartmentParameter();
		$model = new OcModel('customer_department');
		
		$weight = $this->getDepartmentWeight($param);
		if (!empty($weight)) {
			$param['weight'] = $weight + 10;
		}
		
		
		$model->startTrans();
		try {
			$ret = $model->add($param);
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
			}
			$model->commit();
		} catch (\Exception $ex) {
//			Log::write('新增客户的部门失败：' . $model->_sql());
			$model->rollback();
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
		}
		$this->ajaxReturn(['status' => 'success']);
	}
	
	// 编辑客户部门
	public function changeDepartment()
	{
		if (IS_GET) {
			$id = I('get.id');
			if (!$id) {
				$this->show('参数错误！');
			}
			$where['customer_department_id'] = $id;
			$where['_string'] = "delete_time is null";
			$department = M('customer_department')->where($where)->find();
			$this->assign('department', $department);
			$this->display('adddepartment');
			return;
		}
		$param = $this->checkDepartmentParameter();
		$model = new OcModel('customer_department');
		$this->getDepartmentWeight($param, 'change');
		
		$model->startTrans();
		try {
			$ret = $model->save($param);
			if (false === $ret) {
				Log::write('新增客户的部门失败：' . $model->_sql());
				
				Log::write('新增客户的部门失败：' . $model->getDbError());
				
				$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
			}
			$model->commit();
		} catch (\Exception $ex) {
//			Log::write('新增客户的部门失败：' . $model->_sql());
			$model->rollback();
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
		}
		$this->ajaxReturn(['status' => 'success']);
	}
	
	public function index()
	{
		if (IS_GET) {
			$where['employee_id'] = session('employee_id');
			$cust = M('customer_history')->where($where)->getField('customer_ids');
			
			if ($cust) {
				$where_c['_string'] = $this->whereEmployee();
				$where_c['_string'] = ' delete_time is null';
				$where_c['customer_id'] = ['in', json_decode($cust)];
				
				$his = M('customer')->where($where_c)->alias('cu')->select();
			}
			
			$this->assign('customer', $his ?? []);
			$this->display();
			return;
		}
		
		// post
	}
	
	// 最近访问记录
	public function history()
	{
		$this->checkParameter('history');
		
		$model = new OcModel('customer_history');
		$where['employee_id'] = session('employee_id');
		
		$his = $model->where($where)->find();
		if ($his) {
			if (false !== strpos($his['customer_ids'], $this->param['customer_id'])) {
				$this->ajaxReturn(['status' => 'success']);
			}
			
			$arr = json_decode($his['customer_ids']);
			for ($i = 0; $i < (count($arr) - C('CUSTOMER_HIS_NUM')); $i++) {
				unset($arr[$i]);
			}
			
			$arr[] = $this->param['customer_id'];
			$data['customer_ids'] = json_encode(array_values($arr));
			
			$ret = $model->where($where)->save($data);
		} else {
			$data['employee_id'] = session('employee_id');
			$data['customer_ids'] = json_encode([$this->param['customer_id']]);
			
			$ret = $model->add($data);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	public function delevent()
	{
		$this->checkParameter('delevent');
		// 权限
		$customer_id = (M('customer_event')->find($this->param['customer_event_id']))['customer_id'];
		$cust = M('customer')->find($customer_id);
		if ('boss' != session('employee.role_type_code')
			&& (session('employee.department_id') != $cust['business_id']
				&& session('employee.department_id') != $cust['information_id'])) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '您没有权限删除！']);
		}
		
		$model = new OcModel('customer_event');
		$where['customer_event_id'] = $this->param['customer_event_id'];
		
		$ret = $model->where($where)
			->save(['delete_time' => date('Y-m-d H:i:s')]);
		if (false === $ret) {
			Log::write('删除客户事件失败：' . $model->getDbError());
			$this->ajaxReturn(['status' => 'failed', 'message' => '删除失败！']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	public function delliaison()
	{
		$this->checkParameter('delliaison');
		
		// 联络人权限
		$liaison = M('customer_liaison')->find($this->param['customer_liaison_id']);
		if ('boss' != session('employee.role_type_code')
			&& 'director' != session('employee.role_type_code')
			&& session('employee_id') != $liaison['employee_id']) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '您没有权限删除！']);
		}
		
		// 判断员工是否是自己部门的
		if ('director' == session('employee.role_type_code')) {
			$department_id = M('employee')->where(['employee_id' => $liaison['employee_id']])
				->getField('department_id');
			if ($department_id != session('employee.department_id')) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '您没有权限删除.！']);
			}
		}
		
		$model = new OcModel('customer_liaison');
		$where['customer_liaison_id'] = $this->param['customer_liaison_id'];
		
		$ret = $model->where($where)
			->save(['delete_time' => date('Y-m-d H:i:s')]);
		if (false === $ret) {
			Log::write('删除客户联络失败：' . $model->getDbError());
			$this->ajaxReturn(['status' => 'failed', 'message' => '删除失败！']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	public function sort()
	{
		if (IS_GET) {
			$this->display();
			return;
		}
		
		$this->checkParameter('sort');
		
		$cust = $this->base_model->find($this->param['customer_id']);
		if (!$cust) {
			$this->ajaxReturn(['status' => 'success']);
		}
		
		$out = false;
		if (isset($this->param['type']) && "" != $this->param['type']) {
			$where['type'] = $this->param['type'];
			$out = true;
		}
		
		if (1 == $cust['city_level']) {
			$where['province_id'] = $cust['province_id'];
		} else if (2 == $cust['city_level']) {
			$where['city_id'] = $cust['city_id'];
		} else if (0 == $cust['city_level'] && !$out) {
			$where['county_id'] = $cust['county_id'];
		}
		
		$where['city_level'] = $cust['city_level'];
		
		$custs_weight = $this->base_model->where($where)
			->order('weight')->field('customer_id,weight')->select();
		
		// 获取当前id的序号
		foreach ($custs_weight as $key => $item) {
			if ($this->param['customer_id'] == $item['customer_id']) {
				$cur_weight = $item['weight'];
				$cur_n = $key;
				break;
			}
		}
		
		if (1 == $this->param['top']) {
			$prev_n = -1;
		} else {
			// 获取相对id的序号
			foreach ($custs_weight as $key => $item) {
				if ($this->param['prev_cust'] == $item['customer_id']) {
					$prev_n = $key;
					break;
				}
			}
			
			if (!isset($prev_n)) {
				Log::write('客户排序：未找到该客户');
				$this->ajaxReturn(['status' => 'success']);
			}
		}
		
		if ($cur_n <= $prev_n) {
			// cur < id
			$begin = $cur_n + 1;
			$end = $prev_n;
			$last_w = $custs_weight[$cur_n]['weight'];
			$custs_weight[$cur_n]['weight'] = $custs_weight[$prev_n]['weight'];
			
			$this->sortAdd($custs_weight, $begin, $end, $last_w);
		} else if ($cur_n > $prev_n) {
			// cur > id
			$begin = $prev_n + 1;
			$end = $cur_n - 1;
			$last_w = $custs_weight[$cur_n]['weight'];
			$custs_weight[$cur_n]['weight'] = $custs_weight[$begin]['weight'];
			
			$this->sortDel($custs_weight, $begin, $end, $last_w);
		}
		
		$this->saveSort($custs_weight, $begin, $end, $cur_n);
	}
	
	//向上
	public function sortTop()
	{
		$this->checkParameter('sorttop');
		
		$this->base_model->startTrans();
		try {
			$cur_weight = $this->base_model->where(['customer_id' => $this->param['id']])->getField('weight');
			$prev_weight = $this->base_model->where(['customer_id' => $this->param['prev_id']])->getField('weight');
			$where['customer_id'] = $this->param['customer_id'];
			// save db
			
			$ret = $this->base_model->where(['customer_id' => $this->param['id']])
				->save(['weight' => $prev_weight]);
			if (false === $ret) {
				E('db err:' . $this->base_model->getDbError());
			}
			$res = $this->base_model->where(['customer_id' => $this->param['prev_id']])
				->save(['weight' => $cur_weight]);
			if (false === $res) {
				E('db err:' . $this->base_model->getDbError());
			}
			
			$this->base_model->commit();
		} catch (\Exception $ex) {
			$this->base_model->rollback();
			
			Log::write('客户排序失败' . $ex->getMessage());
			$this->ajaxReturn(['status' => 'failed'
				, 'message' => '客户排序失败']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	private function saveSort($custs_weight, $begin, $end, $cur_n)
	{
		$this->base_model->startTrans();
		// save db
		try {
			$where['customer_id'] = $this->param['customer_id'];
			$ret = $this->base_model->where($where)
				->save(['weight' => $custs_weight[$cur_n]['weight']]);
			if (false === $ret) {
				E('db err:' . $this->base_model->getDbError());
			}
			
			for ($i = $begin; $i <= $end; $i++) {
				$where['customer_id'] = $custs_weight[$i]['customer_id'];
				$ret = $this->base_model->where($where)
					->save(['weight' => $custs_weight[$i]['weight']]);
				if (false === $ret) {
					E('db err:' . $this->base_model->getDbError());
				}
			}
			
			$this->base_model->commit();
		} catch (\Exception $ex) {
			$this->base_model->rollback();
			
			Log::write('添加客户失败' . $ex->getMessage());
			$this->ajaxReturn(['status' => 'failed'
				, 'message' => '新增客户失败']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	// 序号向前移动大到小
	private function sortAdd(&$custs_weight, $begin, $end, $last_w)
	{
		for ($i = $begin; $i <= $end; $i++) {
			$cur_w = $custs_weight[$i]['weight'];
			$custs_weight[$i]['weight'] = $last_w;
			$last_w = $cur_w;
		}
	}
	
	// 序号向后移动小到大
	private function sortDel(&$custs_weight, $begin, $end, $last_w)
	{
		for ($i = $end; $i >= $begin; $i--) {
			$cur_w = $custs_weight[$i]['weight'];
			$custs_weight[$i]['weight'] = $last_w;
			$last_w = $cur_w;
		}
	}
	
	public function list()
	{
		$ret = 'true ';
		$where['_string'] = 'delete_time is null';
		
		if ('salesman' == session('employee.role_type_code') && 'information' == session('employee.department_type_id')) {
			$where['_string'] .= ' and exists(select 1 from customer_employee ce where ce.customer_id=aa.customer_id and ce.delete_time is null  and ce.employee_id=' . session('employee_id') . ')';
			$ret .= ' and exists(select 1 from customer_employee ce where ce.customer_id=cu.customer_id and ce.delete_time is null and ce.employee_id=' . session('employee_id') . ')';
		} else if ('information' == session('employee.department_type_id')) {
			$where['information_id'] = session('employee.department_id');
			$ret .= "and information_id='" . session('employee.department_id') . "'";
		} else if ('business' == session('employee.department_type_id')) {
//			$where['business_id'] = session('employee.department_id');
//			$ret .= "and business_id='" . session('employee.department_id') . "'";
		}
		$ret .= " and ";
		// 获取类型列表和客户数
		
		$field = 'type,count(*) num';
		$data = M('customer')->where($where)->group('type')->alias('aa')
			->field($field)->select();
		
		$total = array_sum(array_column($data, 'num'));
		$arr = [];
		foreach ($data as $value) {
			$arr[$value['type']] = $value['num'];
		}
		
		// 获取Vip客户的数量
		$where['is_vip'] = 1;
		$abc = M('customer')->where($where)->alias('aa')->count();
		
		// 获取的最近联系数量
		$last_t = (new \DateTime)->modify('- 7day')->format('Y-m-d H:i:s');
		$where_lis['_string'] = 'aa.delete_time is null';
		$where_lis['liaison_time'] = ['egt', $last_t];
		if ('salesman' == session('employee.role_type_code') || 'boss' == session('employee.role_type_code')) {
			$where_lis['aa.employee_id'] = session('employee_id');
		} else if ('director' == session('employee.role_type_code')) {
			$where_e['_string'] = 'delete_time is null';
			$where_e['department_id'] = session('employee.department_id');
			
			$employee = M('employee')->where($where_e)->getField('employee_id', true);
			$where_lis['aa.employee_id'] = ['in', $employee];
		}
		$model = M('customer_liaison');
		$num_lis = $model->where($where_lis)->alias('aa')->count();
		
		// 获取省的总数
		$field = 'aa.*,(select count(*) num from customer cu where ' . $ret . ' province_id=aa.province_id and delete_time is null) num';
		$provinces = M('province')->alias('aa')
			->field($field)->select();
		
		// sort
		array_multisort(array_column($provinces, 'num'), SORT_NUMERIC, SORT_DESC, $provinces);
		
		$this->assign('cust_total', $total);
		$this->assign('type_list', $arr);
		$this->assign('provinces', $provinces);
		$this->assign('num_abc', $abc);
		$this->assign('num_lis', $num_lis);
		$this->display();
	}
	
	public function add()
	{
		if (IS_GET) {
			$this->getProvince();
			$this->getDepartment();
			
			$this->display();
			return;
		}
		
		// post
		$this->checkParameter('add');
		$this->duplicateCheck();
		
		//设置城市级别
		if ($this->param['province_id'] && !$this->param['city_id']) {
			$this->param['city_level'] = 1;
		} else if ($this->param['city_id'] && !$this->param['county_id']) {
			$this->param['city_level'] = 2;
		} else {
			$this->param['city_level'] = 0;
		}
		//
		$this->param['cur_department_id'] = session('employee.department_id');
		$this->param['create_department_id'] = session('employee.department_id');
		
		// 当前所属部们
		if ('information' == session('employee.department_type_id')) {
			$this->param['information_id'] = session('employee.department_id');
		} else if ('business' == session('employee.department_type_id')) {
			$this->param['business_id'] = session('employee.department_id');
		} else if ('boss' == session('employee.role_type_code')) {
			$department_id = $this->param['department_id'];
			$employee_id = $this->param['employee_id'];
			
			$type = M('department')->where(['department_id' => $department_id])
				->getField('department_type_id');
			if ('information' == $type) {
				$this->param['information_id'] = $this->param['department_id'];
			} else if ('business' == $type) {
				$this->param['business_id'] = $this->param['business_id'];
			} else {
				$this->ajaxReturn(['status' => 'failed', 'message' => '部门类型不对']);
			}
			
			$this->param['cur_department_id'] = $department_id;
			$this->param['create_department_id'] = $department_id;
			$this->param['employee_id'] = $employee_id;
		}
		
		if (empty($this->param['employee_id'])) {
			$this->param['employee_id'] = session('employee_id');
		}
		
		$this->param['desc'] = str_replace(' ', '&nbsp;', $_POST['desc']);
		
		$this->base_model->startTrans();
		try {
			$customer_id = $this->base_model->add($this->param);
			if (false === $customer_id) {
				E('db err:' . $this->base_model->getDbError());
			}
			
			// 修改权重值为id
			$ret = $this->base_model->where(['customer_id' => $customer_id])
				->save(['weight' => $customer_id]);
			if (false === $ret) {
				E('db err:' . $this->base_model->getDbError());
			}
			
			// 默认将该业务员添加到联系表
			$data['customer_id'] = $customer_id;
			
			if ('boss' == session('employee.role_type_code')) {
				$data['department_id'] = $department_id;
				$data['employee_id'] = $employee_id;
			} else {
				$data['department_id'] = session('employee.department_id');
				$data['employee_id'] = session('employee_id');
			}
			
			$data['_string'] = 'delete_time is null';
			$model = new OcModel('customer_employee');
			$find = $model->where($data)->find();
			if (!$find) {
				$ret = $model->add($data);
				if (false === $customer_id) {
					E('db err:' . $model->getDbError());
				}
			}
			
			// 计入日志
			$log['customer_id'] = $customer_id;
			$log['customer_name'] = $this->param['name'];
			$log['event'] = '新增客户';
			(new Operate)->log($log);
			
			$this->base_model->commit();
		} catch (\Exception $ex) {
			$this->base_model->rollback();
			
			Log::write('添加客户失败' . $ex->getMessage());
			$this->ajaxReturn(['status' => 'failed'
				, 'message' => '新增客户失败']);
		}
		
		$this->ajaxReturn(['status' => 'success', 'customer_id' => $customer_id]);
	}
	
	public function change()
	{
		if (IS_GET) {
			if (empty(I('get.customer_id'))) {
				$this->show('参数错误，请检查！');
				return;
			}
			
			$cust = $this->base_model->find(I('get.customer_id'));
			
			if (!empty($cust['city_id'])) {
				$this->getCounty($cust['city_id']);
			}
			
			$this->getProvince($cust['province_id']);
			$this->assign('customer', $cust);
			$this->display('Customer/search:addinfo');
			return;
		}
		
		// post
		$this->checkParameter('change');
		$this->duplicateCheck('change');
		
		//设置城市级别
		if ($this->param['province_id'] && !$this->param['city_id']) {
			$this->param['city_level'] = 1;
		} else if ($this->param['city_id'] && !$this->param['county_id']) {
			$this->param['city_level'] = 2;
		} else {
			$this->param['city_level'] = 0;
		}
		
		$this->param['desc'] = str_replace(' ', '&nbsp;', $_POST['desc']);
		
		$this->base_model->startTrans();
		try {
			$ret = $this->base_model->save($this->param);
			if (false === $ret) {
				E('修改客户失败：' . $this->base_model->getDbError());
			}
			
			$this->base_model->commit();
		} catch (\Exception $ex) {
			$this->base_model->rollback();
			
			Log::write('修改客户失败' . $ex->getMessage());
			$this->ajaxReturn(['status' => 'failed'
				, 'message' => '修改客户失败']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	// 总经理修改客户业务员
	public function departEmployee()
	{
		if (IS_GET) {
			if (empty(I('get.id'))) {
				$this->show('参数错误，请检查！');
				return;
			}
			
			$where['customer_id'] = I('get.id');
			$field = "aa.*,(select name from department where department_id=aa.business_id) business_name,(select name from department where department_id=aa.information_id) information_name";
			$customer = $this->base_model->alias('aa')->where($where)->field($field)->find();
			
			$where['department_id'] = ['in', [$customer['business_id'], $customer['information_id']]];
			$where['_string'] = 'delete_time is null';
			$select_employee = M('customer_employee')->where($where)
				->field('employee_id,department_id')->select();
			
			$where_e['aa.department_id'] = ['in', [$customer['business_id'], $customer['information_id']]];
			$where_e['_string'] = 'aa.delete_time is null';
			$field = "aa.name,aa.employee_id,bb.role_type_code,aa.thumbnail_url,aa.department_id";
			$employee = M('employee')->alias('aa')->where($where_e)->field($field)
				->join('role bb on aa.role_id=bb.role_id and bb.delete_time is null')
				->select();
			Log::write(json_encode($customer));
			$this->assign('customer', $customer);
			$this->assign('employee', $employee);
			$this->assign('select_employee', $select_employee);
			$this->display();
			return;
		}
		
		if ('boss' != session('employee.role_type_code')) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '您没有权限修改']);
		}
		
		$this->checkParameter('departEmployee');
		
		$list = [];
		foreach ($this->param['list'] as $value) {
			$list[$value['department_id']][] = $value['employee_id'];
		}
		
		$model = new OcModel('customer_employee');
		$model->startTrans();
		try {
			foreach ($list as $department_id => $item) {
				// 删除没有选中的
				$where['customer_id'] = $this->param['customer_id'];
				$where['department_id'] = $department_id;
				$where['employee_id'] = ['not in', $item];
				$ret = $model->where($where)->save(['delete_time' => date('Y-m-d H:i:s')]);
				if (false === $ret) {
					E('db error1:' . $model->getDbError());
				}
				//
				$data['customer_id'] = $this->param['customer_id'];
				$data['department_id'] = $department_id;
				$data['_string'] = 'delete_time is null';
				
				foreach ($item as $value) {
					$data['employee_id'] = $value;
					
					// 判断是否已经存在
					$find = $model->where($data)->find();
					if ($find) continue;
					
					$ret = $model->add($data);
					if (false === $ret) {
						E('db error:' . $model->getDbError());
					}
				}
			}
			
			$model->commit();
		} catch (\Exception $ex) {
			$model->rollback();
			Log::write('修改客户的联络业务员失败：' . $ex->getMessage());
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	// 修改本部门客户的业务人员
	public function employee()
	{
		if (IS_GET) {
			if (empty(I('get.id'))) {
				$this->show('参数错误，请检查！');
				return;
			}
			
			$where['customer_id'] = I('get.id');
			$customer_name = $this->base_model->where($where)->getField('name');
			$where['department_id'] = session('employee.department_id');
			$where['_string'] = 'delete_time is null';
			$select_employee = M('customer_employee')->where($where)
				->getField('employee_id', true);
			$where_e['aa.department_id'] = session('employee.department_id');
			$where_e['_string'] = 'aa.delete_time is null';
			$field = "aa.name,aa.employee_id,bb.role_type_code,aa.thumbnail_url";
			$employee = M('employee')->alias('aa')->where($where_e)->field($field)
				->join('role bb on aa.role_id=bb.role_id and bb.delete_time is null')
				->select();
			
			$this->assign('customer_name', $customer_name);
			$this->assign('employee', $employee);
			$this->assign('select_employee', $select_employee);
			$this->display();
			
			return;
		}
		
		// 只有主任才能修改
		if ('director' != session('employee.role_type_code')) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '您没有权限修改']);
		}
		
		$this->checkParameter('employee');
		
		$model = new OcModel('customer_employee');
		$model->startTrans();
		try {
			// 删除没有选中的
			$where['customer_id'] = $this->param['customer_id'];
			$where['department_id'] = session('employee.department_id');
			$where['employee_id'] = ['not in', $this->param['list']];
			$ret = $model->where($where)->save(['delete_time' => date('Y-m-d H:i:s')]);
			if (false === $ret) {
				E('db error1:' . $model->getDbError());
			}
			//
			$data['customer_id'] = $this->param['customer_id'];
			$data['department_id'] = session('employee.department_id');
			$data['_string'] = 'delete_time is null';
			
			foreach ($this->param['list'] as $value) {
				$data['employee_id'] = $value;
				
				// 判断是否已经存在
				$find = $model->where($data)->find();
				if ($find) continue;
				
				$ret = $model->add($data);
				if (false === $ret) {
					E('db error:' . $model->getDbError());
				}
			}
			
			$model->commit();
		} catch (\Exception $ex) {
			$model->rollback();
			Log::write('修改客户的联络业务员失败：' . $ex->getMessage());
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	// 添加联系人
	public function addContact()
	{
		$this->checkParameter('addContact');
		
		$model = new OcModel('customer_contact');
		
		$model->startTrans();
		try {
			$ret = $model->add($this->param);
			
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
			}
			$this->param['customer_contact_id'] = $ret;
			$this->param['weight'] = $ret;
			$res = $model->save($this->param);
			if (false === $res) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
			}
			$model->commit();
		} catch (\Exception $ex) {
			Log::write('新增客户的联系人失败：' . $model->_sql());
			$model->rollback();
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
		}
		$this->ajaxReturn(['status' => 'success']);
	}
	
	// 修改联系人
	public function changeContact()
	{
		$this->checkParameter('changeContact');
		
		$model = new OcModel('customer_contact');
		$ret = $model->save($this->param);
		if (false === $ret) {
			Log::write('修改客户的联系人失败：' . $model->getDbError());
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	
	public function contactSort()
	{
		if (IS_GET) {
			if (empty(I('get.id'))) {
				return;
			}
			
			$field = '*';
			$where['_string'] = 'delete_time is null';
			$where['customer_id'] = I('get.id');
			
			$depart = M('customer_department')->where($where)
				->field($field)->order('weight')->select();
//			$arr_temp = M('customer_contact')->where($where)
//				->field($field)->order('weight desc')->select();
			$where['status'] = 0;
			$quit_contact = M('customer_contact')->where($where)
				->field($field)->order('weight')->select();
			$data = [];
			$where['status'] = 1;
			$data['depart'] = $depart;
			$data['leave'] = $quit_contact;
			foreach ($depart as $v) {
				$where['customer_department_id'] = $v['customer_department_id'];
				$data['contact'][] = M('customer_contact')->where($where)
					->field($field)->order('function')->select();
				
			}

//			var_dump($data['contact']);
			$this->assign('data', $data);
			$this->assign('depart', $depart);
			$this->assign('customer_id', I('get.id'));
			$this->display();
			return;
		}
	}
	
	public function sortDepartment()
	{
		$data = I('post.data');
		$depart = $data['depart'];
		$contact = [];
//		foreach ($data['contact'] as $v) {
//			if (!empty($v)) {
//				foreach ($v as $vv) {
//					$contact[] = $vv;
//				}
//			}
//		}
//		if ($data['leave']) {
//			$contact = array_merge($contact, $data['leave']);
//		}
		$model = new OcModel('customer_department');
//		$model2 = new OcModel('customer_contact');
		
		$model->startTrans();
		try {
			foreach ($depart as $item) {
				$item['delete_time'] = null;
				$ret = $model->save($item);
				if (false === $ret) {
					$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
				}
			}
//			foreach ($contact as $item2) {
//				$item2['delete_time'] = null;
//				$res = $model2->save($item2);
//				if (false === $res) {
//					$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
//				}
//			}
			$model->commit();
		} catch (\Exception $ex) {
			$model->rollback();
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
		}
		$this->ajaxReturn(['status' => 'success']);
	}
	
	// 复职
	public function back()
	{
		$this->checkParameter('leave');
		$model = new OcModel('customer_contact');
		$model->startTrans();
		try {
			$where['customer_contact_id'] = $this->param['customer_contact_id'];
			$ret = $model->where($where)->save(['status' => 1]);
			if (false == $ret) {
				// 状态为已经复职，不必再次记录到大事件
				$this->param['is_event'] = 0;
			}
			
			// 保存大事件
			if (1 == $this->param['is_event']) {
				$contact = $model->find($this->param['customer_contact_id']);
				
				$department = M('customer_department')->find($contact['customer_department_id']);
				$contact['department'] = $department['department'];
				
				$data['customer_id'] = $contact['customer_id'];
				$data['occur_time'] = date('Y-m-d');
				$data['context'] = $contact['department'] . $contact['position'] . $contact['name'] . "复职";
				$model_event = M('customer_event');
				$re = $model_event->add($data);
				if (false === $re) {
					E('保存大事件失败：' . $model->getDbError());
				}
				if ($department['delete_time'] != null) {
					$param['customer_department_id'] = $contact['customer_department_id'];
					$param['delete_time'] = null;
					$res = M('customer_department')->save($param);
					if (false === $res) {
						E('修改部门失败：' . $model->getDbError());
					}
				}
			}
			
			$model->commit();
		} catch (\Exception $ex) {
			$model->rollback();
			Log::write('修改客户离职失败' . $ex->getMessage());
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败：' . $model->getDbError()]);
		}
		
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	// 离职
	public function leave()
	{
		$this->checkParameter('leave');
		$model = new OcModel('customer_contact');
		$model->startTrans();
		try {
			$where['customer_contact_id'] = $this->param['customer_contact_id'];
			$ret = $model->where($where)->save(['status' => 0]);
			if (false == $ret) {
				// 状态为已经离职，不必再次记录到大事件
				$this->param['is_event'] = 0;
			}
			
			// 保存大事件
			if (1 == $this->param['is_event']) {
				$contact = $model->find($this->param['customer_contact_id']);
				
				$contact['department'] = M('customer_department')->find($contact['customer_department_id'])['department'];
				
				$data['customer_id'] = $contact['customer_id'];
				$data['occur_time'] = date('Y-m-d');
				$data['context'] = $contact['department'] . $contact['position'] . $contact['name'] . "离职";
				$model_event = M('customer_event');
				$ret = $model_event->add($data);
				if (false === $ret) {
					E('保存大事件失败：' . $model->getDbError());
				}
			}
			
			$model->commit();
		} catch (\Exception $ex) {
			$model->rollback();
			Log::write('修改客户离职失败' . $ex->getMessage());
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败：' . $model->getDbError()]);
		}
		
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	// 添加标签
	public function tags()
	{
		$this->checkParameter('tags');
		$where['customer_id'] = $this->param['customer_id'];
		$tags = $this->base_model->where($where)->getField('tags');
		
		if ($tags) {
			$arr = json_decode($tags);
			if (in_array($this->param['tags'], $arr)) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '该标签已经存在了']);
			}
			$arr[] = $this->param['tags'];
			$this->param['tags'] = json_encode($arr);
		} else {
			$this->param['tags'] = json_encode([$this->param['tags']]);
		}
		
		$ret = $this->base_model->save($this->param);
		if (false === $ret) {
			Log::write('修改客户的标签失败：' . $this->base_model->getDbError());
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	// 添加客户事件
	public function addEvent()
	{
		$this->checkParameter('addEvent');
		
		$model = new OcModel('customer_event');
		$ret = $model->add($this->param);
		if (false === $ret) {
			Log::write('新增客户的大事件失败：' . $model->getDbError());
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	public function changeEvent()
	{
		$this->checkParameter('changeEvent');
		
		$model = new OcModel('customer_event');
		$ret = $model->save($this->param);
		if (false === $ret) {
			Log::write('修改客户的大事件失败：' . $model->getDbError());
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	public function addLiaison()
	{
		$this->liaison();
	}
	
	public function changeLiaison()
	{
		$this->liaison('change');
	}
	
	// 添加联络记录
	public function liaison($type = 'add')
	{
		if ('add' == $type) {
			$this->checkParameter('addLiaison');
			$this->param['employee_id'] = session('employee_id');
		} else
			$this->checkParameter('changeLiaison');
		
		$model = new OcModel('customer_liaison');
		$model->startTrans();
		try {
			if ('add' == $type)
				$ret = $model->add($this->param);
			else {
				// 主任批复
				$save_date = $this->param;
				
				if (!empty($this->param['reply'])) {
					$save_date['is_reply'] = 1;
				}
				
				$ret = $model
					->where(['customer_liaison_id' => $this->param['customer_liaison_id']])
					->save($save_date);
			}
			if (false === $ret) {
				E('db error:' . $model->getDbError());
			}
			
			// 加入周报
			if (1 == $this->param['is_export']) {
				$this->addWeekExport(('add' == $type) ? $ret : $this->param['customer_liaison_id']);
			}
			
			$model->commit();
		} catch (\Exception $ex) {
			$model->rollback();
			Log::write('新增客户的联络记录失败：' . $ex->getMessage());
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败:' . $ex->getMessage()]);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	private function addWeekExport($liaison_id)
	{
		// 判断是否已经加入了周报
		$model = new OcModel('work_export');
		
		$find = $model->where(['liaison_id' => $liaison_id])->find();
		if ($find) {
			return;
		}
		
		$data['project_id'] = $this->param['project_id'];
		$data['customer_id'] = $this->param['customer_id'];
		$data['customer_contact_id'] = $this->param['customer_contact_id'];
		$data['type'] = $this->param['important'];
		$data['is_over'] = $this->param['status'];
		$data['desc'] = $this->param['context'];
		$data['context'] = $this->param['context'];
		$data['week'] = (new \DateTime($this->param['liaison_time']))->format('W');
		$data['date'] = (new \DateTime($this->param['liaison_time']))->format('Y-m-d');
		$data['employee_id'] = session('employee_id');
		$data['department_id'] = session('employee.department_id');
		$data['liaison_id'] = $liaison_id;
		
		$ret = $model->add($data);
		if (false === $ret) {
			Log::write('db err:' . $model->getDbError());
			
			E('联络加入周报失败！');
		}
	}
	
	public function liaisonReply()
	{
		$this->checkParameter('liaison');
		
		$model = new OcModel('customer_liaison');
		$ret = $model->save($this->param);
		if (false === $ret) {
			Log::write('批复客户的联络记录失败：' . $model->getDbError());
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	public function opponent()
	{
		$this->checkParameter('opponent');
		$type = empty($this->param['opponent_id']) ? 'add' : 'change';
		
		$model = new OcModel('opponent');
		$where['name'] = $this->param['name'];
		$where['_string'] = 'delete_time is null';
		$find = $model->where($where)->find();
		if ($find) {
			$ret = $model->where($where)->save($this->param);
		} else {
			$ret = $model->add($this->param);
		}
		if (false === $ret) {
			Log::write('db error:' . $model->getDbError());
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
		}
		
		$this->ajaxReturn(['status' => 'success', 'opponent_id' => $ret]);
	}
	
	public function delOpponent()
	{
		$this->checkParameter('delopponent');
		
		$model = new OcModel('opponent');
		$where['name'] = $this->param['name'];
		$where['_string'] = 'delete_time is null';
		$ret = $model->where($where)->save(['delete_time' => date('Y-m-d H:i:s')]);
		if (false === $ret) {
			Log::write('db error:' . $model->getDbError());
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}

//	private function getProvince($province_id = null)
//	{
//		$where['_string'] = 'delete_time is null';
//		$result = M('province')->where($where)->order('province_id')->select();
//		$this->assign('province', $result);
//		if ($province_id) {
//			$where['province_id'] = $province_id;
//			$city = M('city')->order('city_id')->where($where)->select();
//			$this->assign('city', $city);
//		}
//	}
	//根据客户数量显示省份
	public function getProvince($province_id = null)
	{
		$field = 'aa.*,(select count(*) num from customer cu where '
			. $this->whereEmployee() . ' province_id=aa.province_id and delete_time is null) num';
		
		$result = M('province')->alias('aa')->where('delete_time is null')
			->field($field)->order('province_id')->select();
		array_multisort(array_column($result, 'num'), SORT_NUMERIC, SORT_DESC, $result);
		$this->assign('province', $result);
		if ($province_id) {
			$where['province_id'] = $province_id;
			$city = M('city')->order('city_id')->where($where)->select();
			$this->assign('city', $city);
		}
		
	}
	
	private function getCounty($city_id)
	{
		$where['city_id'] = $city_id;
		$where['_string'] = 'delete_time is null';
		
		$result = M('county')->where($where)->order('county_id')->select();
		$this->assign('county', $result);
	}
	
	private function getDepartment()
	{
		$where['_string'] = 'delete_time is null';
		$where['department_type_id'] = ['neq', 'other'];
		
		$department = M('department')->where($where)
			->field('department_id,name')->select();
		
		$this->assign('department', $department);
	}
	
	private function whereEmployee()
	{
		$ret = 'true ';
		if ('salesman' == session('employee.role_type_code') && 'information' == session('employee.department_type_id')) {
			$this->where['_string'] = ' exists(select 1 from customer_employee ce where ce.customer_id=cu.customer_id and ce.delete_time is null  and ce.employee_id=' . session('employee_id') . ')';

			$ret .= " and exists(select 1 from customer_employee ce where ce.customer_id=cu.customer_id and ce.delete_time is null  and ce.employee_id=" . session('employee_id') . ") ";
		} else
			// 信息部和业务部特殊处理
			if ('information' == session('employee.department_type_id')) {
				$this->where['information_id'] = session('employee.department_id');
				$ret .= "and information_id='" . session('employee.department_id') . "'";
			} else if ('business' == session('employee.department_type_id')) {
//				$this->where['business_id'] = session('employee.department_id');
//				$ret .= "and business_id='" . session('employee.department_id') . "'";
			}
		
		return $ret . " and ";
	}
	
	public function delDepartment()
	{
		$param = $this->checkDepartmentParameter('del');
		$data['status'] = 0;
		$param['delete_time'] = date('Y-m-d H:i:s');
		$model = new OcModel('customer_department');
		$model2 = new OcModel('customer_contact');
		
		$model->startTrans();
		try {
			$ret = $model->save($param);
			$res = $model2->where(['customer_department_id' => $param['customer_department_id']])->save($data);
			
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
			}
			if (false === $res) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
			}
			
			$model->commit();
		} catch (\Exception $ex) {
//			Log::write('新增客户的部门失败：' . $model->_sql());
			$model->rollback();
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
		}
		$this->ajaxReturn(['status' => 'success']);
	}
	
	public function delContact()
	{
		$data['customer_contact_id'] = I('post.customer_contact_id');
		$data['delete_time'] = date('Y-m-d H:i:s');
		$model = new OcModel('customer_contact');
		
		$model->startTrans();
		try {
			$ret = $model->save($data);
			
			if (false === $ret) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
			}
			$model->commit();
		} catch (\Exception $ex) {
			$model->rollback();
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台失败']);
		}
		$this->ajaxReturn(['status' => 'success']);
	}
	
	private function getDepartmentWeight($param, $type = 'add')
	{
		$model = new OcModel('customer_department');
		$param['_string'] = "delete_time is null";
		$res = $model->where($param)->select();
		if ($res) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '该部门已存在！']);
		}
		if ($type == 'change') {
			return;
		}
		$data['customer_id'] = $param['customer_id'];
		$data['_string'] = "delete_time is null";
		$weight = $model->where($data)->max('weight');
		
		return $weight;
	}
	
	private function checkDepartmentParameter($type = 'add')
	{
		if ($type == "del") {
			try {
				(new Validator())->execute(I('post.'), [
					'customer_department_id' => ['type' => 'integer'],
				]);
			} catch (\Exception $ex) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！' . $ex->getMessage()]);
			}
		}
		if ($type == "change") {
			try {
				(new Validator())->execute(I('post.'), [
					'customer_department_id' => ['type' => 'integer'],
				]);
			} catch (\Exception $ex) {
				$this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！' . $ex->getMessage()]);
			}
		}
		try {
			(new Validator())->execute(I('post.'), [
				'customer_id' => ['type' => 'integer', 'required' => false, 'allow_empty' => true],
				'department' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
			
			]);
		} catch (\Exception $ex) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！' . $ex->getMessage()]);
		}
		
		$param = I('post.');
		return $param;
	}
	
	/**
	 * 重复检查
	 * @param $type  类型，add是新增，change是修改
	 */
	private function duplicateCheck($type = 'add')
	{
		$where['_string'] = 'delete_time is null';
		$where['name'] = $this->param['name'];
		
		if ($type == 'add') {
			$result = $this->base_model->where($where)->find();
		} else {
			$where['customer_id'] = ['neq', $this->param['customer_id']];
			$result = $this->base_model->where($where)
				->find();
		}
		
		if ($result) {
			$this->ajaxReturn([
				'status' => 'failed',
				'message' => '该客户已经存在，请检查！'
			]);
		}
	}
	
	private function checkParameter(string $type)
	{
		$this->param = I('post.');
		try {
			if ('add' == $type || 'change' == $type) {
				if ('change' == $type) {
					(new Validator())->execute(I('post.'), [
						'customer_id' => ['type' => 'integer'],
					]);
				}
				(new Validator())->execute(I('post.'), [
					'name' => ['type' => 'string'],
					'type' => ['type' => 'integer'],
					'is_vip' => ['enum_eq' => [0, 1]],
					'province_id' => ['type' => 'integer', 'required' => false, 'allow_empty' => true],
					'city_id' => ['type' => 'integer', 'required' => false, 'allow_empty' => true],
					'county_id' => ['type' => 'integer', 'required' => false, 'allow_empty' => true],
					'address' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'desc' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'is_send' => ['enum_eq' => [1], 'required' => false],
				]);
				if (empty($this->param['is_send'])) {
					$this->param['is_send'] = 0;
				}
				if (empty($this->param['city_id'])) {
					$this->param['city_id'] = null;
				}
				if (empty($this->param['county_id'])) {
					$this->param['county_id'] = null;
				}
				if (empty($this->param['province_id'])) {
					$this->param['province_id'] = null;
				}
				
			} else if ('employee' == $type) {
				(new Validator())->execute(I('post.'), [
					'customer_id' => ['type' => 'integer'],
					'list' => [
						'type' => 'array',
						'value' => [
							'type' => 'integer'
						]
					]
				]);
			} else if ('departEmployee' == $type) {
				(new Validator())->execute(I('post.'), [
					'customer_id' => ['type' => 'integer'],
					'list' => [
						'type' => 'array',
						'value' => [
							'type' => 'array',
							'keys' => [
								'department_id' => ['type' => 'integer'],
								'employee_id' => ['type' => 'integer'],
							]
						]
					]
				]);
			} else if ('addContact' == $type || 'changeContact' == $type) {
				if ('changeContact' == $type) {
					(new Validator())->execute(I('post.'), [
						'customer_contact_id' => ['type' => 'integer'],
					]);
				}
				(new Validator())->execute(I('post.'), [
					'customer_id' => ['type' => 'integer'],
					'name' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'position' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'sex' => ['enum_eq' => [0, 1, 2]],
					'function' => ['enum_eq' => [1, 2, 3, 4]],
					'birthday' => ['regexp' => '/^\d{2}\-\d{2}$/', 'required' => false, 'allow_empty' => true],
					'tel' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'phone' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'weixin' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'qq' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'email' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'is_remind' => ['enum_eq' => ['1'], 'required' => false],
				]);
				if (empty($this->param['is_remind'])) {
					$this->param['is_remind'] = 0;
				}
				
				if (1 == $this->param['sex']) {
					$this->param['head_image'] = '/public/img/info/man.png';
					$this->param['thumbnail_url'] = '/public/img/info/man.png';
				} else if (2 == $this->param['sex']) {
					$this->param['head_image'] = '/public/img/info/woman.png';
					$this->param['thumbnail_url'] = '/public/img/info/woman.png';
				} else {
					$this->param['head_image'] = null;
					$this->param['thumbnail_url'] = null;
				}
			} else if ('leave' == $type) {
				(new Validator())->execute(I('post.'), [
					'customer_contact_id' => ['type' => 'integer'],
					'is_event' => ['enum_eq' => [1, 0]],
				]);
			} else if ('tags' == $type) {
				(new Validator())->execute(I('post.'), [
					'customer_id' => ['type' => 'integer'],
					'tags' => ['type' => 'string'],
				]);
			} else if ('addEvent' == $type || 'changeEvent' == $type) {
				if ('changeEvent' == $type) {
					(new Validator())->execute(I('post.'), [
						'customer_event_id' => ['type' => 'integer'],
					]);
				}
				(new Validator())->execute(I('post.'), [
					'customer_id' => ['type' => 'integer'],
					'occur_time' => ['type' => 'date'],
					'context' => ['type' => 'string'],
				]);
			} else if ('addLiaison' == $type || 'changeLiaison' == $type) {
				if ('changeLiaison' == $type) {
					(new Validator())->execute(I('post.'), [
						'customer_liaison_id' => ['type' => 'integer'],
					]);
				}
				(new Validator())->execute(I('post.'), [
					'customer_id' => ['type' => 'integer'],
					'project_id' => ['type' => 'integer', 'required' => false, 'allow_empty' => true],
					'liaison_time' => ['regexp' => '/^\d{4}-\d{2}-\d{2}$/'],
					'customer_contact_id' => ['type' => 'integer', 'required' => false, 'allow_empty' => true],
					'status' => ['enum_eq' => [0, 1]],
					'context' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'important' => ['enum_eq' => ['0', '1'], 'required' => false],
					'is_export' => ['enum_eq' => ['0', '1'], 'required' => false],
					'next_time' => ['regexp' => '/^\d{4}-\d{2}-\d{2}$/', 'required' => false, 'allow_empty' => true],
					'reply' => ['type' => 'string',
						'required' => false, 'allow_empty' => true
					],
				]);
				
				if (empty($this->param['next_time'])) {
					$this->param['next_time'] = null;
				}
				if (empty($this->param['project_id'])) {
					$this->param['project_id'] = null;
				}
				if (empty($this->param['customer_contact_id'])) {
					$this->param['customer_contact_id'] = null;
				}
				$this->param['important'] = $this->param['important'] ?? 0;
				$this->param['is_export'] = $this->param['is_export'] ?? 0;
			} else if ('liaisonReply' == $type) {
				(new Validator())->execute(I('post.'), [
					'customer_liaison_id' => ['type' => 'integer'],
					'reply' => ['type' => 'string'],
				]);
			} else if ('opponent' == $type) {
				(new Validator())->execute(I('post.'), [
					'name' => ['type' => 'string'],
					'address' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'fee' => ['type' => 'numeric', 'required' => false, 'allow_empty' => true],
					'advantage' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
					'inferiority' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
				]);
			} else if ('delopponent' == $type) {
				(new Validator())->execute(I('post.'), [
					'name' => ['type' => 'string'],
				]);
			} else if ('history' == $type) {
				(new Validator())->execute(I('post.'), [
					'customer_id' => ['type' => 'integer'],
				]);
			} else if ('sort' == $type) {
				(new Validator())->execute(I('post.'), [
					'customer_id' => ['type' => 'integer'],
					'prev_cust' => ['type' => 'integer', 'required' => false, 'allow_empty' => true],
					'top' => ['enum_eq' => [0, 1]],
					'type' => [
						'type' => 'integer',
						'required' => false,
						'allow_empty' => true
					],
				]);
			} else if ('delliaison' == $type) {
				(new Validator())->execute(I('post.'), [
					'customer_liaison_id' => ['type' => 'integer'],
				]);
			} else if ('delevent' == $type) {
				(new Validator())->execute(I('post.'), [
					'customer_event_id' => ['type' => 'integer'],
				]);
			} else if ('sorttop' == $type) {
				(new Validator())->execute(I('post.'), [
					'id' => ['type' => 'integer'],
					'prev_id' => ['type' => 'integer'],
				]);
			}
		} catch (\Exception $ex) {
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！' . $ex->getMessage()]);
		}
	}
	
	
}
