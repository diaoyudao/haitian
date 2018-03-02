<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    <link href="/public/css/task/select.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" type="text/css" href="/public/bootstrap-select/css/bootstrap-select.min.css">
</block>
<block name="body_main">
    <style>
        .img_box {
            display: inline-block;
        }

        .img_box + .img_box {
            margin-left: 20px;
        }
        textarea[disabled]{
            background-color:#fff;
        }

    </style>
    <div class="body">
        <input type="hidden" name="task_id" value="{$Think.get.task_id}"/>
        <p class="title">创建人</p>
        <p class="content"><img src="{$task.director.thumbnail_url}" alt="">{$task.director.name}</p>
        <div class="row">
            <div class="col-md-4 title">创建时间</div>
            <div class="col-md-4 title" style="margin-left: 50px">截止时间</div>
        </div>
        <div class="row content time_box">
            <div class="col-md-4">{$task.create_time|strtotime|date='m-d',###}</div>
            <if condition="session('employee')['role_type_code'] eq 'director' and $Think.get.is_change != 'no'">
                <div class="form-group" style="padding-left: 165px;width: 360px;display: block;">
                    <div class="input-group date form_date" data-date="" data-date-format="dd MM yyyy"
                         data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                        <input class="form-control" size="16" type="text" value="{$task.end_date}" readonly
                               name="end_date"
                               style="background-color: #fff;border: 1px solid #e0e0e0;cursor: auto;"
                               placeholder="截止时间">
                        <span class="input-group-addon"
                              style="background-color: #fff;border: 1px solid #e0e0e0;"><span
                                    class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"
                              style="background-color: #fff;border: 1px solid #e0e0e0;"><span
                                    class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
                <else/>
                <div class="col-md-4"
                     style="margin-left: 50px;display: block;">{$task.end_date|strtotime|date='m-d',###}</div>
                <input type="hidden" name="end_date" value="{$task.end_date}"/>
            </if>


        </div>
        <p class="title">任务负责人</p>
        <if condition="session('employee')['role_type_code'] eq 'director' and $Think.get.is_change != 'no'">
            <div class="content select_box" style="display: block;    overflow: inherit;">
                <div class="form-group">
                    <div class="">
                        <select id="usertype" name="usertype" class="selectpicker show-tick form-control" multiple
                                data-live-search="false" title="选择任务负责人">
                            <php>$employee_id=array_column($task['handler'],'employee_id');</php>
                            <volist name="department" id="dt">
                                <option value="{$dt.employee_id}"
                                <php>if(in_array($dt['employee_id'],$employee_id)){echo 'selected';}</php>
                                >{$dt.name}</option>
                            </volist>

                        </select>
                    </div>
                </div>
            </div>
            <else/>
            <div class="content  select_box">
                <volist name="task.handler" id="vv">
                    <div class="img_box" style=""><img src="{$vv.thumbnail_url}" alt="">{$vv.name}</div>
                </volist>
            </div>
            <input type="hidden" name="usertype" value="{$task.handler}"/>
        </if>


        <p class="title">任务内容</p>
        <if condition="session('employee')['role_type_code'] eq 'director' and $Think.get.is_change != 'no'">
            <input class="content" style="width: 100%;" name="context" value="{$task.context}"/>
            <else/>
            <p class="content">{$task.context}</p>
            <input type="hidden" name="context" value="{$task.context}"/>
        </if>
            <div class="content">
                <label class="lsglabel"><input style="vertical-align: sub" name="is_over" type="checkbox" value="1" <if condition="(session('employee')['role_type_code'] eq 'director') or (I('get.is_change') eq 'no')">disabled</if>
                    <php> if(!empty($task) && (!empty($task['over_time'])))
                        {echo ' checked ';} </php>
                    /> 已完成</label>
            </div>
            <p class="title">任务完成情况</p>

            <textarea name="over_context"  class="content"  <if condition="session('employee')['role_type_code'] eq 'director' or I('get.is_change') eq 'no'">disabled</if>
            style="width:100%;height:140px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;">{$task.over_context}</textarea>


        <eq name="Think.get.is_change" value="no">
                <else/>
                <div class="preserve" onclick="finish()"><a>保存</a></div>
                <div class="cancel" onclick="removeIframe();"><a>取消</a></div>
            </eq>
            <div class="clear"></div>

    </div>
</block>

<block name="footer_js">
    <script type="text/javascript" src="/public/bootstrap-time/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="/public/bootstrap-time/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script type="text/javascript" src="/public/bootstrap-select/js/bootstrap-select.js"></script>
    <script>
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
			startDate: '<php>echo date("Y-m - d H: i:s");</php>',
		}).on('changeDate', gotoDate);

		function gotoDate() {
			$('.form_date').datetimepicker('hide');
		}

		function finish() {

			var url = '/service/task/manage/change';
			var param = {};

			if ($("select[name=usertype]").length > 0) {
				param.handler = $('select[name=usertype]').val();
				param.context = $('input[name=context]').val();
				param.end_date = $('input[name=end_date]').val();

				if (param.end_date == "") {
					console.log("请选择截止时间");
					layer.msg('请选择截止时间!', {icon: 2, time: 2000});
					return;
				}

				if (!param.handler) {
					console.log("请选择任务负责人");
					layer.msg('请选择任务负责人!', {icon: 2, time: 2000});
					return;
				}

				if (param.context == "") {
					console.log("请输入任务内容");
					layer.msg('请输入任务内容!', {icon: 2, time: 2000});
					return;
				}

			} else {
				param.over_context = $('textarea[name=over_context]').val();
				param.is_over = $('input[name=is_over]:checked').val();

				if (param.over_context == '') {
					layer.msg("请输入完成情况！", {icon: 2, time: 1500});
					return
				}
			}

			param.task_id = $('input[name=task_id]').val();

			K.doAjax(param, url)

		}

		function removeIframe() {
			K.removeIframe();
		}
    </script>
</block>