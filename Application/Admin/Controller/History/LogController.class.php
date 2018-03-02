<?php
namespace Admin\Controller\History;

use Think\Controller;
use Admin\Common\Model\OcModel;

/**
 * 日志类
 */
class LogController extends Controller
{
    private $param = [];
    private $where = [];
    private $base_model;

    public function __construct() {
        parent::__construct();

        $this->base_model = M('operate_log');
    }

    public function list()
    {
        $this->searchParameterCheck();
        $this->composeParam();

        $counts = $this->base_model->where($this->where)->count();
        $page = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
        $page->show();

        $field = "aa.*,"
            . "(select thumbnail_url from employee where employee_id=aa.employee_id) thumbnail_url";
        $data = $this->base_model->field($field)->alias('aa')
            ->page(I('get.pg', 1, FILTER_VALIDATE_INT), C('ONE_PAGE_SIZE'))
            ->where($this->where)->order('operate_log_id desc')->select();

        $this->assign('pager', $page);
        $this->assign('counts', $counts);
        $this->assign('data', $data);    

        $this->display();
        // 
    }

    private function searchParameterCheck() {
        $this->param = I('get.');
    }

    private function composeParam() {
        if(empty($this->param['create_time'])) {
            $this->where['create_time'] = ['like', date('Y-m') . '%'];
        } else {
            $this->where['create_time'] 
                = ['like', $this->param['create_time'] . '%'];
        }
    }
}