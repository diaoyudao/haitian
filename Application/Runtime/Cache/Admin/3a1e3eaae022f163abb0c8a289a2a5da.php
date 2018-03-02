<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <LINK rel="Bookmark" href="/favicon.ico" >
    <LINK rel="Shortcut Icon" href="/favicon.ico" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="/public/huiadmin/lib/html5.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/respond.min.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/PIE_IE678.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/Hui-iconfont/1.0.7/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/css/style.css" />
    
    <link rel="stylesheet" type="text/css" href="/public/bootstrap-3.3.7/css/bootstrap.css"/>

    <!--[if IE 6]>
    <script type="text/javascript" src="/public/huiadmin/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>haitian</title>
</head>
<body>
<style>
body{
    background-color: #EEF5F9;
}  
.page-head{
    width:100%;
    height:60px;line-height: 60px;
    background-color: #fff;
    border-bottom: 1px #ccc solid;
    box-shadow: 0 3px 3px #ccc;
    font-size:16px;
    color:#30baba;
}
.page-head .title{
    margin-left: 20px;
}
</style>
<nav class="page-head">    
    <div class="title">首页
    </div>
</nav>

    <style>
        .body_box {
            padding: 10px;
        }

        .body_box p {
            margin: 0px;
        }

        .body_box ul {
            margin: 0;
        }

        input[type="radio"],
        input[type="checkbox"] {
            margin: 0px;
        }

        a,
        a:hover {
            color: #000;
            text-decoration: none;
        }

        ul .disc {
            list-style: disc;
            color: #2FBBE6 !important;
        }

        ul .through a {
            text-decoration: line-through;
            color: rgba(0, 0, 0, 0.498039215686275);
        }

        ul, ol, dl {
            font-size: 13px;
        }

        .left_box {
            position: relative;
            float: left;
            width: 580px;
            margin-right: -580px;
            /*padding-bottom: 200px;*/
            font-size: 13px;
            color: #688696;
        }

        .right_box {
            float: right;
            width: 100%;
        }

        .right_box_content {
            margin-left: 580px;
            background-color: #EEF5F9;
            min-height: 671px;
            padding: 0 20px;
        }

        .lbox,
        .rbox {
            padding: 10px 20px;
            padding-top: 20px;
            padding-bottom: 40px;
            border: 1px solid #D7D7D7;
            background-color: #fff;
            position: relative;
        }

        .rbox {
            padding: 20px 20px;
        }

        .lbox .title,
        .rbox .title {
            font-size: 16px;
            color: #688696;
            margin-bottom: 20px;
        }

        .rbox .title {
            margin-bottom: 15px;
        }

        .lbox .title span {
            margin-left: 20px;
        }

        .lbox .title .glyphicon,
        .rbox .title span {
            float: right;
            cursor: pointer;
            margin-top: 3px;
        }

        .rbox .title span {
            font-size: 13px;
            margin-top: 5px;
        }

        .rbox .title span a {
            color: #688696;
        }

        .work_index_box {
            margin-bottom: 20px;
        }

        .work_index_box ul {
            overflow: hidden;
            padding: 0 15px;

        }

        .work_index_box ul:last-child {
            margin-top: 25px;
        }

        .work_index_box ul li {
            float: left;
            width: 80px;
        }

        .work_index_box ul li + li {
            margin-left: 62px;

        }

        .week_work_box {
            margin-bottom: 20px;
        }

        .tbox {
            height: 450px;
        }

        .todo_box ul {
            padding-left: 35px;
            height: 93%;
            overflow: hidden;
        }

        .todo_box ul li input {
            position: absolute;
            left: -35px;
            top: 2px;
        }

        .todo_box ul li {
            position: relative;
            color: #688696;
        }

        .todo_box ul li a {
            font-size: 13px;
        }

        .todo_box ul li + li {
            margin-top: 20px;
        }

        .todo_box .todo_mask {
            position: absolute;
            padding: 20px 15px;
            background-color: #fff;
            border: 1px solid #D7D7D7;
            top: 37px;
            right: 25px;
            display: none;
        }

        .todo_box .todo_mask p {
            cursor: pointer;
        }

        .rbox ul {
            padding-left: 16px;
        }

        .rbox ul li a {
            font-size: 13px;
        }

        .rbox ul li + li {
            margin-top: 8px;
        }

        .date_box {
            margin-top: 20px;
            height: 450px;
            border: 1px solid #D7D7D7;
            background-color: #fff;
            padding: 20px;
            padding-bottom: 0;
        }

        /*日历*/
        .datelist {
            position: relative;
            width: 100%;
            font-size: 13px;
        }

        .datelist h1 {
            width: 100%;
            height: 45px;
            margin: 0;
            padding: 0;
            text-align: center;
            font-size: 14px;
            line-height: 39px;
            /*border: 1px solid #E4E4E4;*/
        }

        .datelist .pre {
            position: absolute;
            top: 11px;
            left: 110px;
            cursor: pointer;
        }

        .datelist .next {
            position: absolute;
            top: 11px;
            right: 110px;
            cursor: pointer;
        }

        .datelist li {
            /*margin-top: 20px;*/
            float: left;
            width: 14%;
            text-align: center;
        }

        .date_body li {
            position: relative;
            float: left;
            margin-top: 1px;
            width: 14%;
            line-height: 40px;
            text-align: center;
            color: #688696;
        }

        .date_body li.active {
            background-color: #F2F2F2;
        }

        .date_body li img {
            position: absolute;
            width: 20px;
            height: 20px;
            bottom: 5px;
            left: 50%;
            margin-left: -10px;
        }

        .week_work_box .radius {
            border-radius: 50% !important;
            position: relative;
            top: -1px;
            margin-right: 10px;
        }

        .week_work_box ul {
            padding: 0;
            color: #000;
        }

        /*时间提醒弹窗*/
        .dayremind {
            width: 100%;
            padding: 10px;
            overflow: hidden;
            /*overflow-y: scroll;*/
        }

        .dayremind li {
            width: 100%;
            padding: 10px 0;
            border-bottom: 1px solid #E4E4E4;
        }
    </style>
    <div class="body_box">
        <div class="left_box">
            <?php if(session('employee')['role_type_code'] == 'boss'): ?><div class="work_index_box lbox">
                    <p class="title">工作指标</p>
                    <ul>
                        <li>
                            <p><?php echo ($liaison); ?></p>
                            <p>今日联络次数</p>
                        </li>
                        <li>
                            <p><?php echo ($login_num); ?></p>
                            <p>今日登录人数</p>
                        </li>
                        <li>
                            <p><?php echo ($yesterday_customers); ?></p>
                            <p>昨日新增客户</p>
                        </li>
                        <li>
                            <p><?php echo ($yesterday_contract); ?></p>
                            <p>昨日新签合同</p>
                        </li>
                    </ul>
                    <ul>
                        <li>
                            <p><?php echo ($failed_liaison); ?></p>
                            <p>今日联络失败</p>
                        </li>
                        <li>
                            <p><?php echo ($unfinish); ?></p>
                            <p>待完成任务</p>
                        </li>
                        <li>
                            <p><?php echo ($month_customers); ?></p>
                            <p>本月新增客户</p>
                        </li>
                        <li>
                            <p><?php echo ($month_contract); ?></p>
                            <p>本月新签合同</p>
                        </li>
                    </ul>
                </div><?php endif; ?>

            <?php if(session('employee')['role_type_code'] == 'salesman'): ?><div class="week_work_box rbox" style="height: 201px;">
                    <p class="title">本周工作内容</p>
                    <ul>
                        <?php if(is_array($work)): $i = 0; $__LIST__ = $work;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><li><span class="label label-secondary radius"><?php echo ($i); ?></span><?php echo ($item["context"]); ?></li><?php endforeach; endif; else: echo "" ;endif; ?>
                    </ul>
                </div><?php endif; ?>
            <div class="todo_box lbox tbox">
                <p class="title">待办事项<span><?php echo ($count); ?></span><span class="glyphicon glyphicon-option-vertical"
                                                                style="display: none"
                                                                aria-hidden="true"></span></p>
                <?php $arr=['1'=>'审核','2'=>'审批','3'=>'分配'] ?>
                <ul>
                    <?php if(is_array($wait)): $i = 0; $__LIST__ = $wait;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$wt): $mod = ($i % 2 );++$i;?><li class="disc">
                            <?php switch($wt["type"]): case "task": ?><a onclick="showTask('任务','/service/task/manage/change?task_id=<?php echo ($wt["task_id"]); ?>')">新任务需要完成：<?php echo ($wt["context"]); ?></a><?php break;?>
                                <?php case "liaison": ?><a href="/service/customer/search/detail?customer_id=<?php echo ($wt["customer_id"]); ?>">客户：<?php echo ($wt["customer_name"]); ?>的项目：<?php echo ($wt["project_name"]); ?>需要跟进，点击查看</a><?php break;?>
                                <?php case "contact": ?><a href="/service/customer/search/detail?customer_id=<?php echo ($wt["customer_id"]); ?>">客户：<?php echo ($wt["customer_name"]); ?>的联系人：<?php echo ($wt["name"]); ?>生日，联系客户送上祝福，点击查看</a><?php break;?>
                                <?php default: ?>
                                <a href="/service/project/manage/approve?type=<?php echo ($wt["approve"]); ?>">项目：<?php echo ($wt["name"]); ?>需要<?php echo ($arr[$wt[approve_status]]); ?></a><?php endswitch;?>

                        </li><?php endforeach; endif; else: echo "" ;endif; ?>

                </ul>
                <div class="todo_mask"><p>清空已完成</p></div>
            </div>
        </div>
        <div class="right_box">
            <div class="right_box_content">
                <div class="notice_box rbox" style="height: 201px">
                    <p class="title">通知<span><a href="/service/home/index/allnotice">全部</span></a></p>
                    <ul>
                        <?php if(is_array($notice)): $i = 0; $__LIST__ = $notice;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$ne): $mod = ($i % 2 );++$i;?><li class="disc"
                                onclick="LsgLayerShow('通知','/service/home/index/detailnotice?id=<?php echo ($ne["notice_id"]); ?>',700,800)">
                                <a><?php echo ($ne["title"]); ?></a><?php endforeach; endif; else: echo "" ;endif; ?>
                        </li>

                    </ul>
                </div>
                <div class="date_box">
                    <!-- 日历 -->
                    <div class="datelist">
                        <h1><span id="year"></span> <span id="month"></span>月</h1>
                        <span class="pre">&lt;</span>
                        <span class="next">&gt;</span>

                        <ol>
                            <li>日</li>
                            <li>一</li>
                            <li>二</li>
                            <li>三</li>
                            <li>四</li>
                            <li>五</li>
                            <li>六</li>

                        </ol>
                    </div>
                    <ul class="date_body">
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                        <li></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

