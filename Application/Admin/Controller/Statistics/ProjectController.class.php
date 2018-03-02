<?php
namespace Admin\Controller\Statistics;

use Think\Controller;
use Admin\Common\Model\OcModel;
use Admin\Common\Parameter\Validator;
/**
 * 项目统计类
 */
class ProjectController extends Controller
{
    public $param = [];
    public $where = [];
    private $base_model;
    static public $result = [];
    private $total = 0;

    public function __construct() {
        parent::__construct();

        $this->base_model = M('customer');
    }
//__NAMESPACE__.'\ProjectController:exportData
    public function export() {
        (new ProjectExport())->excel('项目统计.xls', __NAMESPACE__ . '\ProjectController::exportData');
    }

    public function data()
    {
        $where['department_type_id'] = ['in', ['business', 'information']];
        $where['_string'] = 'delete_time is null';
        $department = M('department')->where($where)->select();

        $this->assign('department', $department);
        $this->assign('year', date('Y'));
        $this->assign('month', date('m'));

        $this->display();
    }

    // 客户查询
    public function customer() {
        $this->checkParameter();
        $this->composeParam();

        $this->getCustomerData();

        $this->ajaxReturn(['status' => 'success', 'data' => self::$result]);
    }

    // 新客户查询
    public function newCustomer() {
        $this->checkParameter('newCustomer');
        $this->composeParamNew();

        $this->newCustomerData();

        $this->ajaxReturn(['status' => 'success', 'data' => self::$result]);
    }

    // 联络查询
    public function liaison() {
        $this->checkParameter('liaison');
        //$this->composeParam();

        $this->liaisonData();

        $this->ajaxReturn(['status' => 'success', 'data' => self::$result]);
    }

    // 合同查询
    public function contract() {
        $this->checkParameter('contract');
        $this->composeParamNew();

        $this->contractData();
        
        $this->ajaxReturn(['status' => 'success', 'data' => self::$result]);
    }   

    static public function exportData(&$objPHPExcel) {
        $app = new ProjectController();

        $app->param = I('get.');

        $app->composeParam();
        $app->exportNewCust($objPHPExcel);

        $app->where = [];
        //$app->composeParam();
        $app::$result = [];
        $app->exportLiaison($objPHPExcel);

        $app->where = [];
        $app->composeParamNew();
        $app::$result = [];
        $app->exportContract($objPHPExcel);       
    }

    private function setSheetHead(&$sheet1) {
        $sheet1->setCellValue('A1', '部门：');
        if(empty($this->param['department_id']))
            $sheet1->setCellValue('B1', '所有');
        else {
            $sheet1->setCellValue('B1', M('department')
                ->where(['department_id' => $this->param['department_id']])
                ->getField('name'));
        }
        
        // 日期 小计   政府单位    政府单位    企业公司    其他  海外客户

        $sheet1->setCellValue('A2', '日期')->setCellValue('B2', '合计')
            ->setCellValue('C2', '政府单位')->setCellValue('D2', '政府单位')
            ->setCellValue('E2', '企业公司')->setCellValue('F2', '其他')
            ->setCellValue('G2', '海外客户');
    }

    private function exportNewCust(&$objPHPExcel) {
        // customer
        var_dump($this->param);
        $this->param['time'] = $this->param['new_time'] . '-01';
        $this->newCustomerData();

        $sheet1 = $objPHPExcel->setActiveSheetIndex(0);
        //设置sheet的name
        $sheet1->setTitle('新增客户统计');
        $sheet1->setCellValue('C1', '时间：')->setCellValue('D1', $this->param['new_time']);
        $this->setSheetHead($sheet1);
//self::$result['day'][(string)$i][$value['type']] += 1;
        for($i = 1; $i <= self::$result['max_day']; $i++) {
            $n = $i + 2;

            if(self::$result['day'][$i]) {                
                $v = self::$result['day'][$i];
                $sheet1->setCellValue('A'.$n, $i);
                $sheet1->setCellValue('B'.$n, ($v['1']??0) + ($v['2']??0) + ($v['3']??0) + ($v['4']??0) + ($v['0']??0));
                $sheet1->setCellValue('C'.$n, $v['1']??0);
                $sheet1->setCellValue('D'.$n, $v['2']??0);
                $sheet1->setCellValue('E'.$n, $v['3']??0);
                $sheet1->setCellValue('F'.$n, $v['0']??0);
                $sheet1->setCellValue('G'.$n, $v['4']??0);
                continue;
            } 

            $sheet1->setCellValue('A'.$n, $i);            
            $sheet1->setCellValue('B'.$n, 0);
            $sheet1->setCellValue('C'.$n, 0);
            $sheet1->setCellValue('D'.$n, 0);
            $sheet1->setCellValue('E'.$n, 0);
            $sheet1->setCellValue('F'.$n, 0);
            $sheet1->setCellValue('G'.$n, 0);
        }        
    }

