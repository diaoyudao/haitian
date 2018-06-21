<?php

namespace Admin\Controller\Customer;

use Think\Controller;
use Think\Log;

use Admin\Common\Model\OcModel;
use Admin\Common\Parameter\Validator;

/**
 * 客户查询类，查询内容太多，将部分分出来
 */
class SearchController extends Controller
{
	private $param = [];
	private $where = [];
	private $base_model;
	
	public function __construct()
	{
		parent::__construct();
		
		$this->base_model = new OcModel('customer');
	}
	
	public function list()
	{
		$this->checkParameter('list');
		
		$where['_string'] = $this->whereEmployee();
		$where['_string'] .= 'delete_time is null';
		$where['name'] = ['like', '%' . $this->param['name'] . '%'];
		$result = M('customer')->where($where)->alias('cu')
			->field('customer_id,name,(select count(*) from project where customer_id=cu.customer_id and delete_time is null and company=\'本公司\' and contract_date is not null) is_old_cust')
			->select();
		
		$this->ajaxReturn(['status' => 'success', 'data' => $result]);
	}
	
	// 查询当前客户的显示页面所有信息，不含分页内容
	public function detail()
	{
		$this->checkParameter('detail');
		// 基础信息
		$where['aa.customer_id'] = $this->param['customer_id'];
		
		$field = "aa.*,(select province_name from province where province_id=aa.province_id) province_name,(select city_name from city where city_id=aa.city_id) city_name,(select county_name from county where county_id=aa.county_id) county_name";
		$result = $this->base_model->where($where)->alias('aa')->field($field)->find();
		
		//
		$this->prevNextCustId($result);
		
		// 标签
		$result['tags'] = json_decode($result['tags']);
		// 业务人员
		$model = M('customer_employee');
		$where['_string'] = 'aa.delete_time is null';
		$field = 'bb.department_type_id,cc.name,cc.thumbnail_url,bb.name department_name';
		
		$arr_employee = $model->where($where)->alias('aa')
			->join("department bb on aa.department_id=bb.department_id and bb.department_type_id
                 in('business','information') and bb.delete_time is null")
			->join("employee cc on aa.employee_id=cc.employee_id and cc.delete_time is null")
			->field($field)->order('bb.department_type_id,aa.customer_employee_id')->select();
		
		foreach ($arr_employee as $value) {
			$result['employee'][$value['department_name']][] = $value;
		}
		
		// 联系人
		$field = 'aa.customer_contact_id,aa.name,aa.status,aa.function,aa.position,aa.tel,aa.phone,aa.is_important,aa.customer_id,aa.thumbnail_url,bb.department';
		unset($where['_string']);
		$where['status'] = 1;
		$arr_temp = M('customer_contact')->where($where)->alias('aa')
			->join('customer_department bb on aa.customer_department_id=bb.customer_department_id and bb.delete_time is null and aa.delete_time is null')
			->field($field)->order('bb.weight,aa.function,phone desc,tel desc,customer_contact_id')->select();
		$where['status'] = 0;
		$arr_leave = M('customer_contact')->where($where)->alias('aa')
			->join('customer_department bb on aa.customer_department_id=bb.customer_department_id and bb.delete_time is null and aa.delete_time is null')
			->field($field)->order('bb.weight,aa.function,phone desc,tel desc,customer_contact_id')->select();
		foreach ($arr_temp as $item) {
			$result['contact'][$item['department']][] = $item;
		}
		if (!empty($arr_leave)) {
			$result['contact']['已离职'] = $arr_leave;
		}
		$result['province_name'] = M('province')->where(['province_id' => $result['province_id']])->getField('province_name');
		$result['city_name'] = M('city')->where(['city_id' => $result['city_id']])->getField('city_name');
		$result['county_name'] = M('county')->where(['county_id' => $result['county_id']])->getField('county_name');
		
		$this->assign('data', $result);
		
		$this->display();
	}
	
	public function sortCust()
	{
		$this->checkParameter('sortCust');
		
		$cust = $this->base_model->find($this->param['customer_id']);
		if (!$cust) {
			$this->ajaxReturn(['status' => 'success', 'data' => []]);
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
		$where['name'] = ['like', '%' . $this->param['name'] . '%'];
		$where['_string'] = $this->whereEmployee();
		$where['_string'] .= ' delete_time is null';
		
		$custs = $this->base_model->where($where)->alias('cu')
			->order('weight')->field('customer_id,name')->select();
		
		$this->ajaxReturn(['status' => 'success', 'data' => $custs]);
	}
	
	private function prevNextCustId($cust)
	{
		if (1 == $cust['city_level']) {
			$where['province_id'] = $cust['province_id'];
		} else if (2 == $cust['city_level']) {
			$where['city_id'] = $cust['city_id'];
		} else if (0 == $cust['city_level']) {
			$where['county_id'] = $cust['county_id'];
		}
		
		if (isset($this->param['type']) && "" != $this->param['type']) {
			$where['type'] = $this->param['type'];
		}
		$where['city_level'] = $cust['city_level'];
		
		$where['_string'] = $this->whereEmployee();
		$where['_string'] .= 'delete_time is null';
		
		$where['weight'] = ['lt', $cust['weight']];
		$cust_prev = M('customer')->where($where)->alias('cu')
			->order('weight desc')->field('customer_id,name,is_vip')
			->find();
		
		$where['weight'] = ['gt', $cust['weight']];
		$cust_next = M('customer')->where($where)->alias('cu')
			->order('weight')->field('customer_id,name,is_vip')
			->find();
		
		$this->assign('prev_cust', $cust_prev);
		$this->assign('next_cust', $cust_next);
	}
	
	// 查询当前部门的所有成员
	public function employee()
	{
		$where['department_id'] = session('employee.department_id');
		$where['_string'] = 'delete_time is null';
		
		$result = M('employee')->where($where)->select();
		
		$this->ajaxReturn(['status' => 'success', 'data' => $result]);
	}
	
	// 查询客户事件
	public function event()
	{
		$this->checkParameter('event');
		
		$where['customer_id'] = $this->param['customer_id'];
		$where['_string'] = 'delete_time is null';
		
		$model = M('customer_event');
		
		$counts = $model->where($where)->count();
		$page = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
		$page->show();
		
		if (empty($this->param['order'])) {
			$this->param['order'] = 'occur_time desc,create_time desc';
		}
		
		$field = 'customer_event_id,occur_time,create_time,context';
		$result = $model->where($where)->order($this->param['order'])
			->page(I('post.pg', 1, FILTER_VALIDATE_INT), C('ONE_PAGE_SIZE'))
			->field($field)->select();
		
		foreach ($result as &$item) {
			$item['create_time'] = (new \DateTime($item['create_time']))
				->format('Y-m-d');
		}
		
		$this->ajaxReturn(['status' => 'success', 'data' => $result,
			'total_page' => $page->totalPages]);
	}
	
	public function addEvent()
	{
		if (empty(I('get.id')) && empty(I('get.event_id'))) {
			$this->show('参数错误，请检查！');
			return;
		}
		
		if (!empty(I('get.id'))) {
			$this->assign('customer_id', I('get.id'));
			$this->display();
			return;
		}
		
		$event = M('customer_event')->find(I('get.event_id'));
		$this->assign('event', $event);
		$this->assign('customer_id', $event['customer_id']);
		$this->display();
	}
	
	public function addProject()
	{
		if (empty(I('get.id')) && empty(I('get.project_id')) && empty(I('get.hm'))) {
			$this->show('参数错误，请检查！');
			return;
		}
		
		$this->getDepartment();
		$this->getModel();
		
		$model = M('model_config')->where('delete_time is null')->select();
		$this->assign('model', $model);
		$model = M('config_auto')->where("delete_time is null and type='fee_type'")->select();
		$this->assign('fee_type', $model);
		// 新增
		if (!empty(I('get.hm'))) {
			$where['_string'] = 'delete_time is null';
			$where_dp['business_id'] = session('employee.department_id');
			$where_dp['information_id'] = session('employee.department_id');
			$where_dp['_logic'] = 'or';
			$where['_complex'] = $where_dp;
			$customer = M('customer')->where($where)->field('customer_id,name')->select();
			$this->assign('customer', $customer);
			
			$this->display();
			return;
		}
		// 新增
		if (!empty(I('get.id'))) {
			// 判断是否是老客户，老客户的初始状态为合作中
	        $where_his['customer_id'] = I('get.id');
	        $where_his['company'] = '本公司';
	        $where_his['_string'] = 'delete_time is null and contract_date is not null';
	        $his = M('project')->where($where_his)->count();
	        if(0 < $his) {
	            $this->assign('old_customer', 1);
	        }	 

			$this->assign('customer_id', I('get.id'));
			$this->display();
			return;
		}
		// 修改
		$project = M('project')->find(I('get.project_id'));
		$project2 = M('project_attr')->find(I('get.project_id'));
		if ($project2) {
			$project = array_merge($project, $project2);
		}
		// 特殊处理关联客户
		if (!empty($project['other_cust'])) {
			$where_c['customer_id'] = ['in', $project['other_cust']];
			$other_cust = M('customer')->where($where_c)->field('customer_id,name')->select();
		}
		
		$this->assign('other_cust', $other_cust ?? []);
		$this->assign('project', $project);
		$this->assign('customer_id', $project['customer_id']);
		$this->assign('customer_name', M('customer')
			->where(['customer_id' => $project['customer_id']])
			->getField('name'));
		$this->display();
	}
	
	public function opponent()
	{
		$model = M('opponent')->where('delete_time is null')->select();
		
		$this->ajaxReturn(['status' => 'success', 'data' => $model]);
	}
	public function search()
	{
		$where['name']=['like','%'.I('post.opponent_name').'%'];
		$where['_string']='delete_time is null';
		
		$res = M('opponent')->where($where)->select();
		$this->ajaxReturn(['status' => 'success', 'data' => $res]);
	}
	
	// 查询客户项目
	public function project()
	{
		$this->checkParameter('project');
		
		$where['customer_id'] = $this->param['customer_id'];
		$where['_string'] = 'delete_time is null';
		if ($this->param['son_status']) $where['son_status'] = $this->param['son_status'];
		$model = M('project');
		
		if (empty($this->param['order'])) {
			$this->param['order'] = 'project_id desc';
		}
		
		$counts = $model->where($where)->order($this->param['order'])
			->alias('aa')->count();
		
		$page = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
		$page->show();
		
		$field = 'aa.*,(select name from config_auto where config_auto_id=aa.fee_type and type=\'fee_type\') fee_type';
		$result = $model->where($where)->order($this->param['order'])
			->page(I('post.pg', 1, FILTER_VALIDATE_INT), C('ONE_PAGE_SIZE'))
			->alias('aa')->field($field)->select();
		
		foreach ($result as &$item) {
			if('待定' != $item['company']) {
                $item['status_name'] = C('SON_STATUS_LIST')[$item['son_status']];
            } else {
                $item['status_name'] = $item['other_status'];
            }
		}
		
		$this->ajaxReturn(['status' => 'success', 'data' => $result
			, 'total_page' => $page->totalPages]);
	}
	
	// 查询联络记录
	public function liaison()
	{
		$this->checkParameter('detail');
		
		$where['aa.customer_id'] = $this->param['customer_id'];
		$where['_string'] = 'aa.delete_time is null';
		// 本部门
		$where_emp['_string'] = 'delete_time is null';
		
		$where_emp['department_id'] = session('employee.department_id');
		
		$employee_arr = M('employee')->where($where_emp)->getField('employee_id', true);
//		if(session('employee.department_type_id') == 'information'){
//			$where['aa.employee_id'] = ['in', $employee_arr];
//		}
		$model = M('customer_liaison');
		
		$counts = $model->where($where)->alias('aa')
			->join('employee cc on aa.employee_id=cc.employee_id')
			->count();
		$page = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
		$page->show();
		
		$field = 'aa.*,cc.name employee_name,cc.thumbnail_url employee_url,(select name from project where project_id=aa.project_id) project_name,(select name from customer_contact where customer_contact_id=aa.customer_contact_id) contact_name,(select position from customer_contact where customer_contact_id=aa.customer_contact_id) contact_position,(select thumbnail_url from customer_contact where customer_contact_id=aa.customer_contact_id) contact_url,(select department from customer_department where customer_department_id in(select customer_department_id from customer_contact where customer_contact_id=aa.customer_contact_id)) contact_department';
		$result = $model->where($where)->order('liaison_time desc')
			->page(I('post.pg', 1, FILTER_VALIDATE_INT), C('ONE_PAGE_SIZE'))
			->join('employee cc on aa.employee_id=cc.employee_id')
			->alias('aa')->field($field)->select();
		
		$this->ajaxReturn(['status' => 'success', 'data' => $result, 'total_page' => $page->totalPages]);
	}
	
	public function addLiaison()
	{
		if (empty(I('get.id')) && empty(I('get.liaison_id'))) {
			$this->show('参数错误，请检查！');
			return;
		}
		
		if (!empty(I('get.id'))) {
			$where['customer_id'] = I('get.id');
			$where['_string'] = 'delete_time is null';
			$customer = M('customer')->find(I('get.id'));
			if (!$customer) {
				$this->show('参数错误，请检查！');
				return;
			}
			
			$project = M('project')->where($where)
				->field('project_id,customer_id,name')->select();
			
			$field = 'customer_contact_id,name,customer_id,function,position,status,(select department from customer_department where customer_department_id=aa.customer_department_id) department';
			$contact = M('customer_contact')->where($where)->alias('aa')
				->field($field)->select();
			
			$this->assign('customer_id', I('get.id'));
			$this->assign('project', $project);
			$this->assign('customer', $customer);
			$this->assign('contact', $contact);
			$this->display();
			return;
		}
		
		$liaison = M('customer_liaison')->find(I('get.liaison_id'));
		$where['customer_id'] = $liaison['customer_id'];
		$where['_string'] = 'delete_time is null';
		
		$project = M('project')->where('delete_time is null')
			->field('project_id,customer_id,name')->select();
		
		$field = 'customer_contact_id,name,customer_id,function,position,status,(select department from customer_department where customer_department_id=aa.customer_department_id) department';
		$contact = M('customer_contact')->where($where)
			->alias('aa')->field($field)->select();
		
		$this->assign('data', $liaison);
		$this->assign('project', $project);
		$this->assign('contact', $contact);
		$this->assign('customer_id', $liaison['customer_id']);
		$this->display();
	}
	
	public function addContact()
	{
		$customer_id = I('get.id');
		$where['customer_id'] = $customer_id;
		$where['_string'] = 'delete_time is null';
		
		$department = M('customer_department')->where($where)->select();
		$this->assign('department', $department);
		$this->display('addcontact');
	}
	
	public function changeContact()
	{
		if (empty(I('get.contact_id'))) {
			$this->show('参数错误，请检查！');
			return;
		}
		
		$field = "aa.*,(select name from customer where customer_id=aa.customer_id) customer_name";
		$where['customer_contact_id'] = I('get.contact_id');
		$data = M('customer_contact')->alias('aa')->where($where)
			->field($field)->find();
		$department_where['customer_id'] = $data['customer_id'];
		$department_where['_string'] = 'delete_time is null';
		
		$department = M('customer_department')->where($department_where)->select();
		unset($department_where['_string']);
		$department_all = M('customer_department')->where($department_where)->select();
		
		$this->assign('department', $department);
		$this->assign('department_all', $department_all);
		$this->assign('data', $data);
		$this->display('addcontact');
	}
	
	public function addCard()
	{
		if (empty(I('get.contact_id'))) {
			$this->show('参数错误，请检查！');
			return;
		}
		
		$field = "aa.*,(select name from customer where customer_id=aa.customer_id) customer_name,(select department from customer_department where customer_department_id=aa.customer_department_id) department";
		$where['customer_contact_id'] = I('get.contact_id');
		$data = M('customer_contact')->alias('aa')->where($where)
			->field($field)->find();
		
		$this->assign('data', $data);
		$this->display();
	}
	
	// 查询下次联络记录
	public function liaisonNext()
	{
		$this->checkParameter('detail');
		
		// 获取提醒时间周期
		$liaison_limit = M('config')->where($where_lia)->getField('value');
		$liaison_limit = $liaison_limit ? $liaison_limit : 24;
		$now = new \DateTime();
		$now_time = $now->format('Y-m-d H:i:s');
		$limit_time = $now->modify('- ' . $liaison_limit . 'hour')
			->format('Y-m-d H:i:s');
		
		$where['customer_id'] = $this->param['customer_id'];
		$where['_string'] = 'delete_time is null';
		$where['next_time'] = [['egt', $now_time], ['elt', $limit_time], 'or'];
		// 本部门
		$where_emp['_string'] = 'delete_time is null';
		$where_emp['department_id'] = session('employee.department_id');
		$employee_arr = M('employee')->where($where_emp)->getField('employee_id', true);
		$where['employee_id'] = ['in', $employee_arr];
		
		$model = M('project');
		
		$result = $model->where($where)->order('liaison_time desc')
			->select();
		
		$this->ajaxReturn(['status' => 'success', 'data' => $result]);
	}
	
	public function getProvince()
	{
		$this->checkParameter('getProvince');
		
		if (isset($this->param['type']) && "" != $this->param['type']) {
			$field = 'aa.*,(select count(*) num from customer cu where '
				. $this->whereEmployee() . ' province_id=aa.province_id and delete_time is null and type='
				. $this->param['type'] . ') num';
		} else
			$field = 'aa.*,(select count(*) num from customer cu where '
				. $this->whereEmployee() . ' province_id=aa.province_id and delete_time is null) num';
		
		$provinces = M('province')->alias('aa')->where('delete_time is null')
			->field($field)->order('province_id')->select();
		if(isset($this->param['list_type']) && 0 == $this->param['list_type']){
			array_multisort(array_column($provinces, 'num'), SORT_NUMERIC, SORT_DESC, $provinces);
		}
		
		$this->ajaxReturn(['status' => 'success', 'data' => $provinces]);
	}
	
	public function getCity()
	{
		$this->checkParameter('city');
		
		if (isset($this->param['type']) && "" != $this->param['type']) {
			$field = 'aa.*,(select count(*) num from customer cu where '
				. $this->whereEmployee() . ' city_id=aa.city_id and delete_time is null and city_level<>1 and type='
				. $this->param['type'] . ') num';
			$this->where['type'] = $this->param['type'];
			$where['type'] = $this->param['type'];
		} else
			$field = 'aa.*,(select count(*) num from customer cu where '
				. $this->whereEmployee() . ' city_id=aa.city_id and delete_time is null and city_level<>1) num';
		
		$where['province_id'] = $this->param['province_id'];
		$where['_string'] = 'delete_time is null';
		// 获取市级下属客户，包含普通和市级数量
		$result = M('city')->where($where)->field($field)
			->alias('aa')->order('city_id')->select();
		// sort
		if(isset($this->param['list_type']) && 0 == $this->param['list_type']) {
			array_multisort(array_column($result, 'num'), SORT_NUMERIC, SORT_DESC, $result);
		}
		// 获取该省级客户
		$prov_cust = null;
		if (empty($this->where['_string']))
			$this->where['_string'] = 'delete_time is null';
		else
			$this->where['_string'] .= ' and delete_time is null';
		$this->where['province_id'] = $this->param['province_id'];
		$this->where['city_level'] = 1;
		$field_p = 'customer_id,name,type,is_vip,(select province_name from province where province_id=cu.province_id) province_name,(select city_name from city where city_id=cu.city_id) city_name';
		$arr = M('customer')->where($this->where)->alias('cu')
			->field($field_p)
			->order('cu.weight,cu.customer_id')->select();
		if ($arr) {
			$prov_cust['city_id'] = 'prov';
			$prov_cust['num'] = count($arr);
			$prov_cust['cust'] = $arr;
		}
		
		//var_dump($arr);
		$this->ajaxReturn(['status' => 'success',
			'data' => $result,
			'prov_cust' => $prov_cust]);
	}
	
	// 获取该省级客户
	public function getProvLevel()
	{
		$this->checkParameter('city');
		
		$this->whereEmployee();
		
		if (isset($this->param['type']) && "" != $this->param['type']) {
			$this->where['type'] = $this->param['type'];
		}
		
		if (empty($this->where['_string']))
			$this->where['_string'] = 'delete_time is null';
		else
			$this->where['_string'] .= ' and delete_time is null';
		$this->where['province_id'] = $this->param['province_id'];
		$this->where['city_level'] = 1;
		$arr = M('customer')->where($this->where)->alias('cu')
			->field('customer_id,name,type,is_vip')
			->order('cu.weight,cu.customer_id')->select();
		
		//var_dump($arr);
		$this->ajaxReturn(['status' => 'success',
			'data' => $arr]);
	}
	
	public function getCityLevel()
	{
		$this->checkParameter('county');
		
		$this->whereEmployee();
		
		if (isset($this->param['type']) && "" != $this->param['type']) {
			$this->where['type'] = $this->param['type'];
		}
		
		$this->where['city_id'] = $this->param['city_id'];
		$this->where['city_level'] = 2;
		$arr = M('customer')->where($this->where)->alias('cu')
			->field('customer_id,name,type,is_vip,(select province_name from province where province_id=cu.province_id)province_name, (select city_name from city where city_id=cu.city_id) city_name')
			->order('cu.weight,cu.customer_id')->select();
		
		$this->ajaxReturn(['status' => 'success',
			'data' => $arr]);
	}
	
	public function getCounty()
	{
		$this->checkParameter('county');
		
		if (isset($this->param['type']) && "" != $this->param['type']) {
			$field = 'aa.*,(select count(*) num from customer cu where '
				. $this->whereEmployee() . ' county_id=aa.county_id and delete_time is null and city_level=0 and type='
				. $this->param['type'] . ') num';
			$this->where['type'] = $this->param['type'];
			$where['type'] = $this->param['type'];
		} else
			$field = 'aa.*,(select count(*) num from customer cu where '
				. $this->whereEmployee() . ' county_id=aa.county_id and delete_time is null and city_level=0) num';
		
		$where['city_id'] = $this->param['city_id'];
		$where['_string'] = 'delete_time is null';
		$result = M('county')->where($where)->field($field)
			->alias('aa')->order('county_id')->select();
		// sort
		if(isset($this->param['list_type']) && 0 == $this->param['list_type']) {
			array_multisort(array_column($result, 'num'), SORT_NUMERIC, SORT_DESC, $result);
		}
		// 获取该市级客户
		$prov_cust = null;
		
		$this->where['city_id'] = $this->param['city_id'];
		$this->where['city_level'] = 2;
		$arr = M('customer')->where($this->where)->alias('cu')
			->field('customer_id,name,type,is_vip,(select province_name from province where province_id=cu.province_id) province_name, (select city_name from city where city_id=cu.city_id) city_name')
			->order('cu.weight,cu.customer_id')->select();
		
		if ($arr) {
			$prov_cust['county_id'] = 'city';
			$prov_cust['num'] = count($arr);
			$prov_cust['cust'] = $arr;
		}
		
		$this->ajaxReturn(['status' => 'success',
			'data' => $result, 'city_cust' => $prov_cust]);
	}
	
	public function getCustomer()
	{
		$this->checkParameter('getCustomer');
		
		if (isset($this->param['type']) && "" != $this->param['type']) {
			$this->where['type'] = $this->param['type'];
		}
		if (!empty($this->param['county_id'])) {
			$this->where['county_id'] = $this->param['county_id'];
		}
		if (!empty($this->param['name'])) {
			$this->where['name'] = ['like', '%' . $this->param['name'] . '%'];
		}
		
		$this->whereEmployee();
		
		if (empty($this->where['_string']))
			$this->where['_string'] = 'delete_time is null';
		else
			$this->where['_string'] .= ' and delete_time is null';
		
		$result = M('customer')->where($this->where)->alias('cu')
			->field('customer_id,name,type,is_vip,(select province_name from province where province_id=cu.province_id)province_name, (select city_name from city where city_id=cu.city_id) city_name')
			->order('cu.weight,cu.customer_id')->select();
		
		$this->ajaxReturn(['status' => 'success', 'data' => $result]);
	}
	
	// 业务员看自己的，主任看自己部门的，总经理看all
	public function getCustomerAbc()
	{
		$this->checkParameter('getCustomerRecent');
		
		if (!empty($this->param['name'])) {
			$where['name'] = ['like', '%' . $this->param['name'] . '%'];
		}
		
		if (empty($this->param['order'])) {
			$order = 'aa.is_vip';
		} else {
			$this->param['order_sort'] = $this->param['order_sort'] ?? 0;
			if (1 == $this->param['order_sort']) {
				$order = (1 == $this->param['order']) ? 'aa.is_vip' : ((2 == $this->param['order']) ? 'aa.province_id' : 'aa.type');
			} else {
				$order = (1 == $this->param['order']) ? 'aa.is_vip desc' : ((2 == $this->param['order']) ? 'aa.province_id desc' : 'aa.type desc');
			}
		}
		
		$where['_string'] = 'aa.delete_time is null';
		$where['is_vip'] = 1;
		
		$field = 'aa.*,(select province_name from province where province_id=aa.province_id)province_name, (select city_name from city where city_id=aa.city_id) city_name';
		$model = M('customer');
		// 业务员特殊处理
		if ('salesman' == session('employee.role_type_code')) {
			$where['bb.employee_id'] = session('employee_id');
			
			$counts = $model->where($where)->alias('aa')
				->join('customer_employee bb on aa.customer_id=bb.customer_id and bb.delete_time is null')
				->count();
			$page = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
			$page->show();
			
			$result = $model->where($where)->alias('aa')
				->order($order)->field($field)
				->join('customer_employee bb on aa.customer_id=bb.customer_id and bb.delete_time is null')
				->page(I('post.pg', 1, FILTER_VALIDATE_INT), C('ONE_PAGE_SIZE'))
				->select();
			
			$this->ajaxReturn(['status' => 'success', 'data' => $result,
				'total_page' => $page->totalPages]);
		}
		
		// 信息部和业务部特殊处理
		if ('information' == session('employee.department_type_id')) {
			$where['information_id'] = session('employee.department_id');
		}
		if ('business' == session('employee.department_type_id')) {
			$where['business_id'] = session('employee.department_id');
		}
		
		$counts = $model->where($where)->alias('aa')->count();
		$page = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
		$page->show();
		
		$result = $model->where($where)->order('customer_id')->field($field)
			->page(I('post.pg', 1, FILTER_VALIDATE_INT), C('ONE_PAGE_SIZE'))
			->alias('aa')->order($order)->select();
		
		$this->ajaxReturn(['status' => 'success', 'data' => $result,
			'total_page' => $page->totalPages]);
	}
	
	// 近期7天跟踪客户,业务员看自己的，主任看自己部门的，总经理看自己
	public function getCustomerRecent()
	{
		$this->checkParameter('getCustomerRecent');
		
		if (!empty($this->param['name'])) {
			$where['name'] = ['like', '%' . $this->param['name'] . '%'];
		}
		
		$last_t = (new \DateTime)->modify('- 7day')->format('Y-m-d H:i:s');
		$where['_string'] = 'aa.delete_time is null';
		$where['liaison_time'] = ['egt', $last_t];
		
		// 信息部和业务部特殊处理
		if ('salesman' == session('employee.role_type_code') || 'boss' == session('employee.role_type_code')) {
			$where['aa.employee_id'] = session('employee_id');
		} else if ('director' == session('employee.role_type_code')) {
			$where_e['_string'] = 'delete_time is null';
			$where_e['department_id'] = session('employee.department_id');
			
			$employee = M('employee')->where($where_e)->getField('employee_id', true);
			$where['aa.employee_id'] = ['in', $employee];
		} else {
			$this->ajaxReturn(['status' => 'success', 'data' => []]);
		}
		
		$model = M('customer_liaison');
		$counts = $model->where($where)->alias('aa')
			->join('customer bb on aa.customer_id=bb.customer_id and bb.delete_time is null')
			->count();
		$page = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
		$page->show();
		
		$field = 'aa.*,bb.name,bb.is_vip,bb.type,(select name from customer_contact where customer_contact_id=aa.customer_contact_id) contact_name,(select name from employee where employee_id=aa.next_employee_id) next_employee_name,(select name from employee where employee_id=aa.employee_id) employee_name,(select name from project where project_id=aa.project_id) project_name,(select province_name from province where province_id=bb.province_id) province_name,(select city_name from city where city_id=bb.city_id) city_name';
		$result = $model->where($where)->alias('aa')
			->page(I('post.pg', 1, FILTER_VALIDATE_INT), C('ONE_PAGE_SIZE'))
			->join('customer bb on aa.customer_id=bb.customer_id')
			->field($field)->order('aa.liaison_time desc')->select();
		
		$this->ajaxReturn(['status' => 'success', 'data' => $result, 'total_page' => $page->totalPages]);
	}
	
	private function getDepartment()
	{
		$where['_string'] = 'delete_time is null';
		$depart = M('department')->where($where)->select();
		
		$this->assign('department', $depart);
	}
	
	private function getModel()
	{
		$where['_string'] = 'delete_time is null';
		$res = M('model_config')->where($where)->order('model_config_id')->select();
		
		$this->assign('models', $res);
	}
	
	private function whereEmployee()
	{
		$ret = 'true ';
		if ('salesman' == session('employee.role_type_code') && 'information' == session('employee.department_type_id')) {
			$this->where['_string'] = ' exists(select 1 from customer_employee ce where ce.customer_id=cu.customer_id and ce.delete_time is null  and ce.employee_id=' . session('employee_id') . ')';

			$ret .= " and exists(select 1 from customer_employee ce where ce.customer_id=cu.customer_id and ce.delete_time is null  and ce.employee_id=" . session('employee_id') . ") ";
		}
// else
//			// 信息部和业务部特殊处理
			if ('information' == session('employee.department_type_id')) {
				$this->where['information_id'] = session('employee.department_id');
				$ret .= "and information_id='" . session('employee.department_id') . "'";
			
			} else if ('business' == session('employee.department_type_id')) {
//				$this->where['business_id'] = session('employee.department_id');
//				$ret .= "and business_id='" . session('employee.department_id') . "'";
			}
		
		return $ret . " and ";
	}
	
	private function checkParameter(string $type)
	{
		try {
			if ('getProvince' == $type) {
				(new Validator())->execute(I('post.'), [
					'type' => ['type' => 'integer',
						'required' => false,
						'allow_empty' => true
					],
				]);
			} else if ('city' == $type) {
				(new Validator())->execute(I('post.'), [
					'province_id' => ['type' => 'integer'],
					'type' => ['type' => 'integer',
						'required' => false,
						'allow_empty' => true
					],
				]);
			} else if ('county' == $type) {
				(new Validator())->execute(I('post.'), [
					'city_id' => ['type' => 'integer'],
					'type' => ['type' => 'integer',
						'required' => false,
						'allow_empty' => true
					],
				]);
			} else if ('getCustomer' == $type) {
				(new Validator())->execute(I('post.'), [
					'county_id' => ['type' => 'integer', 'required' => false],
					'type' => ['type' => 'integer', 'required' => false, 'allow_empty' => true],
					'name' => ['type' => 'string', 'required' => false]
				]);
			} else if ('detail' == $type) {
				(new Validator())->execute(I(''), [
					'customer_id' => ['type' => 'integer'],
				]);
			} else if ('event' == $type) {
				(new Validator())->execute(I('post.'), [
					'customer_id' => ['type' => 'integer'],
					'order' => ['enum_eq' => ['occur_time', 'create_time', 'occur_time desc', 'create_time desc']
						, 'required' => false, 'allow_empty' => true
					],
				]);
			} else if ('project' == $type) {
				(new Validator())->execute(I('post.'), [
					'customer_id' => ['type' => 'integer'],
					'order' => ['enum_eq' => ['begin_date', 'scale_fee', 'begin_date desc', 'scale_fee desc']
						, 'required' => false, 'allow_empty' => true
					],
					'son_status' => ['enum_eq' => [41, 42, 43, 44], 'required' => false, 'allow_empty' => true],
				]);
			} else if ('getCustomerRecent' == $type) {
				(new Validator())->execute(I('post.'), [
					'name' => ['type' => 'string', 'required' => false],
					'order' => ['enum_eq' => [1, 2, 3], 'required' => false],
					'order_sort' => ['enum_eq' => [0, 1], 'required' => false]
				]);
			} else if ('sortCust' == $type) {
				(new Validator())->execute(I('post.'), [
					'customer_id' => ['type' => 'integer'],
					'name' => ['type' => 'string'],
					'type' => [
						'type' => 'integer',
						'required' => false,
						'allow_empty' => true
					],
				]);
			} else if ('list' == $type) {
				(new Validator())->execute(I('post.'), [
					'name' => ['type' => 'string'],
				]);
			}
		} catch (\Exception $ex) {
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！']);
		}
		
		$this->param = I('');
	}
}