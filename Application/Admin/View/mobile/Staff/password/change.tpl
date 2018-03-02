<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="body_main">
    <article class="page-container">
        <form method="post" class="form form-horizontal" id="form-change-password">
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>账户：</label>
                <div class="formControls col-xs-8 col-sm-9"> {$Think.session.staff_name}</div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>旧密码：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="password" class="input-text" autocomplete="off" placeholder="" name="old_passwd"
                           id="old_passwd">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>新密码（大于等于8位，必须包含英文和数字）：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="password" class="input-text" autocomplete="off" placeholder="" name="new_passwd"
                           id="new_passwd">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>确认密码：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="password" class="input-text" autocomplete="off" placeholder=""
                           name="new_passwd2" id="new-password2">
                </div>
            </div>
            <div class="row cl">
                <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                    <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;保存&nbsp;&nbsp;">
                </div>
            </div>
        </form>
    </article>
</block>
<block name="footer_js">
    <script type="text/javascript">
        $(function () {
            $("#form-change-password").validate({
                rules: {
                    old_passwd: {
                        required: true,
                        rangelength:[6,20],
                    },
                    new_passwd: {
                        required: true,
                        rangelength:[8,20]
                    },
                    new_passwd2: {
                        required: true,
                        rangelength:[8,20],
                        equalTo: "#new_passwd"
                    },
                },
                onkeyup: false,
                focusCleanup: true,
                success: "valid",
                submitHandler: function (form) {
                    var old_pwd = $('input[name=old_passwd]').val();
                    var new_pwd = $('input[name=new_passwd]').val();
                    if(old_pwd == new_pwd) {
                        layer.msg('新旧密码不能相同', {icon: 2, time: 1500});
                        return false;
                    }

                    K.doAjaxSubmit('#form-change-password', null, function(response) {
                        if (response.status && response.status == 'ok') {
                            layer.msg('修改密码成功！', {icon: 1, time: 2000});
                        } else {
                            if (response.message) {
                                layer.msg(response.message, {icon: 2, time: 1500});
                            } else {
                                layer.msg('后台错误!', {icon: 2, time: 1500});
                            }
                        }
                    });

                    return false;
                }
            });
        });
    </script>
</block>