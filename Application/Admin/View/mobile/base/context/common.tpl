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
        <link rel="stylesheet" type="text/css" href="/public/bootstrap-3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui/css/H-ui.min.css" />
        <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/Hui-iconfont/1.0.7/iconfont.css" />
        <link rel="stylesheet" type="text/css" href="/public/home/css/main.css">
        <block name="common_css"></block>
        <block name="common_js"></block>

        <!--/meta 作为公共模版分离出去-->
        <block name="title"><title>后台管理</title></block>
        <meta name="keywords" content="<block name='meta_keywords'>后台管理系统模版</block>">
        <meta name="description" content="<block name='meta_description'>后台管理系统模版</block>">
        <style>
            /*.head_box{
                width: 100%;
                height: 50px;
                background-color: #343643;
                position: relative;
                text-align: center;
                line-height: 50px;
                color: #fff;
                font-size: 16px;
            }
            .head_left,
            .head_right{
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
            }
            .head_left{
                left: 20px;
            }

            .head_right{
                right: 20px;
            }*/
            .nav_bar{
                position: fixed;
                bottom: 0;
                width: 100%;
                height: 60px;
                padding: 4px 0;
                border-top: 1px solid #C9C9C9;
            }
            .nav_bar ul{
                overflow: hidden;
            }
            .nav_bar ul li{
                float: left;
                width: 25%;
                text-align: center;
            }
            .nav_bar ul li p{
                font-size: 13px;
            }
            
            .nav_bar ul .checked{
                color: #4286F5;
            }   

            .body_main{
                /*padding-bottom: 60px;*/
            }

            .nav_bar .Hui-iconfont{
                font-size: 20px;
            }

        </style>
    </head>
    <body>

        <!-- <div class="head_box">
            <block name="head_left">
            </block>
            <block name="head_name">
            </block>
            <block name="head_right">
            </block>
        </div> -->
        <div class="body_main">
            <block name="body_main">
                <!-- <iframe id="main-iframe" scrolling="yes" frameborder="0" src="/service/customer/manage/index"></iframe> -->
            </block>
        </div>
        
        <!-- <div class="nav_bar">
            <ul>
                <li class="checked">
                    <i class="Hui-iconfont Hui-iconfont-home"></i>
                    <p>首页</p>
                </li>
                <li>
                    <i class="Hui-iconfont Hui-iconfont-order"></i>
                    <p>申请</p>
                </li>
                <li>
                    <i class="Hui-iconfont Hui-iconfont-middle"></i>
                    <p>项目</p>
                </li>
                <li>
                    <i class="Hui-iconfont Hui-iconfont-user"></i>
                    <p>客户</p>
                </li>
            </ul>
        </div> -->
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
        <script>
            // $(function(){
            //     $(".nav_bar ul li").click(function(){
            //         console.log($(this).index());
            //         $(".nav_bar ul li").removeClass("checked");
            //         $(this).addClass("checked");
            //         $(this).addClass("checked");
            //         if($(this).index()==0){
            //             $("#main-iframe").attr("src","/service/index/index1");
            //         }else if($(this).index()==1){
            //             $("#main-iframe").attr("src","/service/customer/manage/list");
            //         }
            //     })
            // })
        </script>

        <!-- footer_js 自定义javascript **begin** -->
        <block name="footer_js">

        </block>
        <!--/footer_js 自定义javascript **end** -->

    </body>
    </html>