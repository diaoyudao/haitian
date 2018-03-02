<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">

</block>
<block name="common_js">

</block>

<block name="body_main">
	<style>
		.body{
			padding: 20px;
			padding-top: 0;
			overflow: hidden;
			/*margin-left: 10px;*/
			background-color: #fff;
			/*margin-right: 10px;*/
		}
		img{
			width: 32px;
			height:32px;
			margin-right:10px;
		}

		.title{
			color: #363636;
			font-size: 13px;
			margin-top:20px;
		}
		.content{
			font-size: 13px;
			margin-top:10px;
		}

		.preserve,
		.cancel{
			margin-top:40px;
			/*width: 	70px;*/
			/*height:30px;*/
			border-radius: 4px;
			color: #fff;
			font-size: 13px;
			line-height: 30px;
			text-align: center;
			cursor:pointer;
			float:left;
		}
		.cancel{
			margin-left: 20px;
		}
		.clear{
			clear: both;
		}
	</style>
	<div class="body">
		<p></p>
		<div class="preserve"><button onclick="" class="btn btn-primary radius" type="button">保存</button></div>
		<div class="cancel"><button onclick="removeIframe()" class="btn btn-default radius" type="button">取消</button></div>
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