<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
	<link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap-datetimepicker.min.css">
	<link href="/public/css/customer/search/addliaison.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">

</block>

<block name="body_main">
	<style>
		.w-item{
			width:140px;
			height: 37px;
			line-height: 37px;
		}

	</style>
	<div class="body">

	  <form action="" method="post" id="add-form-post">
	    <input type="hidden" name="customer_liaison_id" value="{$data.customer_liaison_id}"/>
	    <input type="hidden" name="customer_id" value="{$customer_id}"/>
		<div class="mt-20" style="overflow: hidden;">
			<div style="float: left;">
				<p class="title">时间</p>
				<div class="content">
					<div class="form-group">
						<div class="input-group date form_date day_datetime" data-link-format="yyyy-mm-dd" data-date-format="dd MM yyyy" >
							<input class="input_text" size="16" type="text" name="liaison_time" value="{$data.liaison_time}" readonly>
							<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
							<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
						</div>
						<input type="hidden" id="dtp_input1" value="" /><br/>
					</div>
				</div>
			</div>
			<div style="float: left;margin-left: 20px;">
				<p class="title">相关事宜</p>
				<div class="content">
					<input class="input_text w-item" size="30" type="text" name="outline" value="{$data.outline}">		
				</div>
			</div>

			<div style="float: left;margin-left: 20px;">
				<p class="title">联络人</p>
				<div class="content">					
					<select class="screen_department input_text w-item" name="customer_contact_id">
						<option value="">选择联络人</option>
						<volist name="contact" id="item">
						<option value="{$item.customer_contact_id}" <if condition="$item['customer_contact_id'] eq $data['customer_contact_id']"> selected</if>>{$item.name}，{$item.department}</option>
						</volist>
					</select>
				</div>
			</div>
			<div style="float: left;margin-left: 20px;">
				<p class="title">联络结果</p>
				<div class="content w-item">
						<label style="font-weight: initial;" class="lsglabel"><input name="status" type="radio" value="1" <if condition="'0' neq $data['status']"> checked</if> style="margin: 0" />成功 </label> 
						<label style="font-weight: initial;" class="lsglabel"><input name="status" type="radio" value="0" <if condition="'0' eq $data['status']"> checked</if> style="margin: 0" />失败 </label>
				</div>
			</div>
			<div class="clear"></div>
		</div>		
		<p class="title">联络内容</p>
		<textarea  class="content" name="context" style="width:100%;height:120px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;">{$data.context}</textarea>
		<div class="mt-20">
			<div class="" style="display:inline-block">
				<p class="title">下次联络</p>
				<div class="content">
					<div class="form-group">
						<div class="input-group date form_date next_datetime" >
							<input class="input_text" size="16" type="text" name="next_time" value="{$data.next_time}" readonly>
							<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
							<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
						</div>
						<input type="hidden" id="dtp_input1" value="" />
					</div>
				</div>
			</div>
			<div class="ml-20" style="display:inline-block">
				<p class="title">其他</p>
				<div class="content ">
					<label for="important" style="color:#363636;font-weight: 300;"><input name="important" id="important" type="checkbox" value="1" <if condition="1 eq $data['important']"> checked</if> style="margin:0;margin-left: 10px;margin-right: 5px;">标记重要<img src="/public/img/test/u8862.png" alt=""></label>		
					<if condition="'boss' != session('employee.role_type_code')">	
					<label for="is_export" style="color:#363636;font-weight: 300;"><input name="is_export" id="is_export" type="checkbox" value="1" style="margin:0;margin-left: 10px;margin-right: 5px;" <if condition="1 eq $data['is_export']"> checked</if>>加入周报</label>
					</if>
				</div>	
			</div>
		</div>
		<if condition="'director' == session('employee.role_type_code')">	
		<p class="title mt-20">批复</p>		
		<textarea  class="content" name="reply" style="width:100%;height:120px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;">{$data.reply}</textarea>
		</if>
		<div class="preserve"><button onclick="commit()" class="btn btn-primary radius" type="button">保存</button></div>
		<div class="cancel"><button onclick="removeIframe()" class="btn btn-default radius" type="button">取消</button></div>
		<div class="clear"></div>
	  </form>
	</div>
</block>

<block name="footer_js">
	<!-- <script type="text/javascript" src="/public/bootstrap-time/js/jquery-1.8.3.min.js"></script> -->
	<script type="text/javascript" src="/public/bootstrap-time/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/public/bootstrap-time/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="/public/bootstrap-time/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<script>
		$(function(){

			$(".day_datetime").datetimepicker({
				language: 'zh-CN',
				 weekStart: 1,  
		         autoclose: true,  
		         startView: 2,  
		         minView: 2,  
		         forceParse: false, 
				format: 'yyyy-mm-dd',
				endDate: '<php>echo date('Y-m-d');</php>',
			}).on('changeDate',gotoDate); 

			$(".next_datetime").datetimepicker({
				language: 'zh-CN',
				weekStart: 1,  
		         autoclose: true,  
		         startView: 2,  
		         minView: 2,  
		         forceParse: false,
				format: 'yyyy-mm-dd',
				startDate: '<php>echo date('Y-m-d');</php>',
			}).on('changeDate',gotoDate);
		})
		function gotoDate(){
			$('.form_date').datetimepicker('hide');
        }
		
		function removeIframe() {
			K.removeIframe();
		}

		function commit() {
			if($("input[name='liaison_time']").val()==""){
				console.log("请填写时间");
				layer.msg('请填写时间!', {icon: 2, time: 2000});
				return;
			}

			if ($('input[name=customer_liaison_id]').val()) {
				var url = '/service/customer/manage/changeLiaison';
			} else {
				var url = '/service/customer/manage/addLiaison';
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