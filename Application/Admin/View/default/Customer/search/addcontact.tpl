<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    <link href="/public/css/customer/search/addcontact.css" rel="stylesheet" type="text/css"/>
</block>
<block name="common_js">

</block>

<block name="body_main">
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
            <input type="hidden" name="customer_contact_id" value="{$data.customer_contact_id}">
            <input type="hidden" name="customer_id"
                   value="<empty name='data'>{$Think.get.id}<else/>{$data.customer_id}</empty>">
            <input type="hidden" name="birthday" value="">
            <div class="inline-d">
                <p class="title">姓名</p>
                <p class="content"><input class="input_text" name="name" value="{$data.name}" type="text"></p>
            </div>
            <div class="inline-d ml-10">
                <p class="title">部门/科室</p>
                <p class="content" style="display: inline-block;">
                    <notempty name="data">
                        <eq name="data.status" value="1">
                            <select name="department" class="screen_department" style="height:39px;width:100px;">
                                <volist name="department" id="item">
                                    <option value="{$item.customer_department_id}"
                                    <if condition="I('get.customer_department_id') == $item['customer_department_id'] || $data['customer_department_id']== $item['customer_department_id']">
                                        selected
                                    </if>
                                    >{$item.department}</option>
                                </volist>
                            </select>
                            <else/>
                            <input type="hidden" name="department" value="{$data.customer_department_id}">
                            <volist name="department_all" id="ite">
                                <if condition="$data['customer_department_id'] == $ite['customer_department_id']">
                                    <input class="input_text" value="{$ite.department}" disabled type="text">
                                </if>
                            </volist>
                        </eq>
                        <else/>
                        <select name="department" class="screen_department" style="height:39px;width:100px;">
                            <volist name="department" id="item">
                                <option value="{$item.customer_department_id}"
                                <if condition="I('get.customer_department_id') == $item['customer_department_id'] || $data['customer_department_id']== $item['customer_department_id']">
                                    selected
                                </if>
                                >{$item.department}</option>
                            </volist>
                        </select>
                    </notempty>


                </p>

            </div>
            <div class="inline-d ml-10">
                <p class="title">职位</p>
                <p class="content" style="display: inline-block;"><input class="input_text" name="position"
                                                                         value="{$data.position}" type="text"
                                                                         placeholder="如'主任'、'总经理'"></p>
            </div>
            <div class="inline-d ml-10">
                <p class="title">决策链</p>
                <p class="content">
                    <select name="function" class="screen_department" style="height:39px;width:100px;">
                        <option value="1"
                        <if condition="1 == $data['function']"> selected</if>
                        >决策人</option>
                        <option value="2"
                        <if condition="2 == $data['function']"> selected</if>
                        >负责人</option>
                        <option value="3"
                        <if condition="3 == $data['function']"> selected</if>
                        >经办人</option>
                        <option value="4"
                        <if condition="4 == $data['function']"> selected</if>
                        >其他</option>
                    </select>
                </p>
            </div>
            <div class="inline-d">
                <p class="title">性别</p>
                <p class="content" style="height:39px;">
                    <label class="lsglabel" style="line-height: 39px;margin-right:8px"><input name="sex" type="radio"
                                                                                              value="0"
                        <if condition="empty($data['sex']) || '0' eq $data['sex']"> checked</if>
                        />未知 </label>
                    <label class="lsglabel" style="line-height: 39px;margin-right:8px"><input name="sex" type="radio"
                                                                                              value="1"
                        <if condition=" 1 eq $data['sex']"> checked</if>
                        />男 </label>
                    <label class="lsglabel" style="line-height: 39px;margin-right:8px"><input name="sex" type="radio"
                                                                                              value="2"
                        <if condition="'2' eq $data['sex']"> checked</if>
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
                        <if condition="1 == $data['is_remind']"> checked</if>
                        style="margin:0;margin-left: 10px;margin-right: 5px;">生日提醒</label>
                </div>
                <div class="radio-box ml-20" style="top:-17px;padding:0;line-height: 37px;">
                    <label for="identity-1" style="color:#363636;font-weight: 300;"><input name="is_important"
                                                                                           type="checkbox" value="1"
                        <if condition="1 == $data['is_important']"> checked</if>
                        style="margin:0;margin-left: 10px;margin-right: 5px;">重要联系人</label>
                </div>

            </div>

            <div class="inline-d">
                <p class="title">联系电话</p>
                <p class="content"><input class="input_text input-big" name="tel" value="{$data.tel}" type="text"
                                          style="width:240px"></p>
            </div>
            <div class="inline-d ml-30">
                <p class="title">联系手机</p>
                <p class="content"><input class="input_text input-big" name="phone" value="{$data.phone}" type="text"
                                          style="width:240px">
                </p>
            </div>
            <div class="inline-d">
                <p class="title">微信</p>
                <p class="content"><input class="input_text input-big" name="weixin" value="{$data.weixin}" type="text"
                                          style="width:240px"></p>
            </div>
            <div class="inline-d ml-30">
                <p class="title">QQ</p>
                <p class="content"><input class="input_text input-big" name="qq" value="{$data.qq}" type="text"
                                          style="width:240px"></p>
            </div>
            <div class=" inline-d ">
                <p class="title">Email</p>
                <p class="content"><input class="input_text input-big" name="email" value="{$data.email}" type="text"
                                          style="width:240px"></p>
            </div>
            <div class="inline-d ml-30">
                <p class="title">备注</p>
                <p class="content"><input class="input_text input-big" name="note" value="{$data.note}" type="text"
                                          style="width:240px"></p>
            </div>
            <div class="clear"></div>
            <div class="preserve " style="margin-top: 20px">
                <button onclick="commit()" class="btn btn-primary radius" type="button">保存</button>
            </div>
            <if condition="'add' == I('get.type')">
                <div class="preserve ml-20" style="margin-top: 20px">
                    <button onclick="commit(2)" class="btn btn-primary radius" type="button">保存并继续添加</button>
                </div>
            </if>
            <div class="cancel " style="margin-top: 20px">
                <button onclick="removeIframe()" class="btn btn-default radius" type="button">取消</button>
            </div>
            <div class="clear"></div>
        </form>
    </div>
</block>

<block name="footer_js">
    <script>
		$(function () {
			var t = $('input[name=name]').val();
			$('input[name=name]').val("").focus().val(t);
			var birth = '{$data.birthday}';
			if ('' != birth) {
				var tmp1 = birth.substr(0, 2);
				var tmp2 = birth.substr(3, 2);

				$('input[name=month]').val(tmp1);
				$('input[name=day]').val(tmp2);
			}
		})
		var type = '{$Think.get.type}';

		function removeIframe() {
			if (type == 'add') {
				window.location.href = "/service/customer/manage/contactsort?id={$Think.get.id}";
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
			var status = '{$data.status}';
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
						window.location.href = "/service/customer/manage/contactsort?id={$Think.get.id}";
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
</block>