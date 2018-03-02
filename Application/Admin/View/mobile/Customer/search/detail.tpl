<extend name="./Application/Admin/View/mobile/base/context/common-new.tpl"/>
<block name="common_css">
    <!-- <link href="/public/css/customer/search/detail.css" rel="stylesheet" type="text/css" /> -->
    <link rel="stylesheet" type="text/css" href="/public/css/home/swiper.min.css"/>
</block>
<block name="common_js">

</block>

<block name="head_name">
    {$Think.get.name}
</block>

<block name="head_left">
    <!-- <a href="/service/index"><img  class="head_left" src="/public/img/home/xlcweb/u608.png" alt="" /></a> -->
    <a onclick="removeIframe()"><img class="head_left" src="/public/img/home/xlcweb/u608.png" alt=""/></a>
</block>

<block name="head_right">
    <if condition="'salesman' == session('employee.role_type_code')">
        <a onclick="operation('','/service/customer/search/addliaison?id={$data.customer_id}&is_customer=yes')"><img class="head_right"
                                                                                      src="/public/img/home/xlcweb/u1620.png"
                                                                                      alt=""/></a>
    </if>
</block>

<block name="body_main">
    <style>
        .swiper-container {
            height: 30px;
            color: #fff;
            background-color: #343643;

        }

        .swiper-container .swiper-slide {
            text-align: center;
            width: 100px;
        }

        .tab {
            border-bottom: 2px solid #fff;
        }

        .head {
            width: 32px;
            height: 32px;
        }

        .liaison_box {
            padding: 10px;
            padding-top: 20px;
        }

        .liaison_box_border {

            border: 1px solid #E4E4E4;
            border-radius: 3px;
            margin-bottom: 20px;
        }

        .box_li {
            padding: 15px 10px;
        }

        .box_li > div {
            overflow: hidden;
            height: 50px;
        }

        .box_li > div > div {
            overflow: hidden;
            position: relative;
            width: 100%;
            top: -35px;
            padding-left: 40px;
        }

        .box_li > div > img,
        .box_li > div > div {
            float: left;
        }

        .box_li div p {
            overflow: hidden;
        }

        .box_li div p span {
            float: left;
            color: #949494;
        }

        .box_li div p span:last-child {
            float: right;
        }

        .box_li > p > img {
            width: 18px;
            height: 18px;
            margin-right: 5px;
        }

        .reply_box {
            border-top: 1px solid #E4E4E4;
            padding: 15px 10px;
            color: #FF6633;
        }

        .contact_box {
            background-color: #fff;
            margin-top: 20px;
            padding: 0px 20px;
        }

        /*.contact_box p:first-child{
            font-size: 16px;
            color: #688696;
        }*/
        .contact_box .title {
            margin-top: 20px;
            font-size: 14px;
            color: #4286F5;
            padding-left: 5px;
            margin-bottom: 15px;
        }

        /*.contact_box p:nth-child(2){
            margin-top: 10px;
        }*/
        .contact_box .content {
            margin-top: 10px;
            padding-left: 5px;
        }

        .contact_box .content .name_tel_box {
            margin-bottom: 10px;
            position: relative;
        }

        .contact_box .content .name_tel_box .head {
            position: relative;
            /*top: -10px;*/
            margin-right: 5px;
        }

        .contact_box .content .name_tel_box .name_tel {
            display: inline-block;
            font-size: 13px;
        }

        .contact_box .content .name_tel_box .name_tel p {
            font-size: 13px;
            margin-bottom: -5px;
            color: #1E1E1E;
        }

        .contact_box .content .name_tel_box .name_tel span:nth-of-type(1) {
            color: #797979;
        }

        .contact_box .content .name_tel_box .name_tel i,
        .contact_box .content .name_tel_box .name_tel span:nth-of-type(2) {
            position: absolute;
            /*margin-top: 4px;*/
            right: 0;
        }

        .contact_box .content .name_tel_box .name_tel span:nth-of-type(2) {
            margin-top: -5px;
        }

        .contact_box .content .name_tel_box .name_tel i {
            right: 42px;
            margin-top: -11px;
            font-size: 18px;
            color: #03A9F4;
        }

        .contact_box .content .name_tel_box .name_tel span:nth-of-type(2) img {
            width: 26px
            height: 18px;
            cursor: pointer;
        }

        .contact_box .content .name_tel_box .name_tel p span {
            color: #993333 !important;
            margin-left: 10px;
        }

        .project_box {
            /*padding-top: 40px*/
        }

        .project_box select {
            width: 100%;
            height: 40px;
            border: none;
            border-bottom: 1px solid #ccc;
            position: fixed;
            top: 80px;
            background-color: #fff;
            z-index: 1;
            padding: 0 20px;
        }

        .body_ul {
            padding: 0 10px;
            padding-bottom: 10px;
        }

        .body_ul li {
            padding: 20px;
            border: 1px solid #ccc;
            margin-top: 20px;
            border-radius: 3px;
            overflow: hidden;
        }

        .body_ul li p {
            overflow: hidden;
            position: relative;
        }

        .body_ul li p:first-child span:first-child {
            float: left;
            font-size: 14px;
        }

        .body_ul li p:first-child .label_festival {
            float: right;
            display: block;
            padding: 0 2px;
            border: 1px solid #FF6633;
            border-radius: 3px;
            font-size: 11px;
            margin-top: 2px;
            color: #FF6633;
        }

        .body_ul li p:nth-child(2) {
            margin-top: 5px;
            color: #868686;
        }

        .body_ul li p:nth-child(3) {
            margin-top: 20px;
            float: left;
            width: 50%;
            color: #000;
        }

        .body_ul li p:nth-child(4) {
            margin-top: 20px;
            float: left;
            width: 50%;
            color: #000;
        }

        .body_ul li p:nth-child(3) span,
        .body_ul li p:nth-child(4) span {
            margin-right: 10px;
            color: #868686;
        }

        .body_ul li p:nth-child(2) img {
            margin-right: 10px;
            width: 20px;
            height: 20px;
        }

        .body_ul li img {
            position: relative;
            top: -2px;
        }

        .body_ul li p:first-child img {
            top: -1px;
        }

        .info_box {
            padding: 30px 20px;
        }

        .info_box img {
            position: relative;
            top: -2px;
        }

        .info_box p:first-child {
            overflow: hidden;
            padding: 0 10px;
        }

        .info_box p:first-child span:first-child {
            float: left;
            font-size: 14px;
        }

        .info_box p:first-child img {
            float: right;
        }

        .info_box p:nth-child(2) {
            margin-top: 5px;
            color: #868686;
            padding: 0 10px;
        }

        .info_box p:nth-child(2) img {
            margin-right: 10px;
            width: 20px;
            height: 20px;
        }

        .info_box p:nth-child(3) {
            margin-top: 30px;
            line-height: 25px;
        }
        .pev{
            position: fixed;
            width: 100%;
            top: 80px;
            bottom: 0;
            overflow: hidden;
            overflow-y: scroll;
            -webkit-overflow-scrolling:touch;
        }
    </style>
    
    <div class="swiper-container" style="width: 320px">
        <div class="swiper-wrapper ">
            <div class="swiper-slide tab">联络记录</div>
            <div class="swiper-slide">联络人</div>
            <div class="swiper-slide">客户项目</div>
            <div class="swiper-slide">基础情况</div>
        </div>
    </div>
    <div class="pev" style="">
        <div class="liaison_box text_box">
           
        </div>
        <div class="contact_box text_box" style="display: none">
            <volist name="data.contact" id="item">
                <p class="title">{$key}</p>
                <div class="content">
                    <volist name="item" id="item2">
                        <div class="name_tel_box" data="{$item2.customer_contact_id}">
                            <img class="head" src="{$item2.thumbnail_url}" alt="">
                            <div class="name_tel">
                                <p>{$item2.name}，{$item2.position}，
                                    <php>echo C('CONTACT_FUNCTION')[$item2['function']];</php>
                                    <if condition="'0' == $item2['status']">（已离职）</if>
                                </p>
                                <span>{$item2.phone}</span>
                                <i class="Hui-iconfont Hui-iconfont-tel2"></i>
                                <span><img src="/public/img/test/u840.png" alt=""></span>
                            </div>
                        </div>
                    </volist>
                </div>
            </volist>
        </div>
        <div class="project_box text_box" style="display: none">
            <ul class="body_ul">

            </ul>
        </div>
        <div class="info_box text_box" style="display: none">
            <p><span>{$data.name}</span>
                <if condition="$data['is_vip'] eq 1"><img src="/public/img/admin/vip.png"
                                                            alt=""></if>
            </p>
            <p><img src="/public/home/img/{$data.type}.png" alt="">
                <if condition="4 eq $data.type">海外，{$data.address}
                    <else/>
                    中国，{$data.province_name}，{$data.city_name}，{$data.address}</if>
            </p>
            <p>
                {$data.desc}
            </p>
        </div>
    </div>

