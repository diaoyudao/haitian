<?php
namespace Admin\Controller\System;

use Think\Controller;
use Admin\Common\Model\OcModel;

/**
 * 搜索类
 */
class SearchController extends Controller
{
    private $param = [];
    private $where = [];
    private $base_model;
    private $result = [];
    private $page2 = null;
    private $page3 = null;

    public function index()
    {
        $this->checkParameter();
        $this->composeParam();

        if(!empty($this->param['name'])) {
            $this->getCustomer();
            $this->getContact();
        }

        $this->assign('pager1_total', max($this->page2->totalPages??1, $this->page3->totalPages??1));

        $this->assign('data', $this->result);
        $this->display();
    }   

    public function customer() {
        $this->checkParameter();
        $this->composeParam();

        $this->getCustomer();


    }

    public function contact() {
        
    }

    private function getContact() {
        $model = M('customer_contact');

        $this->where = [];
//        $this->where['_string'] .= ' bb.delete_time is null';
        if(!empty($this->param['name'])) {
            $where_or['bb.name'] = ['like', '%' . $this->param['name'] . '%'];
            $where_or['bb.phone'] = ['like', '%' . $this->param['name'] . '%'];
            $where_or['bb.tel'] = ['like', '%' . $this->param['name'] . '%'];

            $where_or['_logic'] = 'or';
            $this->where['_complex'] = $where_or;
        }

        $counts = $model->field($field)->alias('bb')
            ->join('customer aa on aa.customer_id=bb.customer_id and aa.delete_time is null')
            ->where($this->where)
            ->count();
        $this->page3 = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
        $this->page3->show();

        $field = "'联系人' type,bb.name,bb.tel,bb.phone,aa.name cust_name,aa.customer_id";
        $arr_temp = $model->field($field)->alias('bb')
            ->page($this->param['pager3_pg']??($this->param['pager1_pg']??1), C('ONE_PAGE_SIZE'))
            ->join('customer aa on aa.customer_id=bb.customer_id and aa.delete_time is null')
            ->where($this->where)->select();

        $this->result = array_merge($this->result, $arr_temp);

        $this->assign('pager3_total', $this->page3->totalPages);
    } 

    private function getCustomer() {
        $model = M('customer');


        if(!empty($this->param['name'])) {
            $this->where['aa.name'] = ['like', '%' . $this->param['name'] . '%'];            
        }

        $counts = $model->field($field)->alias('aa')
            ->where($this->where)
            ->count();
        $this->page2 = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
        $this->page2->show();
		\Think\Log::write('==='.json_encode($this->where));
		\Think\Log::write('=='.$model->_sql());
        // 1政府单位，2旅游景区，3国有企业，0其他，4海外客户，5民营企业
        $field = "if(1 = type,'政府单位',if(2=type,'旅游景区',if(3=type,'国有企业',if(4=type,'海外客户',if(5=type,'民营企业','其他'))))) type,customer_id,name";
        $this->result = $model->field($field)->alias('aa')
            ->page($this->param['pager2_pg']??($this->param['pager1_pg']??1), C('ONE_PAGE_SIZE'))
            ->where($this->where)->select();

        $this->assign('pager2_total', $this->page2->totalPages);
    }

    private function composeParamPosition() {
        // 总经理能选择部门，其他只能查看自己部门
        $this->where['_string'] = 'aa.delete_time is null';
	
		if ('salesman' == session('employee.role_type_code') && 'information' == session('employee.department_type_id')) {
			$this->where['_string'] .= ' and  exists(select 1 from customer_employee ce where ce.customer_id=aa.customer_id and ce.delete_time is null  and ce.employee_id=' . session('employee_id') . ') ';
//			var_dump(session('employee_id'));
		}
		if('information' == session('employee.department_type_id')) {
            $this->where['aa.information_id'] = session('employee.department_id');
        } else if('boss' == session('employee.department_type_id')) {
            
        } else {
            $this->assign('data', $this->result);    
            $this->display();
            exit;            
        }        
    }

    private function checkParameter() {
        try {
            (new \Admin\Common\Parameter\Validator())->execute(I(''), [
                'name' => ['type' => 'string','required' => false],
            ]);
        } catch (\Exception $ex) {

            $this->assign('data', $this->result);    
            $this->display();
            exit;   
        }

        $this->param = I('');
    }

    private function composeParam() {
        
        $this->composeParamPosition();
    }    
}