    private function exportLiaison(&$objPHPExcel) {
        // customer
        $this->param['time'] = $this->param['lia_time'] . '-01';
        $this->liaisonData();

        $sheet1 = $objPHPExcel->createSheet();
        //设置sheet的name
        $sheet1->setTitle('联络统计');
        $sheet1->setCellValue('C1', '时间：')->setCellValue('D1', $this->param['lia_time']);
        $this->setSheetHead($sheet1);

        for($i = 1; $i <= self::$result['max_day']; $i++) {
            $n = $i + 2;

            if(self::$result['day'][$i]) {                
                $v = self::$result['day'][$i];
                $sheet1->setCellValue('A'.$n, $i);
                $sheet1->setCellValue('B'.$n, ($v['1']??0) + ($v['2']??0) + ($v['3']??0) + ($v['4']??0) + ($v['0']??0));
                $sheet1->setCellValue('C'.$n, $v['1']??0);
                $sheet1->setCellValue('D'.$n, $v['2']??0);
                $sheet1->setCellValue('E'.$n, $v['3']??0);
                $sheet1->setCellValue('F'.$n, $v['0']??0);
                $sheet1->setCellValue('G'.$n, $v['4']??0);
                continue;
            } 

            $sheet1->setCellValue('A'.$n, $i);            
            $sheet1->setCellValue('B'.$n, 0);
            $sheet1->setCellValue('C'.$n, 0);
            $sheet1->setCellValue('D'.$n, 0);
            $sheet1->setCellValue('E'.$n, 0);
            $sheet1->setCellValue('F'.$n, 0);
            $sheet1->setCellValue('G'.$n, 0);
        }
    }

    private function exportContract(&$objPHPExcel) {
        // customer
        $this->param['time'] = $this->param['year'] . '-01-01';
        $this->contractData();

        $sheet1 = $objPHPExcel->createSheet();
        //设置sheet的name
        $sheet1->setTitle('合同签订统计');
        $sheet1->setCellValue('A1', '部门：');
        if(empty($this->param['department_id']))
            $sheet1->setCellValue('B1', '所有');
        else {
            $sheet1->setCellValue('B1', M('department')
                ->where(['department_id' => $this->param['department_id']])
                ->getField('name'));
        }
        $sheet1->setCellValue('C1', '时间：')->setCellValue('D1', $this->param['year']);
        // 
        $sheet1->setCellValue('A2', '月')->setCellValue('B2', '数量')
            ->setCellValue('C2', '金额');
        // month
        for($i = 1; $i <= 12; $i++) {
            $n = $i + 2;
            if(self::$result['month'][$i]) {                
                $v = self::$result['month'][$i];
                $sheet1->setCellValue('A'.$n, $i);
                $sheet1->setCellValue('B'.$n, $v['num']??0);
                $sheet1->setCellValue('C'.$n, $v['fee']??0);

                continue;
            } 

            $sheet1->setCellValue('A'.$n, $i);            
            $sheet1->setCellValue('B'.$n, 0);
            $sheet1->setCellValue('C'.$n, 0);
        }
    }

    private function getCustomerData() {
        // 客户数
        $field = "type,count(*) number";
        $arr = $this->base_model->where($this->where)            
            ->alias('aa')->field($field)
            ->group('type')->select();

        foreach ($arr as $it) {
            self::$result['customer_type'][(string)($it['type'])] = $it['number'];
        }

        // 级别
        $field = "is_vip,count(*) number";
        $arr = $this->base_model->where($this->where)            
            ->alias('aa')->field($field)
            ->group('is_vip')->select();

        foreach ($arr as $it) {
            self::$result['customer_level'][(string)($it['is_vip'])] = $it['number'];
        }

        // 昨日新增客户，新签合同
        $yesterday = (new \DateTime)->modify('- 1day')->format('Y-m-d');
        $begin_t = $yesterday . ' 00:00:00';
        $end_t = $yesterday . ' 23:59:59';

        $name = ['new_yesterday','contract_yesterday'];
        $this->getTotalCustomer($begin_t, $end_t, $name);
        unset($this->where['aa.create_time']);
        $this->getTotalContract($yesterday, $yesterday, $name);
        unset($this->where['bb.contract_date']);
        // 本月
        $day = date('Y-m');
        $begin_t = $day . '-1 00:00:00';
        $end_t = $day . '-31 23:59:59';

        $name = ['new_this_month','contract_this_month'];        
        $this->getTotalCustomer($begin_t, $end_t, $name);
        unset($this->where['aa.create_time']);
        $this->getTotalContract($day . '-1', $end_t, $name);
        unset($this->where['bb.contract_date']);
        // 上月
        $day = (new \DateTime)->modify('- 1month')->format('Y-m');
        $begin_t = $day . '-1 00:00:00';
        $end_t = $day . '-31 23:59:59';

        $name = ['new_last_month','contract_last_month'];
        $this->getTotalCustomer($begin_t, $end_t, $name);
        unset($this->where['aa.create_time']);
        $this->getTotalContract($day . '-1', $end_t, $name);
    }

