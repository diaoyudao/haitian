<?php

namespace Admin\Controller\Statistics;

use Think\Controller;
use Think\Log;
use Admin\Common\Model\OcModel;
use Admin\Common\Parameter\Validator;
use Admin\Common\Textarea;

/**
 * 形势统计类
 */
class SituationController extends Controller
{
	const PAGE_SIZE = 5;
	// 保存文件路径
	private $param = [];
	private $where = [];
	private $base_model;
	private $result;
	
	public function __construct()
	{
		parent::__construct();
		
		$this->base_model = new OcModel('project');
	}
	
	public function changeLevel()
	{
		$this->checkParameter('level');
		
		// 判断旗下是否有项目没有结案
		$where_h['customer_id'] = $this->param['customer_id'];
		$where_h['status'] = ['not in', [6, 7]];
		$where_h['_string'] = 'delete_time is null';
		
		$history = $this->base_model->where($where_h)->find();
		if ($history && 'Z' == $this->param['level']) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '该客户下还有项目未结束或结案，不能转普通！']);
		}
		
		$where['project_id'] = $this->param['project_id'];
		
		$data['level'] = $this->param['level'];
		
		$ret = $this->base_model->where($where)->save($data);
		if (false === $ret) {
			Log::write('修改项目级别失败：' . $this->base_model->getDbError());
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '修改失败！']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	public function list()
	{
		$this->checkParameter('list');
		$this->composeParam();
		
		$where['_string'] = 'delete_time is null';
		$department = M('department')->where($where)
			->field('department_id,name')->select();
		
		$province = M('province')
			->field('province_id,province_name')->select();
		
		$companys = M('opponent')->where($where)
			->field('name')->select();
		array_unshift($companys, ['name' => '本公司']);
		
		$this->getData();
		$this->getModel();
		
		$this->assign('department', $department);
		$this->assign('province', $province);
		$this->assign('companys', $companys);
		
		$this->display();
	}
	
	public function getData()
	{
		$counts = $this->base_model->where($this->where)
			->alias('aa')
			->join('customer bb on aa.customer_id=bb.customer_id and bb.delete_time is null')
			->join('project_attr ar on ar.project_id=aa.project_id')
			->count();
		$page_size = !empty($this->param['pg_size']) ? $this->param['pg_size'] : self::PAGE_SIZE;
		
		$page = new \Think\Page($counts, $page_size);
		$page->show();
		
		$field = "aa.light_proj,bb.name customer_name,aa.name project_name,bb.business_id, scale_fee,aa.customer_id,aa.project_id,aa.son_status,"
			. "aa.begin_date,aa.end_date,(select name from config_auto where config_auto_id=aa.fee_type) fee_type,bb.business_id,(select name from model_config where model_config_id=aa.proj_type) proj_type,"
			. "context,if('本公司'!=company,if('' !=other_company,other_company,company),concat(company,',',common_company)) company,"
			. "aa.level,aa.address,if('1'=is_ticket,'是',if('0'=is_ticket,'否','')) is_ticket,traffic,peace_passenger,relation,ability,ticket,run_ticket,run_passenger,out_value,programme,report";
		
		$this->result = $this->base_model->where($this->where)
			->page($this->param['pg'] ?? 1, $page_size)
			->field($field)->alias('aa')
			->join('customer bb on aa.customer_id=bb.customer_id and bb.delete_time is null')
			->join('project_attr ar on ar.project_id=aa.project_id')
			->order('bb.province_id,bb.city_id,bb.county_id,aa.project_id')
			->select();
		foreach ($this->result as &$v) {
			if (!empty($v['context'])) {
				$Textarea = new Textarea($v['context']);
				$v['context'] = $Textarea->convertEnterToNone();
			}
		}
		$this->assign('data', $this->result);
		$this->assign('pager', $page);
		
	}
	
	public function changeAbc()
	{
		$this->checkParameter('changeAbc');
		
		$old_proj = $this->base_model->find($this->param['project_id']);
		if ($old_proj['level'] == $this->param['level']) {
			// 不处理
			$this->ajaxReturn(['status' => 'success']);
		}
		if (0 != $old_proj['approve']) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '该项目正在走流程不能修改']);
		}
		
		$this->base_model->startTrans();
		try {
			$model = new OcModel('customer');
			// 修改项目的等级
			$data['level'] = $this->param['level'];
			if ('H' == $data['level']) {
				// 只是修改一下项目等级。
			} else if ('Z' == $old_proj['level'] && 'Z' != $this->param['level']
//				&& (1 == $old_proj['status'] || 2 == $old_proj['status'])) {
			) {
				$data['status'] = 5;
				$data['son_status'] = 51;
				
				$this->changeCust($old_proj);
			}
//			else if ('Z' != $old_proj['level'] && 'Z' == $this->param['level']
//				&& (5 == $old_proj['status'])) {
//				$data['status'] = 2;
//				$data['son_status'] = 21;
//
//				$this->changeCust($old_proj);
//			}
			
			$ret = $this->base_model
				->where(['project_id' => $this->param['project_id']])
				->save($data);
			if (false === $ret) {
				E('修改项目等级失败:' . $this->base_model->getDbError());
			}
			
			$this->base_model->commit();
		} catch (\Exception $ex) {
			$this->base_model->rollback();
			
			Log::write('修改changeAbc失败：' . $ex->getMessage());
			$this->ajaxReturn(['status' => 'failed', 'message' => '修改失败！']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	public function bak()
	{
		if (IS_GET) {
			$this->bakPage();
			
			return;
		}
		
		$this->bakSubmit();
	}
	
	public function delBak()
	{
		if (empty(I('post.id'))) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！']);
		}
		
		$model = new OcModel('project_copy');
		$where['project_copy_id'] = I('post.id');
		$ret = $model->where($where)->save(['delete_time' => date('Y-m-d H:i:s')]);
		if (false === $ret) {
			$this->ajaxReturn(['status' => 'failed', 'message' => '删除失败！']);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	public function down()
	{
		if (empty(I('get.id'))) {
			$this->show('参数错误，请检查！');
			return;
		}
		
		$where['id'] = I('get.id');
		$file = M('project_copy')->where($where)->find();
		if (!$file) {
			$this->show('参数错误，请检查2！');
			return;
		}
		
		header("Content-Disposition: attachment; filename= " . $file['file_name']);
		header("Content-Type: application/octet-stream");
		header('X-Accel-Redirect: /down' . $file['file_path'] . '/' . $file['file_name']);
		header("X-Accel-Buffering: yes");
		header("X-Accel-Limit-Rate :512000");
	}
	
	private function bakSubmit()
	{
		// 查看当前是否有正在备份的状态
		$model = new OcModel('project_copy');
		$where['operate_date'] = date('Y-m-d');
		$where['status'] = 0;
		$where['_string'] = 'delete_time is null';
		
		$find = $model->where($where)->find();
		if ($find) {
			//$this->ajaxReturn(['status' => 'success']);
		}
		// 获取abc数量
		$where_p['_string'] = 'delete_time is null';
		$where_p['level'] = ['neq', 'Z'];
		
		$num = M('project')->where($where_p)->count();
		// 创建vcs文件
		$model->startTrans();
		try {
			$file = $this->createVcs();
			// 写入数据库记录
			$data['abc_num'] = $num;
			$data['operate_date'] = date('Y-m-d');
			$data['status'] = 0;
			$data['note'] = I('post.note');
			$data['file_path'] = $file[0];
			$data['file_name'] = $file[1];
			$data['id'] = md5($file[1]);
			$ret = $model->add($data);
			if (false === $ret) {
				E('db err:' . $model->getDbError());
			}
			
			$model->commit();
		} catch (\Exception $ex) {
			$model->rollback();
			Log::write('写入形式文件失败' . $ex->getMessage());
			
			$this->ajaxReturn(['status' => 'failed', 'message' => '后台处理失败.！' . $ex->getMessage()]);
		}
		
		$this->ajaxReturn(['status' => 'success']);
	}
	
	private function getModel()
	{
		$where['_string'] = 'delete_time is null';
		$res = M('model_config')->where($where)->order('model_config_id')->select();
		
		$this->assign('models', $res);
	}
	
	private function createVcs()
	{
		$file_path = ROOT_PATH . c('PROJECT_COPY_PATH');
		$month = date('Y-m');
		
		$file_path = $file_path . $month;
		if (!is_dir($file_path)) {
			mkdir($file_path);
		}
		
		$file_name = c('PROJECT_FILE_PREFIX') . date('Y-m-d-His') . '.csv';
		
		$field = "(select province_name from province where province_id=bb.province_id limit 1) prov_name,if('1'=pj.light_proj,'是','否') is_light,bb.name cust_name,pj.name,pj.project_id,(select name from model_config where model_config_id=pj.proj_type) proj_type,begin_date,end_date,scale_fee,(select name from config_auto where config_auto_id=pj.fee_type) fee_type,if('1'=is_ticket,'是','否') is_ticket,if('本公司'=company,company,other_company) company,concat(level,'级') level,pj.address,ticket,traffic,peace_passenger,relation,ability,run_ticket,run_passenger,out_value,programme,report,context";
		
		// $field = "aa.light_proj,bb.name customer_name,aa.name project_name,aa.proj_type,bb.business_id, scale_fee,aa.customer_id,aa.project_id,aa.son_status,"
		//     . "aa.begin_date,aa.end_date,(select name from config_auto where config_auto_id=aa.fee_type) fee_type,bb.business_id,"
		//     . "context,if('本公司'=company,concat(company,',',common_company),other_company) company,"
		//     . "concat(aa.level,'级') level,aa.address,if('1'=is_ticket,'是',if('0'=is_ticket,'否','')) is_ticket,traffic,peace_passenger,relation,ability,ticket,run_ticket,run_passenger,income,programme,report";
		
		$where['_string'] = 'pj.delete_time is null';
		$where['is_show_situation'] = 1;
		if (!empty(I('post.begin_time')) && empty(I('post.end_time'))) {
			$where['pj.begin_date'] = ['egt', I('post.begin_time')];
		}
		if (!empty(I('post.end_time')) && empty($this->param['begin_time'])) {
			$where['pj.begin_date'] = ['elt', I('post.end_time')];
		}
		if (!empty(I('post.begin_time')) && !empty(I('post.end_time'))) {
			$where['pj.begin_date'] = [['egt', I('post.begin_time')], ['elt', I('post.end_time')]];
		}
		$result = M('project')->where($where)->field($field)->alias('pj')
			->join('project_attr ar on ar.project_id=pj.project_id')
			->join('customer bb on pj.customer_id=bb.customer_id and bb.delete_time is null')
			->order('bb.province_id,bb.city_id,bb.county_id,pj.project_id')
			->select();
		
		$str = '序号,省,落实完成,客户名称,项目名称,项目类型,展出时间,规模,投资形式,售票,制作公司,级别,展出场地,日常门票,交通情况,日常客流,场地性质及上下级关系,接待能力,项目情况,灯会期间门票,灯会期间客流,收益情况,运营方案,网络报道' . "\n";
		
		$wh = fopen($file_path . '/' . $file_name, 'w');
		
		$str = iconv('utf-8', 'gbk', $str);
		if (false === fwrite($wh, $str)) {
			fclose($wh);
			E('写入文件失败');
		}
		foreach ($result as $n => $v) {
			if ($v['level'] == 'Z级') {
				$v['level'] = '普通';
			}
			$str = ($n + 1) . ',' . $v['prov_name'] . ',' . $v['is_light'] . ',' . $v['cust_name'] . ',' . $v['name'] . ',' . $v['proj_type'] . ',' . $v['begin_date'] . '~' . $v['end_date'];
			$str .= ',' . $v['scale_fee'] . ',' . $v['fee_type'] . ',' . $v['is_ticket'];
			$str .= ',"' . $v['company'] . '",' . $v['level'] . ',' . $v['address'];
			$str .= ',' . $v['ticket'] . ',"' . $v['traffic'] . '",' . $v['peace_passenger'];
			$str .= ',"' . $v['relation'] . '",' . $v['ability'] . ',"' . $v['context'];
			$str .= '",' . $v['run_ticket'] . ',' . $v['run_passenger'] . ',' . $v['out_value'];
			$str .= ',"' . $v['programme'] . '","' . $v['report'] . '"' . "\n";
			
			
			//$str = iconv('utf-8', 'gbk//ignore', $str);
			$str = mb_convert_encoding($str, 'gbk', 'auto');
			Log::write($n . ' :: ' . $str);
			
			if (false === fwrite($wh, $str)) {
				fclose($wh);
				E('写入文件失败');
			}
		}
		
		fclose($wh);

		if ('0' === I('post.is_show_situation')) {

			$model = new OcModel('project');
			$model->startTrans();
			try {
				foreach ($result as $item) {
					$ret = $model->where(['project_id'=>$item['project_id']])->setField('is_show_situation', 0);
					if (false === $ret) {
						E('db err:' . $model->getDbError());
					}
				}
				
				$model->commit();
			} catch (\Exception $ex) {
				$model->rollback();
				$this->ajaxReturn(['status' => 'failed', 'message' => '后台处理失败.！' . $ex->getMessage()]);
			}
		}
		
		return [c('PROJECT_COPY_PATH_S') . $month, $file_name];
	}
	
	private function bakPage()
	{
		$where['_string'] = 'delete_time is null';
		
		$counts = M('project_copy')->where($where)->count();
		
		$page = new \Think\Page($counts, C('ONE_PAGE_SIZE'));
		$page->show();
		
		$copy = M('project_copy')->where($where)
			->page(I('get.pg') ?? 1, C('ONE_PAGE_SIZE'))
			->select();
		
		$this->assign('data', $copy);
		$this->display();
	}
	
	// 判断项目状态，转换客户的归属到当前业务部
	private function changeCust($old_proj)
	{
		$model = new OcModel('customer');
		$old_cust = $model->find($old_proj['customer_id']);
		// 转信息中心
//		if (5 == $old_proj['status']) {
//			if (empty($old_cust['information_id'])) {
//				return;  // 业务部创建的客户,不转信息中心了
//			}
//
//			$data['business_id'] = null;
//			$data['last_business_id'] = $old_cust['business_id'];
//		} else {
			if(session('employee.role_type_code') != 'boss'){
				$data['business_id'] = session('employee.department_id');
			}
			$data['last_business_id'] = $old_cust['business_id'];
//		}
		
		$ret = $model->where(['customer_id' => $old_proj['customer_id']])
			->save($data);
		if (false === $ret) {
			E('db err:' . $model->getDbError());
		}
	}
	
	private function composeParam()
	{
		$this->where['_string'] = 'aa.delete_time is null';
		$this->where['is_show_situation'] = 1;
		
		if (!empty($this->param['department_id'])) {
			$this->where['bb.create_department_id'] = $this->param['department_id'];
		}
		
		if (!empty($this->param['province_id'])) {
			$this->where['bb.province_id'] = $this->param['province_id'];
		}
		if (!empty($this->param['city_id'])) {
			$this->where['bb.city_id'] = $this->param['city_id'];
		}
		if (!empty($this->param['county_id'])) {
			$this->where['bb.county_id'] = $this->param['county_id'];
		}
		if (!empty($this->param['year'])) {
			$this->where['aa.year'] = $this->param['year'];
		}
		
		if (!empty($this->param['is_ticket']) || '0' === $this->param['is_ticket'] ?? null) {
			$this->where['ar.is_ticket'] = $this->param['is_ticket'];
		}
		if (!empty($this->param['time_type']) || '0' === $this->param['time_type'] ?? null) {
			$this->where['aa.time_type'] = $this->param['time_type'];
		}
		
		if (!empty($this->param['begin_time']) && empty($this->param['end_time'])) {
			$this->where['aa.begin_date'] = ['egt', $this->param['begin_time']];
		}
		if (!empty($this->param['end_time']) && empty($this->param['begin_time'])) {
			$this->where['aa.begin_date'] = ['elt', $this->param['end_time']];
		}
		if (!empty($this->param['begin_time']) && !empty($this->param['end_time'])) {
			$this->where['aa.begin_date'] = [['egt', $this->param['begin_time']], ['elt', $this->param['end_time']]];
		}
		
		if (!empty($this->param['company'])) {
			if ($this->param['company'] == '本公司') {
				$this->where['aa.company'] = $this->param['company'];
			} else {
				$this->where['aa.other_company'] = ['like', "%" . $this->param['company'] . "%"];
			}
		}
		if (!empty($this->param['level'])) {
			$this->where['aa.level'] = $this->param['level'];
		}
		if (!empty($this->param['light_proj']) || '0' === $this->param['light_proj'] ?? null) {
			$this->where['aa.light_proj'] = $this->param['light_proj'];
		}
		if (!empty($this->param['proj_type'])) {
			$this->where['aa.proj_type'] = $this->param['proj_type'];
		}
		if (!empty($this->param['name'])) {
			$this->where['bb.name'] = ['like', '%' . $this->param['name'] . '%'];
		}
		
		
	}
	
	private function checkParameter($type)
	{
		try {
			if ('level' == $type) {
				(new Validator())->execute(I(''), [
					'customer_id' => ['type' => 'integer'],
					'project_id' => ['type' => 'integer'],
					'level' => ['enum_eq' => array_keys(c('PROJECT_LEVEL_LIST'))]
				]);
			} else if ('list' == $type) {
				(new Validator())->execute(I(''), [
					'department_id' => [
						'type' => 'integer',
						'required' => false,
						'allow_empty' => true
					],
					'province_id' => [
						'type' => 'integer',
						'required' => false,
						'allow_empty' => true
					],
					'city_id' => [
						'type' => 'integer',
						'required' => false,
						'allow_empty' => true
					],
					'county_id' => [
						'type' => 'integer',
						'required' => false,
						'allow_empty' => true
					],
					'is_ticket' => [
						'enum_eq' => [0, 1],
						'required' => false,
						'allow_empty' => true
					],
					'company' => [
						'type' => 'string',
						'required' => false,
						'allow_empty' => true
					],
					'level' => [
						'enum_eq' => array_keys(c('PROJECT_LEVEL_LIST')),
						'required' => false,
						'allow_empty' => true
					],
					'begin_time' => [
						'type' => 'date',
						'required' => false,
						'allow_empty' => true
					],
					'year' => [
						'type' => 'Y',
						'required' => false,
						'allow_empty' => true
					],
					'end_time' => [
						'type' => 'date',
						'required' => false,
						'allow_empty' => true
					],
					'name' => [
						'type' => 'string',
						'required' => false,
						'allow_empty' => true
					],
					'proj_type' => [
						'type' => 'string',
						'required' => false,
						'allow_empty' => true
					],
					'time_type' => [
						'type' => 'string',
						'required' => false,
						'allow_empty' => true
					],
					
				]);
			} else if ('changeAbc' == $type) {
				(new Validator())->execute(I(''), [
					'project_id' => ['type' => 'integer'],
					'level' => ['enum_eq' => array_keys(c('PROJECT_LEVEL_LIST'))],
				]);
			}
		} catch (\Exception $ex) {
			if (IS_GET) {
				$this->show('参数错误，请检查！' . $ex->getMessage());
			} else {
				$this->ajaxReturn(['status' => 'failed', 'message' => '参数错误，请检查！' . $ex->getMessage()]);
			}
		}
		
		$this->param = I('');
	}
	
}