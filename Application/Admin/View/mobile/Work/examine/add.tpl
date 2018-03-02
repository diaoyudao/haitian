<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
	<link href="/public/css/work/examine/add.css" rel="stylesheet" type="text/css" />
</block>
<block name="body_main">
<style>
	
</style>
<div class="body">
	<p class="title">批复</p>
	<textarea  class="content" style="width:100%;height:140px;resize:none;border: 1px solid #e0e0e0;"></textarea>
	<div class="preserve"><a>保存</a></div>
	<div class="cancel" onclick="removeIframe();"><a>取消</a></div>
	<div class="clear"></div>
</div>
</block>
<block name="footer_js">
<script>
		function removeIframe() {
            K.removeIframe();
        }
</script>
</block>