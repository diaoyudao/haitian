<?php if (!defined('THINK_PATH')) exit();?><!--_meta 作为公共模版分离出去-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
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
    <link rel="stylesheet" type="text/css" href="/public/css/lsg-main/main.css">
    <link rel="stylesheet" type="text/css" href="/public/bootstrap-3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/Hui-iconfont/1.0.7/iconfont.css" />
    


    



    <!--/meta 作为公共模版分离出去-->
    <title>后台管理</title>
    <meta name="keywords" content="后台管理系统模版">
    <meta name="description" content="后台管理系统模版">
    <style>
        body{
            background-color: #eee;
        }
        .main-head{
            width:100%;
            height:60px;
            line-height: 60px;
            background-color: #fff;
            color:#30baba;
            font-size:16px;
            padding-left: 30px;
            margin:0;
            border-bottom: 1px #ccc solid;
            box-shadow: 0 3px 3px #ccc;
        }
    </style>
</head>
<body>

<div class="main-head">
    首页
</div>
<!-- body_main 自定义页面内容 **begin** -->

    <style>
.main-head{
            display: none;
        }

        .swiper-container1{
            overflow: hidden;
            font-size: 14px;
            color: #6B6B6B;
        }

        .swiper-container1 .glyphicon-star{
            margin-right: 5px;
            color: #688696;
        }

        .head_box{
            margin:0;
        }

        .head_box{
            /*border-bottom: 1px solid #e0e0e0;*/
            /*height: 76px;*/
        }

        .head_box .swiper-slide{
            width: 113px;
            height: 50px;
            line-height: 50px;
            /*text-align: center;*/
            position: relative;
            float: left;
            cursor: pointer;
            padding: 0;
            overflow: hidden;
        }

        .head_box .swiper-slide+.swiper-slide{
            margin-left: 30px;
        }

        .head_box .title{
            color: #688696;
            text-align: center;
        }

        .swiper-slide div{
            position: absolute;
            right: 0;
            top: 0;
            height: 50px;
            width: 25px;
            /*background: red;*/
            /*background: -moz-linear-gradient(left,transparent -100%,white 70%,white,white,white);*/
            background: -moz-linear-gradient(left,transparent -100%,white 55%);
        }
        .swiper-slide div span{
            top: 50%;
            margin-top: -6px;
            position: absolute;
            right: -1px;
        }
        .swiper-slide-line{
            border-bottom: 3px solid #688696;
        }

        .left_box{
            position:relative;
            float:left;
            width:185px;
            height: 658px;
            margin-right:-300px;
            background-color: #fff;
            padding-bottom: 200px;
            font-size:13px;
            color:#688696;
        }
        .examination_box,
        .lately_box{
            /*padding:30px 20px 10px 20px;*/
            padding-top:30px;
            padding-bottom: :10px;
            border-bottom: 1px solid #e0e0e0;
        }

        .examination_box{
            padding-top:0;
        }

        .add_box{
            padding: 20px 30px;
            border-bottom: 1px solid #e0e0e0;
            color:#fff;
        }

        .add_box div{
            background-color: #2E8DED;
            text-align: center;
            height: 31px;
            line-height: 31px;
            border-radius: 3px;
            cursor: pointer;
        }

        .add_box div span{
            margin-right: 5px;
        }

        .examination_ul,
        .total_ul,
        .lately_ul{
            /*padding-left: 20px;*/
            margin-top: 15px;
        }
        .examination_ul{
            padding: 20px 0;
            margin-top: 0;  
        }
        .examination_ul li,
        .total_ul li,
        .lately_ul li{
            height: 40px;
            line-height: 40px;
            position: relative;
            cursor: pointer;
            padding: 0 20px;
        }

        .examination_ul li+li{
            margin-top: 10px;
        }

        img{
            width: 24px;
            height: 24px;
            position: relative;
            top: -1px;
        }

        .examination_ul img,
        .total_ul img{

            margin-right: 15px;
        }

        .examination_ul li .num{
            min-width: 20px;
            height:20px;
            text-align: center;
            line-height: 20px;
            /*border: 1px solid #000;*/
            background-color: #30baba;
            border-radius: 50%;
            color:#fff;
            display: block;
            float: right;
            margin-top:10px;
        }
        .total_ul li .num{
            /*color:#fff;*/
            width: 50px;
            /*margin-left: 50px;*/
            display: block;
            float: right;
            text-align: right;
        }

        .bg_color{
            background-color: #D0E4EE;
        }

        .right_box{
            float: right;
            width:100%;
        }
        .right_box_content{
            margin-left: 185px;
            background-color: #EEF5F9;
            min-height: 658px;
            padding:20px 5px 20px 20px;
        }

        .right_box_content .title{
            float: left;
            font-size: 16px;
            color: #688696;
        }

        .right_box_content .num{
            font-size: 13px;
        }

        .head-search{
            display: block;
            float: right;
            /*margin-right: 30px;*/
            color: #333;
            float: right;
            position: relative;
        }

        .head-input{
            position: relative;
            left: 0;
            width: 140px;
            height: 26px;
            border: 1px solid #ccc;
            border-radius: 15px;
            background-color: #fff;
            padding-left: 10px;
            padding-right: 20px;
        }

        .glyphicon-search{
            position: absolute;
            right: 7px;
            color: #999;
            top: 8px;
        }

        .list_table{
            border: 1px solid #ccc;
            padding: 20px;
            background-color: #fff;
            padding-bottom: 0;
        }
        .glyphicon-sort{
            color: #4AAFE4;
            top: 2px;
            margin-left: 5px;
        }



        .glyphicon-time{
            margin-left: 10px;
            color: #ff6633;
        }

        .recently_box{
            display: none;
        }

        .recently_box .table thead tr th{
            color: #A1A1A1; 
        }

        .abc_box{
            display: none;
        }

        .screen_box .list_table{
            height: 570px;
            padding:0;
            padding-top: 40px;
            font-size: 13px;
            overflow-x: visible;
           /* overflow-y: hidden;*/
            box-sizing: border-box;
        }

        .screen_box .list_table .top{
            border-bottom: 1px solid #ccc;
            color: #688696;
            overflow: hidden;
        }

        .screen_box .list_table .top p{
            float: left;
            padding-left: 20px;
            margin: 0;
            margin-bottom: 10px; 
        }

        .screen_box .list_table ul{
            height: 497px;
            float: left;
            border-right: 1px solid #ccc;
            overflow-y: scroll;
            overflow-x:visible;
            box-sizing: border-box;
        }

        .screen_box .list_table ul li{
            position: relative;
            padding:0 20px;
            display: block;
            height: 48px;
            line-height: 48px;
            width: 99%;
            left:0;
            border-bottom: 1px solid #ccc;
            overflow: hidden;
        }

        .screen_box .list_table ul li span:first-child{
            position: absolute;
            right: 42px;
        }

        .screen_box .list_table ul li .glyphicon-menu-right{
            position: absolute;
            height: 100%;
            line-height: 48px;
            right: 20px;
        }

        .screen_box .list_table ul li:last-child{
            /*border-bottom: none;*/
        }

        .abc_box .table tbody tr td {
            margin: 0;
            height: 50px;
            vertical-align: middle;
            font-size: 13px;
        }
        .abc_box .table thead tr th{
            font-size: 13px;
            color: #A1A1A1; 
        }

        .recently_box .table tbody tr td p {
            margin: 0;
            height: 40px;
            vertical-align: middle;
            font-size: 13px;
            line-height: 40px;
        }

        .recently_box .table tbody tr td p img{
            /*width: 16px;
            height: 16px;*/
            margin-right: 10px;
        }
        .recently_box .table tbody tr td:first-child p:first-child{
            font-size: 16px;
        } 

        .recently_box .table tbody tr td:first-child img:nth-of-type(2){
            margin-left: 20px;
        }
        .recently_box .table tbody tr td p:last-child{
            color:#688696;
        }

        .recently_box .table thead tr th{
            font-size: 13px;
            color: #A1A1A1; 
        }

        .screen_box ul li {
            cursor: pointer;
        }

        .screen_box ul li img{
            margin-right: 10px; 
        }
        
        .screen_box .top p:nth-child(2),
        .screen_box .top p:nth-child(3),
        .screen_box .top p:nth-child(4){
            display: none;
        }

        .city_ul,
        .Customer_ul,
        .area_ul{
            display: none;
        }
        .cust-sort{
            position: absolute;
            z-index:99;
            right: 0px;
            top:0;
            font-size:20px;
        }

