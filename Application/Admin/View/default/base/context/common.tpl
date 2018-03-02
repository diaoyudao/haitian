<!--_meta 作为公共模版分离出去-->
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
    <block name="common_css"></block>
    <block name="common_js"></block>

    <!--/meta 作为公共模版分离出去-->
    <block name="title"><title>后台管理</title></block>
    <meta name="keywords" content="<block name='meta_keywords'>后台管理系统模版</block>">
    <meta name="description" content="<block name='meta_description'>后台管理系统模版</block>">
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
    <block name="body_path_name">首页</block>
</div>
<!-- body_main 自定义页面内容 **begin** -->
<block name="body_main">

</block>
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
<block name="footer_js">

</block>
<!--/footer_js 自定义javascript **end** -->

</body>
</html>