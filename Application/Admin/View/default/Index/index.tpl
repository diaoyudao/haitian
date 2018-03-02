<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <LINK rel="Bookmark" href="/favicon.ico">
    <LINK rel="Shortcut Icon" href="/favicon.ico"/>
    <!--[if lt IE 9]>
    <script type="text/javascript" src="/public/huiadmin/lib/html5.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/respond.min.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/PIE_IE678.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/Hui-iconfont/1.0.7/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/icheck/icheck.css"/>
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/skin/default/skin.css" id="skin"/>
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/css/style.css"/>
    <!--[if IE 6]>
    <script type="text/javascript" src="/public/huiadmin/http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>{$Think.config.ADMIN_WEB_NAME}</title>
    <meta name="keywords" content="后台管理系统模版">
    <meta name="description" content="后台管理系统模版">
</head>
<body>
<style>
    @keyframes fadeIn {
        0% {
            left: 50px;
        }
        100% {
            left: 0;
        }
    }

    .fade-input {
        animation: fadeIn 2s 2s infinite;
    }

    #menu-article a {
        display: block !important;
        color: #688696 !important;
        text-shadow: none;
    }

    #menu-article a:hover {
        background-color: #eef5f9 !important;
        color: #688696 !important;
        text-decoration: none;
        text-shadow: none;
    }

    #Hui-article-box {
        position: absolute;
        top: 60px;
        left: 200px;
        right: 0;
        bottom: 0;
        display: block;
        margin: 0;
        padding: 0;
    }

    .ac-article-box {
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        z-index: 1;
        display: block;
    }

    .show_iframe2 {
        width: 100%;
        height: 100%;
        overflow: auto;
    }

    #main-iframe {
        width: 100%;
        height: 100%;
    }

    .head-menu {
        position: absolute;
        z-index: 100;
        padding: 20px 20px 15px;
        border: 2px #999 solid;
        border-top: none;
        background-color: #EEF5F9;
        display: none;
        color: #688696;
        overflow: hidden;
    }

    .head-menu ul, .head-menu li, .head-menu a, {
        border: none !important;
    }

    .head-menu li {
        height: 50px;
        width: 100px;
        display: block;
        line-height: 50px;
    }

    .head-person {
        float: right;
        margin-right: 30px;
        color: #ccc;
    }

    .head-search {
        display: block;
        float: right;
        margin-right: 30px;
        color: #333;
    }

    .head-search input {
        position: relative;
        left: 50px;
        width: 180px;
        height: 26px;
        border: 1px solid #ccc;
        border-radius: 15px;
        background-color: #fff;
        padding-left: 10px;
        display: none;
    }

    .head-search-i {
        position: relative;
        left: -25px;
        color: #999;
    }

    .head-person a, .head-person a:hover, .head-person a:visited {
        color: #999 !important;
    }

    a, a:link {
        text-decoration: none !important;
    }

    #head-remind {
        left: 200px;
    }

    #head-shortcut {
        left: 260px;
    }

    #head-passwd {
        right: 5px;
    }

    .head-remind {
        display: block;
        margin-top: 30px;
        margin-bottom: 45px;
        color: #333;
    }

    .head-remind-title {
        top: 0px;
        left: 0;
        color: #333;
        font-size: 16px;
        padding-left: 20px;
    }

    .head-remind-bottom {
        bottom: 0px;
        left: 0;
        padding-left: 20px;
    }

    .head-remind-txt {
        position: absolute;
        width: 310px !important;
        width: 310px;
        display: block;
        height: 50px;
        line-height: 50px;
        background-color: #fff;
        overflow: hidden;
    }

    .head-remind li {
        display: block;
        width: 250px;
        margin-top: 10px;
        padding: 0 10px;
        background-color: #fff;
        border: 1px solid #ddd;
        overflow: hidden;
    }

    .head-shortcut {
        display: block;

        width: 150px;
    }

    .head-shortcut-title {
        font-size: 16px;

    }

    .short-son-menu {
        position: absolute;
        display: none;
        z-index: 100;
        left: 75px;
        width: 140px;
        text-align: center;
        margin-top: -60px;
        background-color: #fff
    }

    .short-son-menu li {
        border: 1px solid #ccc;
        z-index: 0;
        margin-top: -1px;
    }
