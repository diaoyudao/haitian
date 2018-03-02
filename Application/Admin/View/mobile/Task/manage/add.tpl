<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    <link href="/public/css/task/select.css" rel="stylesheet" type="text/css"/>
</block>
<block name="body_main">
    <style>

    </style>
    <div class="body">
        <input type="hidden" name="task_id" value="{$Think.get.task_id}"/>
        <p class="title">创建人</p>
        <p class="content"><img src="{$task.director.thumbnail_url}" alt="">{$task.director.name}</p>
        <div class="row">
            <div class="col-md-4 title">创建时间</div>
            <div class="col-md-4 title" style="margin-left: 50px">截止时间</div>
        </div>
        <div class="row content">
            <div class="col-md-4">{$task.create_time|strtotime|date='m-d',###}</div>
            <div class="col-md-4" style="margin-left: 50px">{$task.end_date|strtotime|date='m-d',###}</div>
        </div>
        <p class="title">任务负责人</p>
        <div class="content">
            <volist name="task.handler" id="vv">
                <img src="{$vv.thumbnail_url}" alt="">{$vv.name}
            </volist>
        </div>
        <p class="title">任务内容</p>
        <p class="content">{$task.context}</p>
        <p class="title">任务完成情况</p>
        <textarea name="over_context" class="content"
                  style="width:100%;height:140px;resize:none;border: 1px solid #e0e0e0;"></textarea>
        <div class="preserve" onclick="finish()"><a>保存</a></div>
        <div class="cancel" onclick="removeIframe();"><a>取消</a></div>
        <div class="clear"></div>
    </div>
</block>

<block name="footer_js">
    <script>
		function finish() {
			var url = '/service/task/manage/change';
			var param = {};
			param.over_context = $('textarea[name=over_context]').val();
			param.task_id= $('input[name=task_id]').val();
			if (!param.over_context) {
				layer.msg("请输入任务完成情况!", {icon: 2, time: 1500});
				return false;
			}
			K.doAjax(param, url)

		}

		function removeIframe() {
			K.removeIframe();
		}
    </script>
</block>