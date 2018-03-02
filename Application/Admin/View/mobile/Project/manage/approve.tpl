<extend name="./Application/Admin/View/mobile/base/context/common-new.tpl"/>
<block name="common_css">
    <link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" type="text/css" href="/public/bootstrap-select/css/bootstrap-select.min.css">
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="/public/css/home/swiper.min.css"/>
    <!-- <link rel="stylesheet" type="text/css" href="/public/home/css/project/approve.css" /> -->
</block>
<block name="common_js">

</block>

<block name="head_name">
    申请
</block>

<block name="body_main">
    <style>
        html,
        body {
            /*overflow: hidden;*/
        }

        .head {
            width: 32px;
            height: 32px;
            margin-right: 10px;
            margin-top: -1px;
        }

        /*进度条*/
        .mature-progress p {
            margin: 0;
            color: #868686;
            text-align: center;
        }

        .mature-progress .mature-progress-top {
            position: relative;
            padding-left: 15px;
            font-size: 18px;
            height: 40px;
            line-height: 40px;
        }

        .mature-progress .mature-progress-top:before {
            content: '';
            display: block;
            position: absolute;
            width: 8px;
            height: 20px;
            left: 0;
            top: 10px;
            background: #e10482;
            border-radius: 5px;
        }

        .mature-progress .mature-progress-bottom {
            position: relative;
            padding-left: 0;
        }

        .mature-progress .mature-progress-bottom .mature-progress-box {
            position: relative;
            overflow: hidden;
        }

        .mature-progress .mature-progress-bottom .mature-progress-box span {
            color: #868686;
        }

        .mature-progress .mature-progress-bottom .mature-progress-box span + span {
            margin-left: 25px;
        }

        .mature-progress .mature-progress-bottom .mature-progress-box span:first-child {
            margin-left: 6px;
        }

        .mature-progress .mature-progress-bottom .mature-progress-box.bgtwos {
            position: absolute;
            z-index: 0;
            top: 30px;
            left: 12px;
        }

        .mature-progress .mature-progress-bottom .bgtwos dl + dl {
            margin-left: 40px !important;
        }

        .mature-progress .mature-progress-bottom .mature-progress-box dl {
            text-align: center;
            float: left;
        }

        .mature-progress .mature-progress-bottom .mature-progress-box dl + dl {
            margin-left: 17px;
        }

        .mature-progress .mature-progress-bottom .mature-progress-box dl dt {
            width: 20px;
            height: 20px;
            color: #fff;
            text-align: center;
            line-height: 44px;
            border-radius: 50%;
            margin: 0 auto;
            overflow: hidden;
            position: relative;
            z-index: 3;
        }

        .mature-progress .mature-progress-bottom .bgtwos dl dt {
            width: 15px;
            height: 15px;
            border: #ccc solid 1px;
            background-color: #fff;
        }

        .mature-progress .mature-progress-bottom .mature-progress-box .progress-box {
            position: relative;
            width: 223px;
            height: 5px;
            border-radius: 10px;
            border: #ccc solid 1px;
            background: #fff;
            left: 17px;
            margin: 12px 0;
        }

        .mature-progress .mature-progress-bottom .mature-progress-box .progress-box i {
            position: absolute;
            height: 3px;
            background: #30baba;
            left: 0px;
            top: 0;
            width: 0;
        }

        .mature-progress .bgcolor {
            background-color: #30baba !important;
        }

        /*new*/

        .tabcontent {
            padding-top: 30px;
        }

        .content p {
            margin-bottom: 0;
        }

        .lifter {
            margin-right: 30px;
        }

        .color {
            color: #868686
        }

        .swiper-container {
            height: 30px;
            color: #fff;
            background-color: #343643;

        }

        .swiper-container .swiper-slide {
            text-align: center;
            width: 100px;
        }

        .none {
            display: none;
        }

        .tab {
            border-bottom: 3px solid #4286F5;
        }

        .body .order {
            position: absolute;
            top: 33px;
            right: 60px;
            z-index: 100;
            border: 1px solid #E4E4E4;
            background-color: #fff;
            padding: 10px 10px;
        }

        .body .screen {
            position: absolute;
            top: 33px;
            right: 30px;
            z-index: 100;
            border: 1px solid #E4E4E4;
            background-color: #fff;
            padding: 10px 10px;
        }

        /*内容*/
        .body .content {
            padding: 10px;
            padding-bottom: 0;
        }

        .body .content .everyone {
            position: relative;
            width: 100%;
            font-size: 13px;
            border-radius: 5px;
            border: 1px solid #E4E4E4;
            margin-bottom: 20px;
        }

        .body .content .everyone .box {
            padding: 10px 20px;
            border-bottom: 1px solid #E4E4E4;
        }

        .body .content .everyone .box:nth-child(2) p:nth-child(2) {
            margin-top: 5px;
        }

        .body .content .everyone .box:nth-child(2) .loading_box {
            margin-top: 10px;
        }

        .body .content .everyone .box .text_box {
            margin-top: 20px;
        }

        .body .content .everyone .box p span {
            margin-right: 15px;
        }

        .body .content .everyone .box p .glyphicon-arrow-right {
            color: #848484;
        }

        .body .content .everyone .grade {
            position: absolute;
            width: 24px;
            height: 24px;
            top: 15px;
            right: 15px;
        }

        .body .content .everyone p .pic {
            width: 18px;
            height: 18px;
            vertical-align: sub;
            margin-right: 10px;
        }

        .body .content .everyone p.text-title {
            font-size: 14px;
        }

        .body .content .everyone .foot {
            padding: 10px 20px;
            text-align: right;
            color: #4286F5;
        }
    </style>
    <div class="body">
        <div class="swiper-container" style="width: 320px">
            <div class="swiper-wrapper" id="tab" style="">
                <div class="swiper-slide tab">业务转交</div>
                <div class="swiper-slide">返回跟进</div>
                <div class="swiper-slide">申请结案</div>
                <div class="swiper-slide">申请结束</div>
                <div class="swiper-slide">转合作中</div>
            </div>
        </div>
        <div class="tabcontent"
             style="position: fixed;width: 100%;top: 80px;bottom:0;padding-top: 10px;overflow-y: scroll;-webkit-overflow-scrolling:touch;">
            <!-- 内容 -->
            <div class="content " id="context-list">
                <!-- <div class="everyone" id="1000027">
                    <div class="box">
                        <p class="text-title">重庆园博园</p>
                    </div>
                    <div class="box">
                        <p><span class="ml">灯会嘉年华</span></p>
                        <p><span class="ml">2017-01-01</span></p>
                        <div class="loading_box">
                            <div class="mature-progress">
                                <div class="mature-progress-bottom">

                                    <div class="mature-progress-box" id="mamture_progress">
                                        <span>提交</span>
                                        <span>审核</span>
                                        <span>审批</span>
                                        <span>分配</span>
                                        <span>完成</span>
                                        <div class="clear"></div>
                                        <div class="progress-box" id="progress_content" data-progress="0">
                                            <i class="progress-box-1"></i>
                                        </div>
                                        <dl>
                                            <dd>
                                                <p>07-12</p>
                                                <p>12:34</p>
                                            </dd>
                                        </dl>
                                        <dl>
                                            <dd>
                                                <p>07-12</p>
                                                <p>12:34</p>
                                            </dd>
                                        </dl>

                                    </div>
                                    <div class="mature-progress-box bgtwos">
                                        <dl><dt class="bgcolor"></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box">
                        <p><span>区域信息中心一部</span><span class="glyphicon glyphicon-arrow-right"></span><span>业务一部</span></p>
                        <div class="text_box">
                            <p><img class="head" src="/public/img/test/u1423.png" alt="">貂蝉</p>
                            <p>新客户，但有长期、深入合作的机会。</p>
                        </div>
                        <div class="text_box">
                            <p><img class="head" src="/public/img/test/u1423.png" alt="">貂蝉</p>
                            <p>新客户，但有长期、深入合作的机会。</p>
                        </div>
                    </div>
                    <div class="foot"><span>详情</span></div>
                </div> -->


            </div>

        </div>

    </div>