</style>
<header class="navbar-wrapper" style="height:60px;overflow: hidden;color:#fff;">
    <div class="navbar navbar-fixed-top">
        <div class="container-fluid cl" style="height:60px;overflow: hidden;line-height: 60px;">
            <a class="logo navbar-logo f-l mr-10 hidden-xs" href="">
                <img src="/public/img/admin/logo.png" style="height:40px;margin-top: 10px;"/>
            </a>
            <a class="logo navbar-logo-m f-l mr-10 visible-xs" href=""></a>
            <span class="navbar-logo f-l mr-10 hidden-xs"></span>
            <!-- <a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs"
                 href="javascript:;">&#xe667;</a> -->
            <a onClick="hideShowMenu()"><i class="Hui-iconfont" style="font-size:20px;margin-left:30px;color:#fff">&#xe667;</i></a>
            <a onClick="hideShowHeadMenu('head-remind')"><i class="Hui-iconfont"
                                                            style="font-size:20px;margin-left:30px;color:#fff">&#xe6c5;</i></a>

            <a onClick="hideShowHeadMenu('head-shortcut')"><i class="Hui-iconfont"
                                                              style="font-size:20px;margin-left:30px;color:#fff">&#xe692;</i></a>

            <a onClick="hideShowHeadMenu('head-passwd')" class="head-person">
                <img style="width:32px;height: 32px" src="{$employee.thumbnail_url}"/><span
                        class="ml-10">{$Think.session.employee.name}</span>
                <i class="Hui-iconfont" style="font-size:20px;margin-left:5px;color:#fff">&#xe6d5;</i>
            </a>
            <span class="head-search"><input placeholder="搜索" id="head-input"/>
            <i class="Hui-iconfont head-search-i" id="i-search">&#xe665;</i>
            </span>
        </div>
    </div>
</header>
<div class="head-menu " id="head-passwd">
    <div class="head-passwd">
        <ul class="" style="">
            <li><a _href="" data-title="修改密码"
                   onClick="changeMainPage('/service/employee/password/change')">修改密码</a></li>
            <li><a _href="" data-title="修改密码"
                   onClick="changeMainPage('/service/employee/user/changeme')">修改个人资料</a></li>
            <li><a href="/service/login/employee/loginout">退出系统</a></li>
        </ul>
    </div>
</div>
<div class="head-menu " id="head-remind" style="min-width:270px;">
    <div class="head-remind-txt head-remind-title">提醒</div>
    <php>$arr=['1'=>'审核','2'=>'审批','3'=>'分配']</php>
    <ul class="head-remind f-l ">
        <volist name="wait" id="wt" offset="0" length="3">
            <li class="disc">
                <switch name="wt.type">
                    <case value="task">
                        <a onclick="showTask('任务','/service/task/manage/change?task_id={$wt.task_id}')">新任务需要完成：{$wt.context}</a>
                    </case>
                    <case value="liaison">
                        <a href="/service/customer/search/detail?customer_id={$wt.customer_id}">客户：{$wt.customer_name}
                            的项目：{$wt.project_name}需要跟进，点击查看</a>
                    </case>
                    <case value="contact">
                        <a href="/service/customer/search/detail?customer_id={$wt.customer_id}">客户：{$wt.customer_name}
                            的联系人：{$wt.name}生日，联系客户送上祝福，点击查看</a>
                    </case>
                    <default/>
                    <a href="/service/project/manage/approve?type={$wt.approve}">项目：{$wt.name}
                        需要{$arr[$wt[approve_status]]}</a>
                </switch>

            </li>
        </volist>
    </ul>
    <div class="head-remind-txt head-remind-bottom text-c"><a href="/service/index"
                                                              style="color: #688696;">查看全部{$wait|count}条提醒</a></div>
</div>