</block>

<block name="footer_js">
    <script type="text/javascript" src="/public/js/home/swiper-3.3.1.jquery.min.js"></script>
    <script>
		var project_pg = 1;
		var liaison_pg = 1;
		var project_total=null;
		var liaison_total=null;
		var page_size = 7;
        var $is_loading = false;

		var loading = false;

		function operation(e, n) {
			var t = layer.open({type: 2, title: e, content: n,closeBtn: 0});
			layer.full(t)
		}

		function removeIframe() {
			K.removeIframe();
		}
		var index=0;
		$(function () {
            $(".swiper-container").css({"width":parent.document.body.clientWidth});
            console.log("====++",parent.document.body.clientWidth);
            var swiper = new Swiper('.swiper-container', {
                slidesPerView: 'auto',
                spaceBetween: 0,
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true,
                },
            });
			$(".swiper-container .swiper-slide").click(function () {
				$(".swiper-container .swiper-slide").removeClass("tab");
				$(this).addClass("tab");
                index = $(this).index();
				$(".text_box").hide();
				$(".text_box").eq(index).show();
				if(index == 0){
					callScroll('.liaison_box')
				}
				if(index == 2){
					callScroll('.project_box')
				}
			});
            var $index='{$Think.get.index}'?'{$Think.get.index}':0;
			$(".swiper-container .swiper-slide").each(function (i,v) {
				if($index == i && i == 1){
					$(".swiper-container .swiper-slide").removeClass("tab");
					$(this).addClass("tab");
					$('.liaison_box').hide();
					$('.contact_box').show();
				}
			});
			$(".name_tel_box").click(function () {
				var id = $(this).attr('data');
				layer.open({
					type: 2,
					title: "",
					area: ['280px', '370px'],
					shadeClose: true,
					content: '/service/customer/search/addcard?contact_id=' + id,
					// offset: y+'px'
				});
			})

		})
		callLiaison()

		function callLiaison() {
            if(loading==false){
                loading=true;
    			if(null != liaison_total && liaison_total<liaison_pg) {
    				return;
    			}
				window.parent.loading_show();
    			var param={}
    				param.pg = liaison_pg;
    			param.customer_id = '{$data.customer_id}';
    			var url = '/service/customer/search/liaison';
    			K.doAjax(param, url, function(response) {
    				if(response.status && 'success' == response.status) {
    					liaison_total = response.total_page;
                        liaison_pg++;
    					showLiaisonList(response)
						window.parent.loading_hide();
                        loading=false;
    				}else{
                        loading=false;
						window.parent.loading_hide();
                    }
    			});
            }
		}
		function liaisonPage(obj) {
			if(liaison_pg == obj.curr) return;
			liaison_pg = obj.curr
			callLiaison()
		}
		function showLiaisonList(res) {
			// $('.liaison_box').empty()

			$.each(res.data, function(i,v){
				var str = '<div class="liaison_box_border">';
				str += '<div class="box_li"> <div><img class="head" src="'+v.contact_url+'" alt=""> <div>';
				str += '<span>'+(v.contact_name?v.contact_name:"")+'</span><p>';
				str += '<span>'+(v.contact_position?v.contact_position:"")+'</span>';
				str += '<span>'+ K.getDateFormat2(''+v.liaison_time)+'</span></p></div></div>';
				str += '<p>'+((1 == v.important)? ('<img src="/public/img/test/u8862.png" alt="">') :'')+ (v.context?v.context:"") +'</p></div>';
                if(v.reply){
					str +='<div class="reply_box">批复：'+v.reply+'</div>'
				}
				str +='</div>';

				$('.liaison_box').append(str);
			})
		}
		callProject();
		$('select[name=status]').change(function () {
			project_pg=1;
			$('.body_ul').empty();
			callProject();
		})
		function callProject() {
			$is_loading=true;
			if(null != project_total && project_total<project_pg) {
				return;
			}
			window.parent.loading_show();
			var param={}
				param.pg = project_pg;
			param.customer_id = '{$data.customer_id}';
			var url = '/service/customer/search/project';
			K.doAjax(param, url, function(response) {
				if(response.status && 'success' == response.status) {
					project_total = response.total_page;
                    project_pg++;
					$is_loading=false;
					window.parent.loading_hide();
					showProjectList(response)
				}else {
					$is_loading=false;
					window.parent.loading_hide();
				}
			});
		}
		if(index == 0){
			callScroll('.liaison_box')
		}
//		console.log(index)
		function callScroll(c) {
			$(".pev").scroll(function(){
				var viewH =$(this).height(),//可见高度
					contentH =$(''+c).height(),//内容高度
					scrollTop =$(this).scrollTop();//滚动高度
                     console.log(contentH,viewH,scrollTop);

				if(contentH - viewH - scrollTop <= 1) { //到达底部50px时,加载新内容
					if($is_loading) return;
                    if(c == '.liaison_box'){
						callLiaison()
					}else {
						callProject()
					}

				}
			});
		}
		function showProjectList(res) {

			$.each(res.data, function(i,v){
				var str = '<li>';
				str +='<p><span>'+ v.name +'</span> '+(1 == v.time_type?'<span class="label_festival">春节</span>':"")+'</p>';
				str +='<p>'+ v.status_name +'</p>';
				str +='<p><span>项目规模</span>'+ v.scale_fee +'</p>';
				str +='<p><span>投资形式</span>'+ (v.fee_type?v.fee_type:"") +'</p></li>';

				$('.body_ul').append(str);
			})
		}
    </script>
</block>