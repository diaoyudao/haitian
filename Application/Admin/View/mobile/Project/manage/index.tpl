<extend name="./Application/Admin/View/mobile/base/context/common-new.tpl"/>
<block name="common_css">
	<link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap-datetimepicker.min.css">
	<link rel="stylesheet" type="text/css" href="/public/bootstrap-select/css/bootstrap-select.min.css">
	<link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui/css/H-ui.min.css" />
	<link rel="stylesheet" type="text/css" href="/public/css/home/swiper.min.css" />
	<!-- <link rel="stylesheet" type="text/css" href="/public/home/css/project/index.css" /> -->
</block>
<block name="common_js">

</block>
<block name="head_left">
    <img  onclick="lifter()" class="head_right lifter" src="/public/img/home/xlcweb/u927.png" alt="" />
</block>

<block name="head_right">
   <!--  <img onclick="screen()" class="head_right" src="/public/img/home/xlcweb/u929.png" alt="" /> -->
</block>
<block name="head_name">
	项目
</block>

<block name="body_main">
	<style>
		html,body{
			overflow-x: hidden;
		}
		.lifter{
			margin-right: 30px;
		}
		.color{
			color: #868686
		}
		.ml{
			margin-left: 20px;
		}
		.swiper-container {
			
			position: fixed;
			top: 50px;
			z-index: 1;
			width: 150%;
			height: 30px;
			color: #fff;
			background-color: #343643;
		}  
		.swiper-container .swiper-slide{
			text-align: center;
			width: 125px ;
			margin-right: 0 !important;
		}
		
		.none{
				display: none;
		}
		.tab{
			border-bottom: 3px solid #4286F5;
		}
	
		.body .order{
			position: absolute;
			top:33px;
			right:60px;
			z-index: 100;
			border: 1px solid #E4E4E4;
			background-color: #fff;
			padding: 10px 10px;
		}
		.body .screen{
			position: absolute;
			top:33px;
			right:30px;
			z-index: 100;
			border: 1px solid #E4E4E4;
			background-color: #fff;
			padding: 10px 10px;
		}
		 /*内容*/
		 .body .content{
		 	padding: 10px;
			position: fixed;
			width: 100%;
			top: 60px;
			bottom: 0;
			overflow: hidden;
			overflow-y: scroll;
			-webkit-overflow-scrolling:touch;

		 }

		.body .content .everyone{
			position: relative;
			margin-top: 30px;
			width: 100%;
			height: 260px;
			font-size: 13px;
			border-radius: 5px;
			border: 1px solid #E4E4E4;
		}
		.body .content .everyone .box{
			padding: 15px 10px 0 10px ;
			border-bottom: 1px solid #E4E4E4;
		}
		.body .content .everyone .grade{
			position: absolute;
			width: 24px;
			height: 24px;
			top: 15px;
			right: 15px;
		}
		.body .content .everyone p{
			margin-bottom: 10px;
		}
		.body .content .everyone p .pic{
			width: 18px;
			height: 18px;
			vertical-align: sub;
			margin-right: 10px;
		}

		.body .content .everyone p.text-title{
			font-size: 14px;
		}
		.body .content .everyone .foot span{
			display: inline-block;
			width: 33.3%;
			text-align: center;
			line-height: 40px;
		}
		.body .content .everyone .foot span.middle{
			border-left: 1px solid #E4E4E4;
			border-right: 1px solid #E4E4E4;
		}


		/*ios滑动*/
		/*.tabcontent{
			overflow: hidden;
			overflow: scroll;
		}*/
	/*升降查找 */
	</style>
	<div class="body">
		<!-- 升降查找 -->
		<div class="order none">
			<p onclick="changeOrder(0)">默认排序</p>
			<p onclick="changeOrder(1)">时间先后</p>
			<p onclick="changeOrder(2)">级别高低</p>
			<p onclick="changeOrder(3)">规模多少</p>
			<p onclick="changeOrder(4)">日期近远</p>
		</div>
		<div class="swiper-container">
			<div class="swiper-wrapper" id="tab">
			    <div class="swiper-slide tab">合作中</div>
				<div class="swiper-slide">ABC</div>
				<div class="swiper-slide">转交业务</div>
				<div class="swiper-slide">储备项目</div>
				<div class="swiper-slide">前期跟进</div>
				<div class="swiper-slide">返回区域</div>
				<div class="swiper-slide">结案项目</div>
				<div class="swiper-slide">已结束</div>
				
			</div>	
		</div>
		<div class="tabcontent ">
			<!-- 内容 -->
			<div class="content " id="context-list">
				<!-- <div class="everyone">
					<img class="grade" src="/public/img/home/xlcweb/u805.png" alt="">
					<div class="box">
						<p class="text-title">重庆园博园</p>
						<p class="color"><img class="pic" src="/public/img/home/xlcweb/u807.png" alt="">重庆市渝北区</p>
						<p><span class="color">项目</span><span class="ml">灯会嘉年华</span></p>
						<p><span class="color">时间</span><span class="ml">2017-01-01</span></p>
						<p><span class="color">规模</span><span class="ml">200</span></p>
						<p><span class="color">状态</span><span class="ml">合作中-待签合同</span></p>	
					</div>
					<div class="foot"><span>客户详情</span><span onclick="project(1001)" class="middle">项目详情</span><span onclick="liaison()">新增联络记录</span></div>
				</div>

				<div class="everyone">
					<img class="grade" src="/public/img/home/xlcweb/u805.png" alt="">
					<div class="box">
						<p class="text-title">重庆园博园1235</p>
						<p class="color"><img class="pic" src="/public/img/home/xlcweb/u807.png" alt="">重庆市渝北区</p>
						<p><span class="color">项目</span><span class="ml">灯会嘉年华</span></p>
						<p><span class="color">时间</span><span class="ml">2017-01-01</span></p>
						<p><span class="color">规模</span><span class="ml">200</span></p>
						<p><span class="color">状态</span><span class="ml">合作中-待签合同</span></p>	
					</div>
					<div class="foot"><span>客户详情</span><span onclick="project(1001)" class="middle">项目详情</span><span onclick="liaison()">新增联络记录</span></div>
				</div> -->
			</div>

		</div>

	</div>