<div class="head-menu " id="head-shortcut" style="background-color: #fff">
    <div class="">
        <if condition="'boss' != session('employee.role_type_code')">
            <ul class="f-l head-shortcut ml-20" style="">
                <li class="head-shortcut-title">日常</li>
                <li><a _href="" data-title="工作报告"
                    <if condition="'director' == session('employee.role_type_code')">
                        onClick="changeMainPage('/service/work/examine/index')"
                    </if>
                    <if condition="'salesman' == session('employee.role_type_code')">
                        onClick="changeMainPage('/service/work/submit/index')"
                    </if>
                    >工作报告</a></li>

            </ul>
        </if>
        <if condition="(session('employee.role_type_code') == 'director') || ('boss' == session('employee.role_type_code'))">
            <ul class="f-l head-shortcut" style="">
                <li class="head-shortcut-title">任务和通知</li>
                <if condition="session('employee.role_type_code') == 'director'">
                    <li><a _href="" data-title="发布新任务"
                           onClick="changeMainPage('/service/task/manage/index')">发布新任务</a>
                    </li>
                </if>
                <li><a _href="" data-title="发布新通知"
                       onClick="showDig('发布新通知','/service/home/index/addnotice')">
                        发布新通知</a>
                </li>
            </ul>
        </if>

        <ul class="f-l head-shortcut" style="">
            <li class="head-shortcut-title">客户</li>
            <li><a _href="" data-title="新增客户"
                   onClick="changeMainPage('/service/customer/manage/add')">新增客户</a></li>
            <li><a _href="" data-title="新建客户项目"
                   onClick="changeMainPage('/service/customer/search/addproject?hm=1')">
                    新建客户项目</a>
            </li>
        </ul>

    </div>
</div>

<div class="Hui-aside"
     style="background-color: #fff;overflow-x:hidden;overflow-y: auto;top:55px;box-shadow: 3px 0 3px #ccc;display:block;"
     id="menu-self">
    <input runat="server" id="divScrollValue" type="hidden" value=""/>
    <div class="menu_dropdown ">
        <php> foreach( $_SESSION['menu_privileges'] as $menu):</php>
        <dl id="menu-article" style="font-size:20px;overflow: hidden;">

            <dt style="height:60px;line-height: 60px;border:none;padding: 0;">
                <a onClick="changeMainPage('{$menu['link']}')" data-title="{$menu['title']}" style="padding-left:25px;">
                    <i class="Hui-iconfont">&#{$menu['iconfont']};</i>
                    <span style="font-size:15px;margin-left: 25px"> {$menu['title']} </span>
                </a>
            </dt>

            <dd>
                <ul>
                    <php> foreach( $menu['children'] as $page):</php>
                    <a onClick="changeMainPage('{$page['link']}')" data-title="{$page['title']}"
                       href="javascript:void(0)">
                        <li style="height:40px;line-height: 40px;font-size:14px;display:block;padding-left: 50px;">
                            {$page['title']}
                        </li>
                    </a>
                    <php> endforeach;</php>
                </ul>
            </dd>
        </dl>
        <php> endforeach;</php>

    </div>
</div>
<div class="Hui-aside"
     style="width:75px;display:none;overflow:visible;background-color: #fff;top:55px;box-shadow: 3px 0 3px #ccc;"
     id="menu-self2">
    <input runat="server" id="divScrollValue" type="hidden" value=""/>
    <div class="menu_dropdown ">
        <php> foreach( $_SESSION['menu_privileges'] as $menu):</php>
        <dl id="menu-article" style="font-size:20px;overflow: hidden;">
            <dt style="height:60px;line-height: 60px;border:none;padding: 0;">
                <a onClick="changeMainPage('{$menu['link']}')" data-title="{$menu['title']}" style="padding-left:25px;"
                   title="{$menu['title']}" alt="{$menu['title']}">
                    <i class="Hui-iconfont">&#{$menu['iconfont']};</i>
                </a>
            </dt>
            <div class="short-son-menu">
                <ul>
                    <php> foreach( $menu['children'] as $page):</php>
                    <a onClick="changeMainPage('{$page['link']}')" data-title="{$page['title']}"
                       href="javascript:void(0)">
                        <li style="height:40px;line-height: 40px;font-size:14px;display:block;">
                            {$page['title']}
                        </li>
                    </a>
                    <php> endforeach;</php>
                </ul>
            </div>
        </dl>
        <php> endforeach;</php>

    </div>
