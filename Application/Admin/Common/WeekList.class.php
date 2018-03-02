<?php

namespace Admin\Common;

class WeekList
//周列表
{
	/**
	 * 失效数据。
	 * @return boolean
	 */
	static function lists($year = '', $month = '')
	{
		$year = $year ? $year : date('Y');
		$weeks = date("W", mktime(0, 0, 0, 12, 28, $year));
		
		$list = [];
		for ($i = 1; $i <= $weeks; $i++) {
			if ($i < 10) {
				$timestamp['start'] = strtotime($year . 'W0' . $i);
			} else {
				$timestamp['start'] = strtotime($year . 'W' . $i);
			}
			$timestamp['end'] = strtotime('+1 week -1 day', $timestamp['start']);
			$day_now = date('j', $timestamp['start']);
			$week_num = (int)ceil($day_now / 7);
//			dump($timestamp['start']);
			$list[$i-1]['week'][] = date("Y/m/d", $timestamp['start']);
			$list[$i-1]['week'][] = date("Y/m/d", strtotime('+1 day', $timestamp['start']));
			$list[$i-1]['week'][] = date("Y/m/d", strtotime('+2 day', $timestamp['start']));
			$list[$i-1]['week'][] = date("Y/m/d", strtotime('+3 day', $timestamp['start']));
			$list[$i-1]['week'][] = date("Y/m/d", strtotime('+4 day', $timestamp['start']));
			$list[$i-1]['week'][] = date("Y/m/d", strtotime('+5 day', $timestamp['start']));
			$list[$i-1]['week'][] = date("Y/m/d", strtotime('+6 day', $timestamp['start']));
			$list[$i-1]['month'] = date('n', $timestamp['start']);
			$list[$i-1]['week_num'] = $week_num;
		}
		if (!empty($month)) {
			$month_list = [];
			$j = 0;
			foreach ($list as $v) {
				if ($v['month'] == $month) {
					$month_list[$j]['week'][] = $v['week'][0];
					$month_list[$j]['week'][] = $v['week'][1];
					$month_list[$j]['week'][] = $v['week'][2];
					$month_list[$j]['week'][] = $v['week'][3];
					$month_list[$j]['week'][] = $v['week'][4];
					$month_list[$j]['week'][] = $v['week'][5];
					$month_list[$j]['week'][] = $v['week'][6];
					$month_list[$j]['month'] = $v['month'];
					$month_list[$j]['week_num'] = $v['week_num'];
					$j++;
				}
				
			}
			
			return $month_list;
		}
		
		return $list;
	}
	
}