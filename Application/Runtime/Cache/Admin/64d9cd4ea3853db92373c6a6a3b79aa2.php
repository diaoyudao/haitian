<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <link href="/public/huiadmin/static/h-ui/css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="/public/huiadmin/static/h-ui.admin/css/H-ui.login.css" rel="stylesheet" type="text/css" />
    <link href="/public/huiadmin/static/h-ui.admin/css/style.css" rel="stylesheet" type="text/css" />
    <link href="/public/huiadmin/lib/Hui-iconfont/1.0.7/iconfont.css" rel="stylesheet" type="text/css" />
    <link href="/public/swiper3.4.1/css/swiper.min.css" rel="stylesheet" type="text/css" />

    
    <script type="text/javascript" src="/public/huiadmin/lib/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="/public/swiper3.4.1/js/swiper.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/layer/2.1/layer.js"></script>

    <title><?php echo (C("ADMIN_WEB_NAME")); ?> - 后台登录</title>
    <meta name="keywords" content="后台管理系统模版">
    <meta name="description" content="后台管理系统模版">
</head>
<body>
<style>
body{
    width: 100%;
    height: 100%;
    margin: 0;
    overflow: hidden;
}
.login-div{
    position: absolute;
    z-index: 2;
    top:0;
    bottom: 0;
    right:15%;
    width:300px;
    margin: 0;
    padding: 0;
    background-color: rgba(0,0,0,0.5);
}
.login-box{
    position: absolute;
    width:240px;
    margin-left:30px;
    margin-top:150px;
    color:#fff;
    font-size:20px;
    text-align: left;
}
.login-form .tab-line{
    width:100%;
    height:20px;
    margin-top:20px;
    padding-left:5px;
    display: block;
}
.login-form .txt-line{
    width:100%;
    height:40px;
    border: none;
    display: block;
}

.login-form .txt-line2{
    width:48%;
    height:40px;
    border: none;
    display: inline-block;
}
.login-form input{
    font-size:16px;
}
.right3{
    width:45%;
    height:40px;
    float:right;
    margin-right:0;
}
.swiper-img{
    width: 100%;height:100%
}

</style>
<div class="swiper-container"  style="width: 100%;height:100%">
    <div class="swiper-wrapper">
        <div class="swiper-slide" ><img src="/public/img/home/test1.jpg" class="swiper-img"></div>
     <!--    <div class="swiper-slide"><img src="/public/img/home/test2.jpg" class="swiper-img"></div> -->
    </div>    
</div>   

    <div class="login-div">   
    
    <div class="header" style="background:none;top:50px">
        <img src="/public/img/admin/logo.png" style="width:220px;height: 80px;margin-left:30px"/>
    </div>
    <div class="login-box">
        <div class="login-form">
            <form class="form form-horizontal" method="post" id="form-login">
                <label class="tab-line">账号</label>   
                <input id="" name="login_id" type="text" placeholder="账户" class="radius txt-line mt-5 ">
                <label class="tab-line">密码</label>           
                <input id="" name="password" type="password" placeholder="密码" class="radius txt-line mt-5 ">
                <label class="tab-line">验证码</label>  
                <div class="txt-line">
                <input id="" name="verify" type="text" placeholder="验证码" class="radius txt-line2 left mt-5">
                <img class="right3 mt-5" id="verify_png" src="/service/verify/login/index" onclick="newVerify()" />
                <!-- <input name="" type="button" onclick="sendProcess()" class="btn btn-success radius right3 mt-5 "
                               value="发&nbsp;&nbsp;送"> -->
                </div>
                <input name="" type="button" onclick="loginProcess()" class="btn btn-success radius size-L txt-line mt-30 pl-5"
                               value="登&nbsp;&nbsp;&nbsp;&nbsp;录">
            </form>
        </div>
    </div>
   
 </div>
    <script type="text/javascript">
        var newVerify = function () {
            var url = '/service/verify/login/index?rand=' + Math.random();
            document.getElementById('verify_png').src = url;
        }

        var loginProcess = function () {
        	if('' == $('input[name=login_id]').val() || '' == $('input[name=password]').val() || '' == $('input[name=verify]').val() || '验证码' ==  $('input[name=verify]').val()) {
                layer.msg('请填写完整信息!', {icon: 2, time: 2000});
                return false;
            }
        	
            url = window.location.href;

            success_func = function (response) {
                if (response.status && response.status == 'ok') {
                    //if(window.parent)  top.location.replace('/service/');
                    //else window.location.replace('/service/');
                    top.location.replace('/service/');
                } else {
                    if (response.message) {
                        layer.msg(response.message, {icon: 2, time: 1500});
                    } else {
                        layer.msg('后台错误!', {icon: 2, time: 1500});
                    }
                    newVerify()
                }
            };

            error_func = function (response) {
                layer.msg('调用错误，请检查!', {icon: 2, time: 1500});
            };

            $.post(url, $('#form-login').serialize(), function (res) {
                if (success_func) {
                    success_func(res)
                }
            }).error(function (xhr) {
                if (error_func) {
                    error_func(xhr);
                }
            });
            return false;
        }

$(function(){
    document.getElementsByTagName('body')[0].style.height = window.innerHeight+'px'; 
    var mySwiper = new Swiper ('.swiper-container', {
        autoplay: 3000,
        //direction: 'vertical',
        loop: true,
        
        // 如果需要分页器
       // pagination: '.swiper-pagination',
        
        // 如果需要前进后退按钮
       // nextButton: '.swiper-button-next',
       // prevButton: '.swiper-button-prev',
        
        // 如果需要滚动条
        //scrollbar: '.swiper-scrollbar',
      })
});
</script>


</body>
</html>