</block>

<block name="footer_js">
    <script type="text/javascript" src="/public/js/home/swiper-3.3.1.jquery.min.js"></script>
    <script>
		$(function () {
			$(".swiper-container").css({"width":document.body.clientWidth});
			console.log("====+++", document.body.clientWidth);
			var swiper = new Swiper('.swiper-container', {
				slidesPerView: 'auto',
				spaceBetween: 0,
				pagination: {
					el: '.swiper-pagination',
					clickable: true,
				},
			});
			$('.swiper-slide').click(function () {
				$('.swiper-slide').removeClass("tab");
				$(this).addClass("tab")
				console.log($(this).index())
				var i = $(this).index()
				//if($type == (i+1)) return;

				$type = i + 1
				$datas = null; // 查询的数据列表
				$cur_pg = 1
				$totalPage = null;
				$('#context-list').empty();
				
				getApproveData();
			})

			$(".foot span").click(function () {
				var id = $(this).parents(".everyone").attr('id');
				console.log(id);
				// window.parent.location.href="/service/customer/search/addproject?project_id="+id
				window.parent.location.href = "/service/project/manage/approval?project_id=" + id
			})

			
			getApproveData()

		})
		var $type = '{$Think.get.type}' ? '{$Think.get.type}' : 1; // 流程的选择项
		$('.swiper-slide').each(function (i, v) {
			if (i + 1 == $type) {
				$('.swiper-slide').removeClass("tab");
				$(this).addClass("tab")
			}
		})

		function screen() {
			if ($('.screen').hasClass('none')) {
				$('.screen').removeClass('none')
			} else {
				$('.screen').addClass('none')
			}
		}
		
		//进度条
		loading();

		function loading() {
			//
			console.log(1234444555)
			if (!$('#context-list').find('.everyone')) return;
			var num = $('#context-list').find('.everyone').length;
			console.log('==', num)
			for (var i = 0; i < num; i++) {
				// var lsg_number = $('#progress_content').attr('data-progress');
				var lsg_number = $(".everyone").eq(i).find('#progress_content').attr('data-progress');
				console.log(lsg_number);

				if (lsg_number == 0) {
					$(".everyone").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(1) dt").addClass('bgcolor');
				}
				;

				if (lsg_number == 1) {
					$(".everyone").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(1) dt").addClass('bgcolor');
					$(".everyone").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(2) dt").addClass('bgcolor');
					lsgload(i, 55, '.progress-box-1');
				}
				;

				if (lsg_number == 2) {
					$(".everyone").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(1) dt").addClass('bgcolor');
					$(".everyone").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(2) dt").addClass('bgcolor');
					$(".everyone").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(3) dt").addClass('bgcolor');
					lsgload(i, 110, '.progress-box-1');
				}
				;

				if (lsg_number == 3) {
					$(".everyone").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(1) dt").addClass('bgcolor');
					$(".everyone").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(2) dt").addClass('bgcolor');
					$(".everyone").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(3) dt").addClass('bgcolor');
					$(".everyone").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(4) dt").addClass('bgcolor');
					lsgload(i, 165, '.progress-box-1');
				}
				;

				if (lsg_number == 4) {
					$(".everyone").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl dt").addClass('bgcolor');
					lsgload(i, 223, '.progress-box-1');
				}
				;
			}

			function lsgload(i, w, cls) {
				console.log(1111111);
				$(".everyone").eq(i).find(cls).css({
					width: w + 'px'
				})
			}


		}

		// 全局变量
		var cur_index = 0;
