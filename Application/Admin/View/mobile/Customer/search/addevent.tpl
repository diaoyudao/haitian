<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
	<link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap-datetimepicker.min.css">
	<link href="/public/css/customer/search/addevent.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">

</block>

<block name="body_main">
	<style>
		
	</style>
	<div class="body">
	  <form action="" method="post" id="add-form-post">
	    <input type="hidden" name="customer_event_id" value="{$event.customer_event_id}"/>
	    <input type="hidden" name="customer_id" value="{$customer_id}"/>
		<p class="title">时间</p>
		<div class="content">
			<div class="form-group">
				<div class="input-group date form_date" data-date="" data-date-format="dd MM yyyy" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
					<input class="form-control" size="16" type="text" name="occur_time" value="{$event.occur_time}" readonly style="background-color: #fff;border: 1px solid #e0e0e0;" placeholder="时间">
					<span class="input-group-addon" style="background-color: #fff;border: 1px solid #e0e0e0;"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon" style="background-color: #fff;border: 1px solid #e0e0e0;"><span class="glyphicon glyphicon-calendar"></span></span>
				</div>
			</div>
		</div>	
		<p class="title">基本情况</p>
		<textarea  class="content" name="context" style="width:100%;height:140px;resize:none;border: 1px solid #e0e0e0;">{$event.context}</textarea>
		<div class="preserve"><button onclick="commit()" class="btn btn-primary radius" type="button">添加</button></div>
		<div class="cancel"><button onclick="removeIframe()" class="btn btn-default radius" type="button">取消</button></div>
		<div class="clear"></div>
	  </form>
	</div>
</block>

<block name="footer_js">
	<script type="text/javascript" src="/public/bootstrap-time/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/public/bootstrap-time/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/public/bootstrap-time/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="/public/bootstrap-time/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<script>
		$('.form_date').datetimepicker({
			language:  'zh-CN',
			weekStart: 1,
			todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0,
			format: 'yyyy-mm-dd',
		});
		function removeIframe() {
			K.removeIframe();
		}
		function commit() {
			if ($('input[name=customer_event_id]').val()) {
				var url = '/service/customer/manage/changeEvent';
			} else {
				var url = '/service/customer/manage/addEvent';
			}

			K.doAjaxSubmit('#add-form-post', url, function(response) {
				if (response.status && response.status == 'success') {
					K.refreshParent()
	            } else {
	            	if (response.message) {
	            		layer.msg(response.message, {icon: 2, time: 2000});
	            	} else {
	            		layer.msg('后台错误!', {icon: 2, time: 2000});
	            	}
	            }
	        });
		}     
	</script>
</block>