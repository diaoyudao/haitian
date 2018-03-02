<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    <link href="/public/css/work/submit/addsummary.css" rel="stylesheet" type="text/css"/>
</block>

<block name="body_main">
    <style>
        textarea{
            resize:none;
        }
    </style>
    <div class="body">
        <form class="form form-horizontal" id="form-notice-add" type="post">
            <input type="hidden" value="{$Think.get.id}" name="work_plan_id">
            <input type="hidden" name="date" value="{$Think.get.date}">
            <div class="content">
                <label><input name="is_department"  type="radio" value="0" style="vertical-align: middle;"
                    <php> if( empty($plan) || (!empty($plan) && empty($plan['is_department'])))
                        {echo ' checked ';} </php>
                    /> 个人工作计划</label>
                <if condition="session('employee')['role_type_code'] eq 'director'">
                    <label><input name="is_department"  type="radio" value="1" style="vertical-align: middle;"
                        <php> if(!empty($plan) && (!empty($plan['is_department'])))
                            {echo ' checked ';} </php>
                        /> 部门工作计划</label>
                </if>
                <label for="radio" style="color: #0e90d2"></label>


            </div>
            <p class="title">工作内容</p>
            <p class="content"><textarea style="width: 99%;height: 150px;" name="context">{$plan.context}</textarea></p>
            <p class="title">备注</p>
            <p class="content"><textarea style="width: 99%;height: 100px;" name="note">{$plan.note}</textarea></p>
            <div class="row cl">
                <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
                    <button class="btn btn-primary radius" type="submit">保存提交
                    </button>
                    <button onClick="removeIframe();" class="btn btn-default radius" type="button">
                        &nbsp;&nbsp;取消
                        &nbsp;&nbsp;
                    </button>
                </div>
            </div>
        </form>
    </div>

</block>

<block name="footer_js">
    <script>
		$("#form-notice-add").validate({
			// rules: {
			// 	context: {
			// 		required: true,
			// 	},
			// 	note: {
			// 		required: false,
			// 	},

			// },
			// onkeyup: false,
			// focusCleanup: true,
			// success: "valid",
			submitHandler: function (form) {
				saveNotice();
			}
		});

		function saveNotice() {
			var parameter = {};

			if ($("input[name='context']").val() == "") {
				console.log("请填写工作内容");
				layer.msg('请填写工作内容!', {icon: 2, time: 2000});
				return;
			}
			console.log("--------------");
			parameter.date = $('input[name=date]').val();
			if ($('input[name=work_plan_id]').val()) {
				var url = '/service/work/submit/changeplan';
				parameter.work_plan_id = $('input[name=work_plan_id]').val();
			} else {
				var url = '/service/work/submit/addplan';
			}

			parameter.context = $('textarea[name=context]').val();
			parameter.note = $('textarea[name=note]').val();
			parameter.is_department = $('input[name=is_department]:checked').val();
			K.doAjax(parameter, url);
		}

		function removeIframe() {
			K.removeIframe();
		}
    </script>
</block>