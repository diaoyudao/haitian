<extend name="./Application/Admin/View/mobile/base/context/common-new.tpl"/>
<block name="common_css">
    <link href="/public/home/css/customer/manage/list.css" rel="stylesheet" type="text/css"/>
</block>
<block name="common_js">

</block>

<block name="head_name">
    客户
</block>

<block name="body_main">
    <style>

		.blue_flag{
		    width: 14px;
		    height: 14px;
		    position: absolute;
		    left: 7px;
		    top: 50%;
		    margin-top: -6px;
		}
		.glyphicon-menu-right{
			position: absolute !important;
    		right: 10px !important;
		}
    </style>
    <div class="top_box" style="overflow: hidden;z-index: 1;">
        <div class="choice total" type="">全部客户</div>
        <div onclick="callRecent()">最近联系</div>
    </div>

    <div class="all_body body">
        <div class="select_box">
            <div class="city_box">
                <p>选择城市</p>
                <span class="glyphicon glyphicon-triangle-bottom" aria-hidden="true"></span>
            </div>
            <div class="screen_box">
                <p>政府单位</p>
                <span class="glyphicon glyphicon-triangle-bottom" aria-hidden="true"></span>
            </div>
        </div>
        <div class="content_box" style="position: fixed;width: 100%;top: 110px;bottom: 0;overflow: hidden;overflow-y: scroll;-webkit-overflow-scrolling:touch;">
            <ul class="body_ul">
                <li cid="100020" style="display: none">
                    <p><span>重庆园博园</span></p>
                    <p><img src="/public/img/project/ScenicSpot_icon.png" alt="">重庆市渝北区</p>
                </li>
                <li style="display: none">
                    <p><span>重庆园博园</span></p>
                    <p><img src="/public/img/project/ScenicSpot_icon.png" alt="">重庆市渝北区</p>
                </li>
            </ul>
        </div>
        <div class="list_table">
            <ul class="province_ul">
                <volist name="provinces" id="item">
                    <li value="{$item.province_id}">{$item.province_name}<if condition="$item['num'] gt 0"><img class="blue_flag" src="/public/img/info/flag1.png" alt=""></if></li>
                </volist>

            </ul>
            <ul class="city_ul">
                <li>市</li>
                <li><img class="blue_flag" src="/public/img/info/flag1.png" alt="">湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省1</li>
            </ul>
            <ul class="area_ul">
                <li>区/县</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省</li>
                <li>湖南省2</li>
            </ul>
        </div>
        <div class="ul_box">
            <ul>
                <li value="">所有</li>
                <li value="1">政府单位</li>
                <li value="2">旅游景区</li>
                <li value="3">企业公司</li>
                <li value="4">海外客户</li>
                <li value="0">其他</li>
            </ul>
        </div>
    </div>
    <div class="lately_body body"  style="padding-top: 0;position: fixed;width: 100%;top: 80px;padding-bottom: 70px;overflow: hidden;overflow-y: scroll;-webkit-overflow-scrolling:touch;">
        <div class="lately_box">
            <ul class="body_ul">
              
            </ul>
        </div>
    </div>
</block>

