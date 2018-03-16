<?php
namespace Admin\Controller\Project;

use Think\Controller;
use Think\Log;
use Admin\Common\Model\OcModel;
use Admin\Common\Parameter\Validator;

use Admin\Model\Operate;
/**
 * 项目管理类
 */
class ManageController extends Controller
{
    private $param = [];
    private $base_model ;

    public function __construct() {
        parent::__construct();

        $this->base_model = new OcModel('project');
    }

    public function index()
    {
        if(IS_GET) {
            $where['_string'] = 'delete_time is null';
            $where['department_type_id'] = ['in', ['business','information']];
            $department = M('department')->where($where)->select();

            $this->assign('department', $department);
            $this->display();
            return;
        }
        
        // post
    }

    public function del() {
        $this->checkParameter('del');

        // 判断是否能够删除
        $this->delCheck();

        // savedb
        $this->base_model->startTrans();
        try {
            $ret = $this->base_model->where(['project_id' => $this->param['project_id']])
                ->save(['delete_time' => date('Y-m-d H:i:s')]);            
            if(false === $ret) {
                E('dberr:'. $this->base_model->getDbError());
            }

            $model = new OcModel('project_attr');
            $ret = $model->where(['project_id' => $this->param['project_id']])
                ->save(['delete_time' => date('Y-m-d H:i:s')]);
            if(false === $ret) {
                E('dberr:'. $this->base_model->getDbError());
            }

            // 计入日志
            $log = $this->base_model->where(['project_id' => $this->param['project_id']])
                ->alias('aa')->field('aa.name project_name,aa.customer_id,(select name from customer where customer_id=aa.customer_id) customer_name')->find();

            $log['event'] = '删除项目';
            (new Operate)->log($log); 

            $this->base_model->commit();
        } catch(\Exception $ex) {
            $this->base_model->rollback();

            Log::write('删除项目失败:'. $ex->getMessage());
            $this->ajaxReturn(['status' => 'failed', 
                    'message' => '删除项目失败!']);
        }        

        $this->ajaxReturn(['status' => 'success']);
    }

    private function delCheck() {
        $project = $this->base_model->find($this->param['project_id']);
        if(!$project) {
            $this->ajaxReturn(['status' => 'failed', 
                    'message' => '项目不存在!']);
        }
        if(0 != $project['approve']) {
            $this->ajaxReturn(['status' => 'failed', 
                    'message' => '项目正在走流程，不能删除!']);
        }
        if(11 != $project['son_status'] && 21 != $project['son_status'] && 31 != $project['son_status']) {
            $this->ajaxReturn(['status' => 'failed', 
                    'message' => '项目当前状态为'. c('SON_STATUS_LIST')[$project['son_status']] .'，不能删除!']);
        }

        if('boss' != session('employee.role_type_code') 
            && 'director' != session('employee.role_type_code')) {
            $this->ajaxReturn(['status' => 'failed', 
                    'message' => '您没有删除权限!']);
        }

        if(('business' == session('employee.department_type_id') 
            && 31 != $project['son_status']) || 
            ('information' == session('employee.department_type_id') 
            && (11 != $project['son_status'] || 21 != $project['son_status']))) {
            $this->ajaxReturn(['status' => 'failed', 
                    'message' => '您没有删除的权限!']);
        }
    }

