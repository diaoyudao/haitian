<?php
namespace Admin\Controller\Statistics;

use Think\Controller;
use Admin\Common\Model\OcModel;
use Admin\Common\Parameter\Validator;
/**
 * 项目统计导出类
 */
class ProjectExport
{
    public function excel($file_name , $call_back_func) {
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

        call_user_func_array($call_back_func,[&$objPHPExcel]);
        
        ob_end_clean();//清除缓冲区,避免乱码
        header('Content-Type: application/vnd.ms-excel');
        header("Content-Disposition: attachment;filename=".$file_name);
        header('Cache-Control: max-age=0');  // 强制从服务器获取，不使用浏览器缓存
        header('Cache-Control: cache, must-revalidate');

        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        $objWriter->save('php://output'); //文件通过浏览器下载

        exit;
    }
}