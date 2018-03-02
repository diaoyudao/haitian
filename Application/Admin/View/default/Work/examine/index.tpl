<extend name="./Application/Admin/View/default/base/context/common.tpl"/>
<block name="common_css">
    <link href="/public/swiper3.4.1/css/swiper.min.css" rel="stylesheet" type="text/css"/>
    <link href="/public/css/work/examine/index.css" rel="stylesheet" type="text/css"/>
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
        <div class="swiper_box cl">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <volist name="list" id="mm" offset="">
                        <div class="swiper-slide">
                            {$mm.month}月 第{$mm.week_num}周 {$mm['week'][0]}-{$mm['week'][6]}
                        </div>
                    </volist>
                </div>

                <!-- 如果需要导航按钮 -->
                <div class="swiper-button-prev" style="background: none;"><span class="glyphicon glyphicon-menu-left"
                                                                                aria-hidden="true"
                                                                                style="position: absolute;top:50%;margin-top:-6px;"></span>
                </div>
                <div class="swiper-button-next" style="background: none;"><span class="glyphicon glyphicon-menu-right"
                                                                                aria-hidden="true"
                                                                                style="position: absolute;top:50%;margin-top:-6px;"></span>
                </div>

            </div>
        </div>
        <div class="content_box">
            <div class="swiper-container1">
                <div class="swiper-wrapper head_box">
                    <volist name="employee" id="item">
                        <div class="swiper-slide " id="{$item.employee_id}">
                            <div class="line"></div>
                            <if condition="session('employee')['role_type_code'] eq 'boss'">
                                <img class="head" src="/public/img/admin/department_item.png" alt="">{$item.department}
                                <else/>
                                <img class="head" src="{$item.thumbnail_url}" alt="">{$item.name}
                            </if>
                        </div>
                    </volist>

                </div>
            </div>
            <div>
                <php>
                    $week_lists=$list[$list_num]['week'];
                    $array_day=['日','一','二','三','四','五','六'];
                </php>
                <if condition="session('employee')['role_type_code'] neq 'boss'">
                    <p class="week_content_title">本周工作内容</p>
                    <table class="week_content table_box">
                        <thead>
                        <tr>
                            <th width="60">日期</th>
                            <th width="60">分类</th>
                            <th width="120">客户</th>
                            <th width="120">联系人</th>
                            <th width="120">项目</th>
                            <th>具体情况</th>
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
                                $rowspan=count($weeklys);
                                $week_day_key=date('w',strtotime($www));
                                $week_day=$array_day[$week_day_key];

                            </php>
                            <notempty name="weeklys">
                                <volist name="weeklys" id="wl">
                                    <tr class="tr_border">
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
                                        <td>{$wl.context}
                                        </td>
                                        <if condition="$i eq 1">
                                            <td rowspan="{$rowspan}"
                                                style="border:#e0e0e0 2px solid; text-align: center;padding-left: 20px;color:{$color};">
                                                {$span}
                                            </td>
                                        </if>
                                    </tr>
                                </volist>
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
                                </tr>
                            </notempty>
                        </volist>

                        </tbody>
                    </table>
                </if>
                <p class="week_content_title">本周工作总结</p>
                <table class="week_summary table_box">
                    <thead>

                    <tr>
                        <th width="60">日期</th>
                        <th>本周工作计划</th>
                        <th width="100">完成情况</th>
                        <th width="300">未完成原因</th>
                        <th>批复</th>
                        <th></th>
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
                                        </if>
                                        <span style="float: left;width: 80%;">{$su.context}</span></td>
                                    <td>
                                        <if condition="$su.is_over eq 0">
                                            未完成
                                            <else/>
                                            已完成
                                        </if>
                                    </td>
                                    <td>{$su.cause}

                                    </td>
                                    <td style="color: #b94a48;">
                                        {$su.reply}
                                    </td>
                                    <td>
                                        <if condition="$list_num+1 eq $now_week">
                                            <span class="glyphicon glyphicon-option-vertical table_box_icon"
                                                  aria-hidden="true"></span>
                                            <ul class="screen_popup">
                                                <li><span class="text"
                                                          onclick="operation('plan',{$su.work_plan_id})">批复</span></li>
                                            </ul>
                                        </if>

                                </tr>
                            </volist>
                            <else/>
                            <tr class="tr_border">
                                <if condition="$k%2 eq 1">
                                    <td rowspan="{$rowspan2}" class="date ">{$www|strtotime|date='m-d',###}
                                        <br/>星期{$summary_day}</td>
                                    <else/>
                                    <td rowspan="{$rowspan2}"
                                        class="date week_background">{$www|strtotime|date='m-d',###}
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

                            $rowspan2=count($plans);

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
                                        </if>
                                        <span style="float: left;width: 90%;">{$pl.context}</span>

                                    </td>
                                    <td>{$pl.note}</td>

                                </tr>
                            </volist>
                            <else/>
                            <tr class="tr_border">

                                <td
                                        class=" date <if condition='$kk%2 neq 1'>week_background</if> ">{$ww|strtotime|date='m-d',###}
                                    <br/>星期{$plan_day}</td>

                                <td></td>
                                <td></td>

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
		var employee_id = '{$Think.get.employee_id}';

		function operation(type, id) {
//			 layer_show("批复",'/service/work/examine/add', 750, 500);
			var url = '/service/work/examine/add?type=' + type + '&id=' + id;
			layer_show("批复", url, 750, 350);
		}

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
				var url = '/service/work/examine/index?week=' + num + '&employee_id=' + employee_id;
				window.location.replace(url);
			});

			$('.swiper-button-prev').click(function () {
				num--;
				var url = '/service/work/examine/index?week=' + num + '&employee_id=' + employee_id;
				window.location.replace(url);
			});
			$('.swiper-container1 .head_box .swiper-slide').click(function () {
				employee_id = $(this).attr('id');
				$(this).siblings().removeClass("bright");
				$(this).addClass('bright');
				var url = '/service/work/examine/index?week=' + num + '&employee_id=' + employee_id;
				window.location.replace(url);
			});
			$('.swiper-container1 .head_box .swiper-slide').each(function (i, v) {
				if (employee_id == '' && i == 0) {
					$(this).addClass('bright');
					return;
				}
				if ($(this).attr('id') == employee_id) {
					$(this).siblings().removeClass("bright");
					$(this).addClass('bright');
				}

			});


		};


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
    </script>
</block>