<script type="text/javascript" src="/public/huiadmin/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/layer/2.1/extend/layer.ext.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/public/huiadmin/static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="/public/huiadmin/static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="/public/js/lib/common-1.js"></script>
<script type="text/javascript" src="/public/js/lib/list-1.js"></script>

    <script>
		$(function () {
			$(".todo_box .glyphicon-option-vertical").click(function () {
				if ($(".todo_box .todo_mask").css("display") == "none") {
					$(".todo_box .todo_mask").show();
				} else {
					$(".todo_box .todo_mask").hide();
				}
			});
		});
		//日历
		var nowDate = new Date();
		var dateYear = nowDate.getFullYear();
		var dateMon = nowDate.getMonth();
		var tMonth = dateMon;
		var yearMonth;

		function calendar(tMonth) {
			//根据传入的月份重新算时间
			var oDate = new Date();
			oUl = $('.date_body');
			var aLi = oUl.find('li');
			oDate.setMonth(tMonth);
			oDate.setDate(1);
			var iYear = oDate.getFullYear();
			var iMonth = oDate.getMonth();
			var iDay = oDate.getDay();
			if (iMonth < 9) {
				yearMonth = iYear + '-' + '0' + (iMonth + 1)
			} else {
				yearMonth = iYear + '-' + (iMonth + 1)
			}
			$('#year').text(iYear);
			$('#month').text(iMonth + 1);
			//初始化一下
			for (var i = 0; i < aLi.length; i++) {
				aLi[i].innerHTML = "";
				aLi[i].style.height = "55px";
				aLi[i].className = "";
			}
			var iSum = 0; //存本月天数
			var bLeap = false;//是否是闰年
			if (iYear % 4 == 0 && iYear % 100 !== 0 || iYear % 400 == 0) bLeap = true;
			switch (iMonth + 1) {
				case 1:
				case 3:
				case 5:
				case 7:
				case 8:
				case 10:
				case 12:
					iSum = 31;
					break;
				case 4:
				case 6:
				case 9:
				case 11:
					iSum = 30;
					break;
				case 2:
					if (bLeap) iSum = 29;
					else iSum = 28;
					break;
			}
			for (var i = 1; i <= iSum; i++) {
				aLi[iDay].innerHTML = i;
				iDay++;
			}

			for (var i = 0; i < aLi.length; i++) {
				if (aLi[i].innerHTML == nowDate.getDate() && iYear == dateYear && iMonth == dateMon) {
					aLi[i].className = "active";
				}

			}

			//把没字的格子折叠起来
			for (var i = 0; i < aLi.length; i++) {
				if (aLi[i].innerHTML == "") {
					aLi[i].style.height = "0px";
				}
			}
		}

		if ($('.work_index_box').length == 0) {
			$('.todo_box').css('height', '671px');
		}
		calendar(tMonth);
		$('.pre').click(function () {
			calendar(--tMonth);
			monthList();

		})
		$('.next').click(function () {
			calendar(++tMonth);
			monthList();
		})

		function remind(day) {
			var param ={};
			param.day = day;
			var url = '/service/home/index/daylist';
			K.doAjax(param, url, function (response) {
				if (response.status && 'success' == response.status) {
					var str = '<div id="remind"><ul class="dayremind">';
					$.each(response.list, function (i, v) {
						str += '<li><p>' + v.customer_name + '</p><p>' + v.project_name + '</p>';
					});
					str += '</ul></div>';

					layer.open({
						type: 1,
						title: response.day + '相关事宜',
						area: ['300px', '400px'],
						shadeClose: true,
						content: str
					});
//						console.log(response)
				} else {
					if (response.message) {
						layer.msg(response.message, {icon: 2, time: 1500})
					} else {
						layer.msg("后台错误!", {icon: 2, time: 1500})
					}
				}
			});
		}

		// 提示事件(时钟)
		function prompt(a) {
			var days
			for (var i = 0; i < a.length; i++) {
				days = a[i];
				var $li = $('.date_body').find('li');
				$li.each(function (i, el) {
					if ($(el).text() == days) {
						console.log($(el).text(),days)
						var day;
						var year = $('#year').text();
						var month = ($('#month').text() > 9) ? $('#month').text() : ('0' + $('#month').text());
						if (days < 10) {
							day = year + '-' + month + '-0' + days;
						} else {
							day = year + '-' + month + '-' + days;
						}
						$(el).append('<img src="/public/img/home/xlcweb/u410.png" onclick="remind(\''+day+'\')"/>');
					}
				})
			}

		}

		//		prompt([3, 4, 5]);
		monthList();

		function monthList() {
			var param ={};
			param.month = yearMonth;
			var url = '/service/home/index/monthlist';
			K.doAjax(param, url, function (response) {
				if (response.status && 'success' == response.status) {
					prompt(response.list);
				} else {
					if (response.message) {
						layer.msg(response.message, {icon: 2, time: 1500})
					} else {
						layer.msg("后台错误!", {icon: 2, time: 1500})
					}
				}
			});
		}

		function LsgLayerShow(title, url, w, h) {
			layer.open({
				type: 2,
				area: [w + 'px', h + 'px'],
				fix: false,
				maxmin: true,
				shade: 0.4,
				title: title,
				content: url,
			});
		}
		function showTask(title,url) {
            layer_show(title,url,750,750)
		}
    </script>


</body>
</html>