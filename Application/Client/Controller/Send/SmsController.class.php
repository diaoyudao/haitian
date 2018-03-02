<?php

namespace Client\Controller\Send;

use Think\Controller;
use Think\Log;
use Admin\Common\Model\OcModel;
use Admin\Common\Sms;
use Admin\Common\Parameter\Validator;

/**
 * 图书管理类
 */
class SmsController extends Controller
{
	private $base_model = null;
	
	public function __construct()
	{
		parent::__construct();
		$this->base_model = new OcModel('sms_transfer');
	}
	
	
	public function sendSms()
	{
		$res = $this->base_model->limit(0,300)->select();
		foreach ($res as $v) {
			$this->pushToPhone($v);
		}
	}
	
	private function pushToPhone($v)
	{
		$signName = '阿里云短信测试专用';
//		$sms = new Sms();
		$acsResponse = Sms::sendSms($v['mobile'], $signName, $v['sms_code'], $v['customer']);
		if ($acsResponse->Code == 'OK') {
			try {
				$res = $this->base_model->delete($v['transfer_id']);
				if($res === false){
					Log::write('删除短信缓存失败：' . $v['transfer_id']);
					return;
				}
				$this->base_model->commit();
			} catch (\Exception $ex) {
				$this->base_model->rollback();
				Log::write('删除短信缓存失败：' . $ex->getMessage());
			}
		}
		
	}
	
	
}