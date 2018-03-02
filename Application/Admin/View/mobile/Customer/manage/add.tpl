<extend name="./Application/Admin/View/default/base/context/common.tpl"/>
<block name="common_css">
	<link href="/public/css/customer/manage/add.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">
</block>

<block name="body_path_name">
	创建客户
</block>

<block name="body_main">
	<style>
		

	</style>
	<div class="body">
		<form action="" method="post" id="add-form-post">
			
			<p class="title">客户名称</p>
			<p class="content"><input class="input_text" name="name" type="text"></p>
			<div style="display: inline-block;">
				<p class="title">客户分类</p>
				<div class="content">
					<select class="screen_department" name="type">
						<option value="1">政府单位</option>
						<option value="2">旅游景区</option>
						<option value="3">企业公司</option>
						<option value="0">其他</option>
						<option value="4">海外客户</option>
					</select>
				</div>
			</div>
			<div style="display: inline-block;margin-left: 20px; ">
				<p class="title">客户级别</p>
				<div class="content">
					<select class="screen_department" name="level">
						<option value="Z">普通客户</option>
						<option value="A">A级客户</option>
						<option value="B">B级客户</option>
						<option value="C">C级客户</option>
					</select>
				</div>
			</div>

			<p class="title">所在地址</p>
			<div class="content">
				<select class="screen_department" name="temp_s">
					<option value="0">中国</option>
				</select>
				<select class="screen_department" name="province_id" style="margin-left: 20px">
					<option value="">省</option>
					<volist name="province" id="item">
						<option value="{$item.province_id}">{$item.province_name}</option>
					</volist>
				</select>
				<select class="screen_department" name="city_id" style="margin-left: 20px">
					<option value="">市</option>
				</select>
				<select class="screen_department" name="county_id" style="margin-left: 20px">
					<option value="">区/县</option>
				</select>
				<input class="input_text" type="text" name="address" placeholder="详细地址"  style="margin-left: 20px">
			</div>
			<p class="title">基本情况</p>
			<textarea  class="content" name="desc" style="width:100%;height:140px;resize:none;border: 1px solid #e0e0e0;"></textarea>
			<p class="title">画册邮寄情况</p>
			<div class="content">
				<div class="radio-box">
					<input name="is_send" type="checkbox" value="1" id="identity-1"
					<if condition="!empty($employee) or $employee.is_send eq 1">checked</if>
					>
					<label class="ml-10" for="identity-1" style="color:#363636;font-weight: 300;">画册已邮寄</label>
				</div>	    
			</div>
			<p class="title">负责部门</p>
			<div class="content">
				<input class="input_text" type="text" style="margin-left: 20px" value="{$Think.session.employee.department_name}" disabled="disabled" />		
			</div>	
			
			<div class="preserve"><button onclick="commit()" class="btn btn-primary radius" type="button">保存</button></div>
			<div class="clear"></div>
		</div>
	</form> 
</div>
</block>

<block name="footer_js">
	<script type="text/javascript">
		$(function() {
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

			$('select[name=province_id]').change(function() {
				$p_id = $(this).val();
				var parameter={province_id: $p_id}
				var url = '/service/customer/search/getcity';
				K.doAjax(parameter, url, function(response) {
					if('success' == response.status) {
						var city = $('select[name=city_id]');
						city.empty()
						city.append('<option value="">市/县</option>');
						$.each(response.data, function(i,v){
							city.append('<option value="' +v.city_id+ '">' +v.city_name+ '</option>');
						})
					}			
				});
			})

			$('select[name=city_id]').change(function() {
				$p_id = $(this).val();
				var parameter={city_id: $p_id}
				var url = '/service/customer/search/getcounty';
				K.doAjax(parameter, url, function(response) {
					if('success' == response.status) {
						var county = $('select[name=county_id]');
						county.empty()
						county.append('<option value="">区/县</option>');
						$.each(response.data, function(i,v){
							county.append('<option value="' +v.county_id+ '">' +v.county_name+ '</option>');
						})
					}			
				});
			})

		})

		function commit() {
			if("4" != $("select[name='type']").val()) {
				layer.msg('请选择省份!', {icon: 2, time: 2000});
				return;
			}
			
			var parameter = {};

			if ($('input[name=customer_id]').val()) {
				var url = '/service/customer/manage/change';
				parameter.news_id = $('input[name=department_id]').val();
			} else {
				var url = '/service/customer/manage/add';
			}

			K.doAjaxSubmit('#add-form-post', url, function(response) {
				if (response.status && response.status == 'success') {
					layer.msg('保存成功!', {icon: 1, time: 2000});
                //K.removeIframe();
	            } else {
	            	if (response.message) {
	            		layer.msg(response.message, {icon: 2, time: 2000});
	            	} else {
	            		layer.msg('后台错误!', {icon: 2, time: 2000});
	            	}
	            }
	        });
		}     

		function Weekly(){
			layer_show("周报",'/service/work/submit/weekly', 750, 700);
		}


		

	</script>
</block>