<?php
namespace Admin\Controller\Statistics;

use Think\Controller;
use Think\Log;
use Admin\Common\Model\OcModel;

/**
 * 客户统计类
 */
class CustomerController extends Controller
{
    private $arr_project;
    private $where = [];

    public function data()
    {
        $this->getData();

        $this->assign('data', $this->arr_project);
        $this->display();
    }

    public function export() {
        $this->getData();

        $this->outExcel('客户分布形势.xls', '\Admin\Controller\Statistics\CustomerController::setExcel');
    }

    private function getData() {
        $model = M('customer');

        $this->composeParam();        

        // 统计省下客户工程类型数量
        $this->where['bb.out_value'] = ['gt', 0];
        $field = "aa.province_id,aa.type,count(bb.project_id) type_num,(select province_name from province where province_id=aa.province_id) province_name";
        $arr_temp = $model->where($this->where)->alias('aa')->field($field)
            ->join('project bb on aa.customer_id=bb.customer_id and bb.delete_time is null')
            ->order('aa.province_id,aa.type')->group('aa.province_id,aa.type')
            ->select();

        // 合并
        $this->arr_project = [];
        foreach ($arr_temp as $value) {
            $num = 'num' . ((0 == $value['type'])? '4' : $value['type']);
            $this->arr_project[$value['province_id']]['province_name'] = $value['province_name'];
            $this->arr_project[$value['province_id']]['province_id'] = $value['province_id'];
            $this->arr_project[$value['province_id']][$num] = $value['type_num'];            
        }

        $this->arr_project = array_values($this->arr_project);
        foreach ($this->arr_project as &$value) {
            if(!isset($value['num1'])) $value['num1'] = '0';
            if(!isset($value['num2'])) $value['num2'] = '0';
            if(!isset($value['num3'])) $value['num3'] = '0';
            if(!isset($value['num4'])) $value['num4'] = '0';

            $value['project_num'] = ($value['num1']??0) + ($value['num2']??0) + ($value['num3']??0) + ($value['num4']??0);
        }
    }

    private function composeParam() {
        $this->where['aa.type'] = ['neq', 4];
        $this->where['_string'] = 'aa.delete_time is null and aa.province_id is not null';

        // 总经理能选择部门，其他只能查看自己部门
        if('salesman' == session('employee.role_type_code')) {
            $this->where['_string'] .= ' and exists(select 1 from customer_employee ce where ce.customer_id=aa.customer_id and ce.delete_time is null and ce.employee_id='. session('employee_id') .')';
        }else if('business' == session('employee.department_type_id')) {
            $this->where['aa.business_id'] = session('employee.department_id');
        } else if('information' == session('employee.department_type_id')) {
            $this->where['aa.information_id'] = session('employee.department_id');
        } else if('boss' != session('employee.department_type_id')){
            $this->where['_string'] .= ' and false';
        }        
    }

    public function outExcel($file_name , $call_back_func) {
        require('./Application/Admin/Common/Vendor/PHPExcel/PHPExcel.class.php');
        require('./Application/Admin/Common/Vendor/PHPExcel/PHPExcel/Writer/Excel5.php');
        require('./Application/Admin/Common/Vendor/PHPExcel/PHPExcel/IOFactory.php');

        $objPHPExcel = new \PHPExcel();
        $objProps = $objPHPExcel->getProperties();

        $objPHPExcel->getProperties()->setCreator("Admin");
        //最后修改人
        $objPHPExcel->getProperties()->setLastModifiedBy("Admin");
        //标题
        $objPHPExcel->getProperties()->setTitle("$file_name");
        //题目
        $objPHPExcel->getProperties()->setSubject("Customer Document");
        //描述
        $objPHPExcel->getProperties()->setDescription("Office Customer Document xls");
        //关键字
        $objPHPExcel->getProperties()->setKeywords("office Customer openxml php");
        //种类
        $objPHPExcel->getProperties()->setCategory("office xls file");

        call_user_func_array($call_back_func, [&$objPHPExcel, $this->arr_project]);
        
        ob_end_clean();//清除缓冲区,避免乱码
        header('Content-Type: application/vnd.ms-excel');
        header("Content-Disposition: attachment;filename=".$file_name);
        header('Cache-Control: max-age=0');  // 强制从服务器获取，不使用浏览器缓存
        header('Cache-Control: cache, must-revalidate');

        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        $objWriter->save('php://output'); //文件通过浏览器下载

        exit;
    }    

    static public function setExcel(&$objPHPExcel, $arr_project) {
        Log::write(json_encode($objPHPExcel));
        $objPHPExcel->setActiveSheetIndex(0);

        //设置sheet的name
        $objPHPExcel->getActiveSheet()->setTitle('客户分布形势');

        // table sheet 1
        $sheet1 = $objPHPExcel->setActiveSheetIndex(0);

        // head 序号  省   项目数 政府单位    旅游景区    企业公司    其他
        $sheet1->setCellValue('A1', '序号')->setCellValue('B1', '省')->setCellValue('C1', '项目数')->setCellValue('D1', '政府单位')->setCellValue('E1', '旅游景区')->setCellValue('F1', '企业公司')->setCellValue('G1', '其他');

        //设置单元格的值
        foreach ($arr_project as $i => $v) {
            $n = $i + 2;
            $sheet1->setCellValue('A'.$n, $i + 1)
            ->setCellValue('A'.$n, $i + 1)
            ->setCellValue('B'.$n, $v['province_name'] ?? 0)
            ->setCellValue('C'.$n, $v['project_num'] ?? 0)
            ->setCellValue('D'.$n, $v['num1'] ?? 0)
            ->setCellValue('E'.$n, $v['num2'] ?? 0)
            ->setCellValue('F'.$n, $v['num3'] ?? 0)
            ->setCellValue('G'.$n, $v['num4'] ?? 0);
        }
    }
}