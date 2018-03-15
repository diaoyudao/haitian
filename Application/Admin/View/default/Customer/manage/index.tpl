<extend name="./Application/Admin/View/default/base/context/common.tpl"/>
<block name="common_css">
	<link href="/public/swiper3.4.1/css/swiper.min.css" rel="stylesheet" type="text/css" />
	<link href="/public/css/customer/manage/index.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">
</block>

<block name="body_path_name">
	<div class="swiper-container1" style="position: relative;margin-left: -20px;">
		<div class="swiper-button-prev" style="height:22px;margin-top:-11px;margin-left:-10px"></div>
    	<div class="swiper-button-next" style="height:22px;margin-top:-11px;margin-right:-10px"></div>
		<div class="swiper-wrapper head_box" id="tab-head-box" style="">			
			<div class="swiper-slide bright swiper-slide-line title">
				全部客户
			</div>
			<volist name="customer" id="item">
			    <if condition="'boss' == session('employee.role_type_code') || ($item['business_id'] == session('employee.department_id') || $item['information_id'] == session('employee.department_id'))">
				<div class="swiper-slide" id="{$item.customer_id}">
					<if condition="1 == $item['is_vip']">
					<span class="glyphicon glyphicon-star" aria-hidden="true"></span>
					</if>
					<span onclick="callCustPage({$item.customer_id},this)">{$item.name}</span>
					<div onclick="removeTab(this)" >
						<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
					</div>
				</div>
				</if>
			</volist>
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
</block>

<block name="body_main">
	<style>
		
	</style>
	<div class="body">
		<iframe id="detail-iframe" scrolling="yes" frameborder="0" src="/service/customer/manage/list"></iframe>
		<iframe  id="main-iframe" scrolling="yes" frameborder="0" src=""></iframe>

	</div>
</block>

<block name="footer_js">
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

//		refureshSwiper()
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
</block>