    public function add()
    {
        // 判断是否
        if('salesman' != session('employee.role_type_code')
            && 'director' != session('employee.role_type_code')
            && 'boss' != session('employee.role_type_code')) {

            $this->ajaxReturn(['status' => 'failed', 
                    'message' => '你的身份不能允许该操作!']);
        }

        // post
        $type = empty(I('post.project_id'))?'add':'change';
        $this->checkParameter($type);
        $this->duplicateCheck($type);
        Log::write(json_encode($this->param), 'DEBUG');
        if('add' == $type && '本公司' == $this->param['company']) {
            // 判断是否还有其他的本公司项目没有完成的
            $where_add['customer_id'] = $this->param['customer_id'];
            $where_add['_string'] = 'delete_time is null';
            $where_add['company'] = '本公司';
            $where_add['status'] = ['not in', [6,7]];  // 完成、结案
            $ret = M('project')->where($where_add)->find();
            if($ret) {
                $this->ajaxReturn(['status' => 'failed', 
                    'message' => '该客户下还有项目未完成，不能新建项目！']);
            }
        }

        $this->base_model->startTrans();
        try {
            if('change' == $type) {
                $project = $this->base_model->find($this->param['project_id']);
                if(!$project || 0 != $project['approve']) {
                    E('该项目正在走流程，请勿修改！');
                }
            }

            $project_id = $this->saveProjectData($type, $project??null); 

            // 计入日志
            if('add' == $type) {
                $log = M('project')->where(['project_id' => $project_id])
                    ->alias('aa')->field('aa.name project_name,aa.customer_id,(select name from customer where customer_id=aa.customer_id) customer_name')->find();

                $log['event'] = '新增项目';
                (new Operate)->log($log);
            }         

            // 保存流程
            if($this->isGoApprove()) {                
                $this->launch($project_id, $this->param['approve_type']);

                // 计入日志
                if(!isset($log)) {
                    $log = M('project')->where(['project_id' => $project_id])
                    ->alias('aa')->field('aa.name project_name,aa.customer_id,(select name from customer where customer_id=aa.customer_id) customer_name')->find();
                }

                $log['event'] = C('APPROVE_LIST')[$this->param['approve_type']] . '申请';
                (new Operate)->log($log);
            }

            $this->base_model->commit();
        } catch(\Exception $ex) {
            $this->base_model->rollback();
            Log::write('保存项目失败：' . $ex->getMessage());

            $this->ajaxReturn(['status' => 'failed', 
                'message' => '保存项目失败：'.$ex->getMessage()]);
        }        

        $this->ajaxReturn(['status' => 'success']);
    }

    public function approval() {
        if(IS_GET) {
            $this->approvalDisplay();
            return;
        }
    }
    
    // 审批,总经理和主任,root可以审核任何流程
    public function approve() {
        if(IS_GET) {
            $this->display();
            return;
        }
        
        $this->checkParameter('approve');

        // 判断身份
        if('director' != session('employee.role_type_code') 
            && 'boss' != session('employee.role_type_code')) {
            $this->ajaxReturn(['status' => 'failed', 'message' => '你的身份不能允许该操作']);
        }
        // 判断当前项目的状态是否允许
        list($ret ,$project) = $this->isCanApprove($this->param['project_id']);
        if(!$ret) {
            $this->ajaxReturn(['status' => 'failed', 
                'message' => '保存客户失败：'. $project]);
        }

        // 保存     
        $this->base_model->startTrans();
        try {   
            $this->saveApprove($project);

            $this->base_model->commit();
        } catch(\Exception $ex) {
            $this->base_model->rollback();
            Log::write('审批项目失败：' . $ex->getMessage());

            $this->ajaxReturn(['status' => 'failed'
                , 'message' => '审批项目失败'. $ex->getMessage()]);
        }

        $this->ajaxReturn(['status' => 'success']);
    }

