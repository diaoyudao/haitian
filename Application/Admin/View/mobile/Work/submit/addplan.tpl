<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    <link href="/public/css/work/submit/addplan.css" rel="stylesheet" type="text/css" />
</block>

<block name="body_main">
<style>

</style>
<div class="body">
	<p class="title">本周工作计划</p>
	<textarea  class="content" style="width:100%;height:140px;resize:none;border: 1px solid #e0e0e0;"></textarea>
	<p class="title">完成情况</p>
	<div class="content">
		<div style="display: inline-block;">
		    <form action="" style="display: inline-block;">
			    <label class="lsglabel"><input name="Fruit" type="radio" value="已完成" onclick="displayResult();" /> 已完成</label> 
			    <label class="lsglabel"><input name="Fruit" type="radio" value="未完成" onclick="displayResult();"/> 未完成</label>
		    </form> 
	    </div>
	    <div style="display: inline-block;">
			<input class="input_text" type="text" placeholder="描述未完成的原因">	
	    </div>
	</div>

	<div class="preserve"><a>保存</a></div>
	<div class="cancel" onclick="removeIframe();"><a>取消</a></div>
	<div class="clear"></div>
	</div>

</div>
</block>

<block name="footer_js">
<script>
function displayResult(){
	var radios = document.getElementsByName('Fruit');
	for (var i = 0; i < radios.length; i++) {
		if (radios[i].checked) {
			if(radios[i].value=="未完成"){
				$(".input_text").show();
			}else{
				$(".input_text").hide();
			}
			break;
		}
	}
}
</script>
</block>