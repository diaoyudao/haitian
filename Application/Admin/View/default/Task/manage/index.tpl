<extend name="./Application/Admin/View/default/base/context/common.tpl"/>
<block name="common_css">
    <!-- <link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap.min.css"> -->
    <link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" type="text/css" href="/public/bootstrap-select/css/bootstrap-select.min.css">
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/Hui-iconfont/1.0.7/iconfont.css"/>
    <link href="/public/css/task/index.css" rel="stylesheet" type="text/css"/>
</block>
<block name="common_js">

</block>

<block name="body_path_name">
    任务管理
</block>

<block name="body_main">
    <!-- <include file="./Application/Home/View/default/base/newslistsjs.tpl" /> -->
    <style>
        .table thead tr th,
        .table tbody tr td {
            white-space: nowrap;
            vertical-align:middle;
        }

        .table tbody tr td:nth-child(6) {
            white-space: normal;
        }

    </style>
    <div class="body">
        <if condition="session('employee')['role_type_code'] eq 'director'">
            <div class="submit_box">
                <div class="input_box">
                    <input type="text" name="context" class="input" placeholder="输入任务要求">
                </div>
                <div class="form-group">
                    <div class="input-group date form_date" data-date="" data-date-format="dd mm yyyy"
                         data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                        <input class="form-control" size="16" type="text" value="" readonly name="end_date"
                               style="background-color: #fff;border: 1px solid #e0e0e0;" placeholder="截止时间">
                        <span class="input-group-addon" style="background-color: #fff;border: 1px solid #e0e0e0;"><span
                                    class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon" style="background-color: #fff;border: 1px solid #e0e0e0;"><span
                                    class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
                <!-- <input class="responsible" type="text" value="" style="background-color: #fff;border: 1px solid #e0e0e0;" placeholder="负责人"> -->
                <div class="form-group" style="margin-left:20px;">
                    <div class="">
                        <select id="usertype" name="usertype" class="selectpicker show-tick form-control" multiple
                                data-live-search="false" title="选择任务负责人">
                            <volist name="department" id="item">
                                <option value="{$item.employee_id}">{$item.name}</option>
                            </volist>
                        </select>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="preserve" onclick="add();"><a>保存</a></div>
                <div class="clear"></div>
            </div>
        </if>

        <div class="table_box">
            <div class="table_box_top"><span class="table_box_title">任务列表</span> <span
                        class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"
                        onclick="PopupShow()"></span></div>
            <ul class="screen_popup">
                <if condition="session('employee')['role_type_code'] neq 'director'">
                    <li class="show_ok" value="1"><span class="glyphicon glyphicon-ok check-mark"></span><span
                                class="text">只显示我的任务</span></li>
                    <li class="line"></li>
                </if>
                <li class="hide_ok" value="1"><span class="glyphicon glyphicon-ok check-mark"></span><span
                            class="text">只显示可操作任务</span></li>
            </ul>
            <table class="table">
                <thead>
                <tr>
                    <th>序号</th>
                    <th>创建时间</th>
                    <th>创建人</th>
                    <th>完成截止时间</th>
                    <th>任务负责人</th>
                    <th>任务内容</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <volist name="lists" id="item" key="key">
                    <tr>
                        <td>{$key}</td>
                        <td>{$item.create_time|strtotime|date='m-d',###}</td>
                        <td><img src="{$item.director.thumbnail_url}" alt="">{$item.director.name}</td>
                        <td>{$item.end_date|strtotime|date='m-d',###}</td>
                        <td>
                            <php> $counts=count($item['handler']);</php>
                            <if condition="$counts eq 2">
                                <volist name="item.handler" id="vv" offset="0" length="2">
                                    <img src="{$vv.thumbnail_url}" alt="">
                                </volist>
                                <elseif condition="$counts gt 2"/>
                                <volist name="item.handler" id="vv" offset="0" length="2">
                                    <img src="{$vv.thumbnail_url}" alt="">
                                </volist>
                                <div style="position: relative;width: 32px;height: 32px;margin-right: 10px;display: inline;top: -8px;">
                                    <img src="/public/img/admin/circle.png" style="position: absolute;top: 0;left: 0;"
                                         alt="">
                                    <p style="position: absolute;top: -8px;left: 12px;z-index:999;"><span
                                                style="color: #0e90d2;">{$counts}</span></p>
                                </div>
                                <else/>
                                <volist name="item.handler" id="vv">
                                    <img src="{$vv.thumbnail_url}" alt="">{$vv.name}
                                </volist>

                            </if>

                        </td>
                        <td>{$item.context}</td>
                        <php>
                            $employee_id = session('employee_id');
                            $handler=array_column($item['handler'],'employee_id');
                        </php>
                        <switch name="item.status">
                            <case value="操作">

                                <if condition="in_array($employee_id,$handler) || session('employee')['role_type_code'] eq 'director'">
                                    <td style="color: #30baba"
                                        onclick="operation('完成任务','/service/task/manage/change?task_id={$item.task_id}')">{$item['status']}</td>
                                    <else/>
                                    <td style="color: #aeaeae">{$item.status}</td>
                                </if>


                            </case>
                            <case value="已完成">
                                <if condition="in_array($employee_id,$handler) || session('employee')['role_type_code'] eq 'director'">
                                    <td style="color: #aeaeae"
                                        onclick="operation('完成任务','/service/task/manage/change?task_id={$item.task_id}&is_change=no')">{$item['status']}</td>
                                    <else/>
                                    <td style="color: #aeaeae">{$item.status}</td>
                                </if>
                            </case>
                            <default/>
                            <case value="已过期">
                                <if condition="in_array($employee_id,$handler) || session('employee')['role_type_code'] eq 'director'">
                                    <td style="color: #FF7F50"
                                        onclick="operation('完成任务','/service/task/manage/change?task_id={$item.task_id}&is_change=no')">{$item['status']}</td>
                                    <else/>
                                    <td style="color: #FF7F50">{$item.status}</td>
                                </if>
                            </case>
                        </switch>

                    </tr>
                </volist>

                </tbody>
            </table>
        </div>
        <div id="task-pager" class="mt-25 text-c"></div>

    </div>

</block>

<block name="footer_js">

    <!--     <script type="text/javascript" src="/public/bootstrap-time/js/jquery-1.8.3.min.js"></script> -->
    <!-- <script type="text/javascript" src="/public/bootstrap-3.3.7/js/bootstrap.min.js"></script> -->

    <!-- <script type="text/javascript" src="/public/bootstrap-time/js/bootstrap.min.js"></script> -->
    <script type="text/javascript" src="/public/bootstrap-time/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="/public/bootstrap-time/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script type="text/javascript" src="/public/bootstrap-select/js/bootstrap-select.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/layer/2.1/layer.js"></script>
    <script type="text/javascript" src="/public/huiadmin/static/h-ui.admin/js/H-ui.admin.js"></script>
    <script type="text/javascript" src="/public/js/lib/list-1.js"></script>

    <script type="text/javascript">
		$('.form_date').datetimepicker({
			language: 'zh-CN',
			weekStart: 1,
			todayBtn: 1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0,
			format: 'yyyy-mm-dd',
			startDate: '<php>echo date("Y-m-d H:i:s");</php>',
		}).on('changeDate', gotoDate);
		$(window).on('load', function () {
			$('#usertype').selectpicker({
				// 'selectedText': 'cat'
			});
		});

		function gotoDate() {
			$('.form_date').datetimepicker('hide');
		}

		var pg = '{$Think.get.pg}' ? '{$Think.get.pg}' : 1;
		var totalPages = '{$totalPages}' ? '{$totalPages}' : 1;
		var select_type = '{$Think.get.select_type}';
		var status_type = '{$Think.get.status_type}';
		laypage({
			cont: "task-pager",
			pages: totalPages,
			curr: pg,
			jump: function (e, first) {
				if (!first) {
					location.href = '?pg=' + e.curr + '&select_type=' + select_type + '&status_type=' + status_type;
				}
			}
		});

		function add() {
			var url = '/service/task/manage/add';
			var param = {};
			param.handler = $('select[name=usertype]').val();
			param.end_date = $('input[name=end_date]').val();
			param.context = $('input[name=context]').val();

			if (!param.context) {
				layer.msg("请输入任务内容!", {icon: 2, time: 1500});
				return false;
			}
			if (!param.end_date) {
				layer.msg("请选择结束时间!", {icon: 2, time: 1500});
				return false;
			}
			if (!param.handler) {
				layer.msg("请选择负责人!", {icon: 2, time: 1500});
				return false;
			}

			K.doAjax(param, url, function (response) {
				if (response.status && 'success' == response.status) {
					window.location.replace(window.location.href);
				} else {
					if (response.message) {
						layer.msg(response.message, {icon: 2, time: 1500})
					} else {
						layer.msg("后台错误!", {icon: 2, time: 1500})
					}
				}
			});
		}

		// 操作/已完成
		function operation(title, url) {
			layer_show(title, url, 750, 700);
		}

		//筛选显示
		function ScreenPopup() {

			var url = '/service/task/manage/index';
			if (1 == select_type) {
				$(".screen_popup .show_ok .glyphicon").show();
			}
			$(".screen_popup .show_ok").click(function () {
				if ($(this).find(".glyphicon").css("display") == "none") {
					$(".screen_popup .show_ok .glyphicon").hide();
					$(".screen_popup .hide_ok .glyphicon").hide();
					status_type=0
					$(this).find(".glyphicon").show();
					select_type = $(this).val();
					url += '?select_type=' + select_type + '&status_type=' + status_type;
					window.location.replace(url);
				} else {
//						console.log("隐藏");
					$(this).find(".glyphicon").hide();
					select_type = 0;
					url += '?status_type=' + status_type;
					window.location.replace(url);
				}
			});

			if (1 == status_type) {
				$(".screen_popup .hide_ok .glyphicon").show();
			}
			$(".screen_popup .hide_ok").click(function () {
				if ($(this).find(".glyphicon").css("display") == "none") {
//					console.log("显示1");
					$(".screen_popup .hide_ok .glyphicon").hide();
					$(".screen_popup .show_ok .glyphicon").hide();
					$(this).find(".glyphicon").show();
					status_type = $(this).val();
					select_type=0
					url += '?select_type=' + select_type + '&status_type=' + status_type;
					window.location.replace(url);
				} else {
//						console.log("隐藏1");
					$(this).find(".glyphicon").hide();
					status_type = 0;
					url += '?select_type=' + select_type + '&status_type=' + status_type;
					window.location.replace(url);
				}
			});
		}

		ScreenPopup();

		//筛选层弹出/隐藏
		function PopupShow() {
			if ($(".screen_popup").css("display") == "block") {
				$(".screen_popup").hide();
			} else {
				console.log("弹出");
				$(".screen_popup").show();
				
			}
			
		}


    </script>
</block>