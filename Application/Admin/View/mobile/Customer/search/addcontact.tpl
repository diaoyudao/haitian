<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
	<link href="/public/css/customer/search/addcontact.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">

</block>

<block name="body_main">
	<style>
		
	</style>
	<div class="body">
	  <form action="" method="post" id="add-form-post">
	  	<input type="hidden" name="customer_contact_id" value="{$contact.customer_contact_id}">
	  	<input type="hidden" name="customer_id" value="{$Think.get.id}">
	  	<input type="hidden" name="birthday" value="">
		<p class="title">客户名称</p>
		<p class="content"><input class="input_text" name="name" type="text"></p>
		<p class="title">职位</p>
		<p class="content" style="display: inline-block;"><input class="input_text" name="position" type="text" placeholder="如'主任'、'总经理'"></p>
		<p class="title">性别</p>
		<div class="content">
				<label class="lsglabel"><input name="sex" type="radio" value="1" />男 </label> 
				<label class="lsglabel"><input name="sex" type="radio" value="2" />女 </label>
		</div>
		<p class="title">决策链</p>
		<div class="content">
			<select name="function" class="screen_department">
				<option value="1">决策人</option>
				<option value="2">负责人</option>
				<option value="3">经办人</option>
				<option value="4">其他</option>
			</select>
		</div>
		<p class="title">生日</p>
		<p class="content" style="width: 140px;border: 1px solid #e0e0e0;display: inline-block;"><input style="width: 100px;border: none" class="input_text" name="month" type="number" min="1" max="12" value="1">月</p>
		<p class="content" style="width: 140px;border: 1px solid #e0e0e0;display: inline-block;"><input style="width: 100px;border: none" class="input_text" name="day" type="number" min="1" max="31" value="1">日</p>
		<div class="radio-box" style="position: absolute;margin-top: 18px;padding:0;">
			<label for="identity-1" style="color:#363636;font-weight: 300;"><input name="is_remind" type="checkbox" value="1" style="margin:0;margin-left: 10px;margin-right: 5px;">生日提醒</label>
		</div>
		<p class="title">联系电话</p>
		<p class="content"><input class="input_text" name="tel" type="text"></p>
		<p class="title">微信</p>
		<p class="content"><input class="input_text" name="weixin" type="text"></p>
		<p class="title">QQ</p>
		<p class="content"><input class="input_text" name="qq" type="text"></p>
		<p class="title">Email</p>
		<p class="content"><input class="input_text" name="email" type="text"></p>
		<div class="preserve"><button onclick="commit()" class="btn btn-primary radius" type="button">保存</button></div>
		<div class="cancel"><button onclick="removeIframe()" class="btn btn-default radius" type="button">取消</button></div>
		<div class="clear"></div>
	  </form>
	</div>
</block>

<block name="footer_js">
	<script>
		function removeIframe() {
			K.removeIframe();
		}

		function commit() {
            console.log('dddddd');
            if("" == $('input[name=customer_contact_id]').val()) {
            	var url = '/service/customer/manage/addContact';
            } else {
            	var url = '/service/customer/manage/changeContact';
            }
            var m = $('input[name=month]').val()
            var d = $('input[name=day]').val()
            var str = (m<10? ('0'+m) :m) + '-' + (d<10? ('0'+d) :d);
            $('input[name=birthday]').val(str)
            
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