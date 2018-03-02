<extend name="./Application/Admin/View/default/base/context/common.tpl"/>
<block name="common_css">
    <link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" type="text/css" href="/public/bootstrap-select/css/bootstrap-select.min.css">
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="/public/css/project/approve.css"/>
</block>
<block name="common_js">

</block>

<block name="body_path_name">
    审批项目
</block>

<block name="body_main">
    <!-- <include file="./Application/Home/View/default/base/newslistsjs.tpl" /> -->
    <style>
        .laypage_curr {
            background: #fff;
        }
    </style>
    <div class="body">
        <div class="right_box_content">
            <div class="screen_box">
                <if condition="'boss' eq session('employee.role_type_code')">
                    <select class="screen_department" name="department_id">
                        <option value="">全部部门</option>
                        <volist name="department" id="item">
                            <option value="{$item.department_id}">{$item.name}</option>
                        </volist>
                    </select>
                </if>
                <select class="screen_department" placeholder="申请时间先后" name="order">
                    <option value="1">申请时间先后</option>
                    <option value="2">项目级别高低</option>
                    <option value="3">项目规模多少</option>
                    <option value="4">项目日期近远</option>
                </select>
                <select class="screen_department" name="status">
                    <option value="">全部状态</option>
                    <if condition="'director' == session('employee.role_type_code')">
                        <option value="1">待审核</option>
                    </if>
                    <if condition="'boss' == session('employee.role_type_code')">
                        <option value="2">待审批</option>
                    </if>
                    <option value="3">待分配</option>

                </select>
            </div>
            <div style="margin-top:10px;">
                <ul class="nav nav-tabs"
                    style="background-color: #fff;padding:10px;padding-bottom: 1px;border: 1px solid #e0e0e0;">
                    <li role="presentation" class="active"><a href="#">业务转交申请</a></li>
                    <li role="presentation"><a href="#">返回跟进申请</a></li>
                    <li role="presentation"><a href="#">项目结案申请</a></li>
                    <li role="presentation"><a href="#">项目结束申请</a></li>
                    <li role="presentation"><a href="#">转合作中申请</a></li>
                </ul>
                <div id="context-list">
                    <!-- <div class="content_box examination_content_box">
                        <img class="content_top_icon" src="/public/img/project/deliver_icon.png" alt="">
                        <div class="text_box">
                            <div class="title">南宁市文化局<img class="grade_icon" src="/public/img/project/a.png" alt=""></div>
                            <div class="address"><img class="address_icon" src="/public/img/project/address_icon.png" alt="">广西省南宁市</div>
                            <div class="genre"><img class="genre_icon" src="/public/img/project/gov_icon.png" alt="">政府单位</div>
                            <ul class="project_info">
                                <li>
                                    <p class="project_info_title">项目名称</p>
                                    <p>灯会嘉年华</p>
                                </li>
                                <li>
                                    <p class="project_info_title">状态</p>
                                    <p>前期跟进</p>
                                </li>
                                <li>
                                    <p class="project_info_title">项目日期</p>
                                    <p>2017.07.01 - 2017.08.29</p>
                                </li>
                                <li>
                                    <p class="project_info_title">规模（万）</p>
                                    <p>200</p>
                                </li>
                                <li>
                                    <p class="project_info_title">提交</p>
                                    <p><img class="head" src="/public/img/test/u1423.png" alt=""><span class="name">祝融</span>区域信息中心一部</p>
                                </li>
                                <li>
                                    <p class="project_info_title">转入</p>
                                    <p>业务一部</p>
                                </li>
                            </ul>
                            <p class="text">文化局牵头，要求承办方要结合南宁五象与凤凰的传统神话以及广西民族特色等元素，并在中国传统灯会的基础上引入了欧美嘉年华的概念，打造成一个集吃喝玩乐为一体，惠及民众，丰富市民精神文化生活的光影嘉年华活动，为南宁市民和政府搭建一个沟通交流的文化平台。</p>
                            <div class="loading_box">
                                <div class="mature-progress">
                                    <div class="mature-progress-bottom">

                                        <div class="mature-progress-box v0" id="mamture_progress">
                                            <dl>
                                                <dd>
                                                    <p class="member-ico v0">提交</p>
                                                    <p class="member-ico v0">07-12 12:34:556</p>
                                                </dd>
                                            </dl>
                                            <dl>
                                                <dd>
                                                    <p class="member-ico v1">审核</p>
                                                    <p class="member-ico v0">07-12 12:34:556</p>
                                                </dd>
                                            </dl>
                                            <dl>
                                                <dd>
                                                    <p class="member-ico v2">审批</p>
                                                    <p class="member-ico v0">07-12 12:34:556</p>
                                                </dd>
                                            </dl>
                                            <dl>
                                                <dd>
                                                    <p class="member-ico v3">分配</p>
                                                    <p class="member-ico v0">07-12 12:34:556</p>
                                                </dd>
                                            </dl>
                                            <dl>
                                                <dd>
                                                    <p class="member-ico v4">完成</p>
                                                    <p class="member-ico v0">07-12 12:34:556</p>
                                                </dd>
                                            </dl>
                                            <div class="progress-box" id="progress_content" data-progress="0">
                                                <i class="progress-box-1"></i>
                                            </div>
                                        </div>
                                        <div class="mature-progress-box bgtwos">
                                            <dl> <dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="reply_opinion">
                                <div>
                                    <img class="head" src="/public/img/test/u1423.png" alt="">
                                    <span class="name">祝融</span>
                                    <div class="triangle_box" >
                                        <img class="triangle"  src="/public/img/project/u1661_02.png" alt="">
                                        <div class="opinion_box">
                                            啊还是老地方尽快哈了收到了放假咯回来的
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="details_opinion botton" onclick="operation('审批意见','/service/project/manage/approval')">审批意见</div>
                            <div class="project_details botton" onclick="LsgLayerShow('项目详情','/service/customer/search/addproject', 800, 750,100)">项目详情</div>
                            <div class="user_details botton">客户详情</div>
                        </div>
                    </div> -->


                </div>
                <div id="pager0" class="mt-25 text-c"></div>
                <div class="clear"></div>
            </div>

        </div>
    </div>