</style>        

    <div class="body" style="overflow: hidden;">
        <div class="left_box">
            <div class="add_box">
                <div onclick="AddCustomer()"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增客户</div>
            </div>
            <div class="examination_box">
                <ul class="examination_ul ul">
                    <li><img src="/public/img/customer/u26.png" alt=""><span>VIP客户</span><span
                                class="num"><?php echo ((isset($num_abc) && ($num_abc !== ""))?($num_abc):0); ?></span></li>
                    <li><img src="/public/img/customer/u32.png" alt=""><span>最近联系</span><span
                                class="num"><?php echo ((isset($num_lis) && ($num_lis !== ""))?($num_lis):0); ?></span></li>
                </ul>
            </div>
            <div class="total_box">
                <ul class="total_ul ul">
                    <li class="bg_color" type=""><img src="/public/img/customer/u42.png" alt=""><span>全部客户</span><span
                                class="num"><?php echo ($cust_total); ?></span></li>
                    <li type="1"><img src="/public/img/project/gov_icon.png" alt=""><span>政府单位</span><span
                                class="num"><?php echo ((isset($type_list[1]) && ($type_list[1] !== ""))?($type_list[1]):0); ?></span></li>
                    <li type="2"><img src="/public/img/project/ScenicSpot_icon.png" alt=""><span>旅游景区</span><span
                                class="num"><?php echo ((isset($type_list[2]) && ($type_list[2] !== ""))?($type_list[2]):0); ?></span></li>
                    <li type="3"><img src="/public/img/customer/u17.png" alt=""><span>国有企业</span><span
                                class="num"><?php echo ((isset($type_list[3]) && ($type_list[3] !== ""))?($type_list[3]):0); ?></span></li>
                    <li type="5"><img src="/public/img/customer/u57.png" alt=""><span>民营企业</span><span
                                class="num"><?php echo ((isset($type_list[5]) && ($type_list[5] !== ""))?($type_list[5]):0); ?></span></li>
                    <li type="0"><img src="/public/img/customer/u22.png" alt=""><span>其他</span><span
                                class="num"><?php echo ((isset($type_list[0]) && ($type_list[0] !== ""))?($type_list[0]):0); ?></span></li>
                    <li type="4"><img src="/public/img/customer/u37.png" alt=""><span>海外客户</span><span
                                class="num"><?php echo ((isset($type_list[4]) && ($type_list[4] !== ""))?($type_list[4]):0); ?></span></li>
                </ul>
            </div>
        </div>
        <div class="right_box">
            <div class="right_box_content">
                <div class="table_box abc_box">
                    <p class="title">VIP客户<span class="num"></span></p>
                    <span class="head-search">
						<input type="text" id="abc-name" placeholder="搜索客户名称" class="head-input">
						<span onclick="searchCustAbc()" class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</span>
                    <div class="clear"></div>
                    <div class="list_table">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>客户名称</th>
                                <th>省市<span onclick="sortAbc(1)" class="glyphicon glyphicon-sort"
                                            aria-hidden="true"></span></th>
                                <th>类型<span onclick="sortAbc(2)" class="glyphicon glyphicon-sort"
                                            aria-hidden="true"></span></th>
                            </tr>
                            </thead>
                            <tbody id="abc-list">
                            <!-- <tr class="tr_border">
                                <td>
                                    武汉园博园
                                </td>
                                <td>
                                    <img src="/public/img/project/a.png" alt="">
                                </td>
                                <td>
                                    湖北省武汉市
                                </td>
                                <td>
                                    旅游景区
                                </td>
                            </tr> -->
                            </tbody>
                        </table>
                    </div>
                    <div id="abc-pager" class="mt-25 text-c"></div>
                    <div class="clear"></div>
                </div>
                <div class="table_box recently_box">
                    <?php if('salesman' == session('employee.role_type_code')): ?><p class="title">最近联系<span class="num"></span></p><?php endif; ?>
                    <span class="head-search">
						<input type="text" id="liaison-name" placeholder="搜索客户名称" class="head-input">
						<span onclick="searchCustLis()" class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</span>
                    <div class="clear"></div>
                    <div class="list_table mt-10">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>客户名称</th>
                                <th>上次联络</th>
                                <th>下次工作安排</th>
                            </tr>
                            </thead>
                            <tbody id="recent-list">
                            <!-- <tr class="tr_border">
                                <td>
                                    <p>武汉园博园<img src="/public/img/project/a.png" alt=""></p>
                                    <p><img src="/public/img/project/ScenicSpot_icon.png" alt="">旅游景区<img class="content_top_icon" src="/public/img/project/address_icon.png" alt="">湖北省武汉市</p>
                                </td>
                                <td>
                                    <p>05.13，初次接触</p>
                                    <p>张飞</p>
                                </td>
                                <td>
                                    <p>05.20，电话跟进</p>
                                    <p>黄月英</p>
                                </td>
                            </tr> -->

                            </tbody>
                        </table>
                    </div>
                    <div id="recent-pager" class="mt-25 text-c"></div>
                    <div class="clear"></div>
                </div>
                <div class="table_box screen_box">
                    <?php if('salesman' == session('employee.role_type_code')): ?><p class="title"><span>最近联系</span><span class="num"></span></p><?php endif; ?>
                    <span class="head-search">
						<input type="text" id="input-cust-name" placeholder="搜索客户名称" class="head-input">
						<span onclick="searchCust()" class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</span>
                    <div class="clear"></div>
                    <div class="list_table mt-10">
                        <div class="top">
                            <p style="width:23%">省/直辖/自治区</p>
                            <p style="width:23%">市</p>
                            <p style="width:23%">区/县</p>
                            <p style="width:30%">客户名称</p>
                        </div>
                        <ul class="province_ul" style="width:23%">
                            <?php if(is_array($provinces)): $i = 0; $__LIST__ = $provinces;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><li onclick="setProvList('<?php echo ($item["province_id"]); ?>',this)"><?php echo ($item["province_name"]); ?>
                                    <span><?php echo ($item["num"]); ?></span><span class="glyphicon glyphicon-menu-right"
                                                                  aria-hidden="true"></span></li><?php endforeach; endif; else: echo "" ;endif; ?>
                            <!-- <li>湖南省<span>42</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>
                            <li>四川省<span>42</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li> -->

                        </ul>
                        <ul class="city_ul" style="width:23%">
                            <!-- <li class="city-list" >省级客户<span>42</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li> -->
                            <!-- <li>湖南省<span>42</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>
                            <li>湖南省1<span>42</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li> -->
                        </ul>
                        <ul class="area_ul" style="width:23%">
                            <!-- <li class="county-list" >市级客户<span>42</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>
                            <li>湖南省1<span>42</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li> -->
                        </ul>
                        <ul class="Customer_ul" style="width:30%">
                            <!-- <li><img src="/public/img/project/gov_icon.png" alt="">湖南省</li>
                            <li><img src="/public/img/project/ScenicSpot_icon.png" alt="">湖南省</li>
                            <li><img src="/public/img/customer/u17.png" alt="">湖南省</li>
                            <li><img src="/public/img/customer/u37.png" alt="">湖南省</li> -->
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

