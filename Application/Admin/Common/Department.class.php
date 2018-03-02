<?php

namespace Admin\Common;

class Department
{
	/**
	 *
	 * @return boolean
	 */
	static function lists()
	{
		$ret = [];
		if (session('employee')['department_type_id'] != 'boss') {
			return $ret;
		}
		$model = M('department');
		$where['department_type_id'] = [['eq', 'business'], ['eq', 'information'], 'or'];
		$where['_string'] = 'delete_time is null';
		$ret = $model->field('department_id,name')->where($where)->select();
		return $ret;
	}
	
}