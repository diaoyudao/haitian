<extend name="./Application/Admin/View/default/base/context/common.tpl"/>
<block name="common_css">
    <link href="/public/swiper3.4.1/css/swiper.min.css" rel="stylesheet" type="text/css"/>
    <link href="/public/css/work/submit/index.css" rel="stylesheet" type="text/css"/>
</block>
<block name="common_js">
</block>

<block name="body_path_name">
    <span class="glyphicon glyphicon-arrow-left" style="margin-right: 10px" aria-hidden="true"></span>工作报告 > 详细报告
</block>

<block name="body_main">
    <style>

    </style>
    <div class="body">
        <div class="swiper_box">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <volist name="list" id="mm" offset="">
                        <div class="swiper-slide">
                            {$mm.month}月 第{$mm.week_num}周 {$mm['week'][0]}-{$mm['week'][6]}
                        </div>
                    </volist>
                </div>

                <!-- 如果需要导航按钮 -->
                <div class="swiper-button swiper-button-prev" style="background: none;"><span
                            class="glyphicon glyphicon-menu-left"
                            aria-hidden="true"
                            style="position: absolute;top:50%;margin-top:-6px;"></span>
                </div>
                <div class="swiper-button swiper-button-next" style="background: none;"><span
                            class="glyphicon glyphicon-menu-right"
                            aria-hidden="true"
                            style="position: absolute;top:50%;margin-top:-6px;"></span>
                </div>

            </div>
        </div>
        <div class="content_box">
            <div>
                <php>
                    $week_lists=$list[$list_num]['week'];
                    $array_day=['日','一','二','三','四','五','六'];
                </php>
                <p class="week_content_title">本周工作内容</p>
                <table class="week_content table_box">
                    <thead>
                    <tr>
                        <th width="60">日期</th>
                        <th width="120">分类</th>
                        <th width="120">客户</th>
                        <th width="120">联系人</th>
                        <th width="120">项目</th>
                        <th>具体情况</th>
                        <if condition="$list_num+1 eq $now_week">
                            <th width="120"></th>
                        </if>
                        <th class="text-c" width="120">完成情况</th>
                    </tr>
                    </thead>
                    <tbody>


                    <volist name="week_lists" id="www" key="k">

                        <php>
                            $date=date('Y-m-d',strtotime($www));
                            $weeklys=[];
                            $span='完成';
                            $color='#009900';
                            foreach($weekly as $v){
                            if($date == $v['date']){
                            $weeklys[]=$v;
                            if($v['is_over'] == 0){
                            $span='未完成';
                            $color='#FE6834';
                            }
                            }

                            }
                            if($list_num+1 == $now_week){
                            $rowspan=count($weeklys)+1;
                            }else{
                            $rowspan=count($weeklys);
                            }
                            $week_day_key=date('w',strtotime($www));
                            $week_day=$array_day[$week_day_key];

                        </php>
                        <notempty name="weeklys">
                            <volist name="weeklys" id="wl">
                                <tr class="tr_border ">
                                    <if condition="$i eq 1">
                                        <if condition="$k%2 eq 1">
                                            <td rowspan="{$rowspan}"
                                                class="date ">{$www|strtotime|date='m-d',###}
                                                <br/>星期{$week_day}</td>
                                            <else/>
                                            <td rowspan="{$rowspan}"
                                                class="date week_background">{$www|strtotime|date='m-d',###}
                                                <br/>星期{$week_day}</td>
                                        </if>
                                    </if>

                                    <td>
                                        <switch name="wl.type">
                                            <case value="0"><span class="routine follow_up">常规跟进</span></case>
                                            <case value="1"><span class="emphasis follow_up">重点跟进</span></case>
                                            <default/>
                                            <span class="bills  follow_up">款项跟进</span>
                                        </switch>
                                    </td>
                                    <td>{$wl.name}</td>
                                    <td><img class="head" src="{$wl.thumbnail_url}" alt="">{$wl.contact}</td>
                                    <td>{$wl.project}</td>

                                    <td>{$wl.context}</td>
                                    <if condition="$list_num+1 eq $now_week">
                                        <td class="text-c">
                                             <span class="glyphicon glyphicon-pencil" aria-hidden="true"
                                                   onclick="Weekly('{$date}',{$wl.work_export_id})"></span>
                                            <span class="glyphicon glyphicon-trash" aria-hidden="true"
                                                  onclick="delWeekly({$wl.work_export_id})"></span>
                                        </td>
                                        <if condition="$i eq 1">
                                            <td rowspan="{$rowspan-1}"
                                                style="border:#e0e0e0 2px solid; text-align: center;padding-left: 20px;color:{$color};">
                                                {$span}
                                            </td>
                                        </if>
                                        <else/>
                                        <if condition="$i eq 1">
                                            <td rowspan="{$rowspan}"
                                                style="border:#e0e0e0 2px solid; text-align: center;padding-left: 20px;color:{$color};">
                                                {$span}
                                            </td>
                                        </if>
                                    </if>

                                </tr>
                            </volist>
                            <if condition="$list_num+1 eq $now_week">
                                <tr class="tr_border">

                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td style="text-align: center;">

                                        <span class="glyphicon glyphicon-plus" aria-hidden="true"
                                              onclick="Weekly('{$date}')"></span>

                                    </td>
                            </if>
                            </tr>
                            <else/>

                            <tr class="tr_border">
                                <if condition="$k%2 eq 1">
                                    <td
                                            class="date ">{$www|strtotime|date='m-d',###}
                                        <br/>星期{$week_day}</td>
                                    <else/>
                                    <td
                                            class="date week_background">{$www|strtotime|date='m-d',###}
                                        <br/>星期{$week_day}</td>
                                </if>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <if condition="$list_num+1 eq $now_week">
                                    <td></td>
                                </if>
                                <td style="text-align: center">
                                    <if condition="$list_num+1 eq $now_week">
                                        <span class="glyphicon glyphicon-plus" aria-hidden="true"
                                              onclick="Weekly('{$date}')"></span>
                                    </if>
                                </td>
                            </tr>

                        </notempty>


                    </volist>

                    </tbody>
                </table>
                <p class="week_content_title">本周工作总结</p>
                <table class="week_summary table_box">
                    <thead>
                    <tr class="">
                        <th width="60">日期</th>
                        <th>本周工作计划</th>
                        <th width="100">完成情况</th>
                        <th width="300">未完成原因</th>
                        <th width="120"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <volist name="week_lists" id="www" key="k">
                        <php>
                            $date=date('Y-m-d',strtotime($www));
                            $summarys=[];
                            foreach($summary as $val){
                            if($date == $val['date']){
                            $summarys[]=$val;
                            }
                            }
                            $rowspan3=count($summarys);
                            $summary_day_key=date('w',strtotime($www));
                            $summary_day=$array_day[$summary_day_key];

                        </php>
                        <notempty name="summarys">
                            <volist name="summarys" id="su">
                                <tr class="tr_border">
                                    <if condition="$i eq 1">
                                        <if condition="$k%2 eq 1">
                                            <td rowspan="{$rowspan3}" class="date ">{$www|strtotime|date='m-d',###}
                                                <br/>星期{$summary_day}</td>
                                            <else/>
                                            <td rowspan="{$rowspan3}"
                                                class="date week_background">{$www|strtotime|date='m-d',###}
                                                <br/>星期{$summary_day}</td>
                                        </if>
                                    </if>
                                    <td class="cl">
                                        <if condition="$su['is_department'] eq 1">
                                            <img style="float: left;" src="/public/img/admin/department_item.png"/>
                                            <span style="float: left;width: 90%;">{$su.context}</span>
                                    </td>
                                    <else/>
                                    {$su.context}
                                    </if>

                                    <td>
                                        <if condition="$su.is_over eq 0">
                                            未完成
                                            <else/>
                                            已完成
                                        </if>
                                    </td>
                                    <td>{$su.cause}</td>
                                    <td class="text-c">
                                        <if condition="$list_num+1 eq $now_week">
                                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"
                                              onclick="WeekSummary({$su.work_plan_id})"></span>
                                        </if>
                                    </td>
                                </tr>
                            </volist>
                            <else/>
                            <tr class="tr_border">
                                <if condition="$k%2 eq 1">
                                    <td class="date ">{$www|strtotime|date='m-d',###}
                                        <br/>星期{$summary_day}</td>
                                    <else/>
                                    <td class="date week_background">{$www|strtotime|date='m-d',###}
                                        <br/>星期{$summary_day}</td>
                                </if>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </notempty>
                    </volist>
                    </tbody>
                </table>
                <p class="week_content_title">下周工作计划</p>
                <table class="next_week table_box">
                    <thead>
                    <tr>
                        <th width="60">日期</th>
                        <th>工作内容</th>
                        <th width="300">备注</th>
                        <th width="120"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <php>
                        $next_week=$list_next[$next_num]['week'];
                    </php>
                    <volist name="next_week" id="ww" key="kk">

                        <php>
                            $date2=date('Y-m-d',strtotime($ww));
                            $plans=[];
                            foreach($plan as $vv){
                            if($date2 == $vv['date']){
                            $plans[]=$vv;
                            }
                            }
                            if($list_num+1 == $now_week){
                            $rowspan2=count($plans)+1;
                            }else{
                            $rowspan2=count($plans);
                            }
                            $plan_day_key=date('w',strtotime($ww));
                            $plan_day=$array_day[$plan_day_key];
                        </php>
                        <notempty name="plans">
                            <volist name="plans" id="pl">
                                <tr class="tr_border">
                                    <if condition="$i eq 1">
                                        <if condition="$kk%2 eq 1">
                                            <td rowspan="{$rowspan2}" class="date ">{$ww|strtotime|date='m-d',###}
                                                <br/>星期{$plan_day}</td>
                                            <else/>
                                            <td rowspan="{$rowspan2}"
                                                class="date week_background">{$ww|strtotime|date='m-d',###}
                                                <br/>星期{$plan_day}</td>
                                        </if>
                                    </if>

                                    <td class="cl">
                                        <if condition="$pl['is_department'] eq 1">
                                            <img style="float: left;" src="/public/img/admin/department_item.png"/>
                                            <span style="float: left;width: 90%;">{$pl.context}</span>
                                            <else/>
                                            {$pl.context}
                                        </if>
                                    </td>


                                    <td>{$pl.note}</td>
                                    <td class="text-c">
                                        <if condition="$list_num+1 eq $now_week">
                                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"
                                              onclick="NextWeek('{$date2}',{$pl.work_plan_id})"></span>
                                            <span class="glyphicon glyphicon-trash" aria-hidden="true"
                                                  onclick="delNextWeek({$pl.work_plan_id})"></span>
                                        </if>
                                    </td>
                                </tr>
                            </volist>
                            <if condition="$list_num+1 eq $now_week">
                                <tr class="tr_border">

                                    <td></td>
                                    <td></td>
                                    <td>

                                    <span class="glyphicon glyphicon-plus" aria-hidden="true"
                                          onclick="NextWeek('{$date2}')"></span>
                                    </td>
                                </tr>
                            </if>
                            <else/>
                            <tr class="tr_border">
                                <if condition="$kk%2 eq 1">
                                    <td class="date ">{$ww|strtotime|date='m-d',###}
                                        <br/>星期{$plan_day}</td>
                                    <else/>
                                    <td
                                            class="date week_background">{$ww|strtotime|date='m-d',###}
                                        <br/>星期{$plan_day}</td>

                                </if>
                                <td></td>
                                <td></td>
                                <td>
                                    <if condition="$list_num+1 eq $now_week">
                                    <span class="glyphicon glyphicon-plus" aria-hidden="true"
                                          onclick="NextWeek('{$date2}')"></span>
                                    </if>
                                </td>
                            </tr>

                        </notempty>
                    </volist>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</block>

<block name="footer_js">
    <script type="text/javascript" src="/public/swiper3.4.1/js/swiper.min.js"></script>
    <script>
		var num ={$list_num};

		window.onload = function () {
			var mySwiper = new Swiper('.swiper-container', {
				direction: 'horizontal',
				loop: false,
				initialSlide: num,
				// 如果需要前进后退按钮
				nextButton: '.swiper-button-next',
				prevButton: '.swiper-button-prev',

			});
			var swiper = new Swiper('.swiper-container1', {
				pagination: '.swiper-pagination',
				slidesPerView: 'auto',
				paginationClickable: true,
				// spaceBetween: 30
			});
			$('.swiper-button-next').click(function () {
				num++;
				var url = '/service/work/submit/index?week=' + num;
				window.location.replace(url);
			});

			$('.swiper-button-prev').click(function () {
				num--;
				var url = '/service/work/submit/index?week=' + num;
				window.location.replace(url);
			});

		}


		function PeopleSwitch() {
			$(".swiper-container1 .swiper-slide").click(function () {
				$(".swiper-container1 .swiper-slide").removeClass("bright");
				$(this).addClass("bright");
			});
		};
		PeopleSwitch();

		function TableIcon() {
			$(".table_box .table_box_icon").click(function () {
				if ($(this).siblings(".screen_popup").css("display") == "block") {
					$(this).siblings(".screen_popup").hide();
				} else {
					$(".table_box .screen_popup").hide();
					$(this).siblings(".screen_popup").show();
				}
			});
		}

		TableIcon();

		function Weekly(date, id=null) {
			if (id) {
				var url = '/service/work/submit/changeweekly?date=' + date + '&id=' + id;

			} else {
				var url = '/service/work/submit/addweekly?date=' + date;
			}
			layer_show("周报", url, 750, 650);
		}

		function delWeekly(id) {
			layer.confirm('删除后不可恢复，确定要删除吗', {
				btn: ['确定', '取消']
			}, function (index) {
				var param ={};
				param.work_export_id = id;
				var url = '/service/work/submit/delweekly';
				K.doAjax(param, url, function (e) {
					if (e.status && e.status == "success") {
						window.location.replace(window.location.href);
					} else {
						if (e.message) {
							layer.msg(e.message, {icon: 2, time: 1500})
						} else {
							layer.msg("后台错误!", {icon: 2, time: 1500})
						}
					}
				});
			}, function () {
				console.log('取消')
			})

		}

		function WeekSummary(id) {
			if (id) {
				var url = '/service/work/submit/changesummary?id=' + id;

			}
			layer_show("本周工作总结", url, 750, 500);
		}

		function NextWeek(date, id=null) {
			if (id) {
				var url = '/service/work/submit/changeplan?id=' + id + '&date=' + date;

			} else {
				var url = '/service/work/submit/addplan?date=' + date;
			}
			layer_show("下周工作计划", url, 750, 500);
		}

		function delNextWeek(id) {
			layer.confirm('删除后不可恢复，确定要删除吗', {
				btn: ['确定', '取消']
			}, function (index) {
				var param ={};
				param.work_plan_id = id;
				var url = '/service/work/submit/delplan';
				K.doAjax(param, url, function (e) {
					if (e.status && e.status == "success") {
						window.location.replace(window.location.href);
					} else {
						if (e.message) {
							layer.msg(e.message, {icon: 2, time: 1500})
						} else {
							layer.msg("后台错误!", {icon: 2, time: 1500})
						}
					}
				});
			}, function () {
				console.log('取消')

			})
		}
    </script>
</block>