</div>
<div class="dislpayArrow hidden-xs hidden"><a class="pngfix" href="javascript:void(0);"
                                              onClick="displaynavbar(this)"></a>
</div>
<div id="Hui-article-box">
    <div class="ac-article-box">
        <div class="show_iframe2">
            <iframe id="main-iframe" scrolling="yes" frameborder="0" src="/service/home/index/index"></iframe>
        </div>
    </div>
</div>
<div class="layui-layer layui-anim layui-layer-dialog" id="layui-layer1" type="dialog" times="1" showtime="0"
     contype="string" style="display:none;z-index: 19891015; top: 202.5px; left: 30%;">
    <div class="layui-layer-title" style="cursor: move;" move="ok">信息</div>
    <div class="layui-layer-content">
        <img src="/public/img/admin/warning.png" style="width: 28px;"/>
        有其他人在尝试登录该账户，如需让其登录，请退出当前登录。如非本人操作，请及时修改密码。
    </div>
    <span class="layui-layer-setwin"><a class="layui-layer-ico layui-layer-close layui-layer-close1"
                                        href="javascript:;"></a></span>
    <div class="layui-layer-btn"><a class="layui-layer-btn0">确定</a><a class="layui-layer-btn1">取消</a></div>
</div>
<!-- <section id="Hui-article-box">
    
    <div id="iframe_box" class="Hui-article">
        <div class="show_iframe">
            <div style="display:none" class="loading"></div>
            <iframe scrolling="yes" frameborder="0" src="/service/login/welcome/index"></iframe>
        </div>
    </div>
</section> -->
<script type="text/javascript" src="/public/huiadmin/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="/public/huiadmin/static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="/public/huiadmin/static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="/public/js/lib/common-1.js"></script>
<script type="text/javascript">
	$(function () {
		$('#menu-self2').hide();

		$('#menu-self2').find('dl dt a').mouseenter(function () {
			if (!$('#menu-self2').is(':hidden')) {
				$('#menu-self2').find('.short-son-menu').hide();
				$(this).parent().next('.short-son-menu').show();
			}
		})
		$('#menu-self2').mouseleave(function () {
			$('#menu-self2').find('.short-son-menu').hide();
		})
		$('#i-search').mouseenter(function () {
			if ($('#head-input').is(':hidden')) {
				$('#head-input').val('');
				$('#head-input').show();
				$('#head-input').animate({left:'0'}, 150)
			}
		})
		$('#i-search').click(function () {
			var v = $('#head-input').val()
			if ('' != v) {
				changeMainPage('/service/system/search/index?name=' + v);
			}
		})
		$('.head-search').mouseleave(function () {
			if (!$('#head-input').is(':hidden')) {
				$('#head-input').hide();
				$('#head-input').animate({left:'50px'}, 10)
			}
		})

		$("#head-input").keydown(function (e) {
			var curKey = e.which;
			if (curKey == 13) {
				$('#i-search').click();
				return false;
			}
		});
	});
	var $is_layer='{$Think.session.is_layer}';
	if ($is_layer == '') {
		setTimeout(login_repeat, 5000);
	}

	function login_repeat() {
		var param ={};
		var url = '/service/home/index/loginRepeat';
		K.doAjax(param, url, function (e) {
			if (e.status == 'success') {
				$('#layui-layer1').show();
				setTimeout("$('#layui-layer1').hide();", 3000);
			}
		})
	}
	$('.layui-layer-btn').click(function () {
		$('#layui-layer1').hide();
	})
    $('.layui-layer-close').click(function () {
		$('#layui-layer1').hide();
	})

</script>

</body>
</html>