//		var $type = 1; // 流程的选择项
		var $datas = null; // 查询的数据列表
		var $cur_pg = 1
		var $totalPage = null;  // 总页码
		var $is_loading = false;

		function getApproveData() {
			console.log('test2')
			getData(showApproveList)
		}

		function callScroll() {
			console.log('test002');
			$('#context-list').scroll(function () {
				var viewH = $(this).height(),//可见高度
					contentH = $('.tabcontent').height(),//内容高度
					scrollTop = $(this).scrollTop();//滚动高度

				if (contentH - viewH - scrollTop <= 1) { //到达底部50px时,加载新内容
					if ($is_loading) return;
					console.log('scroll begin', viewH, contentH, scrollTop)
					getData(showApproveList)
				}
			});
		}

		function getData(callback) {
			if (null != $totalPage && (1 == $totalPage || $totalPage < $cur_pg)) {
				return;
			}

			var url = '/service/project/search/approve'
			var param = {}
				param.pg = $cur_pg
			param.type = $type
			param.order = 1
			param.status = null
			param.department_id = $('select[name=department_id]').val()

			$is_loading = true;
			window.parent.loading_show()

			K.doAjax(param, url, function (response) {
				if (response.status && 'success' == response.status) {

					$totalPage = response.total_page;
					if ($totalPage >= $cur_pg) {
						$cur_pg++;
					}

					$datas = response.data;

					callback()
					loading();
					callScroll()

					window.parent.loading_hide()
					// SwiperBox();
					$is_loading = false;
				} else {
					window.parent.loading_hide()
					$is_loading = false;
				}
			}, function (e) {
				window.parent.loading_hide()
				$is_loading = false;
			});
		}

		function showApproveList() {

			$.each($datas, function (i, v) {
				var str = '<div class="everyone" id="3"><div class="box">';
				str += '<p class="text-title">' + v.customer_name + '</p></div>';
				str += '<div class="box">';
				str += '<p><span class="ml">' + v.project_name + '</span></p>';
				str += '<p><span class="ml">' + v.begin_date + '</span></p>';

				str += '<div class="loading_box"><div class="mature-progress"><div class="mature-progress-bottom">';
				str += '<div class="mature-progress-box" id="mamture_progress">';
				str += '<span>提交</span><span>审核</span><span>审批</span><span>分配</span><span>完成</span>';
				str += '<div class="clear"></div>';
				str += '<div class="progress-box" id="progress_content" data-progress="' + v.approve.length + '">';
				str += '<i class="progress-box-1"></i></div>';

				$.each(v.approve, function (i1, v1) {
					str += '<dl><dd><p>' + v1.create_time.substr(5, 5) + '</p><p>' + v1.create_time.substr(11, 5) + '</p></dd></dl>';
				})

				str += '</div>';
				str += '<div class="mature-progress-box bgtwos">';
				str += '<dl><dt class="bgcolor"></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl></div>';
				str += '</div></div></div></div>';

				str += '<div class="box">';
				str += '<p><span>' + v.approve[0].out_department_name + '</span><span class="glyphicon glyphicon-arrow-right"></span><span>' + (v.approve[2] ? v.approve[2].in_department_name : '') + '</span></p>';
				$.each(v.approve, function (i2, v2) {
					if (v2.reply) {
						str += '<div class="text_box">';
						str += '<p><img class="head" src="' + v2.thumbnail_url + '" alt="">' + v2.operator_name + '</p>';
						str += '<p>' + v2.reply + '</p>';
						str += '</div>';
					}
				})

				var role = '{$Think.session.employee.role_type_code}';

				var tit = 'boss' == role ? '审批' : '审核';
				if ('{$Think.config.SELF_SYSTEMADMIN.role_id}' == '{$Think.session.employee_id}' || (('director' == role || 'boss' == role) && ('{$Think.session.employee.department_id}' == v.next_department_id))) {
					if (3 >= $type) {
						if (3 != v.approve_status)
							str += '<div class="foot"><span onclick="goDetail(1,' + v.project_id + ')">' + tit + '</span></div></div>';
						else
							str += '<div class="foot"><span onclick="goDetail(2,' + v.project_id + ')">分配</span></div></div>';
					} else {
						str += '<div class="foot"><span onclick="confirmApproveStatus(1,\'' + v.project_id + '\')">同意</span>';
						str += '<span class="ml-30" onclick="confirmApproveStatus(0,\'' + v.project_id + '\')">不同意</span></div></div>';
					}
				} else {
					str += '<div class="foot"></div></div>';
				}

				$('#context-list').append(str)
			})

		}

		function goDetail(t, id) {
			if (1 == t)
				window.parent.operation("", "/service/project/manage/approval?project_id=" + id);
			else
				window.parent.operation("", "/service/project/manage/allot?project_id=" + id);
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
					$cur_pg = 1
					$totalPage = null;
					$('#context-list').empty();

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