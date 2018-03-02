<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
	<link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap-datetimepicker.min.css">
	<link href="/public/css/customer/search/addtiming.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">

</block>

<block name="body_main">
	<style>
		
	</style>
	<div class="body">
		<div style="overflow: hidden;">
			<div style="float: left;">
				<p class="title">提醒时间时间</p>
				<div class="content">
					<div class="form-group">
						<div class="input-group date form_datetime"   >
							<input class="form-control" size="16" type="text" value="" readonly>
							<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
							<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
						</div>
						<input type="hidden" id="dtp_input1" value="" /><br/>
					</div>
				</div>
			</div>
			<div style="float: left;margin-left: 20px;">
				<p class="title">提醒人员</p>
				<div class="content">
					<select class="screen_department" name="level">
						<option value="Z">业务部周瑜</option>
						<option value="A">业务部周瑜111</option>
					</select>
				</div>
			</div>

			<div style="float: left;margin-left: 20px;">
				<p class="title">联络客户</p>
				<div class="content">
					<select class="screen_department" name="level">
						<option value="Z">张辽，办公室主任</option>
						<option value="A">张辽，办公室主任12</option>
					</select>
				</div>
			</div>
		</div>
		<p class="title">提醒内容</p>
		<textarea  class="content" name="desc" style="width:100%;height:140px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;"></textarea>
		
		<div class="preserve"><button onclick="" class="btn btn-primary radius" type="button">保存</button></div>
		<div class="cancel"><button onclick="removeIframe()" class="btn btn-default radius" type="button">取消</button></div>
		<div class="clear"></div>
	</div>
</block>

<block name="footer_js">
	<script type="text/javascript" src="/public/bootstrap-time/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/public/bootstrap-time/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/public/bootstrap-time/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="/public/bootstrap-time/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<script>
		$(function(){
			$('.form_datetime').datetimepicker({
				format: 'yyyy-mm-dd - HH:ii p',
				weekStart: 1,
				todayBtn:  1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				forceParse: 0,
				showMeridian: 1,
				minuteStep : 1
			}); 
		})
		
		function removeIframe() {
			K.removeIframe();
		}
	</script>
</block>