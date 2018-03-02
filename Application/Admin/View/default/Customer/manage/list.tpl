<extend name="./Application/Admin/View/default/base/context/common.tpl"/>
<block name="common_css">

</block>
<block name="common_js">

</block>

<block name="body_main">
    <include file="./Application/Admin/View/default/base/css/cust_list.tpl"/>

    <div class="body" style="overflow: hidden;">
        <div class="left_box">
            <div class="add_box">
                <div onclick="AddCustomer()"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增客户</div>
            </div>
            <div class="examination_box">
                <ul class="examination_ul ul">
                    <li><img src="/public/img/customer/u26.png" alt=""><span>VIP客户</span><span
                                class="num">{$num_abc|default=0}</span></li>
                    <li><img src="/public/img/customer/u32.png" alt=""><span>最近联系</span><span
                                class="num">{$num_lis|default=0}</span></li>
                </ul>
            </div>
            <div class="total_box">
                <ul class="total_ul ul">
                    <li class="bg_color" type=""><img src="/public/img/customer/u42.png" alt=""><span>全部客户</span><span
                                class="num">{$cust_total}</span></li>
                    <li type="1"><img src="/public/img/project/gov_icon.png" alt=""><span>政府单位</span><span
                                class="num">{$type_list[1]|default=0}</span></li>
                    <li type="2"><img src="/public/img/project/ScenicSpot_icon.png" alt=""><span>旅游景区</span><span
                                class="num">{$type_list[2]|default=0}</span></li>
                    <li type="3"><img src="/public/img/customer/u17.png" alt=""><span>国有企业</span><span
                                class="num">{$type_list[3]|default=0}</span></li>
                    <li type="5"><img src="/public/img/customer/u57.png" alt=""><span>民营企业</span><span
                                class="num">{$type_list[5]|default=0}</span></li>
                    <li type="0"><img src="/public/img/customer/u22.png" alt=""><span>其他</span><span
                                class="num">{$type_list[0]|default=0}</span></li>
                    <li type="4"><img src="/public/img/customer/u37.png" alt=""><span>海外客户</span><span
                                class="num">{$type_list[4]|default=0}</span></li>
                </ul>
            </div>
        </div>
        <div class="right_box">
            <div class="right_box_content">
                <div class="table_box abc_box">
                    <p class="title">VIP客户<span class="num"></span></p>
                    <span class="head-search">
						<input type="text" id="abc-name" placeholder="搜索客户名称" class="head-input">
						<span onclick="searchCustAbc()" class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</span>
                    <div class="clear"></div>
                    <div class="list_table">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>客户名称</th>
                                <th>省市<span onclick="sortAbc(1)" class="glyphicon glyphicon-sort"
                                            aria-hidden="true"></span></th>
                                <th>类型<span onclick="sortAbc(2)" class="glyphicon glyphicon-sort"
                                            aria-hidden="true"></span></th>
                            </tr>
                            </thead>
                            <tbody id="abc-list">
                            <!-- <tr class="tr_border">
                                <td>
                                    武汉园博园
                                </td>
                                <td>
                                    <img src="/public/img/project/a.png" alt="">
                                </td>
                                <td>
                                    湖北省武汉市
                                </td>
                                <td>
                                    旅游景区
                                </td>
                            </tr> -->
                            </tbody>
                        </table>
                    </div>
                    <div id="abc-pager" class="mt-25 text-c"></div>
                    <div class="clear"></div>
                </div>
                <div class="table_box recently_box">
                    <if condition="'salesman' == session('employee.role_type_code')">
                        <p class="title">最近联系<span class="num"></span></p>
                    </if>
                    <span class="head-search">
						<input type="text" id="liaison-name" placeholder="搜索客户名称" class="head-input">
						<span onclick="searchCustLis()" class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</span>
                    <div class="clear"></div>
                    <div class="list_table mt-10">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>客户名称</th>
                                <th>上次联络</th>
                                <th>下次工作安排</th>
                            </tr>
                            </thead>
                            <tbody id="recent-list">
                            <!-- <tr class="tr_border">
                                <td>
                                    <p>武汉园博园<img src="/public/img/project/a.png" alt=""></p>
                                    <p><img src="/public/img/project/ScenicSpot_icon.png" alt="">旅游景区<img class="content_top_icon" src="/public/img/project/address_icon.png" alt="">湖北省武汉市</p>
                                </td>
                                <td>
                                    <p>05.13，初次接触</p>
                                    <p>张飞</p>
                                </td>
                                <td>
                                    <p>05.20，电话跟进</p>
                                    <p>黄月英</p>
                                </td>
                            </tr> -->

                            </tbody>
                        </table>
                    </div>
                    <div id="recent-pager" class="mt-25 text-c"></div>
                    <div class="clear"></div>
                </div>
                <div class="table_box screen_box">
                    <if condition="'salesman' == session('employee.role_type_code')">
                        <p class="title"><span>最近联系</span><span class="num"></span></p>
                    </if>
                    <span class="head-search">
						<input type="text" id="input-cust-name" placeholder="搜索客户名称" class="head-input">
						<span onclick="searchCust()" class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</span>
                    <div class="clear"></div>
                    <div class="list_table mt-10">
                        <div class="top">
                            <p style="width:23%">省/直辖/自治区</p>
                            <p style="width:23%">市</p>
                            <p style="width:23%">区/县</p>
                            <p style="width:30%">客户名称</p>
                        </div>
                        <ul class="province_ul" style="width:23%">
                            <volist name="provinces" id="item">
                                <li onclick="setProvList('{$item.province_id}',this)">{$item.province_name}
                                    <span>{$item.num}</span><span class="glyphicon glyphicon-menu-right"
                                                                  aria-hidden="true"></span></li>
                            </volist>
                            <!-- <li>湖南省<span>42</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>
                            <li>四川省<span>42</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li> -->

                        </ul>
                        <ul class="city_ul" style="width:23%">
                            <!-- <li class="city-list" >省级客户<span>42</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li> -->
                            <!-- <li>湖南省<span>42</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>
                            <li>湖南省1<span>42</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li> -->
                        </ul>
                        <ul class="area_ul" style="width:23%">
                            <!-- <li class="county-list" >市级客户<span>42</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>
                            <li>湖南省1<span>42</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li> -->
                        </ul>
                        <ul class="Customer_ul" style="width:30%">
                            <!-- <li><img src="/public/img/project/gov_icon.png" alt="">湖南省</li>
                            <li><img src="/public/img/project/ScenicSpot_icon.png" alt="">湖南省</li>
                            <li><img src="/public/img/customer/u17.png" alt="">湖南省</li>
                            <li><img src="/public/img/customer/u37.png" alt="">湖南省</li> -->
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</block>

