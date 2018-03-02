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
                            {$mm.month}月 第{$mm.week_num}周 {$mm[0]}-{$mm[6]}
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
            <div>
                <p class="week_content_title">本周工作内容</p>
                <table class="week_content table_box">
                    <thead>
                    <tr>
                        <th>日期</th>
                        <th>分类</th>
                        <th>客户</th>
                        <th>联系人</th>
                        <th>项目</th>
                        <th>完成情况</th>
                        <th>具体情况</th>
                    </tr>
                    </thead>
                    <tbody>

                    <php>
                        $week_lists=$list[$list_num];
                    </php>
                    <volist name="week_lists" id="ww">

                        <tr class="tr_border">

                            <td rowspan="3" class="date">{$ww|strtotime|date='m-d',###}<br/>星期{$ww|strtotime|date='w',###}</td>
                            <volist name="weekly" id="wl">
                                <td><span class="emphasis follow_up">重点跟进</span></td>
                                <td>{$wl.name}</td>
                                <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                                <td>七夕灯会</td>
                                <td>未完成</td>
                                <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                                <td>
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="Weekly()"></span>
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                </td>
                            </volist>
                            <td><span class="emphasis follow_up">重点跟进</span></td>
                            <td>重庆园博园</td>
                            <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                            <td>七夕灯会</td>
                            <td>未完成</td>
                            <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                            <td>
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="Weekly()"></span>
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                <span class="glyphicon glyphicon-plus" aria-hidden="true" onclick="Weekly()"></span>
                            </td>
                        </tr>
                    </volist>

                    <tr class="tr_border">
                        <td rowspan="1" class="date week_background">07-24<br/>星期二</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>
                            <span class="glyphicon glyphicon-plus" aria-hidden="true" onclick="Weekly()"></span>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <p class="week_content_title">本周工作总结</p>
                <table class="week_summary table_box">
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>本周工作计划</th>
                        <th>完成情况</th>
                        <th>未完成原因</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="date">1</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet.</td>
                        <td>未完成</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing</td>
                        <td>
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="WeekSummary()"></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="date">1</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet.</td>
                        <td>未完成</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing</td>
                        <td>
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="WeekSummary()"></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="date">1</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet.</td>
                        <td>未完成</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing</td>
                        <td>
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="WeekSummary()"></span>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <p class="week_content_title">下周工作计划</p>
                <table class="next_week table_box">
                    <thead>
                    <tr>
                        <th>No.</th>
                        <th>工作内容</th>
                        <th>备注</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="date">1</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet.</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing</td>
                        <td>
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="NextWeek()"></span>
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="date">1</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet.</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing</td>
                        <td>
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="NextWeek()"></span>
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="date">1</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet.</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing</td>
                        <td>
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="NextWeek()"></span>
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>
                            <span class="glyphicon glyphicon-plus" aria-hidden="true" onclick="NextWeek()"></span>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</block>

<block name="footer_js">
    <script type="text/javascript" src="/public/swiper3.4.1/js/swiper.min.js"></script>
    <script>
		window.onload = function () {
			var mySwiper = new Swiper('.swiper-container', {
				direction: 'horizontal',
				loop: false,
				initialSlide:{$list_num},
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

		function Weekly() {
			layer_show("周报", '/service/work/submit/addweekly', 750, 850);
		}

		function WeekSummary() {
			layer_show("本周工作总结", '/service/work/submit/addsummary', 750, 350);
		}

		function NextWeek() {
			layer_show("下周工作计划", '/service/work/submit/addplan', 750, 500);
		}


    </script>
</block>