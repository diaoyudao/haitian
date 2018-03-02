<extend name="./Application/Admin/View/default/base/context/common.tpl"/>
<block name="common_css">
	<link href="/public/swiper3.4.1/css/swiper.min.css" rel="stylesheet" type="text/css" />
	<link href="/public/css/customer/manage/index.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">
</block>

<block name="body_path_name">
	<div class="swiper-container1">
		<div class="swiper-wrapper head_box" id="tab-head-box">
			<div class="swiper-slide bright swiper-slide-line title">
				全部客户
			</div>
			<div class="swiper-slide" cid="100020">
				<span class="glyphicon glyphicon-star" aria-hidden="true"></span>重庆园博园
				<div>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</div>
			</div>
			<div class="swiper-slide " cid="100024">
				杜甫草堂
				<div>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</div>
			</div>
			<div class="swiper-slide ">
				北京园博园
				<div>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</div>
			</div>
			<div class="swiper-slide ">
				湖北荆州市政府
				<div>
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</div>
			</div>
		</div>   
	</div>
</block>

<block name="body_main">
	<style>
		
	</style>
	<div class="body">
		<iframe id="main-iframe" scrolling="yes" frameborder="0" src="/service/customer/manage/list"></iframe>

	</div>
</block>

<block name="footer_js">
	<script type="text/javascript" src="/public/swiper3.4.1/js/swiper.min.js"></script>
	<script>


		window.onload = function() {
			var swiper = new Swiper('.swiper-container1', {
				pagination: '.swiper-pagination',
				slidesPerView: 'auto',
				paginationClickable: true,
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
			//main-iframe高度
    		document.getElementById("main-iframe").height=0;
    		document.getElementById("main-iframe").height=document.getElementById("main-iframe").contentWindow.document.body.scrollHeight;  

    		$(".swiper-container1 .swiper-slide").click(function(){
				$(".swiper-container1 .swiper-slide").removeClass("swiper-slide-line");
				console.log($(this).index());
				$(this).addClass("swiper-slide-line");
				if($(this).index()==0){
					$("#main-iframe").attr("src","/service/customer/manage/list");
				}else{
					var id = $(this).attr('cid');
					console.log(id)
					$("#main-iframe").attr("src","/service/customer/search/detail?customer_id="+id);
				}
			});
		})



	</script>
</block>