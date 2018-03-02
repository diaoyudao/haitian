<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
	<link href="/public/css/customer/search/info.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">

</block>

<block name="body_main">
	<style>
		
	</style>
	<div class="body">
	    <form action="" method="post" id="add-form-post">
		<input name="customer_id" value="{$Think.get.customer_id}" type="hidden">
		<p class="title">客户名称</p>
		<p class="content"><input class="input_text" name="name" value="{$customer.name}" type="text"></p>
		<div style="display: inline-block;">
			<p class="title">客户分类</p>
			<div class="content">
				<select class="screen_department" name="type">
					<option value="1" <if condition="1 eq $customer['type']"> selected</if>>政府单位</option>
					<option value="2" <if condition="2 eq $customer['type']"> selected</if>>旅游景区</option>
					<option value="3" <if condition="3 eq $customer['type']"> selected</if>>企业公司</option>
					<option value="0" <if condition="0 eq $customer['type']"> selected</if>>其他</option>
					<option value="4" <if condition="4 eq $customer['type']"> selected</if>>海外客户</option>
				</select>
			</div>
		</div>
		<div style="display: inline-block;margin-left: 20px; ">
			<p class="title">客户级别</p>
			<div class="content">
				<select class="screen_department" name="level">
					<option value="Z" <if condition="'Z' eq $customer['level']"> selected</if>>普通客户</option>
					<option value="A" <if condition="'A' eq $customer['level']"> selected</if>>A级客户</option>
					<option value="B" <if condition="'B' eq $customer['level']"> selected</if>>B级客户</option>
					<option value="C" <if condition="'C' eq $customer['level']"> selected</if>>C级客户</option>
				</select>
			</div>
		</div>

		<p class="title">所在地址</p>
		<div class="content">
			<select class="screen_department" name="temp_s">
				<option value="0" <if condition="'0' eq $customer['is_abroad']"> selected</if>>中国</option>
			</select>
			<select class="screen_department" name="province_id" style="margin-left: 20px">
				<option value="">省</option>
				<volist name="province" id="item">
					<option value="{$item.province_id}" <if condition="$item['province_id'] eq $customer['province_id']"> selected</if>>{$item.province_name}</option>
				</volist>
			</select>
			<select class="screen_department" name="city_id" style="margin-left: 20px">
				<option value="">市/县</option>
				<volist name="city" id="item">
					<option value="{$item.city_id}" <if condition="$item['city_id'] eq $customer['city_id']"> selected</if>>{$item.city_name}</option>
				</volist>
			</select>
			<input class="input_text" type="text" value="{$customer.address}" name="address" placeholder="详细地址"  style="margin-left: 20px">
		</div>
		<p class="title">基本情况</p>
		<textarea  class="content" name="desc" style="width:100%;height:140px;resize:none;border: 1px solid #e0e0e0;">{$customer.desc}</textarea>
		<div class="content">
			<div class="radio-box">
				<input name="is_send" type="checkbox" value="1" <if condition="!empty($employee) or $customer.is_send eq 1">checked</if>>
				<label class="ml-10" for="identity-1" style="color:#363636;font-weight: 300;">画册已邮寄</label>
			</div>	    
		</div>

		<div class="preserve"><button onclick="commit()" class="btn btn-primary radius" type="button">保存</button></div>
		<div class="cancel"><button onclick="removeIframe()" class="btn btn-default radius" type="button">取消</button></div>
		<div class="clear"></div>
		</form>
	</div>
</div>

</block>

<block name="footer_js">

	<script>
$(function(){
	$('select[name=type]').change(function() {
		if('4' == $(this).val()) {
			$('select[name=temp_s]').hide();
			$('select[name=province_id]').hide();
			$('select[name=city_id]').hide();
			$('select[name=county_id]').hide();
		} else {
			$('select[name=temp_s]').show();
			$('select[name=province_id]').show();
			$('select[name=city_id]').show();
			$('select[name=county_id]').show();
		}
	})

	if('4' == $('select[name=type]').val()) {
			$('select[name=temp_s]').hide();
			$('select[name=province_id]').hide();
			$('select[name=city_id]').hide();
			$('select[name=county_id]').hide();
	}
})	
		function removeIframe() {
			K.removeIframe();
		}
		function commit() {
			if("4" != $("select[name='type']").val()) {
				layer.msg('请选择省份!', {icon: 2, time: 2000});
				return;
			}
			
			var url = '/service/customer/manage/change';
			 K.doAjaxSubmit('#add-form-post', url, function(response) {
				if (response.status && response.status == 'success') {
					K.refreshParent();
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