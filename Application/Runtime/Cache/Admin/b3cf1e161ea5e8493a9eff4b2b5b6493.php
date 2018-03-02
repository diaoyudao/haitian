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
    
	<link href="/public/swiper3.4.1/css/swiper.min.css" rel="stylesheet" type="text/css" />
	<link href="/public/css/customer/manage/index.css" rel="stylesheet" type="text/css" />

    


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
    
	<div class="swiper-container1" style="position: relative;margin-left: -20px;">
		<div class="swiper-button-prev" style="height:22px;margin-top:-11px;margin-left:-10px"></div>
    	<div class="swiper-button-next" style="height:22px;margin-top:-11px;margin-right:-10px"></div>
		<div class="swiper-wrapper head_box" id="tab-head-box" style="">			
			<div class="swiper-slide bright swiper-slide-line title">
				全部客户
			</div>
			<?php if(is_array($customer)): $i = 0; $__LIST__ = $customer;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i; if('boss' == session('employee.role_type_code') || ($item['business_id'] == session('employee.department_id') || $item['information_id'] == session('employee.department_id'))): ?><div class="swiper-slide" id="<?php echo ($item["customer_id"]); ?>">
					<?php if(1 == $item['is_vip']): ?><span class="glyphicon glyphicon-star" aria-hidden="true"></span><?php endif; ?>
					<span onclick="callCustPage(<?php echo ($item["customer_id"]); ?>,this)"><?php echo ($item["name"]); ?></span>
					<div onclick="removeTab(this)" >
						<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
					</div>
				</div><?php endif; endforeach; endif; else: echo "" ;endif; ?>
			<!-- <div class="swiper-slide" >
				<span class="glyphicon glyphicon-star" aria-hidden="true"></span><span onclick="callCustPage(100020,this)">重庆园博园</span>
				<div>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</div>
			</div>
			<div class="swiper-slide " >
				<span onclick="callCustPage(100024,this)">杜甫草堂</span>
				<div onclick="removeTab(this)">
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</div>
			</div> -->
			
		</div>   
	</div>

</div>
<!-- body_main 自定义页面内容 **begin** -->

	<style>
		
	</style>
	<div class="body">
		<iframe id="detail-iframe" scrolling="yes" frameborder="0" src="/service/customer/manage/list"></iframe>
		<iframe  id="main-iframe" scrolling="yes" frameborder="0" src=""></iframe>

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

	<script type="text/javascript" src="/public/swiper3.4.1/js/swiper.min.js"></script>
	<script>

var swiper;
		window.onload = function() {
			swiper = new Swiper('.swiper-container1', {
				pagination: '.swiper-pagination',
				slidesPerView: 'auto',
				//loopedSlides:20,
				slidesPerColumn : 1,
				preventClicks:false,
				preventClicksPropagation:false,
				paginationClickable: false,
				// 如果需要前进后退按钮
			    nextButton: '.swiper-button-next',
			    prevButton: '.swiper-button-prev',			    
			});
		}

function refureshSwiper() {

	swiper = new Swiper('.swiper-container1', {
				pagination: '.swiper-pagination',
				slidesPerView: 'auto',
				//loopedSlides:20,
				slidesPerColumn : 1,
				preventClicks:false,
				preventClicksPropagation:false,
				paginationClickable: false,
				// 如果需要前进后退按钮
			    nextButton: '.swiper-button-next',
			    prevButton: '.swiper-button-prev',			    
			});

}		

		function TablePopover(){
			$("[data-toggle='popover']").popover();
		}
		TablePopover();

		// function SlideLine(){
			
		// }

		// SlideLine();

		function Weekly(){
			layer_show("周报",'/service/work/submit/weekly', 750, 700);
		}

		$(function(){
    		$(".swiper-container1 .swiper-slide").click(function(){				
				if($(this).index()==0){
					$(".swiper-container1 .swiper-slide").removeClass("swiper-slide-line");
					$(this).addClass("swiper-slide-line");
//					$("#main-iframe").attr("src","/service/customer/manage/list");
					$("#main-iframe").hide();
					$("#detail-iframe").show();
				}
			});
//			parent.document.getElementById("detail-iframe").height=0;
//			parent.document.getElementById("detail-iframe").height=document.body.scrollHeight+20;
			//main-iframe高度
			// document.getElementById("detail-iframe").height=0;
     		//document.getElementById("detail-iframe").height=document.getElementById("detail-iframe").contentWindow.document.body.scrollHeight;

			$('#main-iframe').hide();
//			$('#detail-iframe').hide();
		})

	function callCustPage(id,me) {
		// 判断是否已经存在
		
		$(".swiper-container1 .swiper-slide").removeClass("swiper-slide-line");
		$(me).parent('div').addClass("swiper-slide-line");
		$("#detail-iframe").hide();
		$("#main-iframe").attr("src","/service/customer/search/detail?customer_id="+id);
		$("#main-iframe").show()
	}
	function removeTab(me) {
		// 判断当前选中的是否是自己
		if($(me).parent('div').hasClass('swiper-slide-line')) {
			$(".swiper-container1 .swiper-slide").removeClass("swiper-slide-line");
			$(".swiper-container1 .swiper-slide").eq(0).addClass("swiper-slide-line");
			$("#detail-iframe").attr("src","/service/customer/manage/list");
		}

		$(me).parent('div').remove();	

		refureshSwiper()	
	}

	function addTab(id,name,is_vip) {

		var tid = window.document.getElementById(id);	
	
		var str = '<div class="swiper-slide swiper-slide-line" id="'+id+'">';
		if('1' == is_vip)
			str += '<span class="glyphicon glyphicon-star" aria-hidden="true"></span>';
		str += '<span onclick="callCustPage('+id+',this)">'+name +'</span><div onclick="removeTab(this)"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></div></div>';
		var parent_b = window.document.getElementById('tab-head-box');
		$("#tab-head-box").children("div").removeClass("swiper-slide-line");
		if(tid) {
			$(tid).addClass("swiper-slide-line");
		} else {
			$(parent_b).append(str);
		}

//		$("#main-iframe").attr("src","/service/customer/search/detail?customer_id="+id);

		$("#detail-iframe").hide();
		$("#main-iframe").attr("src","/service/customer/search/detail?customer_id="+id);
		$("#main-iframe").show()

		refureshSwiper()
	}

	</script>

<!--/footer_js 自定义javascript **end** -->

</body>
</html>