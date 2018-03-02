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
		.w-item{width: 100px}

	</style>
	<div class="body">
		<form action="" method="post" id="add-form-post">
			<div style="display: inline-block;">
				<p class="title">客户名称</p>
				<div class="content"><input class="input_text" name="name" type="text"></div>
			</div>
			<div class="ml-20" style="display: inline-block;">
				<p class="title">客户分类</p>
				<div class="content">
					<select class="screen_department input_text w-item" name="type">
						<option value="1">政府单位</option>
						<option value="2">旅游景区</option>
						<option value="3">国有企业</option>
						<option value="5">民营企业</option>
						<option value="0">其他</option>
						<option value="4">海外客户</option>
					</select>
				</div>
			</div>
			<div style="display: inline-block;margin-left: 20px; ">
				<p class="title">普通/VIP</p>
				<div class="content">
					<select class="screen_department input_text w-item" name="is_vip">
						<option value="0">普通客户</option>
						<option value="1">VIP客户</option>
					</select>
				</div>
			</div>
			<div class="ml-20" style="display: inline-block;">
				<p class="title">画册邮寄情况</p>
				<div class="content">
					<div class="radio-box " style="height: 37px;line-height: 37px;padding-left: 10px">
						<input name="is_send" type="checkbox" value="1" id="identity-1"
						<if condition="!empty($employee) or $employee.is_send eq 1">checked</if>
						>
						<label class="ml-10" for="identity-1" style="color:#363636;font-weight: 300;">画册已邮寄</label>
					</div>	    
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
			<textarea  class="content" name="desc" style="width:100%;height:120px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;"></textarea>			
			<p class="title">负责部门</p>
			<div class="content">
				<if condition="'boss' != session('employee.role_type_code')">
				<input class="input_text" type="text" style="margin-left: 20px" value="{$Think.session.employee.department_name}" disabled="disabled" />
				<else/>
				  <select class="screen_department" name="department_id">
				  	<option value="">请选择部门</option>
				  	<volist name="department" id="item">
					<option value="{$item.department_id}">{$item.name}</option>
					</volist>
				  </select>
				  <select class="screen_department ml-20" name="employee_id">
					
				  </select>
				</if>		
			</div>	
			
			<div class="title pt-20">
			<button onclick="commit(0)" class="btn btn-primary radius" type="button">保存</button>
			<button onclick="commit(1)" class="btn btn-primary radius ml-20" type="button">保存并添加联系人</button>
			<button onclick="commit(2)" class="btn btn-primary radius ml-20" type="button">保存并添加大事件</button>
			<button onclick="commit(3)" class="btn btn-primary radius ml-20" type="button">保存并添加项目</button>
			</div>
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
						$('select[name=county_id]').empty()
						city.append('<option value="">省级客户</option>');
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
						county.append('<option value="">市级客户</option>');
						$.each(response.data, function(i,v){
							county.append('<option value="' +v.county_id+ '">' +v.county_name+ '</option>');
						})
					}			
				});
			})

			$('select[name=department_id]').change(function(){
				var $p_id = $(this).val();
				var parameter={department_id: $p_id,role:'director'}
				var url = '/service/employee/department/employee';
				K.doAjax(parameter, url, function(response) {
					if('success' == response.status) {
						var county = $('select[name=employee_id]');
						county.empty()
						
						$.each(response.data, function(i,v){
								county.append('<option value="' +v.employee_id+ '">' +v.name+ '</option>');
						})
					}			
				});
			}) 

		})

		function checkParam() {
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

			if('boss' == '{$Think.session.employee.role_type_code}') {
			    if("" ==$("select[name='department_id']").val() 
			    	|| !$("select[name='employee_id']").val() 
			    	|| "" == $("select[name='employee_id']").val()){
					layer.msg('请选择负责部门和主任!', {icon: 2, time: 2000});
					return;
				}
			}

			if("4" != $("select[name=type]").val() && "" == $("select[name=province_id]").val()) {
				layer.msg('请选择省份!', {icon: 2, time: 2000});
				return;
			}

			return true;
		}

		var $customer_id = null;

		function commit(tt) {
			if(true != checkParam()) {
				return;
			}
			console.log("--------------------------"); // /service/customer/manage/addcontact?ns=1&id={$data.customer_id}

			if($customer_id) {
				if(1 == tt) {
					layer_show('添加联系人','/service/customer/manage/contactsort?ns=1&id='+$customer_id, 620, 550);
				} else if(2 == tt) {
					layer_show('添加大事件','/service/customer/search/addevent?ns=1&id='+$customer_id, 650, 450);
				} else if(3 == tt) {
					layer_show('添加项目','/service/customer/search/addproject?ns=1&id='+$customer_id, 800, 550);
				}
				return;
			}
			
			if ($('input[name=customer_id]').val()) {
				var url = '/service/customer/manage/change';
			} else {
				var url = '/service/customer/manage/add';
			}

			K.doAjaxSubmit('#add-form-post', url, function(response) {
				if (response.status && response.status == 'success') {
					$customer_id = response.customer_id;
					if(1 == tt) {
						layer_show('添加联系人','/service/customer/manage/contactsort?ns=1&id='+$customer_id, 620, 550);
					} else if(2 == tt) {
						layer_show('添加大事件','/service/customer/search/addevent?ns=1&id='+$customer_id, 650, 450);
					} else if(3 == tt) {
						layer_show('添加项目','/service/customer/search/addproject?ns=1&id='+$customer_id, 800, 550);
					} else {
						layer.msg('保存成功!', {icon: 1, time: 2500});
						setTimeout("location.replace(location.href)", 2500)
					}
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