<block name="footer_js">
    <script>
		var cur_type = '';
		var $prov_cust_data = [];
		var $city_cust_data = [];

		$(function () {
			var province = "";
			var city = "";
			var area = "";
			$(".top_box div").click(function () {
				$(".top_box div").removeClass("choice");
				$(this).addClass("choice");
				if ($(this).index() == 0) {
					$(".all_body").show();
					$(".select_box").show();
					$(".lately_body").hide();
				} else {
					$(".lately_body").show();
					$(".all_body").hide();
				}
			})

			// 省、市、区选择
			$(".province_ul li").click(function () {
				province = $(this).text();
				city = "";
				area = "";
				$(".city_box p").text(province + city + area);
				getCity($(this).val());
				$(".city_ul").show();
				$(".area_ul").hide();
				$(".province_ul li").removeClass("choice_bg");
				$(".city_ul li").removeClass("choice_bg");
				$(this).addClass("choice_bg");
			});


//			$(".city_ul li").click(function () {
//				city = $(this).text();
//				area = "";
//				$(".city_box p").text(province + city + area);
//				$(".area_ul").show();
//				$(".city_ul li").removeClass("choice_bg");
//				$(".area_ul li").removeClass("choice_bg");
//				$(this).addClass("choice_bg");
//			});
//			$(".area_ul li").click(function () {
//				area = $(this).text();
//				$(".city_box p").text(province + city + area);
//				$(".area_ul li").removeClass("choice_bg");
//				$(this).addClass("choice_bg");
//				$(".list_table").hide();
//				$(".content_box").show();
//			});
			//筛选
			$(".select_box div").click(function () {
				if ($(this).index() == 0) {
					$(".ul_box").hide();
					$(".content_box").hide();
					if ($(".list_table").css("display") == "none") {
						$(".list_table").show();
					} else {
						$(".list_table").hide();
						$(".content_box").show();
					}
				} else {
					$(".list_table").hide();
					$(".content_box").hide();
					if ($(".ul_box").css("display") == "none") {
						$(".ul_box").show();
//						$(".content_box").show();

					} else {
						$(".ul_box").hide();
						$(".content_box").show();
					}
				}
			});

			$(".ul_box ul li").click(function () {
				var text = $(this).text();
				$(".screen_box p").text(text);
				cur_type = $(this).val();
				setTypeList(cur_type);
				$(".ul_box").hide();
				$(".content_box").show();
			});

			// 跳转客户详情
//			$(".body_ul li").click(function () {
//				var id = $(this).attr('cid');
//				window.parent.operation("", "/service/customer/search/detail?customer_id=" + id);
//			});


		});
		callScroll()
		// 全局变量
		var recent_pg = 1;
		var recent_total = null;

		var $is_loading=false;
		function callRecent() {
			$is_loading=true;
			if(null != recent_total && recent_total<recent_pg) {
				return;
			}
			window.parent.loading_show();
			var url = '/service/customer/search/getCustomerRecent';
			param ={pg:recent_pg};
			K.doAjax(param, url, function (response) {
				if (response.status && response.status == 'success') {

					recent_total = response.total_page;
					recent_pg++;
					$is_loading=false;
					window.parent.loading_hide();
					showRecentList(response.data)
				}else {
					$is_loading=false;
					window.parent.loading_hide();
				}
			});
		}
		function callScroll() {
			$(".lately_body").scroll(function(){
				var viewH =$(this).height(),//可见高度
					contentH =$('.lately_box').height(),//内容高度
					scrollTop =$(this).scrollTop();//滚动高度
				console.log(contentH,viewH,scrollTop);

				if(contentH - viewH - scrollTop <= 1) { //到达底部50px时,加载新内容
					if($is_loading) return;
					callRecent();
				}
			});
		}

		function showRecentList(data) {
//			$('.body_ul').empty();

			$.each(data, function (i, v) {
				var str = '<li onclick="addParentTab(' + v.customer_id + ',\''+v.name+'\')"> ';
				if (v.is_vip == 0) {
					str += '<p><span>' + v.name + '</span></p>';
				} else {
					str += '<p><span>' + v.name + '</span><img src="/public/img/admin/vip.png" alt=""></p>';
				}
				str += '<p><span><img src="/public/home/img/' + v.type + '.png" alt="">' + v.province_name + (v.city_name? v.city_name:"") + '</p>';
				str += '<p>上次联络&nbsp;&nbsp;&nbsp;&nbsp;' + (v.liaison_time ? K.getDateFormat2(''+v.liaison_time) : '') + '</p>';
				str += '<p>下次联络&nbsp;&nbsp;&nbsp;&nbsp;' + (v.next_time ? K.getDateFormat2(''+v.next_time) : '') + '</p> </li>';
				$('.body_ul').append(str);

			})
			$('.body_ul').show();
			$('.select_box').hide();
		}

		$(".total").click(function () {
			setTypeList($(this).attr('type'))

			$(".body_ul").hide();
			$(".screen_box").show();
			$(this).addClass("choice_bg");
			// $(".recently_box").hide();
			// $(".abc_box").hide();
		});

		function setTypeList(t) {
			// 海外客户特殊处理
			if (4 == t) {
				var param = {
					type: 4
				}
				var url = '/service/customer/search/getCustomer';
				K.doAjax(param, url, function (res) {
					if (res.status && res.status == 'success') {
						setCustList(res.data)
					}
				})

				showOnlyCust();
				return;
			}

			cur_type = t;
			var param = {
				type: cur_type
			}
			var url = '/service/customer/search/getProvince';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					$('.province_ul').empty();

					$.each(res.data, function (i, v) {
						var str = '<li onclick="setProvList(\'' + v.province_id + '\')">' + v.province_name  + (v.num>0?'<img class="blue_flag" src="/public/img/info/flag1.png" alt="">':'') + '<span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>'
						$('.province_ul').append(str);
					})

					showType()
				}
			});
		}

		function setProvList(id) {
			var param = {
				type: cur_type,
				province_id: id
			}
			var url = '/service/customer/search/getCity';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					$('.city_ul').empty();

					if (res.prov_cust) {
						var str = '<li class="prov-level" onclick="showCustList(\'prov\')">省级客户' + (res.prov_cust.num>0?'<img class="blue_flag" src="/public/img/info/flag1.png" alt="">':'') + '<span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>';
						$('.city_ul').append(str);
						//setCustList(res.prov_cust.cust)  // 设置省级客户
						$prov_cust_data = res.prov_cust.cust;
					}

					$.each(res.data, function (i, v) {
						var str = '<li class="city-list" onclick="setCityList(\'' + v.city_id + '\')">' + v.city_name +  (v.num>0?'<img class="blue_flag" src="/public/img/info/flag1.png" alt="">':'') + '<span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>';
						$('.city_ul').append(str);
					})

					$(".city_ul").show();
					$(".screen_box .top p").eq(0).show();
					$(".screen_box .top p").eq(1).show();
					$(".area_ul").hide();
					$(".body_ul").hide();
					$(".screen_box .top p").eq(2).hide();
					$(".screen_box .top p").eq(3).hide();
				}
			});
		}

		function getCity(id) {
			var param ={};
			param.province_id = id;
			var url = '/service/customer/search/getCity';
			K.doAjax(param, url, function (e) {
				if (e.status && e.status == "success") {
					$('.city_ul').empty();
					if (e.prov_cust) {
						var str = '<li  onclick="showCustList(\'prov\')">省级' + (e.prov_cust.num>0?'<img class="blue_flag" src="/public/img/info/flag1.png" alt="">':'') + '<span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>';
						$('.city_ul').append(str);
						//setCustList(res.prov_cust.cust)  // 设置省级客户
						$prov_cust_data = e.prov_cust.cust;
					}
					$.each(e.data, function (i, v) {
						var str = '<li class="city-list" onclick="setCityList(\'' + v.city_id + '\')">' + v.city_name + (v.num>0?'<img class="blue_flag" src="/public/img/info/flag1.png" alt="">':'') + '<span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>';

						$('.city_ul').append(str);
					})
				} else {
					if (e.message) {
						layer.msg(e.message, {icon: 2, time: 1500})
					} else {
						layer.msg("后台错误!", {icon: 2, time: 1500})
					}
				}
			})
		}

		function setCityList(id) {
			var param = {
				type: cur_type,
				city_id: id
			}
			var url = '/service/customer/search/getCounty';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					$('.area_ul').empty();

					if (res.city_cust) {
						var str = '<li class="city-level" onclick="showCustList(\'city\')">市级' + (res.city_cust.num>0?'<img class="blue_flag" src="/public/img/info/flag1.png" alt="">':'') + '<span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>';
						$('.area_ul').append(str);

						// setCustList(res.city_cust.cust) 显示的时候再加载
						$city_cust_data = res.city_cust.cust
					}

					$.each(res.data, function (i, v) {
						var str = '<li class="county-list" onclick="getCustList(\'' + v.county_id + '\')" >' + v.county_name + (v.num>0?'<img class="blue_flag" src="/public/img/info/flag1.png" alt="">':'') + '<span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>';
						$('.area_ul').append(str);
					})

					showCountyList()
//					hideCustList()
				}
			})
		}

		function getCustList(id) {
			var param = {
				type: cur_type,
				county_id: id
			}
			var url = '/service/customer/search/getCustomer';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					setCustList(res.data)
					showCustList()
				}
			})
		}

		function setCustList(data) {
			$('.body_ul').empty();
			$.each(data, function (i, v) {
				var str = '<li onclick="addParentTab(' + v.customer_id + ',\''+v.name+'\')"> ';
				if (v.is_vip == 0) {
					str += '<p><span>' + v.name + '</span></p>';
				} else {
					str += '<p><span>' + v.name + '</span><img src="/public/img/admin/vip.png" alt=""></p>';
				}
				str += '<p><span><img src="/public/home/img/' + v.type + '.png" alt="">' + v.province_name + (v.city_name? v.city_name:"") + '</p>';
//				var str = '<li><a onclick="addParentTab(' + v.customer_id + ',\'' + v.name + '\')"><img src="/public/img/project/gov_icon.png" alt="">' + v.name + '</a></li>';
				$('.body_ul').append(str);
			})
		}

		function addParentTab(id, name) {
			// 判断原来是否已经存在了

			var str = '<div class="swiper-slide swiper-slide-line" >';
//			if('A' == level || 'B' == level || 'C' == level)
			str += '<span class="glyphicon glyphicon-star" aria-hidden="true"></span>';
			str += '<span onclick="callCustPage(' + id + ',this)">' + name + '</span><div onclick="removeTab(this)"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></div></div>';
			var parent_b = window.parent.document.getElementById('tab-head-box');
			$("#tab-head-box", window.parent.document).children("div").removeClass("swiper-slide-line");
			$(parent_b).append(str);
			window.parent.operation("", "/service/customer/search/detail?customer_id=" + id+'&name='+name);
		}

		function showCountyList() {
			$(".area_ul").show();
//			$(".list_table").eq(2).show();
		}

		function hideCountyList() {
			$(".area_ul").hide();
//			$(".list_table").eq(2).hide();
		}

		function hideCustList() {
			$(".body_ul").hide();
//			$(".list_table").eq(3).hide();
		}

		function showCustList(type) {
			console.log(type, $city_cust_data)
			type = type || 'county';
			if ('prov' == type) {
				$(".area_ul").hide();
//				$(".list_table").eq(2).hide();
			}

			if ('prov' == type) setCustList($prov_cust_data)
			if ('city' == type) setCustList($city_cust_data)

			$(".body_ul").show();
			$(".content_box").show();
			$(".list_table").hide();
		}

		function showOnlyCust() {
			$(".province_ul").hide();
			$(".city_ul").hide();
			$(".area_ul").hide();
			$(".body_ul").show();
//			$(".list_table").eq(3).show()
//			$(".list_table").children("p:eq(3)").siblings().hide();
		}

		function showType() {
			$(".province_ul").show();
			$(".city_ul").hide();
			$(".area_ul").hide();
			$(".Customer_ul").hide();
			$(".screen_box .top ").children("p:eq(0)").siblings().hide();
		}
    </script>
</block>