    private function newCustomerData() {
        //时间
        $input_time = (new \DateTime($this->param['time']));
        $day = $input_time->format('Y-m');
        $begin_t = $day . '-1 00:00:00';
        $end_t = $day . '-31 23:59:59';

        // 每天的数量
        $this->where['aa.create_time'] = ['between', [$begin_t, $end_t]];
        $field = "type,create_time";
        $arr_temp = $this->base_model->where($this->where)
            ->alias('aa')->field($field)
            ->select();

        $total = 0;
        //获取月的最后一天
        $temp = $input_time->modify('+ 1month')->format('Y-m');
        $max_day = (new \DateTime($temp . '-1'))->modify('- 1day')->format('d');
        
        for ($i=1; $i <= $max_day; $i++) {
            $ym = sprintf("%s-%02d",$day, $i);
            foreach ($arr_temp as $value) {
                if(false !== strpos($value['create_time'], $ym)) {
                    self::$result['day'][(string)$i][$value['type']] += 1;
                    $total += 1;
                }
            }
        }
        self::$result['max_day'] = $max_day;
        self::$result['total'] = $total;
    }

    private function liaisonData() {
        //时间
        $input_time = (new \DateTime($this->param['time']));
        $day = $input_time->format('Y-m');
        $begin_t = $day . '-01 00:00:00';
        $end_t = $day . '-31 23:59:59';

        // 每天的数量
        $this->whereEmployeeLia();
        $this->where['aa.liaison_time'] = ['between', [$begin_t, $end_t]];
        $field = "bb.type,aa.liaison_time";

        $model = M('customer_liaison');
        $arr_temp = $model->where($this->where)->alias('aa')
            ->join('customer bb on aa.customer_id=bb.customer_id 
                and bb.delete_time is null')
            ->field($field)->select();

        $total = 0;
        //获取月的最后一天
        $temp = $input_time->modify('+ 1month')->format('Y-m');
        $max_day = (new \DateTime($temp . '-1'))->modify('- 1day')->format('d');
        
        for ($i=1; $i <= $max_day; $i++) {
            $ym = sprintf("%s-%02d",$day, $i);
            foreach ($arr_temp as $value) {
                if(false !== strpos($value['liaison_time'], $ym)) {
                    self::$result['day'][(string)$i][$value['type']] += 1;
                    $total += 1;
                }
            }
        }
        self::$result['max_day'] = $max_day;
        self::$result['total'] = $total;
    }

    private function contractData() {
        //时间
        $begin_t = $this->param['year'] . '-01-01';
        $end_t = $this->param['year'] . '-12-31';

        // 每天的数量
        $this->where['bb.company'] = '本公司';
        $this->where['bb.contract_date'] = ['between', [$begin_t, $end_t]];
        $field = "bb.contract_date,count(*) number,sum(scale_fee) fee";

        $arr_temp = $this->base_model->where($this->where)->alias('aa')
            ->join('project bb on aa.customer_id=bb.customer_id')
            ->field($field)
            ->group('bb.contract_date')->select();

        $this->total = 0;
        // 设置每月数量
        for ($i=1; $i <= 12; $i++) {
            $ym = sprintf("%s-%02d", $this->param['year'], $i);
            foreach ($arr_temp as $value) {
                if(false !== strpos($value['contract_date'], $ym)) {
                    self::$result['month'][(string)$i]['num'] += $value['number'];
                    self::$result['month'][(string)$i]['fee'] += $value['fee'];
                    $this->total += $value['number'];
                }
            }
        }

        self::$result['total'] = $this->total;
    }

    // 获取新增客户总数
    private function getTotalCustomer($begin_t, $end_t, $name) {    
        $this->where['aa.create_time'] = ['between', [$begin_t, $end_t]];
        self::$result[$name[0]] = $this->base_model->where($this->where)
            ->alias('aa')->count();
    }

    // 获取新增合同总数
    private function getTotalContract($begin_t, $end_t, $name) {   
        $this->where['bb.contract_date'] = ['between', [$begin_t, $end_t]];    
        self::$result[$name[1]] = $this->base_model->where($this->where)
            ->join('project bb on aa.customer_id=bb.customer_id')
            ->alias('aa')->count();
    }

    private function whereEmployee() {
        if('salesman' == session('employee.role_type_code')) {
            $this->where['_string'] = ' exists(select 1 from customer_employee ce where ce.customer_id=aa.customer_id and ce.delete_time is null and ce.employee_id='. session('employee_id') .') ';
        } else if('director' == session('employee.role_type_code')) {
            $where['_string'] = 'delete_time is null';
            $where['department_id'] = session('employee.department_id');
            $arr = M('employee')->where($where)->getField('employee_id',true);
            $this->where['aa.employee_id'] = ['in', $arr];
        }
    }

    private function whereEmployeeLia() {
        $this->whereEmployee();

        if('boss' == session('employee.role_type_code') && !empty($this->param['department_id'])) {
            $where['_string'] = 'delete_time is null';
            $where['department_id'] = $this->param['department_id'];
            $arr = M('employee')->where($where)->getField('employee_id',true);
            $this->where['aa.employee_id'] = ['in', $arr];
        }
    }

    private function composeParamNew() {
        // 总经理能选择部门，其他只能查看自己部门
        $this->where['_string'] = 'aa.delete_time is null';

        if('salesman' == session('employee.role_type_code')) {
            $this->where['_string'] .= ' and exists(select 1 from customer_employee ce where ce.customer_id=aa.customer_id and ce.delete_time is null and ce.employee_id='. session('employee_id') .')';
        } else if('business' == session('employee.department_type_id')) {
            $this->where['aa.create_department_id'] = session('employee.department_id');
        } else if('information' == session('employee.department_type_id')) {
            $this->where['aa.create_department_id'] = session('employee.department_id');
        } else if('boss' == session('employee.department_type_id')) {
            if(!empty($this->param['department_id'])) {
                $this->where['aa.create_department_id'] = $this->param['department_id'];
            }
        } else {
            $this->ajaxReturn(['status' => 'failed', 'message' => '您无查看权限']);
        }        
    } 

    private function composeParam() {
        // 总经理能选择部门，其他只能查看自己部门
        $this->where['_string'] = 'aa.delete_time is null';

        if('salesman' == session('employee.role_type_code')) {
            $this->where['_string'] .= ' and exists(select 1 from customer_employee ce where ce.customer_id=aa.customer_id and ce.delete_time is null and ce.employee_id='. session('employee_id') .')';
        } else if('business' == session('employee.department_type_id')) {
            $this->where['aa.business_id'] = session('employee.department_id');
        } else if('information' == session('employee.department_type_id')) {
            $this->where['aa.information_id'] = session('employee.department_id');
        } else if('boss' == session('employee.department_type_id')) {
            if(!empty($this->param['department_id'])) {
                $where_or['aa.business_id'] = $this->param['department_id'];
                $where_or['aa.information_id'] = $this->param['department_id'];
                $where_or['_logic'] = 'or';
                $this->where['_complex'] = $where_or;
            }
        } else {
            $this->ajaxReturn(['status' => 'failed', 'message' => '您无查看权限']);
        }        
    }

    private function checkParameter(string $type = 'customer')
    {     
        $this->param = I('post.');   
        try {
            (new Validator())->execute($this->param, [
                'department_id' => ['type' => 'integer', 'required' => false,'allow_empty' => true],
            ]);

            if ('newCustomer' == $type || 'liaison' == $type) {
                (new Validator())->execute($this->param, [
                    'time' => ['type' => 'Y_m', 'required' => false],
                ]);

                $this->param['time'] = $this->param['time'] . '-01';
            } else if ('contract' == $type) {
                (new Validator())->execute($this->param, [
                    'year' => ['type' => 'Y', 'required' => false],
                ]);
                $this->param['time'] = $this->param['year'] . '-01-01';
            } 
        } catch (\Exception $ex) {

            $this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！'.$ex->getMessage()]);
        }        
    }
}