<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    <link href="/public/css/work/submit/addsummary.css" rel="stylesheet" type="text/css" />
</block>

<block name="body_main">
<style>

</style>
<div class="body">
	<p class="title">工作内容</p>
	<p class="content"><input class="input_text" type="text"></p>
	<p class="title">备注</p>
	<p class="content"><input class="input_text" type="text"></p>
	<div class="preserve"><a>保存</a></div>
	<div class="cancel" onclick="removeIframe();"><a>取消</a></div>
	<div class="clear"></div>
	</div>

</div>
</block>

<block name="footer_js">
</block>