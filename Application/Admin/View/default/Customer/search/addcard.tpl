<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
	<link href="/public/bootstrap-3.3.7/css/bootstrap.css" rel="stylesheet" type="text/css" />
	<link href="/public/css/customer/search/addcard.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">

</block>

<block name="body_main">
	<style>
		.quit_box{
			display: none
		}
		.glyphicon-exclamation-sign{
			font-size: 80px;
			color: #FF6633;
		}
		.quit_box p{
			text-align: center;
			margin-top: 25px;
		}
		.quit_box p input{
			margin-right: 5px;
			margin-top: -2px;
		}
		.head{
			/*margin-right: 20px;*/
		}
	</style>
	<div class="body">
		<div class="card_box">
			<div style="padding-bottom: 30px;border-bottom: 1px solid #e0e0e0;">
				<img class="head" src="{$data.thumbnail_url}" alt="">
				<div class="" style="display: inline-block;">
					<p><span>{$data.name|default="未知姓名"}</span><span style="color:#3399CC;margin-left: 10px;">{$data.department}</span></p>
					<p class="content" style="display: inline-block;">{$data.position}，<php>echo C('CONTACT_FUNCTION')[$data['function']];</php><if condition="'0'==$data['status']">（已离职）</if></p>
					<input class="btn btn-default radius" type="button" onclick="goChange()" value="修改资料"  style="font-size: 13px;margin-top: -17px;margin-left: 134px;">
					<eq name="data.status" value="1">
						<input class="btn btn-default radius" type="button" value="设置离职" style="font-size: 13px;float: right;margin-top: 3px;margin-left: 15px;" onclick="Quit()">
						<else/>
						<input class="btn btn-default radius" type="button" value="设置复职" style="font-size: 13px;float: right;margin-top: 3px;margin-left: 15px;" onclick="Quit()">

					</eq>
					<p class="content"><img src="/public/img/info/u8616.png" alt="" class="icon">{$data.birthday}</p>
					<div style="margin-top: 20px">
						<p class="icon_p" ><i class="Hui-iconfont c-999 icon" style="font-size:20px;margin-right: 10px;">&#xe696;</i>{$data.phone}</p>
					</div>
					<div style="margin-top: 20px">
						<p class="icon_p" ><img src="/public/img/info/u5922.png" alt="" class="icon">{$data.tel}</p>
					</div>
					<div style="margin-top: 20px">
						<p class="icon_p"><img src="/public/img/info/u5912.png" alt="" class="icon">{$data.qq}</p>
					</div>
					<div style="margin-top: 20px">
						<p class="icon_p" ><img src="/public/img/info/u5914.png" alt="" style="margin-left: -6px;margin-right: 5px;">{$data.weixin}</p>
					</div>
					<div style="margin-top: 20px">
						<p class="icon_p"><img src="/public/img/info/u5924.png" alt="" class="icon">{$data.email}</p>
					</div>
				</div>
			</div>
			<div>
				<p style="display: inline-block;width: 90px;padding-left: 10px;float: left;margin-top: 20px;">资料备注</p>
				<div style="display: inline-block;width: 455px;">
					<textarea  class="content" name="desc" style="width:100%;height:120px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;margin-top: 20px;">{$data.note}</textarea>
				</div>
			</div>
		</div>
		<div class="quit_box">
			<p><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span></p>
			<eq name="data.status" value="1">
			<p>该操作将设置联系人状态为已离职，请确认。</p>
				<else/>
				<p>该操作将设置联系人回到原有部门，请确认！</p>
			</eq>
			<p><label for="event"><input id="event" name="event" type="checkbox" value="" /><span>记录到客户大事件</span></label></p>
			<div class="preserve" style="margin-left: 155px;"><button style="width: 70px;" class="btn btn-primary radius" type="button" <eq name="data.status" value="1"> onclick="leave()"<else/>onclick="back()"</eq>>确认</button></div>
			<div class="cancel" style="margin-left: 100px;"><button style="width: 70px;" onclick="removeIframe()" class="btn btn-default radius" type="button">点错了</button></div>
			<div class="clear"></div>
		</div>
		

		
	</div>
</block>

<block name="footer_js">
	<script>
		function removeIframe() {
			$(".quit_box").hide();
			$(".card_box").show();
		}
		function Quit(){
			$(".quit_box").show();
			$(".card_box").hide();
		}
		function goChange() {
			window.location.href="/service/customer/search/changeContact?contact_id={$data.customer_contact_id}"
		}
		function leave() {
			console.log(12345)
			var e = $('input[name=event]').is(':checked');
			console.log(e)

			var param = {
				is_event: (e ? 1 : 0),
				customer_contact_id: '{$data.customer_contact_id}'
			}
			var url = '/service/customer/manage/leave';
			K.doAjax(param, url, function(res) {
				if(res.status && 'success' == res.status) {
					 parent.window.location.reload(parent.window.location.href);

                } else {
                    if (res.message) {
                        layer.msg(res.message, {icon: 2, time: 2000});
                    } else {
                        layer.msg('后台错误!', {icon: 2, time: 2000});
                    }
				}
			});
		}
		function back() {
			console.log(12345)
			var e = $('input[name=event]').is(':checked');
			console.log(e)

			var param = {
				is_event: (e ? 1 : 0),
				customer_contact_id: '{$data.customer_contact_id}'
			}
			var url = '/service/customer/manage/back';
			K.doAjax(param, url, function(res) {
				if(res.status && 'success' == res.status) {
					 parent.window.location.reload(parent.window.location.href);

                } else {
                    if (res.message) {
                        layer.msg(res.message, {icon: 2, time: 2000});
                    } else {
                        layer.msg('后台错误!', {icon: 2, time: 2000});
                    }
				}
			});
		}

	</script>
</block>