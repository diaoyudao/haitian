<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
	<link href="/public/css/customer/search/info.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">

</block>

<block name="body_main">
	<style>
		.w-item{width: 100px}
	</style>
	<div class="body">
	    <form action="" method="post" id="add-form-post">
		<input name="customer_id" value="{$Think.get.customer_id}" type="hidden">
		<div style="display: inline-block;">
			<p class="title">客户名称</p>
			<div class="content"><input class="input_text" name="name" value="{$customer.name}" type="text"></div>
		</div>
		<div class="ml-20" style="display: inline-block;">
			<p class="title">客户分类</p>
			<div class="content">
				<select class="screen_department input_text w-item" name="type">
					<option value="1" <if condition="1 eq $customer['type']"> selected</if>>政府单位</option>
					<option value="2" <if condition="2 eq $customer['type']"> selected</if>>旅游景区</option>
					<option value="3" <if condition="3 eq $customer['type']"> selected</if>>国有企业</option>
					<option value="5" <if condition="5 eq $customer['type']"> selected</if>>民营企业</option>
					<option value="0" <if condition="0 eq $customer['type']"> selected</if>>其他</option>
					<option value="4" <if condition="4 eq $customer['type']"> selected</if>>海外客户</option>
				</select>
			</div>
		</div>
		<div class="ml-20" style="display: inline-block">
			<p class="title">普通/VIP</p>
			<div class="content">
				<select class="screen_department input_text w-item" name="is_vip">
					<option value="0" <if condition="'0' eq $customer['is_vip']"> selected</if>>普通客户</option>
					<option value="1" <if condition="'1' eq $customer['is_vip']"> selected</if>>VIP客户</option>					
				</select>
			</div>
		</div>
		<div class="ml-20" style="display: inline-block;">
				<p class="title">画册邮寄情况</p>
				<div class="content">
					<div class="radio-box " style="height: 37px;line-height: 37px;padding-left: 10px">
						<input name="is_send" type="checkbox" value="1" <if condition="!empty($employee) or $customer.is_send eq 1">checked</if>>
						<label class="ml-10" for="identity-1" style="color:#363636;font-weight: 300;">画册已邮寄</label>
					</div>	    
				</div>
			</div>

		<p class="title">所在地址</p>
		<div class="content">
			<select class="screen_department" name="temp_s">
				<option value="0" <if condition="'0' eq $customer['temp_s']"> selected</if>>中国</option>
			</select>
			<select class="screen_department" name="province_id" style="margin-left: 20px">
				<option value="">省</option>
				<volist name="province" id="item">
					<option value="{$item.province_id}" <if condition="$item['province_id'] eq $customer['province_id']"> selected</if>>{$item.province_name}</option>
				</volist>
			</select>
			<select class="screen_department" name="city_id" style="margin-left: 20px">
				<option value="">省级客户</option>
			  <notempty name="city">	
				<volist name="city" id="item">
					<option value="{$item.city_id}" <if condition="$item['city_id'] eq $customer['city_id']"> selected</if>>{$item.city_name}</option>
				</volist>
			  </notempty>
			</select>
			<select class="screen_department" name="county_id" style="margin-left: 20px">
				<option value="">市级客户</option>
			  <notempty name="county">	
				<volist name="county" id="item">
					<option value="{$item.county_id}" <if condition="$item['county_id'] eq $customer['county_id']"> selected</if>>{$item.county_name}</option>
				</volist>
			  </notempty>
			</select>
			<input class="input_text" type="text" value="{$customer.address}" name="address" placeholder="详细地址"  style="margin-left: 15px;width:180px;">
		</div>
		<p class="title">基本情况</p>
		<textarea  class="content" name="desc" style="width:100%;height:120px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;">{$customer.desc}</textarea>
		
		<div class="preserve mt-20"><button onclick="commit()" class="btn btn-primary radius" type="button">保存</button></div>
		<div class="cancel mt-20"><button onclick="removeIframe()" class="btn btn-default radius" type="button">取消</button></div>
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

	$('select[name=province_id]').change(function() {
				$p_id = $(this).val();
				var parameter={province_id: $p_id}
				var url = '/service/customer/search/getcity';
				K.doAjax(parameter, url, function(response) {
					if('success' == response.status) {
						var city = $('select[name=city_id]');
						city.empty()
						$('select[name=county_id]').empty()
						city.append('<option value="">省级客户</option>');
						$.each(response.data, function(i,v){
							city.append('<option value="' +v.city_id+ '">' +v.city_name+ '</option>');
						})
					}			
				});
			})

			$('select[name=city_id]').change(function() {
				var county = $('select[name=county_id]');
				county.empty()
				$p_id = $(this).val();
				var parameter={city_id: $p_id}
				var url = '/service/customer/search/getcounty';
				K.doAjax(parameter, url, function(response) {
					if('success' == response.status) {
						
						county.append('<option value="">市级客户</option>');
						$.each(response.data, function(i,v){
							county.append('<option value="' +v.county_id+ '">' +v.county_name+ '</option>');
						})
					}			
				});
			})


})	
		function removeIframe() {
			K.removeIframe();
		}
		function commit() {
			if($("input[name='name']").val()==""){
				console.log("客户名称");
				layer.msg('客户名称!', {icon: 2, time: 2000});
				return;
			}else if($("select[name='type']").val()==null){
				console.log("请选择客户分类");
				layer.msg('请选择客户分类!', {icon: 2, time: 2000});
				return;
			}else if($("select[name='is_vip']").val()==null){
				console.log("请选择客户级别");
				layer.msg('请选择客户级别!', {icon: 2, time: 2000});
				return;
			}else if($("select[name='temp_s']").val()==null){
				console.log("请选择所在地址");
				layer.msg('请选择所在地址!', {icon: 2, time: 2000});
				return;
			}

			if("4" != $("select[name='type']").val() && "" == $("select[name=province_id]").val()) {
				layer.msg('请选择省份!', {icon: 2, time: 2000});
				return;
			}
			console.log("--------------------------");

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