    public function allot() {
        if(IS_GET) {
            if(empty(I('get.project_id'))) {
                $this ->show('未上传参数！');
                return;
            }
            if('director' != session('employee.role_type_code') 
                && c('SELF_SYSTEMADMIN.role_id') != session('employee_id')) {
                $this->ajaxReturn(['status' => 'failed', 'message' => '您没有权限']);
            }

            // root department 特殊处理            
            if(c('SELF_SYSTEMADMIN.role_id') == session('employee_id')) {
                // 获取处理的部门id
                $department_id = M('project')->where(['project_id' => I('get.project_id')])
                    ->getField('next_department_id');
            } else {
                $department_id = session('employee.department_id');
            }

            $field = "aa.employee_id,aa.name";

            $where['aa.department_id'] = $department_id;
            $where['_string'] = 'aa.delete_time is null';
            $employee = M('employee')->alias('aa')->where($where)->field($field)
                ->join("role bb on aa.role_id=bb.role_id")
                ->select();

            $where_e['customer_id'] = M('project')
                ->where(['project_id' => I('get.project_id')])
                ->getField('customer_id');
            $where_e['department_id'] = $department_id;
            $where_e['_string'] = 'delete_time is null';
            $select_employee = M('customer_employee')->where($where_e)
                ->getField('employee_id', true);                

            $this->assign('employee', $employee);
            $this->assign('project_id', I('get.project_id'));
            $this->assign('select_employee', $select_employee);
            $this->display();
            return;
        }

        // post

        $this->checkParameter('allot');

        // 只有主任才能修改
        if('director' != session('employee.role_type_code')
            && c('SELF_SYSTEMADMIN.role_id') != session('employee_id')) {
            $this->ajaxReturn(['status' => 'failed', 'message' => '您没有权限']);
        }
        // 判断当前处理人是否正确
        $where['project_id'] = $this->param['project_id'];
        $where['is_over'] = 0;
        $where['status'] = 3;
        $in_department_id = M('project_approve')->where($where)->getField('in_department_id');
        if(!$in_department_id) {
            $this->ajaxReturn(['status' => 'failed', 'message' => '项目状态不正确']);
        }

        if(session('employee.department_id') != $in_department_id 
            && c('SELF_SYSTEMADMIN.role_id') != session('employee_id')) {
            $this->ajaxReturn(['status' => 'failed', 'message' => '您没有权限分配']);
        }

        $project = M('project')->find($this->param['project_id']);

        $this->base_model->startTrans();
        try {   
            $this->saveEmployee($project['customer_id'], $in_department_id);
            $this->saveApprove($project);

            $this->base_model->commit();
        } catch(\Exception $ex) {
            $this->base_model->rollback();
            Log::write('分配项目失败：' . $ex->getMessage());

            $this->ajaxReturn(['status' => 'failed'
                , 'message' => '分配项目失败'. $ex->getMessage()]);
        }

        $this->ajaxReturn(['status' => 'success']);
    }

    // 业务部门转到信息部门,去除该部门的业务员客户管理权限
    private function transInformation($cust, $cur_department_id) {
        $model_cust = new OcModel('customer');
        $where['customer_id'] = $cust['customer_id'];
        $save_data['business_id'] = null;
        $save_data['information_id'] = $cur_department_id;
        $save_data['last_information_id'] = $cust['information_id'];
        $save_data['last_business_id'] = $cust['business_id'];
        $save_data['cur_department_id'] = $cur_department_id;
        $ret = $model_cust->where($where)->save($save_data);
        if(false === $ret) {
            E('db err:'. $model_cust->getDbError());
        }

        $model = new OcModel('customer_employee');
        $where['department_id'] = $cust['business_id'];
        $save_epy['delete_time'] = date('Y-m-d H:i:s');

        $ret = $model->where($where)->save($save_epy);
        if(false === $ret) {
            E('db err:'. $model->getDbError());
        }
    }

    private function delCustEmpolyee($department_id) {
        $model = new OcModel('customer_employee');

        $where['department_id'] = $department_id;
        $save_epy['delete_time'] = date('Y-m-d H:i:s');

        $ret = $model->where($where)->save($save_epy);
        if(false === $ret) {
            E('db err:'. $model->getDbError());
        }
    }

    /**
     * 重复检查
     * @param $type  类型，add是新增，change是修改
     */
    private function duplicateCheck($type = 'add')
    {
        
        $where['_string'] = 'delete_time is null';
        $where['name'] = $this->param['name'];
        $where['customer_id'] = $this->param['customer_id'];

        if ($type == 'add') {
            $result = $this->base_model->where($where)->find();
        } else {
            $where['project_id'] = ['neq' , $this->param['project_id']];
            $result = $this->base_model->where($where)
                ->find();
        }

        if ($result) {
            $this->ajaxReturn([
                'status' => 'failed',
                'message' => '该项目已经存在，请检查！'
            ]);
        }
    }

