<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    <link href="/public/css/work/examine/add.css" rel="stylesheet" type="text/css"/>
</block>
<block name="body_main">
    <style>

    </style>
    <div class="body">
        <input type="hidden" name="id" value="{$Think.get.id}">
        <input type="hidden" name="type" value="{$Think.get.type}">
        <p class="title">批复</p>
        <textarea class="content" style="width:100%;height:140px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;"
                  name="reply">{$reply}</textarea>
        <div class="preserve" onclick="saveReply()"><a>保存</a></div>
        <div class="cancel" onclick="removeIframe();"><a>取消</a></div>
        <div class="clear"></div>
    </div>
</block>
<block name="footer_js">
    <script>
		function saveReply() {
			var parameter = {};
			var type = $('input[name=type]').val();
			if ($('textarea[name=reply]').val() == '') {
				layer.msg("批复不能为空!", {icon: 2, time: 1500});
				return false;
			}
			switch (type) {
				case 'weekly':
					var url = '/service/work/examine/replyexport';
					parameter.work_export_id = $('input[name=id]').val();
					break;
				case 'summary':
					var url = '/service/work/examine/replysummary';
					parameter.work_summary_id = $('input[name=id]').val();
					break;
				default:
					var url = '/service/work/examine/add';
					parameter.work_plan_id = $('input[name=id]').val();
			}

			parameter.reply = $('textarea[name=reply]').val();

			K.doAjax(parameter, url);
		}

		function removeIframe() {
			K.removeIframe();
		}
    </script>
</block>