<!-- body_main 自定义页面内容 **end** -->
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="/public/huiadmin/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/public/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="/public/huiadmin/static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/jquery.validation/1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/jquery.validation/1.14.0/messages_zh.min.js"></script>
<script type="text/javascript" src="/public/js/lib/common-1.js"></script>

<!-- footer_js 自定义javascript **begin** -->

    <script>
		$(function () {
			$(".province_ul li").click(function () {
				var v = $(this).attr('prov_id');

				$(".city_ul").show();
				$(".screen_box .top p").eq(1).show();
				$(".area_ul").hide();
				$(".Customer_ul").hide();
				$(".screen_box .top p").eq(2).hide();
				$(".screen_box .top p").eq(3).hide();

				backColor(this)
			});

			$(".area_ul li").click(function () {
				console.log('area_ul li', $(this).index());
				$(".Customer_ul").show();
				$(".screen_box .top p").eq(3).show();

				backColor(this)
			});

			$(".examination_ul li").click(function () {
				$(".screen_box").hide();
				$(".ul li").removeClass("bg_color");
				$(this).addClass("bg_color");
				if ($(this).index() == 0) {
					callAbc();
					$(".abc_box").show();
					$(".recently_box").hide();

				} else {
					callRecent();
					$(".abc_box").hide();
					$(".recently_box").show();
				}
			});
			$(".total_ul li").click(function () {

				setTypeList($(this).attr('type'))

				$(".recently_box").hide();
				$(".abc_box").hide();
				$(".screen_box").show();
				$(".ul li").removeClass("bg_color");
				$(this).addClass("bg_color");
				// $(".recently_box").hide();
				// $(".abc_box").hide();
				$(".screen_box .title span:nth-of-type(1)").text($(this).find("span:nth-of-type(1)").text());
			});
			console.log(document.body.scrollHeight)
			console.log(window.innerHeight)
			// console.log($('#main-iframe',parent.document).height())
			// $('#main-iframe',parent.document).height((window.innerHeight + 50) + 'px');
			parent.document.getElementById("detail-iframe").height = 0;
			parent.document.getElementById("detail-iframe").height = document.body.scrollHeight + 100;
		})

		function backColor(me) {
			$(me).css('background-color', '#D0E4EE').siblings().css('background-color', '#fff');
		}

		function initPageHeight() {
			parent.document.getElementById("detail-iframe").height = 0;
			parent.document.getElementById("detail-iframe").height = document.body.scrollHeight + 100;
		}

		function AddCustomer() {
			window.parent.location.href = "/service/customer/manage/add";
		}

		// 全局变量
		var abc_pg = 1;
		var recent_pg = 1;
		var abc_total = null;
		var recent_total = null;

		function callAbc(param) {
			param = param || {};
			var url = '/service/customer/search/getCustomerAbc';
			param.pg = abc_pg;
			K.doAjax(param, url, function (response) {
				if (response.status && response.status == 'success') {
					if (abc_total != response.total_page) {
						laypage({cont:"abc-pager",pages:response.total_page,curr:1,
                        jump:abcPage
                        });
						abc_pg = 1
					}
					abc_total = response.total_page;

					showAbcList(response.data)
				}
			});
		}

		function callRecent() {
			var url = '/service/customer/search/getCustomerRecent';
			param ={pg:recent_pg};
			K.doAjax(param, url, function (response) {
				if (response.status && response.status == 'success') {
					if (recent_total != response.total_page) {
						laypage({cont:"recent-pager",pages:response.total_page,curr:1,
                        jump:recentPage
                        });
						recent_pg = 1
					}
					recent_total = response.total_page;

					showRecentList(response.data)
				}
			});
		}

		function showRecentList(data) {
			$('#recent-list').empty();
			console.log(data)
			$.each(data, function (i, v) {
				var addr = (4 == v.type ? v.address : (v.province_name + (v.city_name ? v.city_name : '')));
				var type_img = (1 == v.type ? 'gov_icon.png' : (2 == v.type ? 'ScenicSpot_icon.png' : (3 == v.type ? 'enterprise.png' : ((4 == v.type ? 'overseas.png' : (5 == v.type ? 'enterprise.png' : 'other.png'))))));

				var str = '<tr class="tr_border" onclick="addParentTab(' + v.customer_id + ',\'' + v.name + '\',\'' + v.is_vip + '\')">';
				str += '<td><p>' + v.name;
				if ('1' == v.is_vip)
					str += '<img src="/public/img/admin/vip.png" alt="">';
				str += '</p><p><img src="/public/img/project/' + type_img + '" alt="">' + (1 == v.type ? "政府单位" : (2 == v.type ? "旅游景区" : (3 == v.type ? "国有企业" : (4 == v.type ? "海外客户" : (5 == v.type ? "民营企业" : "其他"))))) + '<img class="content_top_icon" src="/public/img/project/address_icon.png" alt="">' + addr + '</p></td>';
				str += '<td><p>' + (v.liaison_time ? K.getDateFormat2(v.liaison_time) : '') + '，' + (v.project_name ? v.project_name : '') + '</p><p>' + v.employee_name + '</p></td>';
				str += '<td><p>' + (v.next_time ? K.getDateFormat2(v.next_time) : '') + '</p><p>' + (v.next_employee_name ? v.next_employee_name : '') + '</p></td></tr>';

				$('#recent-list').append(str)
			})

			initPageHeight()
		}

		function showAbcList(data) {
			$('#abc-list').empty();

			$.each(data, function (i, v) {
				var addr = (4 == v.type ? v.address : (v.province_name + (v.city_name ? v.city_name : '')));
				var str = '<tr class="tr_border" onclick="addParentTab(' + v.customer_id + ',\'' + v.name + '\',\'' + v.is_vip + '\')">';
				str += '<td>' + v.name + '</td>';
				str += '<td>' + addr + '</td>';
				str += '<td>' + (1 == v.type ? "政府单位" : (2 == v.type ? "旅游景区" : (3 == v.type ? "国有企业" : (4 == v.type ? "海外客户" : (5 == v.type ? "民营企业" : "其他"))))) + '</td></tr>';

				$('#abc-list').append(str)
			})

			initPageHeight()
		}

		// 全局变量
		var cur_type = '';
		var cur_prov_cust = null;
		var cur_city_cust = null;
		var $prov_cust_data = [];
		var $city_cust_data = [];

		function setTypeList(t) {
			// 海外客户特殊处理
			cur_type = t;
			if (4 == t) {
				var param = {
					type: 4
				}
				var url = '/service/customer/search/getCustomer';
				K.doAjax(param, url, function (res) {
					if (res.status && res.status == 'success') {
						setCustList(res.data, 'out', '')
					}
				})

				showOnlyCust();
				return;
			}

			var param = {
				type: cur_type
			}
			var url = '/service/customer/search/getProvince';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					$('.province_ul').empty();

					$.each(res.data, function (i, v) {
						var str = '<li onclick="setProvList(\'' + v.province_id + '\',this)">' + v.province_name + '<span>' + v.num + '</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>'
						$('.province_ul').append(str);
					})

					showType()

					initPageHeight()
				}
			});
		}

		function setProvList(id, me) {
			backColor(me)

			var param = {
				type: cur_type,
				province_id: id
			}
			var url = '/service/customer/search/getCity';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					$('.city_ul').empty();

					if (res.prov_cust) {
						var str = '<li class="prov-level" onclick="getProvLevel(\'' + id + '\',this)">省级客户<span>' + res.prov_cust.num + '</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>';
						$('.city_ul').append(str);

						//$prov_cust_data = res.prov_cust.cust;
					}

					$.each(res.data, function (i, v) {
						var str = '<li class="city-list" onclick="setCityList(\'' + v.city_id + '\',this)">' + v.city_name + '<span>' + v.num + '</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>';
						$('.city_ul').append(str);
					})

					$(".city_ul").show();
					$(".screen_box .top p").eq(0).show();
					$(".screen_box .top p").eq(1).show();
					$(".area_ul").hide();
					$(".Customer_ul").hide();
					$(".screen_box .top p").eq(2).hide();
					$(".screen_box .top p").eq(3).hide();
				}
			});
		}

		function setCityList(id, me) {
			backColor(me)

			var param = {
				type: cur_type,
				city_id: id
			}
			var url = '/service/customer/search/getCounty';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					$('.area_ul').empty();

					if (res.city_cust) {
						var str = '<li class="city-level" onclick="getCityLevel(\'' + id + '\',this)">市级客户<span>' + res.city_cust.num + '</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>';
						$('.area_ul').append(str);

						//$city_cust_data = res.city_cust.cust
					}

					$.each(res.data, function (i, v) {
						var str = '<li class="county-list" onclick="getCustList(\'' + v.county_id + '\',this)" >' + v.county_name + '<span>' + v.num + '</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>';
						$('.area_ul').append(str);
					})

					showCountyList()
					hideCustList()
				}
			})
		}

		function getCustList(id, me) {
			backColor(me)

			var param = {
				type: cur_type,
				county_id: id
			}
			var url = '/service/customer/search/getCustomer';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					setCustList(res.data, 'county', id)
					showCustList()
				}
			})
		}


		function setCustList(data, tt, oid) {
			$('.Customer_ul').empty();

			$.each(data, function (i, v) {
				var str = '<li><a alt="' + v.name + '" title="' + v.name + '" onclick="addParentTab(' + v.customer_id + ',\'' + v.name + '\',\'' + v.is_vip + '\')"><img src="/public/img/project/' + v.type + '.png" alt="">' + v.name + '</a>';
				if (tt)
					str += '<i onclick="layer_show(\'排序\',\'/service/customer/manage/sort?t=' + tt + '&ty=' + cur_type + '&oid=' + oid + '&id=' + v.customer_id + '\',350,360)" class="Hui-iconfont cust-sort" style="color:#1296db;right: 15px;">&#xe675;</i>';
				if (i > 0) str += '<i onclick="sortTop(\'' + v.customer_id + '\',\'' + data[i - 1].customer_id + '\',\'' + tt + '\',\'' + oid + '\')" class="Hui-iconfont cust-sort" style="color:#1296db">&#xe679;</i>';
				str += '</li>';
				$('.Customer_ul').append(str);
			})
		}

		function sortTop(id, prev_id, t, oid) {
			K.doAjax({id:id,prev_id:prev_id}, '/service/customer/manage/sorttop', function (e) {
				if (e.status && e.status == "success") {
					if ('out' == t) window.setTypeList(4);
					else if ('prov' == t) window.getProvLevel(oid);
					else if ('city' == t) window.getCityLevel(oid);
					else if ('county' == t) window.getCustList(oid);
				} else {
					if (e.message) {
						layer.msg(e.message, {icon: 2, time: 1500})
					} else {
						layer.msg("后台错误!", {icon: 2, time: 1500})
					}
				}
			});
		}

		function addParentTab(id, name, level) {
			// 记录到最近查看客户列表
			try {
				K.doAjax({customer_id:id}, '/service/customer/manage/history', function (res){}, function (){});
			} catch (e) {
			}

			window.parent.addTab(id, name, level)
		}

		// 搜索客户，不要排序
		function searchCust() {
			var v = $('#input-cust-name').val()
			if ("" == v) {
				return;
			}

			var param = {
				name: v,
			}
			var url = '/service/customer/search/getCustomer';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					setCustList(res.data)
					showOnlyCust()
					$(".ul li").removeClass("bg_color");
				}
			})
		}

		function searchCustAbc() {
			console.log(222333)
			var v = $('#abc-name').val()
			if ("" == v) {
				return;
			}
			var param = {
				name: v,
			}
			var url = '/service/customer/search/getCustomerAbc';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					showAbcList(res.data)
				}
			})
		}

		function searchCustLis() {
			var v = $('#liaison-name').val()
			if ("" == v) {
				return;
			}
			var param = {
				name: v,
			}
			var url = '/service/customer/search/getCustomerRecent';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					showRecentList(res.data)
				}
			})
		}

		function getProvLevel(id, me) {
			backColor(me)

			var param = {
				type: cur_type,
				province_id: id,
			}
			var url = '/service/customer/search/getProvLevel';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					$prov_cust_data = res.data;
					showCustList('prov', id);
				}
			})
		}

		function getCityLevel(id, me) {
			backColor(me)

			var param = {
				type: cur_type,
				city_id: id,
			}
			var url = '/service/customer/search/getCityLevel';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					$city_cust_data = res.data;
					showCustList('city', id);
				}
			})
		}


		function showCountyList() {
			$(".area_ul").show();
			$(".screen_box .top p").eq(2).show();
		}

		function hideCountyList() {
			$(".area_ul").hide();
			$(".screen_box .top p").eq(2).hide();
		}

		function hideCustList() {
			$(".Customer_ul").hide();
			$(".screen_box .top p").eq(3).hide();
		}

		function showCustList(type, oid) {
			console.log(type, $city_cust_data)
			type = type || 'county';
			if ('prov' == type) {
				$(".area_ul").hide();
				$(".screen_box .top p").eq(2).hide();
			}

			if ('prov' == type) setCustList($prov_cust_data, 'prov', oid)
			if ('city' == type) setCustList($city_cust_data, 'city', oid)

			$(".Customer_ul").show();
			$(".screen_box .top p").eq(3).show();
		}

		function showOnlyCust() {
			$(".province_ul").hide();
			$(".city_ul").hide();
			$(".area_ul").hide();
			$(".Customer_ul").show();
			$(".screen_box .top p").eq(3).show()
			$(".screen_box .top ").children("p:eq(3)").siblings().hide();
		}

		function showType() {
			$(".province_ul").show();
			$(".city_ul").hide();
			$(".area_ul").hide();
			$(".Customer_ul").hide();
			$(".screen_box .top ").children("p:eq(0)").siblings().hide();
		}

		function abcPage(obj) {
			if (abc_pg == obj.curr) return;
			abc_pg = obj.curr
			callAbc()
		}

		function recentPage(obj) {
			if (recent_pg == obj.curr) return;
			recent_pg = obj.curr
			callRecent()
		}

		// sort abc
		var $order_sort = 1;

		function sortAbc(t) {
			console.log('===', t)
			var param = {
				order: (t + 1),
				order_sort: $order_sort
			};
			$order_sort = ((1 == $order_sort) ? 0 : 1);
			callAbc(param)
		}

		function sortCall(id) {
			console.log(id)
		}


    </script>

<!--/footer_js 自定义javascript **end** -->

</body>
</html>