    private function getLogName(int $project_id) {
        $log = M('project')->where(['project_id' => $project_id])
            ->alias('aa')->field('aa.name project_name,aa.customer_id,(select name from customer where customer_id=aa.customer_id) customer_name')->find();   

        return $log;
    }

    private function saveEmployee($customer_id, $in_department_id) {
        $model = new OcModel('customer_employee');

        // 删除没有选中的
        $where['customer_id'] = $customer_id;
        $where['department_id'] = $in_department_id;
        $where['employee_id'] = ['not in', $this->param['employee']];
        $ret = $model->where($where)->save(['delete_time' => date('Y-m-d H:i:s')]);
        if(false === $ret) {
            E('db error2:' . $model->getDbError());
        }
        //
        $data['customer_id'] = $customer_id;
        $data['department_id'] = $in_department_id;
        $data['update_time'] = date('Y-m-d H:i:s');
        $data['_string'] = 'delete_time is null';

        foreach ($this->param['employee'] as $value) {
            $data['employee_id'] = $value;

            // 判断是否已经存在
            $find = $model->where($data)->find();
            if($find) continue;

            $ret = $model->add($data);
            if(false === $ret) {
                E('db error3:' . $model->getDbError());
            }
        }
    }

    private function approvalDisplay() {
        if(empty(I('get.project_id'))) {
            $this ->show('未上传参数！');
            return;
        }

        list($ret ,$result) = $this->isCanApprove(I('get.project_id'));
        if(!$ret) {
            $this ->show($result);
            return;
        }

        // 获取流程
        $where_t['aa.project_id'] = I('get.project_id');
        $where_t['is_over'] = 0;
        $field = "aa.*,bb.name operator_name,bb.thumbnail_url,(select name from department where department_id=aa.out_department_id) out_department_name"
            . ",(select name from department where department_id=aa.in_department_id) in_department_name";
        $approve = M('project_approve')->alias('aa')->where($where_t)
            ->join('employee bb on aa.employee_id=bb.employee_id')
            ->field($field)->order('aa.status,create_time')->select();
        
        if('boss' == session('employee.role_type_code')) {
            if(1 == $result['approve']) {
                // 业务转交给业务部
                $where_d['department_type_id'] = 'business';
            } else {
                // 返回根据或结案都转给信息部
                $where_d['department_type_id'] = 'information';
            }
            $where_d['_string'] = 'delete_time is null';

            $department = M('department')->where($where_d)->select();

            $this->assign('department', $department);
            $this->assign('out_department_id', $employee['out_department_id']);
        }

        $this->assign('approve', $approve);
        $this->assign('project', $result);
        $this->display();
    }