</block>

<block name="footer_js">
	<script type="text/javascript" src="/public/js/home/swiper-3.3.1.jquery.min.js"></script>
<script>
	$(function(){
		// 滑动
		var mySwiper = new Swiper ('.swiper-container', {
			pagination: '.swiper-pagination',
			slidesPerView: 'auto',
			paginationClickable: true,
			spaceBetween: 30,
			freeMode: true

		})
		console.log($('#tab').children());
		$('#tab').children().click(function(){
			var index = $(this).index();

			$(this).css('border-bottom','3px solid #4286F5');
			$(this).siblings().css('border','0');

			if(0 == index) $type = 4;
			else if(1 == index) $type = 5;
			else if(2 == index) $type = 3;
			else if(3 == index) $type = 2;
			else if(4 == index) $type = 1;
			else if(5 == index) $type = 12;
			else if(6 == index) $type = 6;
			else if(7 == index) $type = 7;

			getProjData()
		})

		$('select[name=order]').change(function(){
			getProjData()
		})		

		// 初始化数据
		getProjData()
		callScroll()
	})

	function callScroll() {
		$('#context-list').scroll(function(){
	        var viewH =$(this).height(),//可见高度  
	         contentH =$('.tabcontent').height(),//内容高度  
	         scrollTop =$(this).scrollTop();//滚动高度  
	         
	        if(contentH - viewH - scrollTop <= 1) { //到达底部50px时,加载新内容  
	        	if($is_loading) return;
	        	//console.log('scroll begin',viewH,contentH,scrollTop)
				getData(showProjList)
	        }				
		});
	}
	// 升降查找
	function lifter(){
		if($('.order').hasClass('none')){
			$('.order').removeClass('none')
		}else{
			$('.order').addClass('none')
		}
		
	}
	function screen(){
		if($('.screen').hasClass('none')){
			$('.screen').removeClass('none')
		}else{
			$('.screen').addClass('none')
		}
	}
	var urlhear = location.search;
	if (urlhear.indexOf("?") != -1) {
		var str = urlhear.substr(1, 1);
		console.log("==str", str);
		$('#nav').find('li .triangle').removeClass('none');
		$('#nav li').eq(str).find('.triangle').addClass('none');
		$('.tab').find('.contentlist').removeClass('none');
		$('.tab').find('.contentlist').eq(str).addClass('none')
	}

	// 全局变量
