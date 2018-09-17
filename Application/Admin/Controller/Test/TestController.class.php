<?php

namespace Admin\Controller\Test;

use Think\Controller;
use Common\Code\MyString;
use Admin\Common\Record\StaffLog;
use Admin\Common\DeleteTime;

/**
 * TEST
 */
class TestController extends Controller
{
	// 跑线上的老联系人数据
	public function index()
	{
		$this->depart();
		
		echo "<br>all end" . date('Y-m-d H:i:s') . "<br>";
	}
	
	public function depart()
	{
		echo "begin" . date('Y-m-d H:i:s') . "\n<br>";
		$model = M('customer_contact');
		$contact = $model->where('delete_time is null')
			->order('customer_id,status desc, customer_contact_id')->select();
		
		//var_dump($contact[1]);
		
		echo "\n total = " . count($contact) . "\n<br>";
		
		$last_cust_id = $contact[0]['customer_id'];
		$weight = 10;
		
		foreach ($contact as $key => $item) {
			if ('100504' == $item['customer_id']) {
				var_dump($item);
				echo "<br>";
			}
			$where['department'] = empty($item['department']) ? '未知' : $item['department'];
			$where['customer_id'] = $item['customer_id'];
			$model_depart = M('customer_department');
			$his = $model_depart->where($where)->find();
			if ($his) {
				$this->changeContact($item, $his['customer_department_id']);
				
				$weight += 10;
				continue;
			}
			
			if ($last_cust_id != $item['customer_id']) {
				$weight = 10;
			}
			
			$input['department'] = $where['department'];
			$input['customer_id'] = $item['customer_id'];
			$input['weight'] = $weight;
			
			$ret = $model_depart->add($input);
			if (false === $ret) {
				echo "db err" . $item['customer_contact_id'] . ":" . $model_depart->getDbError() . "\n";
				exit;
			}
			
			$this->changeContact($item, $ret);
			
			$last_cust_id = $item['customer_id'];
			$weight += 10;
		}
		
		echo "\n run end \n<br>";
	}
	
	private function changeContact($item, $department_id)
	{
		$model = M('customer_contact');
		$where['customer_contact_id'] = $item['customer_contact_id'];
		$data['customer_department_id'] = $department_id;
		$ret = $model->where($where)->save($data);
		if (false === $ret) {
			echo "save contact db err:" . $item['customer_contact_id'] . ":" . $model->getDbError() . "\n";
			exit;
		}
	}
	
	//批量分配
	public function import()
	{
		//'350000','360000','110000','140000','370000','440000','210000','120000'
		//510000 500000 530000 520000 630000 640000 330000 620000
		//610000 150000 230000 650000 450000 430000 420000
		//130000 310000 340000 220000 410000 320000 540000 460000
//		$arr = ['1037' => ['350000', '360000', '110000', '140000', '370000', '440000', '210000', '120000'],
//			'1031' => ['510000', '500000', '530000', '520000', '630000', '640000', '330000', '620000'],
//			'1038' => ['610000', '150000', '230000', '650000', '450000', '430000', '420000'],
//			'1039' => ['130000', '310000', '340000', '220000', '410000', '320000', '540000', '460000']
//		];
//		$arr = ['1048' => ['330000', '530000', '500000','630000'],
		$arr = ['1048' => ['210000','460000'],
			'1053' => ['440000','350000','450000','430000','410000']
		];
		
		$arr_new = $this->ergodic($arr);
		if (!empty($arr_new)) {
			$this->ergodic2($arr_new);
		}
	}
	
	private function ergodic($arr)
	{
		$model = M('customer_employee');
		$arr_new = [];
		$model->startTrans();
		try {
			foreach ($arr as $k => $v) {
				$customer_where['province_id'] = ['in', $v];
				$customer_where['_string'] = 'delete_time is null';
				$customer_where['information_id'] = 100017;
				$customer_ids = M('customer')->where($customer_where)->getField('customer_id', true);
				foreach ($customer_ids as $item) {
					
					$data['employee_id'] = $k;
					$data['customer_id'] = $item;
					$data['department_id'] = 100017;
					$data['_string'] = 'delete_time is null';
					$count = $model->where($data)->count();
					if ($count == 0) {
						$arr_new[$k][] = $item;
					}
				}
			}
			$model->commit();
		} catch (\Exception $ex) {
			$model->rollback();
			E('数据库错误！');
		}
		return $arr_new;
	}
	
	private function ergodic2($arr)
	{
		$model = M('customer_employee');
		$model->startTrans();
		try {
			foreach ($arr as $k => $v) {
				
				foreach ($v as $item) {
					
					$data['employee_id'] = $k;
					$data['customer_id'] = $item;
					$data['department_id'] = 100017;
//					$data['update_time'] = date('Y-m-d H:i:s');
					$model->add($data);
					
				}
			}
//
			$model->commit();
		} catch
		(\Exception $ex) {
			$model->rollback();
			E('数据库错误！');
		}
	}
	
}