    private function saveApprove($project) {
        
            // 获取新状态
            $data_status = $this->getNewStatus($project);

            // 总经理审批,转发和返回，会更改处理部门
            if(isset($this->param['is_pass']) && 1 == $this->param['is_pass'] && (3 == $data_status['approve_status'] && (
                1 == $data_status['approve'] || 2 == $data_status['approve'] 
                || 3 == $data_status['approve']))) {
                if(empty($this->param['handle_department_id'])) {
                    E('未选择处理的部门');
                }

                // 总经理操作会修改客户的当前归属部门
                $this->changeTransDepartment($project['customer_id'], $this->param['handle_department_id'],$data_status['approve']);

                // 变更的部门需要保存
                $data_status['in_department_id'] = $this->param['handle_department_id'];
                $data_status['next_department_id'] = $this->param['handle_department_id'];
            }

            // 保存项目状态
            $data_proj = $data_status;
            // 对于流程结束的特殊处理
            if(0 == $data_proj['approve']) {
                $data_proj['approve_status'] = 0;
                $data_proj['out_department_id'] = null;
                $data_proj['in_department_id'] = null;
                $data_proj['next_department_id'] = null;
            }
            Log::write(json_encode($data_proj));
            $where['project_id'] = $project['project_id'];
            $ret = $this->base_model->where($where)
                ->save($data_proj);
            if(false === $ret) {
                E($this->base_model->getDbError());
            }

            // 获取发起信息
            $where_app['project_id'] = $project['project_id'];
            $where_app['status'] = 1;
            $where_app['approve'] = $project['approve'];
            $where_app['is_over'] = 0;
            $approve = M('project_approve')->where($where_app)->order('create_time')->find();

            $modle = new OcModel('project_approve');
            // 关闭所有流程记录状态  
            if(0 == $data_status['approve']) {      
                unset($where_app['status']);
                $ret = $modle->where($where_app)->save(['is_over' => 1]);
                if(false === $ret) {
                    E($modle->getDbError());
                }
            }

            // 保存流程状态  
            $data = $approve; 
            unset($data['project_approve_id']);
            unset($data['create_time']);
            unset($data['update_time']);
            unset($data['operator']);

            if(!empty($this->param['is_pass']))
                $data['is_pass'] = $this->param['is_pass'];
            if(!empty($this->param['reply']))
                $data['reply'] = $this->param['reply'];
            $data['project_id'] = $project['project_id'];

            $data = array_merge($data, $data_status);

            $data['status'] = $data_status['approve_status'];            
            $data['approve'] = $approve['approve'];
            $data['start_employee'] = $approve['employee_id'];
            $data['employee_id'] = session('employee_id');

            $data['is_over'] = (isset($this->param['is_pass']) 
                && 0 == $this->param['is_pass']) ? 1: 0;  // 审批不通过关闭流程

            if(0 == $data_status['approve']) {
                $data['is_over'] = 1;
            }

            $ret = $modle->add($data);
            if(false === $ret) {
                E($modle->getDbError());
            }

            $this->saveLog($project['project_id'], $data['approve'], $data['status']);
    }

    private function saveLog($project_id, $approve, $status) {
        if(4 <= $status) {
            // 不保存分配
            return;
        }

        $log = $this->getLogName($project_id);

        $log['event'] = C('APPROVE_LIST')[$approve] . C('APPROVE_STATUS_LIST')[$status];

        $log['result'] = (empty($this->param['is_pass'])) ? '不同意':'同意';

        (new Operate)->log($log);
    }

    // 判断是否能审批
    private function isCanApprove($project_id) {
        $where['project_id'] = $project_id;
        $where['_string'] = 'delete_time is null';
        $where['approve'] = ['neq', 0];

        $field="aa.*,(select name from customer where customer_id=aa.customer_id) customer_name,(select name from department where department_id=aa.out_department_id) out_department_name";
        $project = $this->base_model->alias('aa')->where($where)->field($field)->find();
        if(!$project) {
            return [false, '项目状态不正确'];
        }

        // 审批审核只能针对状态小于等于3的情况
        if(3 <= $project['approve_status']) {
            return [false, '项目流程状态不正确'];
        }
        
        //如果是root用户则允许代各主任审核
        if(c('SELF_SYSTEMADMIN.role_id') == session('employee_id')) {
            return [true, $project];
        }

        // 判断审批的身份是否对应
        $ide = session('employee.role_type_code');
        if('boss' == session('employee.role_type_code')) {
            if(!((1 == $project['approve'] || 2 == $project['approve'] 
                || 3 == $project['approve']) 
                && 2 == $project['approve_status'])) {
                return [false, '当前项目不满足您审核状态！'];
            }
        } else if('director' == session('employee.role_type_code') 
            && 'business' == session('employee.department_type_id')) {
            if(1 != $project['approve_status'] && 3 != $project['approve_status']) {
                return [false, '当前项目不满足您审批状态！'];
            }
        } else if('director' == session('employee.role_type_code') 
            && 'information' == session('employee.department_type_id')) {
            if(!((1 == $project['approve_status'] && 1 == $project['approve']) 
                || (3 == $project['approve_status'] && 2 == $project['approve']))) {
                return [false, '当前项目不满足您审批状态.！'];
            }
        } else {
            return [false, '您没有权限！'];
        }


        return [true, $project];
    }