var cur_index = 0;
var $type = 4 ; // 流程的选择项
var $datas = null; // 查询的数据列表
var $cur_pg = 1;  // cur页码
var $totalPage = null;  // 总页码
var $order = 0;
var $is_loading = false;

function changeOrder(t) {
	lifter()

	$order = t;
	$cur_pg = 1
	$totalPage = null;
	$('#context-list').empty()

	getData(showProjList)
}

function getProjData() {
	$cur_pg = 1;
	$totalPage = null;
	$('#context-list').empty()
	getData(showProjList)
}

function pageData(obj) {
	if($cur_pg == obj.curr) return;
	$cur_pg = obj.curr
	getData(showProjList)
}

function getData(callback) {
	console.log($cur_pg , $totalPage)
	if($totalPage && $cur_pg > $totalPage) return;
	var url = '/service/project/search/list'
	var param = {}
	param.pg = $cur_pg
	param.type = $type
	param.order = $order

	$is_loading = true;
	window.parent.loading_show()

	K.doAjax(param, url, function(response){
		if(response.status && 'success' ==response.status) {			
			$totalPage = response.total_page;
			if($totalPage >= $cur_pg) {				
				$cur_pg++;
			}
			console.log('pg=',$cur_pg)

			$datas = response.data;

            callback()

          //  callScroll()
            window.parent.loading_hide()
            $is_loading = false;
        } else {
        	window.parent.loading_hide()
        	$is_loading = false;
        }
    },function(e){
    	window.parent.loading_hide()
    	$is_loading = false;
    });
}

// 显示项目列表数据
function showProjList() {
	console.log('test',$datas)
	
	$.each($datas, function(i,v) {
		console.log('==', v.level)
		var type_img = (1==v.type?'gov_icon.png':(2==v.type?'ScenicSpot_icon.png':(3==v.type?'enterprise.png':((4==v.type?'overseas.png':'other.png')))));
		var type_img = '/public/img/info/' + type_img;

		vname="'"+v.customer_name+"'"

		var str = '<div class="everyone">';
		if('Z'!=v.level)
			str += '<img class="grade" src="/public/img/info/'+(v.level.toLowerCase())+'.png" alt="">';
		str += '<div class="box">';
		str += '<p class="text-title">'+v.customer_name+'</p>';
		str += '<p class="color"><img class="pic" src="'+type_img+'" alt="">'+v.province_name + (v.city_name?v.city_name:'')+'</p>';
		str += '<p><span class="color">项目</span><span class="ml">'+v.project_name+'</span></p>';
		str += '<p><span class="color">时间</span><span class="ml">'+(v.begin_date?v.begin_date:'')+'</span></p>';
		str += '<p><span class="color">规模</span><span class="ml">'+v.scale_fee+'</span></p>';
		str += '<p><span class="color">状态</span><span class="ml">'+v.status_name+'</span></p></div>';
		str += '<div class="foot"><span onclick="cust('+v.customer_id+','+vname+')">客户详情</span><span onclick="project('+v.project_id+')" class="middle">项目详情</span>';
		str += '<span onclick="liaison('+v.customer_id+')">新增联络记录</span></div></div>';

		$('#context-list').append(str);
	})
}

	 // 跳转项目详情
	 function cust(id,name){
	 	console.log(123);
	 	window.parent.operation("","/service/customer/search/detail?customer_id="+ id+"&name="+name);
	 }
	 function project(id){
	 	console.log(123)
	 	window.parent.operation("","/service/customer/search/addproject?project_id="+id);
	 }
	 function liaison(id){
	 	window.parent.operation("","/service/customer/search/addliaison?id="+id);
	 }

</script>
</block>