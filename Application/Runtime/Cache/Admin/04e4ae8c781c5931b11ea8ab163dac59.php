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
    
    <link href="/public/css/customer/search/addcontact.css" rel="stylesheet" type="text/css"/>

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
        .input_text {
            width: 100px;
        }

        input:disabled {
            background: #fff;
        }

        .input-big {
            width: 96%;
        }

        .inline-d {
            margin-top: 10px;
            display: inline-block;
        }
    </style>
    <div class="body">
        <form action="" method="post" id="add-form-post">
            <input type="hidden" name="customer_contact_id" value="<?php echo ($data["customer_contact_id"]); ?>">
            <input type="hidden" name="customer_id"
                   value="<?php if(empty($data)): echo ($_GET['id']); else: echo ($data["customer_id"]); endif; ?>">
            <input type="hidden" name="birthday" value="">
            <div class="inline-d">
                <p class="title">姓名</p>
                <p class="content"><input class="input_text" name="name" value="<?php echo ($data["name"]); ?>" type="text"></p>
            </div>
            <div class="inline-d ml-10">
                <p class="title">部门/科室</p>
                <p class="content" style="display: inline-block;">
                    <?php if(!empty($data)): if(($data["status"]) == "1"): ?><select name="department" class="screen_department" style="height:39px;width:100px;">
                                <?php if(is_array($department)): $i = 0; $__LIST__ = $department;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><option value="<?php echo ($item["customer_department_id"]); ?>"
                                    <?php if(I('get.customer_department_id') == $item['customer_department_id'] || $data['customer_department_id']== $item['customer_department_id']): ?>selected<?php endif; ?>
                                    ><?php echo ($item["department"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                            </select>
                            <?php else: ?>
                            <input type="hidden" name="department" value="<?php echo ($data["customer_department_id"]); ?>">
                            <?php if(is_array($department_all)): $i = 0; $__LIST__ = $department_all;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$ite): $mod = ($i % 2 );++$i; if($data['customer_department_id'] == $ite['customer_department_id']): ?><input class="input_text" value="<?php echo ($ite["department"]); ?>" disabled type="text"><?php endif; endforeach; endif; else: echo "" ;endif; endif; ?>
                        <?php else: ?>
                        <select name="department" class="screen_department" style="height:39px;width:100px;">
                            <?php if(is_array($department)): $i = 0; $__LIST__ = $department;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><option value="<?php echo ($item["customer_department_id"]); ?>"
                                <?php if(I('get.customer_department_id') == $item['customer_department_id'] || $data['customer_department_id']== $item['customer_department_id']): ?>selected<?php endif; ?>
                                ><?php echo ($item["department"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                        </select><?php endif; ?>


                </p>

            </div>
            <div class="inline-d ml-10">
                <p class="title">职位</p>
                <p class="content" style="display: inline-block;"><input class="input_text" name="position"
                                                                         value="<?php echo ($data["position"]); ?>" type="text"
                                                                         placeholder="如'主任'、'总经理'"></p>
            </div>
            <div class="inline-d ml-10">
                <p class="title">决策链</p>
                <p class="content">
                    <select name="function" class="screen_department" style="height:39px;width:100px;">
                        <option value="1"
                        <?php if(1 == $data['function']): ?>selected<?php endif; ?>
                        >决策人</option>
                        <option value="2"
                        <?php if(2 == $data['function']): ?>selected<?php endif; ?>
                        >负责人</option>
                        <option value="3"
                        <?php if(3 == $data['function']): ?>selected<?php endif; ?>
                        >经办人</option>
                        <option value="4"
                        <?php if(4 == $data['function']): ?>selected<?php endif; ?>
                        >其他</option>
                    </select>
                </p>
            </div>
            <div class="inline-d">
                <p class="title">性别</p>
                <p class="content" style="height:39px;">
                    <label class="lsglabel" style="line-height: 39px;margin-right:8px"><input name="sex" type="radio"
                                                                                              value="0"
                        <?php if(empty($data['sex']) || '0' == $data['sex']): ?>checked<?php endif; ?>
                        />未知 </label>
                    <label class="lsglabel" style="line-height: 39px;margin-right:8px"><input name="sex" type="radio"
                                                                                              value="1"
                        <?php if( 1 == $data['sex']): ?>checked<?php endif; ?>
                        />男 </label>
                    <label class="lsglabel" style="line-height: 39px;margin-right:8px"><input name="sex" type="radio"
                                                                                              value="2"
                        <?php if('2' == $data['sex']): ?>checked<?php endif; ?>
                        />女 </label>
                </p>
            </div>
            <div class="inline-d">
                <p class="title">生日</p>
                <p class="content" style="width: 80px;border: 1px solid #e0e0e0;display: inline-block;"><input
                            style="width: 30px;border: none" class="input_text" name="month" type="number" min="1"
                            max="12" value="">月</p>
                <p class="content" style="width: 80px;border: 1px solid #e0e0e0;display: inline-block;"><input
                            style="width: 30px;border: none" class="input_text" name="day" type="number" min="1"
                            max="31" value="">日</p>
                <div class="radio-box ml-10" style="top:-17px;padding:0;line-height: 37px;">
                    <label for="identity-1" style="color:#363636;font-weight: 300;"><input name="is_remind"
                                                                                           type="checkbox" value="1"
                        <?php if(1 == $data['is_remind']): ?>checked<?php endif; ?>
                        style="margin:0;margin-left: 10px;margin-right: 5px;">生日提醒</label>
                </div>
                <div class="radio-box ml-20" style="top:-17px;padding:0;line-height: 37px;">
                    <label for="identity-1" style="color:#363636;font-weight: 300;"><input name="is_important"
                                                                                           type="checkbox" value="1"
                        <?php if(1 == $data['is_important']): ?>checked<?php endif; ?>
                        style="margin:0;margin-left: 10px;margin-right: 5px;">重要联系人</label>
                </div>

            </div>

            <div class="inline-d">
                <p class="title">联系电话</p>
                <p class="content"><input class="input_text input-big" name="tel" value="<?php echo ($data["tel"]); ?>" type="text"
                                          style="width:240px"></p>
            </div>
            <div class="inline-d ml-30">
                <p class="title">联系手机</p>
                <p class="content"><input class="input_text input-big" name="phone" value="<?php echo ($data["phone"]); ?>" type="text"
                                          style="width:240px">
                </p>
            </div>
            <div class="inline-d">
                <p class="title">微信</p>
                <p class="content"><input class="input_text input-big" name="weixin" value="<?php echo ($data["weixin"]); ?>" type="text"
                                          style="width:240px"></p>
            </div>
            <div class="inline-d ml-30">
                <p class="title">QQ</p>
                <p class="content"><input class="input_text input-big" name="qq" value="<?php echo ($data["qq"]); ?>" type="text"
                                          style="width:240px"></p>
            </div>
            <div class=" inline-d ">
                <p class="title">Email</p>
                <p class="content"><input class="input_text input-big" name="email" value="<?php echo ($data["email"]); ?>" type="text"
                                          style="width:240px"></p>
            </div>
            <div class="inline-d ml-30">
                <p class="title">备注</p>
                <p class="content"><input class="input_text input-big" name="note" value="<?php echo ($data["note"]); ?>" type="text"
                                          style="width:240px"></p>
            </div>
            <div class="clear"></div>
            <div class="preserve " style="margin-top: 20px">
                <button onclick="commit()" class="btn btn-primary radius" type="button">保存</button>
            </div>
            <?php if('add' == I('get.type')): ?><div class="preserve ml-20" style="margin-top: 20px">
                    <button onclick="commit(2)" class="btn btn-primary radius" type="button">保存并继续添加</button>
                </div><?php endif; ?>
            <div class="cancel " style="margin-top: 20px">
                <button onclick="removeIframe()" class="btn btn-default radius" type="button">取消</button>
            </div>
            <div class="clear"></div>
        </form>
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
		$(function () {
			var t = $('input[name=name]').val();
			$('input[name=name]').val("").focus().val(t);
			var birth = '<?php echo ($data["birthday"]); ?>';
			if ('' != birth) {
				var tmp1 = birth.substr(0, 2);
				var tmp2 = birth.substr(3, 2);

				$('input[name=month]').val(tmp1);
				$('input[name=day]').val(tmp2);
			}
		})
		var type = '<?php echo ($_GET['type']); ?>';

		function removeIframe() {
			if (type == 'add') {
				window.location.href = "/service/customer/manage/contactsort?id=<?php echo ($_GET['id']); ?>";
			}
			else {
				K.refreshParent();
			}
		}

		function commit(tt) {
//			if($("input[name='department']").val()==""){
//				$("input[name='department']").val('未知')
//			}
			var param ={};

			if ($("select[name='function']").val() == null) {
				console.log("请选择决策链");
				layer.msg('请选择决策链!', {icon: 2, time: 2000});
				return;
			}
			if (($("input[name='month']").val() != "" && $("input[name='day']").val() == "")
				|| ($("input[name='month']").val() == "" && $("input[name='day']").val() != "")) {
				console.log("请填写生日月");
				layer.msg('请填写完整的生日!', {icon: 2, time: 2000});
				return;
			}

			if ("" == $('input[name=customer_contact_id]').val()) {
				var url = '/service/customer/manage/addContact';
			} else {
				var url = '/service/customer/manage/changeContact';
				param.customer_contact_id = $('input[name=customer_contact_id]').val();
			}
			var m = $('input[name=month]').val()
			var d = $('input[name=day]').val()
			if ("" != m && "" != d) {
				m = parseInt(m)
				d = parseInt(d)
				var str = (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
				$('input[name=birthday]').val(str)
			} else {
				$('input[name=birthday]').val('')
			}
			param.customer_id = $('input[name=customer_id]').val();
//			param.department=$('select[name=department]').find("option:selected").text();
			var status = '<?php echo ($data["status"]); ?>';
			if (type != 'add' && status != 1) {
				param.customer_department_id = $('input[name=department]').val();
			} else {
				param.customer_department_id = $('select[name=department]').val();
			}
			param.function = $('select[name=function]').val();
			param.birthday = $('input[name=birthday]').val();
			param.name = $('input[name=name]').val();
			param.tel = $('input[name=tel]').val();
			param.phone = $('input[name=phone]').val();
			param.weixin = $('input[name=weixin]').val();
			param.qq = $('input[name=qq]').val();
			param.email = $('input[name=email]').val();
			param.position = $('input[name=position]').val();
			if ($('input[name=is_remind]:checked').val()) {
				param.is_remind = $('input[name=is_remind]:checked').val();
			}
			if ($('input[name=is_important]:checked').val()) {
				param.is_important = $('input[name=is_important]:checked').val();
			} else {
				param.is_important = 0;
			}
			param.sex = $('input[name=sex]:checked').val();
//			param.thumbnail_url=$('input[name=thumbnail_url]').val();
			console.log(param)
//            return
			K.doAjax(param, url, function (response) {
				if (response.status && response.status == 'success') {
					if (2 == tt) {
						layer.msg('保存成功!', {icon: 1, time: 2000});
						setTimeout("location.replace(location.href)", 2000)
						return;
					}

					if (type == 'add') {
						window.location.href = "/service/customer/manage/contactsort?id=<?php echo ($_GET['id']); ?>";
//						parent.window.location.reload(parent.window.location.href);
//						K.removeIframe();
					} else {
						K.refreshParent();
					}
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

<!--/footer_js 自定义javascript **end** -->

</body>
</html>