    // 审批，获取新的审批状态
    private function getNewStatus($project) {
        // 下一状态加1
        $status['approve_status'] = $project['approve_status'] + 1;
        $status['approve'] = $project['approve'];

        // 是否审批通过，1,2 不通过就关闭流程，3分配没有是否通过的概念。
        if(isset($this->param['is_pass']) && 0 == $this->param['is_pass']) {
            Log::write('审批不通过');
            $status['approve'] = 0;  
            return $status;
        }

        // 流程完毕，1：转发，2返回跟进，3申请结案',总经理处理完毕就修改状态
        if((1 == $project['approve'] || 2 == $project['approve'] || 3 == $project['approve'])
            && 3 == $status['approve_status']) {
            $status['status'] = (1 == $project['approve']) ? 3 : ((2 == $project['approve']) ? 1 : 6);
            $status['son_status'] = $status['status'] . '1';
            if(2 == $project['approve']) {
                $status['is_return'] = 1;
            }
        }
        // 流程4 ，5 (申请结束和转合作中)
        if((4 == $project['approve'] || 5 == $project['approve']) 
            && 2 == $status['approve_status']) {
            $status['approve'] = 0;
            if(4 == $project['approve']) {
                $status['status'] = 7;
                $status['son_status'] = 46;
            } else {
                $status['status'] = 4;
                $status['son_status'] = 44;
            }
        }

        if(4 == $status['approve_status']) {
            $status['approve'] = 0;
        }

        // 设置下一流程需要处理的部门
        if(1 == $status['approve_status']) {
            $status['next_department_id'] = session('employee.department_id');
        } else if(2 == $status['approve_status'] && (1 <= $status['approve'] && 3 >= $status['approve'])) {
            // 总经理部门
            $depart = $this->getBossDepartment();
            $status['next_department_id'] = $depart['department_id'];
        }
        
        return $status;
    }

    // 总经理部门
    private function getBossDepartment() {
        $where['department_type_id'] = 'boss';
        $where['_string'] = 'delete_time is null';
        $department = M('department')->where($where)->find();

        return $department;
    }

    // 保存项目表
    private function saveProjectData($type, $project) {
        // pc特殊处理，手机不需要修改这些内容
        Log::write($GLOBALS["client_theme"] . $type);
        if('pc' == $GLOBALS["client_theme"]) {
            $this->param['son_status'] = $this->param['status'];
            $this->param['status'] = substr($this->param['status'],0,1);
            // 在建在展则设置合同时间
            if(((4 == $this->param['approve_type'] || 5 == $this->param['approve_type'])
                && empty($project['contract_date']))
                || 44 == $this->param['son_status']) {
                $this->param['contract_date'] = date('Y-m-d');
            }
        }
        Log::write(json_encode($this->param));
        if(0 != $this->param['approve_type']) {
            // 根据不同的角色设置不同的流程
            $this->initApproveStatus();
        }
        
        if('add' == $type) {
            // 判断是否是老客户，老客户的初始状态为合作中
            $where_his['customer_id'] = $this->param['customer_id'];
            $where_his['company'] = '本公司';
            $where_his['_string'] = 'delete_time is null and contract_date is not null';
            $his = $this->base_model->where($where_his)->count();
            if(0 < $his) {
                $this->param['status'] = 4;
            }

            $project_id = $this->base_model->add($this->param);            
        } else {

            $project_id = $this->base_model->save($this->param);            
        }

        if(false === $project_id) {
            E('db error：' . $this->base_model->getDbError());
        }

        $model_attr = new OcModel('project_attr');
        if('add' == $type) {
            $this->param['project_id'] = $project_id;
            $ret = $model_attr->add($this->param);
        } else {
            $ret = $model_attr->save($this->param);
        }
        if(false === $ret) {
            E('db error：' . $this->base_model->getDbError());
        }        

        return ('add' == $type) ? $project_id : $this->param['project_id'];
    }

    // 判断是否需要走流程
    private function isGoApprove() {
        if(0 == $this->param['approve_type']) {
            return false;
        }

        if((4 == $this->param['approve_type'] 
            || 5 == $this->param['approve_type'])
            && ('director' == session('employee.role_type_code') 
                || 'boss' == session('employee.role_type_code'))) {
            return false;
        }

        return true;
    }