</block>

<block name="footer_js">
    <script type="text/javascript" src="/public/huiadmin/static/h-ui.admin/js/H-ui.admin.js"></script>
    <script type="text/javascript" src="/public/js/lib/common-1.js"></script>
    <script>
		$(function () {
			$(".nav-tabs li").click(function () {
				$(".nav-tabs li").removeClass("active");
				$(this).addClass("active");

				// $(".ul li").removeClass("bg_color");
				// $(this).addClass("bg_color");
				// $(".examination_content_box").show();
				// $(".total_content_box").hide();
				var index = $(this).index();
				if ($(this).index() == 1) {
					// 返回跟进
					$type = 2;
					initApproveData();
					console.log($(this).index());
					$(".examination_content_box .content_top_icon").attr('src', "/public/img/project/follow_icon.png");
					$(".content_box").css({"border-top":"2px solid #688696"});
					$(".text_box .title").css({"color":"#688696"});
					$(".lan").css("cssText", "color:#688696 !important;");
					$(".mature-progress .mature-progress-bottom .mature-progress-box .progress-box i").css({"background":"#688696"});
					$(".mature-progress .mature-progress-bottom .bgtwos dl dt").css({"border":"#C3CFD5 solid 5px"});
					$(".details_opinion").css({"background-color":"#688696"});
				} else if ($(this).index() == 2) {
					// 申请结案
					$type = 3;
					initApproveData()
					console.log($(this).index());
					$(".examination_content_box .content_top_icon").attr('src', "/public/img/project/closed_icon.png");
					$(".content_box").css({"border-top":"2px solid #ff6633"});
					$(".text_box .title").css({"color":"#ff6633"});
					$(".lan").css("cssText", "color:#ff6633 !important;");
					$(".mature-progress .mature-progress-bottom .mature-progress-box .progress-box i").css({"background":"#ff6633"});
					$(".mature-progress .mature-progress-bottom .bgtwos dl dt").css({"border":"#FFC2AD solid 5px"});
					$(".details_opinion").css({"background-color":"#ff6633"});
				} else if ($(this).index() == 0) {
					// 转发
					$type = 1;
					initApproveData()
					console.log($(this).index());
					$(".examination_content_box .content_top_icon").attr('src', "/public/img/project/deliver_icon.png");
					$(".content_box").css({"border-top":"2px solid #30baba"});
					$(".text_box .title").css({"color":"#30baba"});
					$(".lan").css("cssText", "color:#30BABA !important;");
					$(".mature-progress .mature-progress-bottom .mature-progress-box .progress-box i").css({"background":"#30baba"});
					$(".mature-progress .mature-progress-bottom .bgtwos dl dt").css({"border":"#ACE3E3 solid 5px"});
					$(".details_opinion").css({"background-color":"#30baba"});
				} else if (3 == $(this).index()) {
					$type = 4;
					initApproveData()
				} else if (4 == $(this).index()) {
					$type = 5;
					initApproveData()
				}
			});

			$('select[name=order]').change(function () {
				initApproveData()
			})

			$('select[name=status]').change(function () {
				initApproveData()
			})
			
			// 初始完毕后掉一次数据
			initApproveData()
		});
		var $type = '{$Think.get.type}' ? '{$Think.get.type}' : 1; // 流程的选择项

		$(".nav-tabs li").each(function (i, v) {
			if (i + 1 == $type) {
				$(".nav-tabs li").removeClass("active");
				$(this).addClass("active");
			}
		});

		//进度条
		function loading() {
			//
			var num = $('#context-list').find('.examination_content_box').length;
			console.log('==', num)
			for (var i = 0; i < num; i++) {
				// var lsg_number = $('#progress_content').attr('data-progress');
				var lsg_number = $(".content_box").eq(i).find('#progress_content').attr('data-progress');
				console.log(lsg_number);

				if (lsg_number == 0) {
					$(".content_box").eq(i).find(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(1) p").addClass('lan');
				}
				;

				if (lsg_number == 1) {
					$(".content_box").eq(i).find(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(1) p").addClass('lan');
					$(".content_box").eq(i).find(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(2) p").addClass('lan');
					lsgload(i, 170, '.progress-box-1');
				}
				;

				if (lsg_number == 2) {
					$(".content_box").eq(i).find(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(1) p").addClass('lan');
					$(".content_box").eq(i).find(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(2) p").addClass('lan');
					$(".content_box").eq(i).find(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(3) p").addClass('lan');
					lsgload(i, 330, '.progress-box-1');
				}
				;

				if (lsg_number == 3) {
					$(".content_box").eq(i).find(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(1) p").addClass('lan');
					$(".content_box").eq(i).find(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(2) p").addClass('lan');
					$(".content_box").eq(i).find(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(3) p").addClass('lan');
					$(".content_box").eq(i).find(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(4) p").addClass('lan');
					lsgload(i, 500, '.progress-box-1');
				}
				;

				if (lsg_number == 4) {
					$(".content_box").eq(i).find(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(1) p").addClass('lan');
					$(".content_box").eq(i).find(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(2) p").addClass('lan');
					$(".content_box").eq(i).find(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(3) p").addClass('lan');
					$(".content_box").eq(i).find(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(4) p").addClass('lan');
					$(".content_box").eq(i).find(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(5) p").addClass('lan');
					lsgload(i, 665, '.progress-box-1');
				}
				;
			}

		}

		function lsgload(i, w, cls) {
			console.log(1111111);
			$(".content_box").eq(i).find(cls).css({
				width: w + 'px'
			})
		}

		// 操作/已完成
		function operation(title, url) {
			if (-1 < title.indexOf('审核')) {
				layer_show(title, url, 750, 500);
			} else if (-1 < title.indexOf('审核')) {
				layer_show(title, url, 750, 580);
			} else {
				layer_show(title, url, 750, 420);
			}

		}

		// 全局变量
		var cur_index = 0;
		var $datas = null; // 查询的数据列表
		var $cur_pg = 1
		var $totalPage = null;  // 总页码

		function initApproveData() {
			$datas = null; // 查询的数据列表
			$cur_pg = 1
			$totalPage = null;
			getData(showApproveList)
		}

		function getApproveData() {
			getData(showApproveList)
		}

		function pageData(obj) {
			if ($cur_pg == obj.curr) return;
			console.log('page', obj)
			$cur_pg = obj.curr
			getData(showApproveList)
		}

		function getData(callback) {
			var url = '/service/project/search/approve'
			var param = {}
				param.pg = $cur_pg
			param.type = $type
			param.order = $('select[name=order]').val()
			param.status = $('select[name=status]').val()
			param.department_id = $('select[name=department_id]').val()

			K.doAjax(param, url, function (response) {
				if (response.status && 'success' == response.status) {
					$datas = response.data;
					if (null == response.total_page) {
						laypage({cont:"pager0",pages:0,curr:0,
                        jump:null
                        });
					} else if ($totalPage != response.total_page) {
						laypage({cont:"pager0",pages:response.total_page,curr:1,
                        jump:pageData
                        });
						$cur_pg = 1
					}
					$totalPage = response.total_page;
					// 显示数据

					callback()

					loading();
				}
			});
		}

		function LsgLayerShow(title, url, w, h, y) {
			$(".screen_popup").hide();
            layer_show(title,url,w,h)

			// layer.open({
			// 	type: 2,
			// 	area: [w + 'px', h + 'px'],
			// 	fix: false,
			// 	maxmin: true,
			// 	shade: 0.4,
			// 	title: title,
			// 	content: url,
			// 	offset: y + 'px'
			// });
		}

		// 显示流程列表数据
		function showApproveList() {
			$('#context-list').empty()
			var role = '{$Think.session.employee.role_type_code}';
			var tit = 'boss' == role ? '审批' : '审核';

			$.each($datas, function (i, v) {
				var type_img = (1 == v.type ? 'gov_icon.png' : (2 == v.type ? 'ScenicSpot_icon.png' : (3 == v.type ? 'enterprise.png' : ((4 == v.type ? 'overseas.png' : (5 == v.type ? 'enterprise.png' : 'other.png'))))));

				var str = '<div class="content_box examination_content_box">';
				str += '<img class="content_top_icon" src="/public/img/project/deliver_icon.png" alt="">';
				str += '<div class="text_box">';
				str += '<div class="title">' + v.customer_name;
				if ('Z' != v.level)
					str += '<img class="grade_icon" src="/public/img/project/' + v.level.toLowerCase() + '.png" alt="">';
				str += '</div><div class="address"><img class="address_icon" src="/public/img/project/address_icon.png" alt="">' + v.province_name + (v.city_name ? v.city_name : '') + '</div>';

				str += '<div class="genre"><img class="genre_icon" src="/public/img/project/' + type_img + '" alt="">' + (1 == v.type ? "政府单位" : (2 == v.type ? "旅游景区" : (3 == v.type ? "国有企业" : (4 == v.type ? "海外客户" : (5 == v.type ? "民营企业" : "其他"))))) + '</div>';

				str += '<ul class="project_info"><li><p class="project_info_title">项目名称</p><p>' + v.project_name + '</p></li>';
				str += '<li><p class="project_info_title">状态</p><p>' + v.status_name + '</p></li>';
				str += '<li><p class="project_info_title">项目日期</p><p>' + (v.begin_date ? v.begin_date : '') + ' ~ ' + (v.end_date ? v.end_date : '') + '</p></li>';
				str += '<li><p class="project_info_title">规模（万）</p><p>' + v.scale_fee + '</p></li>';
				str += '<li><p class="project_info_title">提交</p><p><img class="head" src="/public/img/test/u1423.png" alt=""><span class="name">' + v.approve[0].operator_name + '</span>' + v.approve[0].out_department_name + '</p></li>';
				str += '<li><p class="project_info_title">转入</p><p>' + (v.approve[2] ? v.approve[2].in_department_name : '') + '</p></li></ul>';
				str += '<p class="text">' + v.context + '</p>';

				if (3 >= $type) {
					str += '<div class="loading_box"><div class="mature-progress"><div class="mature-progress-bottom"><div class="mature-progress-box v0" id="mamture_progress">';

					str += '<dl><dd><p class="member-ico v0">提交</p><p class="member-ico v0">' + (v.approve[0] ? v.approve[0].create_time : '') + '</p></dd></dl>';
					str += '<dl><dd><p class="member-ico v0">审核</p><p class="member-ico v0">' + (v.approve[1] ? v.approve[1].create_time : '') + '</p></dd></dl>';
					str += '<dl><dd><p class="member-ico v0">审批</p><p class="member-ico v0">' + ((v.approve[2]) ? v.approve[2].create_time : '') + '</p></dd></dl>';
					str += '<dl><dd><p class="member-ico v0">分配</p><p class="member-ico v0">' + ((v.approve[3]) ? v.approve[3].create_time : '') + '</p></dd></dl>';
					str += '<dl><dd><p class="member-ico v0">完成</p><p class="member-ico v0"></p></dd></dl>';
					str += '<div class="progress-box" id="progress_content" data-progress="' + v.approve.length + '"><i class="progress-box-1"></i></div></div><div class="mature-progress-box bgtwos"><dl> <dt></dt> </dl><dl> <dt></dt> </dl><dl> <dt></dt> </dl><dl> <dt></dt> </dl><dl> <dt></dt> </dl>';
					str += '</div></div></div></div>';
				}

				$.each(v.approve, function (i2, v2) {
					if (v2.reply) {
						str += '<div class="reply_opinion"><div><img class="head" src="' + v2.thumbnail_url + '" alt="">';
						str += '<span class="name">' + v2.operator_name + '</span><div class="triangle_box" ><img class="triangle"  src="/public/img/project/u1661_02.png" alt=""><div class="opinion_box">' + v2.reply + '</div></div></div></div>';
					}
				})

				if (3 >= $type) {
					if (('director' == role || 'boss' == role) && ('{$Think.config.SELF_SYSTEMADMIN.role_id}' == '{$Think.session.employee_id}' || '{$Think.session.employee.department_id}' == v.next_department_id) && (1 == v.approve_status || 2 == v.approve_status)) {
						str += '<div class="details_opinion botton" onclick="operation(\'' + tit + '意见\',\'/service/project/manage/approval?project_id=' + v.project_id + '\')">' + tit + '意见</div>';
					}

					if (('{$Think.config.SELF_SYSTEMADMIN.role_id}' == '{$Think.session.employee_id}' || ('director' == role && ('{$Think.session.employee.department_id}' == v.next_department_id))) && (3 == v.approve_status)) {
						str += '<div class="details_opinion botton" onclick="operation(\'分配\',\'/service/project/manage/allot?project_id=' + v.project_id + '\')">分配</div>';
					}
				} else {
					if ('{$Think.config.SELF_SYSTEMADMIN.role_id}' == '{$Think.session.employee_id}' || ('director' == role && ('{$Think.session.employee.department_id}' == v.next_department_id))) {
						str += '<div class="details_opinion botton" onclick="confirmApproveStatus(1,\'' + v.project_id + '\')">同意</div>';
						str += '<div class="details_opinion botton" onclick="confirmApproveStatus(0,\'' + v.project_id + '\')">不同意</div>';
					}
				}

				str += '<div class="project_details botton" onclick="LsgLayerShow(\'查看项目详情\',\'/service/customer/search/addproject?r=1&project_id=' + v.project_id + '\', 800, 520,100)">项目详情</div><a href="/service/customer/search/detail?customer_id=' + v.customer_id + '"><div class="user_details botton" >客户详情</div></a>';
				str += '</div></div>';

				$('#context-list').append(str);
			})
		}

		function confirmApproveStatus(t, pid) {
			if (1 == t)
				var title = '确认同意该申请？'
			else
				var title = '确认不同意该申请？'
			layer.confirm(title, {
				btn: ['确认', '取消'] //可以无限个按钮
			}, function (index, layero) {
				approveStatus(t, pid)
				layer.close(index);
			}, function (index) {
				layer.close(index);
			});
		}

		function approveStatus(t, pid) {
			console.log(pid)
			var parameter = {
				project_id: pid,
				is_pass: t
			};
			var url = '/service/project/manage/approve';

			K.doAjax(parameter, url, function (res) {
				if (res.status && res.status == 'success') {

					getApproveData();
				} else {
					if (res.message) {
						layer.msg(res.message, {icon: 2, time: 2000});
					} else {
						layer.msg('后台错误!', {icon: 2, time: 2000});
					}
				}
			});
		}

    </script>
</block>