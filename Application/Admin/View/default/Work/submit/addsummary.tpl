<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    <link href="/public/css/work/submit/addplan.css" rel="stylesheet" type="text/css"/>
</block>

<block name="body_main">
    <style>

    </style>
    <div class="body">
        <form class="form form-horizontal" id="form-notice-add" type="post">
            <input type="hidden" name="work_plan_id" value="{$Think.get.id}"/>
            <p class="title">本周工作计划</p>
            <textarea class="content" style="width:100%;height:140px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;" name="context">{$summary.context}</textarea>
            <p class="title">完成情况</p>
            <div class="content">
                <div style="display: inline-block;">
                    <label class="lsglabel"><input name="is_over" type="radio" value="1" onClick="changeOver();"
                        <php> if(empty($summary) || ((!empty($summary)) && $summary['is_over'] == 1) )
                            {echo ' checked ';} </php>
                        />
                        已完成</label>
                    <label class="lsglabel"><input name="is_over" type="radio" value="0" onClick="changeOver();"
                        <php> if((!empty($summary) && $summary['is_over'] == 0) )
                            {echo ' checked ';} </php>

                        />
                        未完成</label>
                </div>
                <input class="input_text" type="text" placeholder="描述未完成的原因" name="cause"
                       value="{$summary.cause}">
            </div>


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

    </div>
</block>

<block name="footer_js">
    <script>


		$("#form-notice-add").validate({
			// rules: {
			// 	context: {
			// 		required: true,
			// 	},
			// 	cause: {
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
		if (0 == $('input[type=radio][name=is_over]:checked').val()) {
			$('input[name=cause]').show();
		}

		function changeOver() {
			$('input[name=is_over]').change(function () {
				if (1 == $(this).val()) {
					$('input[name=cause]').hide();
				} else {
					$('input[name=cause]').show();
				}
			})
		}

		function saveNotice() {
			var parameter = {};

			if($("textarea[name='context']").val()==""){
                console.log("请填写本周工作计划");
                layer.msg('请填写本周工作计划!', {icon: 2, time: 2000});
                return;
            }else if($('input[name=cause]').css("display")!="none"){
            	if($('input[name=cause]').val()==""){
            		console.log("请填写未完成的原因");
                	layer.msg('请填写未完成的原因!', {icon: 2, time: 2000});
                	return;
            	}
            }
            console.log("--------------");

			if ($('input[name=work_plan_id]').val()) {
				var url = '/service/work/submit/changesummary';
				parameter.work_plan_id = $('input[name=work_plan_id]').val();
			}

			parameter.context = $('textarea[name=context]').val();
			parameter.cause = $('input[name=cause]').val();
			parameter.is_over = $('input[type=radio][name=is_over]:checked').val();
			if (0 == parameter.is_over && '' == parameter.cause) {
				layer.msg("请输入未完成原因", {icon: 2, time: 1500})
			}
			if (1 == parameter.is_over) {
				parameter.cause = '';
			}
			K.doAjax(parameter, url);
		}

		function removeIframe() {
			K.removeIframe();
		}
    </script>
</block>