    // 根据不同的角色设置不同的流程
    private function initApproveStatus() {
        $this->param['approve'] = $this->param['approve_type'];
        $this->param['out_department_id'] = session('employee.department_id');
        $this->param['next_department_id'] = session('employee.department_id');

        $role_type = session('employee.role_type_code');
        if(1 == $this->param['approve_type'] 
            || 2 == $this->param['approve_type']
            || 3 == $this->param['approve_type']) {

            $temp_s = (('boss'==$role_type)?3:('director'==$role_type?2:1));
            $this->param['approve_status'] = $temp_s;

            // 设置下一处理部门
            if('director'==$role_type) {
                $depart = $this->getBossDepartment();
                $this->param['next_department_id'] = $depart['department_id'];
            } else if('boss'==$role_type){
                $this->param['next_department_id'] = $this->param['in_department_id'];
                // 总经理操作会修改客户的当前归属部门
                $this->changeTransDepartment($this->param['customer_id'], $this->param['in_department_id'], $this->param['approve_type']);
                // 修改项目状态
                $this->param['status'] = (1 == $this->param['approve_type']) ? 3 : ((2 == $this->param['approve_type']) ? 1 : 6);
                $this->param['son_status'] = $this->param['status'] . '1';
                if(2 == $this->param['approve_type']) {
                    $this->param['is_return'] = 1;
                }   
            }

        } else if(4 == $this->param['approve_type'] 
            || 5 == $this->param['approve_type']) {
            if('salesman'==$role_type) {
                $this->param['approve_status'] = 1;
            } else {
                $this->param['approve_status'] = 0;
                $this->param['approve'] = 0;

                if(4 == $this->param['approve_type']) {
                    $this->param['status'] = 7;
                    $this->param['son_status'] = 46;
                } else {
                    $this->param['status'] = 4;
                    $this->param['son_status'] = 44;
                }
            }
        } else {
            E('没有该流程' . $this->param['approve_type']);
        }   
    }

    private function changeTransDepartment($customer_id, $cur_department_id, $approve_type) {
        $model = new OcModel('customer');
        $where_cust['customer_id'] = $customer_id;
        $cust = $model->where($where_cust)->find();
        if(false === $cust) {
            E('err：客户不存在' );
        }
        if(1 == $approve_type) {
            // 获取部门的类型
            $where_t['department_id'] = $cur_department_id;

            $temp_type = M('department')->where($where_t)->getField('department_type_id');
            $data_cust[$temp_type . '_id'] = $cur_department_id;
            $data_cust['last_' . $temp_type . '_id'] = $cust[$temp_type . '_id'];
            $data_cust['cur_department_id'] = $cur_department_id;

            $ret = $model->where($where_cust)->save($data_cust);
            if(false === $ret) {
                E('db err:'.$model->getDbError());
            }
            // 解除原部们的关系
            if($cust[$temp_type . '_id'] != $cur_department_id) {
                $this->delCustEmpolyee($cust[$temp_type . '_id']);
            }                    
        } else if(2 == $approve_type
            || 3 == $approve_type) {
            // 返回跟进和申请结案，只能返回给信息中心,解除业务部和客户的关系
            $this->transInformation($cust, $cur_department_id);
        }
    }

    /*
     * 发起项目流程。1转交，2返回，3申请结案,4申请结束，5转合作中
     * 返回可能引起客户的信息中心部门变化
     */
    private function launch($project_id, $type)
    { 
        // 保存流程
        $approve['project_id'] = $project_id;
        $approve['out_department_id'] = session('employee.department_id');
        $approve['approve'] = $type;        
        $approve['employee_id'] = session('employee_id');

        $modle = new OcModel('project_approve');

        for($i = 1; $i <= $this->param['approve_status']; $i++) {
            if(3 == $i) {
                $approve['reply'] = $this->param['reply'];
                $approve['in_department_id'] = $this->param['in_department_id'];
                // 修改客户所属部门
                $this->changeCustomer($project_id);
            }
            $approve['status'] = $i;
            $ret = $modle->add($approve);
            if(false === $ret) {
                E('db err:' . $modle->getDbError());
            }
        }        
    }

