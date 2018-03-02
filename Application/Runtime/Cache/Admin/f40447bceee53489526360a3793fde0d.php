<?php if (!defined('THINK_PATH')) exit();?><!--_meta 作为公共模版分离出去-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <LINK rel="Bookmark" href="/favicon.ico" >
    <LINK rel="Shortcut Icon" href="/favicon.ico" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="/public/huiadmin/lib/html5.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/respond.min.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/PIE-2.0beta1/PIE_IE678.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/Hui-iconfont/1.0.7/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/css/style.css" />
    
	<link href="/public/bootstrap-3.3.7/css/bootstrap.css" rel="stylesheet" type="text/css" />
	<link href="/public/css/customer/search/addcard.css" rel="stylesheet" type="text/css" />

    <!--[if IE 6]>
    <script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <!--/meta 作为公共模版分离出去-->
    <title>后台管理</title>
    <meta name="keywords" content="后台管理系统模版">
    <meta name="description" content="后台管理系统模版">
</head>
<body>
<!-- body_main 自定义页面内容 **begin** -->

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
				<img class="head" src="<?php echo ($data["thumbnail_url"]); ?>" alt="">
				<div class="" style="display: inline-block;">
					<p><span><?php echo ((isset($data["name"]) && ($data["name"] !== ""))?($data["name"]):"未知姓名"); ?></span><span style="color:#3399CC;margin-left: 10px;"><?php echo ($data["department"]); ?></span></p>
					<p class="content" style="display: inline-block;"><?php echo ($data["position"]); ?>，<?php echo C('CONTACT_FUNCTION')[$data['function']]; if('0'==$data['status']): ?>（已离职）<?php endif; ?></p>
					<input class="btn btn-default radius" type="button" onclick="goChange()" value="修改资料"  style="font-size: 13px;margin-top: -17px;margin-left: 134px;">
					<?php if(($data["status"]) == "1"): ?><input class="btn btn-default radius" type="button" value="设置离职" style="font-size: 13px;float: right;margin-top: 3px;margin-left: 15px;" onclick="Quit()">
						<?php else: ?>
						<input class="btn btn-default radius" type="button" value="设置复职" style="font-size: 13px;float: right;margin-top: 3px;margin-left: 15px;" onclick="Quit()"><?php endif; ?>
					<p class="content"><img src="/public/img/info/u8616.png" alt="" class="icon"><?php echo ($data["birthday"]); ?></p>
					<div style="margin-top: 20px">
						<p class="icon_p" ><i class="Hui-iconfont c-999 icon" style="font-size:20px;margin-right: 10px;">&#xe696;</i><?php echo ($data["phone"]); ?></p>
					</div>
					<div style="margin-top: 20px">
						<p class="icon_p" ><img src="/public/img/info/u5922.png" alt="" class="icon"><?php echo ($data["tel"]); ?></p>
					</div>
					<div style="margin-top: 20px">
						<p class="icon_p"><img src="/public/img/info/u5912.png" alt="" class="icon"><?php echo ($data["qq"]); ?></p>
					</div>
					<div style="margin-top: 20px">
						<p class="icon_p" ><img src="/public/img/info/u5914.png" alt="" style="margin-left: -6px;margin-right: 5px;"><?php echo ($data["weixin"]); ?></p>
					</div>
					<div style="margin-top: 20px">
						<p class="icon_p"><img src="/public/img/info/u5924.png" alt="" class="icon"><?php echo ($data["email"]); ?></p>
					</div>
				</div>
			</div>
			<div>
				<p style="display: inline-block;width: 90px;padding-left: 10px;float: left;margin-top: 20px;">资料备注</p>
				<div style="display: inline-block;width: 455px;">
					<textarea  class="content" name="desc" style="width:100%;height:120px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;margin-top: 20px;"><?php echo ($data["note"]); ?></textarea>
				</div>
			</div>
		</div>
		<div class="quit_box">
			<p><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span></p>
			<?php if(($data["status"]) == "1"): ?><p>该操作将设置联系人状态为已离职，请确认。</p>
				<?php else: ?>
				<p>该操作将设置联系人回到原有部门，请确认！</p><?php endif; ?>
			<p><label for="event"><input id="event" name="event" type="checkbox" value="" /><span>记录到客户大事件</span></label></p>
			<div class="preserve" style="margin-left: 155px;"><button style="width: 70px;" class="btn btn-primary radius" type="button" <?php if(($data["status"]) == "1"): ?>onclick="leave()"<?php else: ?>onclick="back()"<?php endif; ?>>确认</button></div>
			<div class="cancel" style="margin-left: 100px;"><button style="width: 70px;" onclick="removeIframe()" class="btn btn-default radius" type="button">点错了</button></div>
			<div class="clear"></div>
		</div>
		

		
	</div>

<!-- body_main 自定义页面内容 **end** -->
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="/public/huiadmin/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/jquery.validation/1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/jquery.validation/1.14.0/messages_zh.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="/public/huiadmin/static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="/public/js/lib/common-1.js"></script>
<!-- footer_js 自定义javascript **begin** -->

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
			window.location.href="/service/customer/search/changeContact?contact_id=<?php echo ($data["customer_contact_id"]); ?>"
		}
		function leave() {
			console.log(12345)
			var e = $('input[name=event]').is(':checked');
			console.log(e)

			var param = {
				is_event: (e ? 1 : 0),
				customer_contact_id: '<?php echo ($data["customer_contact_id"]); ?>'
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
				customer_contact_id: '<?php echo ($data["customer_contact_id"]); ?>'
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

<!--/footer_js 自定义javascript **end** -->

</body>
</html>