<block name="footer_js">
    <script>
		$(function () {
			$(".province_ul li").click(function () {
				var v = $(this).attr('prov_id');

				$(".city_ul").show();
				$(".screen_box .top p").eq(1).show();
				$(".area_ul").hide();
				$(".Customer_ul").hide();
				$(".screen_box .top p").eq(2).hide();
				$(".screen_box .top p").eq(3).hide();

				backColor(this)
			});

			$(".area_ul li").click(function () {
				console.log('area_ul li', $(this).index());
				$(".Customer_ul").show();
				$(".screen_box .top p").eq(3).show();

				backColor(this)
			});

			$(".examination_ul li").click(function () {
				$(".screen_box").hide();
				$(".ul li").removeClass("bg_color");
				$(this).addClass("bg_color");
				if ($(this).index() == 0) {
					callAbc();
					$(".abc_box").show();
					$(".recently_box").hide();

				} else {
					callRecent();
					$(".abc_box").hide();
					$(".recently_box").show();
				}
			});
			$(".total_ul li").click(function () {

				setTypeList($(this).attr('type'))

				$(".recently_box").hide();
				$(".abc_box").hide();
				$(".screen_box").show();
				$(".ul li").removeClass("bg_color");
				$(this).addClass("bg_color");
				// $(".recently_box").hide();
				// $(".abc_box").hide();
				$(".screen_box .title span:nth-of-type(1)").text($(this).find("span:nth-of-type(1)").text());
			});
			console.log(document.body.scrollHeight)
			console.log(window.innerHeight)
			// console.log($('#main-iframe',parent.document).height())
			// $('#main-iframe',parent.document).height((window.innerHeight + 50) + 'px');
			parent.document.getElementById("detail-iframe").height = 0;
			parent.document.getElementById("detail-iframe").height = document.body.scrollHeight + 100;
		})

		function backColor(me) {
			$(me).css('background-color', '#D0E4EE').siblings().css('background-color', '#fff');
		}

		function initPageHeight() {
			parent.document.getElementById("detail-iframe").height = 0;
			parent.document.getElementById("detail-iframe").height = document.body.scrollHeight + 100;
		}

		function AddCustomer() {
			window.parent.location.href = "/service/customer/manage/add";
		}

		// 全局变量
		var abc_pg = 1;
		var recent_pg = 1;
		var abc_total = null;
		var recent_total = null;

		function callAbc(param) {
			param = param || {};
			var url = '/service/customer/search/getCustomerAbc';
			param.pg = abc_pg;
			K.doAjax(param, url, function (response) {
				if (response.status && response.status == 'success') {
					if (abc_total != response.total_page) {
						laypage({cont:"abc-pager",pages:response.total_page,curr:1,
                        jump:abcPage
                        });
						abc_pg = 1
					}
					abc_total = response.total_page;

					showAbcList(response.data)
				}
			});
		}

		function callRecent() {
			var url = '/service/customer/search/getCustomerRecent';
			param ={pg:recent_pg};
			K.doAjax(param, url, function (response) {
				if (response.status && response.status == 'success') {
					if (recent_total != response.total_page) {
						laypage({cont:"recent-pager",pages:response.total_page,curr:1,
                        jump:recentPage
                        });
						recent_pg = 1
					}
					recent_total = response.total_page;

					showRecentList(response.data)
				}
			});
		}

		function showRecentList(data) {
			$('#recent-list').empty();
			console.log(data)
			$.each(data, function (i, v) {
				var addr = (4 == v.type ? v.address : (v.province_name + (v.city_name ? v.city_name : '')));
				var type_img = (1 == v.type ? 'gov_icon.png' : (2 == v.type ? 'ScenicSpot_icon.png' : (3 == v.type ? 'enterprise.png' : ((4 == v.type ? 'overseas.png' : (5 == v.type ? 'enterprise.png' : 'other.png'))))));

				var str = '<tr class="tr_border" onclick="addParentTab(' + v.customer_id + ',\'' + v.name + '\',\'' + v.is_vip + '\')">';
				str += '<td><p>' + v.name;
				if ('1' == v.is_vip)
					str += '<img src="/public/img/admin/vip.png" alt="">';
				str += '</p><p><img src="/public/img/project/' + type_img + '" alt="">' + (1 == v.type ? "政府单位" : (2 == v.type ? "旅游景区" : (3 == v.type ? "国有企业" : (4 == v.type ? "海外客户" : (5 == v.type ? "民营企业" : "其他"))))) + '<img class="content_top_icon" src="/public/img/project/address_icon.png" alt="">' + addr + '</p></td>';
				str += '<td><p>' + (v.liaison_time ? K.getDateFormat2(v.liaison_time) : '') + '，' + (v.project_name ? v.project_name : '') + '</p><p>' + v.employee_name + '</p></td>';
				str += '<td><p>' + (v.next_time ? K.getDateFormat2(v.next_time) : '') + '</p><p>' + (v.next_employee_name ? v.next_employee_name : '') + '</p></td></tr>';

				$('#recent-list').append(str)
			})

			initPageHeight()
		}

		function showAbcList(data) {
			$('#abc-list').empty();

			$.each(data, function (i, v) {
				var addr = (4 == v.type ? v.address : (v.province_name + (v.city_name ? v.city_name : '')));
				var str = '<tr class="tr_border" onclick="addParentTab(' + v.customer_id + ',\'' + v.name + '\',\'' + v.is_vip + '\')">';
				str += '<td>' + v.name + '</td>';
				str += '<td>' + addr + '</td>';
				str += '<td>' + (1 == v.type ? "政府单位" : (2 == v.type ? "旅游景区" : (3 == v.type ? "国有企业" : (4 == v.type ? "海外客户" : (5 == v.type ? "民营企业" : "其他"))))) + '</td></tr>';

				$('#abc-list').append(str)
			})

			initPageHeight()
		}

		// 全局变量
		var cur_type = '';
		var cur_prov_cust = null;
		var cur_city_cust = null;
		var $prov_cust_data = [];
		var $city_cust_data = [];

		function setTypeList(t) {
			// 海外客户特殊处理
			cur_type = t;
			if (4 == t) {
				var param = {
					type: 4
				}
				var url = '/service/customer/search/getCustomer';
				K.doAjax(param, url, function (res) {
					if (res.status && res.status == 'success') {
						setCustList(res.data, 'out', '')
					}
				})

				showOnlyCust();
				return;
			}

			var param = {
				type: cur_type
			}
			var url = '/service/customer/search/getProvince';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					$('.province_ul').empty();

					$.each(res.data, function (i, v) {
						var str = '<li onclick="setProvList(\'' + v.province_id + '\',this)">' + v.province_name + '<span>' + v.num + '</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>'
						$('.province_ul').append(str);
					})

					showType()

					initPageHeight()
				}
			});
		}

		function setProvList(id, me) {
			backColor(me)

			var param = {
				type: cur_type,
				province_id: id
			}
			var url = '/service/customer/search/getCity';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					$('.city_ul').empty();

					if (res.prov_cust) {
						var str = '<li class="prov-level" onclick="getProvLevel(\'' + id + '\',this)">省级客户<span>' + res.prov_cust.num + '</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>';
						$('.city_ul').append(str);

						//$prov_cust_data = res.prov_cust.cust;
					}

					$.each(res.data, function (i, v) {
						var str = '<li class="city-list" onclick="setCityList(\'' + v.city_id + '\',this)">' + v.city_name + '<span>' + v.num + '</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>';
						$('.city_ul').append(str);
					})

					$(".city_ul").show();
					$(".screen_box .top p").eq(0).show();
					$(".screen_box .top p").eq(1).show();
					$(".area_ul").hide();
					$(".Customer_ul").hide();
					$(".screen_box .top p").eq(2).hide();
					$(".screen_box .top p").eq(3).hide();
				}
			});
		}

		function setCityList(id, me) {
			backColor(me)

			var param = {
				type: cur_type,
				city_id: id
			}
			var url = '/service/customer/search/getCounty';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					$('.area_ul').empty();

					if (res.city_cust) {
						var str = '<li class="city-level" onclick="getCityLevel(\'' + id + '\',this)">市级客户<span>' + res.city_cust.num + '</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>';
						$('.area_ul').append(str);

						//$city_cust_data = res.city_cust.cust
					}

					$.each(res.data, function (i, v) {
						var str = '<li class="county-list" onclick="getCustList(\'' + v.county_id + '\',this)" >' + v.county_name + '<span>' + v.num + '</span><span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span></li>';
						$('.area_ul').append(str);
					})

					showCountyList()
					hideCustList()
				}
			})
		}

		function getCustList(id, me) {
			backColor(me)

			var param = {
				type: cur_type,
				county_id: id
			}
			var url = '/service/customer/search/getCustomer';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					setCustList(res.data, 'county', id)
					showCustList()
				}
			})
		}


		function setCustList(data, tt, oid) {
			$('.Customer_ul').empty();

			$.each(data, function (i, v) {
				var str = '<li><a alt="' + v.name + '" title="' + v.name + '" onclick="addParentTab(' + v.customer_id + ',\'' + v.name + '\',\'' + v.is_vip + '\')"><img src="/public/img/project/' + v.type + '.png" alt="">' + v.name + '</a>';
				if (tt)
					str += '<i onclick="layer_show(\'排序\',\'/service/customer/manage/sort?t=' + tt + '&ty=' + cur_type + '&oid=' + oid + '&id=' + v.customer_id + '\',350,360)" class="Hui-iconfont cust-sort" style="color:#1296db;right: 15px;">&#xe675;</i>';
				if (i > 0) str += '<i onclick="sortTop(\'' + v.customer_id + '\',\'' + data[i - 1].customer_id + '\',\'' + tt + '\',\'' + oid + '\')" class="Hui-iconfont cust-sort" style="color:#1296db">&#xe679;</i>';
				str += '</li>';
				$('.Customer_ul').append(str);
			})
		}

		function sortTop(id, prev_id, t, oid) {
			K.doAjax({id:id,prev_id:prev_id}, '/service/customer/manage/sorttop', function (e) {
				if (e.status && e.status == "success") {
					if ('out' == t) window.setTypeList(4);
					else if ('prov' == t) window.getProvLevel(oid);
					else if ('city' == t) window.getCityLevel(oid);
					else if ('county' == t) window.getCustList(oid);
				} else {
					if (e.message) {
						layer.msg(e.message, {icon: 2, time: 1500})
					} else {
						layer.msg("后台错误!", {icon: 2, time: 1500})
					}
				}
			});
		}

		function addParentTab(id, name, level) {
			// 记录到最近查看客户列表
			try {
				K.doAjax({customer_id:id}, '/service/customer/manage/history', function (res){}, function (){});
			} catch (e) {
			}

			window.parent.addTab(id, name, level)
		}

		// 搜索客户，不要排序
		function searchCust() {
			var v = $('#input-cust-name').val()
			if ("" == v) {
				return;
			}

			var param = {
				name: v,
			}
			var url = '/service/customer/search/getCustomer';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					setCustList(res.data)
					showOnlyCust()
					$(".ul li").removeClass("bg_color");
				}
			})
		}

		function searchCustAbc() {
			console.log(222333)
			var v = $('#abc-name').val()
			if ("" == v) {
				return;
			}
			var param = {
				name: v,
			}
			var url = '/service/customer/search/getCustomerAbc';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					showAbcList(res.data)
				}
			})
		}

		function searchCustLis() {
			var v = $('#liaison-name').val()
			if ("" == v) {
				return;
			}
			var param = {
				name: v,
			}
			var url = '/service/customer/search/getCustomerRecent';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					showRecentList(res.data)
				}
			})
		}

		function getProvLevel(id, me) {
			backColor(me)

			var param = {
				type: cur_type,
				province_id: id,
			}
			var url = '/service/customer/search/getProvLevel';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					$prov_cust_data = res.data;
					showCustList('prov', id);
				}
			})
		}

		function getCityLevel(id, me) {
			backColor(me)

			var param = {
				type: cur_type,
				city_id: id,
			}
			var url = '/service/customer/search/getCityLevel';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					$city_cust_data = res.data;
					showCustList('city', id);
				}
			})
		}


		function showCountyList() {
			$(".area_ul").show();
			$(".screen_box .top p").eq(2).show();
		}

		function hideCountyList() {
			$(".area_ul").hide();
			$(".screen_box .top p").eq(2).hide();
		}

		function hideCustList() {
			$(".Customer_ul").hide();
			$(".screen_box .top p").eq(3).hide();
		}

		function showCustList(type, oid) {
			console.log(type, $city_cust_data)
			type = type || 'county';
			if ('prov' == type) {
				$(".area_ul").hide();
				$(".screen_box .top p").eq(2).hide();
			}

			if ('prov' == type) setCustList($prov_cust_data, 'prov', oid)
			if ('city' == type) setCustList($city_cust_data, 'city', oid)

			$(".Customer_ul").show();
			$(".screen_box .top p").eq(3).show();
		}

		function showOnlyCust() {
			$(".province_ul").hide();
			$(".city_ul").hide();
			$(".area_ul").hide();
			$(".Customer_ul").show();
			$(".screen_box .top p").eq(3).show()
			$(".screen_box .top ").children("p:eq(3)").siblings().hide();
		}

		function showType() {
			$(".province_ul").show();
			$(".city_ul").hide();
			$(".area_ul").hide();
			$(".Customer_ul").hide();
			$(".screen_box .top ").children("p:eq(0)").siblings().hide();
		}

		function abcPage(obj) {
			if (abc_pg == obj.curr) return;
			abc_pg = obj.curr
			callAbc()
		}

		function recentPage(obj) {
			if (recent_pg == obj.curr) return;
			recent_pg = obj.curr
			callRecent()
		}

		// sort abc
		var $order_sort = 1;

		function sortAbc(t) {
			console.log('===', t)
			var param = {
				order: (t + 1),
				order_sort: $order_sort
			};
			$order_sort = ((1 == $order_sort) ? 0 : 1);
			callAbc(param)
		}

		function sortCall(id) {
			console.log(id)
		}


    </script>
</block>