    // 设置boss cust
    private function changeCustomer($project_id) {        
        $proj = M('project')->find($project_id);
        $department = M('department')->find($this->param['in_department_id']);

        $data[$department['department_type_id'] . '_id'] 
            = $this->param['in_department_id'];
        $data['last_'.$department['department_type_id'] . '_id'] 
            = $proj['cur_department_id'];
        $data['cur_department_id'] = $this->param['in_department_id'];

        $where['customer_id'] = $proj['customer_id'];
        $model = new OcModel('customer');
        $ret = $model->where($where)->save($data);
        if(false === $ret) {
            E('db err:'.$model->getDbError());
        }
    }

    private function checkParameter(string $type)
    {
        $this->param = I('post.');
        try {
            if ('add' == $type || 'change' == $type) {
                if ('change' == $type) {
                    (new Validator())->execute(I('post.'), [
                        'project_id' => ['type' => 'integer'],
                    ]);
                }
                (new Validator())->execute(I('post.'), [
                    'customer_id' => ['type' => 'integer'],
                    'name' => ['type' => 'string', 'required' => false],
                    'time_type' => ['enum_eq' => [0,1], 'required' => false,'allow_empty'=>true],
                    'approve_type' => ['enum_eq' => [0,1,2,3,4,5]],
                    'begin_date' => ['type' => 'date', 'required' => false,'allow_empty'=>true],
                    'end_date' => ['type' => 'date', 'required' => false,'allow_empty'=>true],
                    'scale_fee' => ['type' => 'numeric', 'required' => false,'allow_empty'=>true],
                    'fee_type' => ['type' => 'integer', 'required' => false,'allow_empty'=>true],
                    'company' => ['type' => 'string', 'required' => false],
                    'other_company' => ['type' => 'string', 'required' => false,'allow_empty'=>true],
                    'status' => ['regexp' => '/^\d{2}$/', 'required' => false],
                    'context' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
                    'summary' => ['type' => 'string', 'required' => false, 'allow_empty' => true], 
                    'other_cust' => ['type' => 'string', 'required' => false, 'allow_empty' => true],                   
                ]);
                if('pc' == $GLOBALS['client_theme']) {
                    if('本公司' == I('post.company')) {                    
                        $this->param['other_company'] = null;
                    }
                }
                if('' === I('post.is_ticket')??null) {
                    $this->param['is_ticket'] = null;
                }

                if(empty(I('post.begin_date'))) {
                    $this->param['begin_date'] = null;
                }
                if(empty(I('post.end_date'))) {
                    $this->param['end_date'] = null;
                }
                if(empty(I('post.other_cust'))) {
                    $this->param['other_cust'] = null;
                } 
            } else if('approve' == $type) {
                (new Validator())->execute(I('post.'), [
                    'project_id' => ['type' => 'integer'],
                    'is_pass' => ['enum_eq' => [0,1]], // 是否审批通过
                    'reply' => ['type' => 'string', 'required' => false, 'allow_empty' => true],
                    'handle_department_id' => ['type' => 'integer'
                        ,'required' => false, 'allow_empty' => true
                    ],                    
                ]);

                if(empty($this->param['reply'])) {
                    $this->param['reply'] = null;
                }
            } else if('allot' == $type) {
                (new Validator())->execute(I('post.'), [
                    'project_id' => ['type' => 'integer'],
                    'employee' => [
                        'type' => 'array',
                        'value' => [
                            'type' => 'integer'
                        ]
                    ]                   
                ]);
            } else if ('del' == $type) {
                (new Validator())->execute(I('post.'), [
                    'project_id' => ['type' => 'integer'],
                ]);
            }
        } catch (\Exception $ex) {

            $this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！'.$ex->getMessage()]);
        }
    }
}