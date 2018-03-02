<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="body_main">
    <article class="page-container">
        <form class="form form-horizontal" id="form-admin-add">
            <input type="hidden" value="{$staff.staff_id}" name="staff_id">
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>管理员账号：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" value="{$staff.staff_code}" placeholder="" id="staff_code"
                           name="staff_code">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>姓名：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" value="{$staff.name}" placeholder="" id="adminName"
                           name="name">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red"></span>手机：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" value="{$staff.phone}" placeholder="" id="phone" name="phone">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red"></span>邮箱：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" placeholder="@" name="email" id="email"
                           value="{$staff.email}">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red"></span>部门：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" value="{$staff.department}" placeholder="" id="department"
                           name="department">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red"></span>职位：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" placeholder="" name="position" id="position"
                           value="{$staff.position}">
                </div>
            </div>
            <!--
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3">设置角色：</label>
                <div class="formControls col-xs-8 col-sm-9">

                    <dl class="permission-list">
                        <dl class="cl permission-list2" id="roles">
                            <dt>
                                <label class="">
                                </label>
                            </dt>
                            <volist name="roles" id="item">
                            <dd >
                                <label class="">
                                    <input type="checkbox" value="{$item.role_id}" name="roles"
                                    <php> if(in_array($item['role_id'],$use_roles)) {echo ' checked ';} </php>
                                    >
                                    {$item.name}</label>
                            </dd>
                            </volist>
                        </dl>
                    </dl>

                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3">设置栏目组（超级系统管理员无需选择）：</label>
                <div class="formControls col-xs-8 col-sm-9">

                    <dl class="permission-list">
                        <dl class="cl permission-list2" id="authoritys">
                            <dt>
                                <label class="">
                                </label>
                            </dt>
                            <volist name="menu_authority" id="item">
                            <dd >
                                <label class="">
                                    <input type="checkbox" value="{$item.menu_authority_id}" name="menu_authority"
                                    <php> if(in_array($item['menu_authority_id'],$user_menu_authority)) {echo ' checked ';} </php>
                                    >
                                    {$item.name}</label>
                            </dd>
                            </volist>
                        </dl>
                    </dl>

                </div>
            </div>-->
            <!--
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>人员属性：</label>
                <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                    <div class="radio-box">
                        <input name="identity" type="radio" value="1" id="identity-1"
                        <if condition="empty($staff) or $staff.identity eq 1">checked</if>
                        >
                        <label for="identity-1">编辑者</label>
                    </div>
                    <div class="radio-box">
                        <input type="radio" value="2" name="identity" id="identity-2"
                        <if condition="$staff.identity eq 2">checked</if>
                        >
                        <label for="identity-2">审核者</label>
                    </div>
                </div>
            </div>-->
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>状态：</label>
                <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                    <div class="radio-box">
                        <input name="status" type="radio" value="1"
                        <php> if(empty($staff) || ((!empty($staff)) && $staff['status'] == 1) )
                            {echo ' checked ';} </php>
                        >
                        <label for="sex-1">启用</label>
                    </div>
                    <div class="radio-box">
                        <input type="radio" value="0" name="status"
                        <php> if((!empty($staff)) && $staff['status'] == 0){echo ' checked ';} </php>
                        >
                        <label for="sex-2">禁用</label>
                    </div>
                </div>
            </div>
            <div class="row cl">
                <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                    <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
                    <button onClick="K.removeIframe();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
                </div>
            </div>
        </form>
    </article>
</block>

<block name="footer_js">
    <script type="text/javascript">
        $(function () {
            $('.skin-minimal input').iCheck({
                checkboxClass: 'icheckbox-blue',
                radioClass: 'iradio-blue',
                increaseArea: '20%'
            });

            $("#form-admin-add").validate({
                rules: {
                    staff_code: {
                        required: true,
                        minlength: 4,
                        maxlength: 16
                    },
                    name: {
                        required: true,
                        minlength: 2,
                        maxlength: 5
                    },
//                    password: {
//                        minlength: 6,
//                        required: true,
//                    },
//                    password2: {
//                        required: true,
//                        equalTo: "#password",
//                        minlength: 6,
//                    },
                    phone: {
                        required: false,
                        isPhone: true,
                    },
                    email: {
                        required: false,
                        email: true,
                    },
                    department: {
                        required: false,
                    },
                    position: {
                        required: false,
                    },
                    status: {
                        required: true,
                    },
                },

                onkeyup: false,
                focusCleanup: true,
                success: "valid",
                submitHandler: function (form) {
                    var param ={};
                    var arr = [];
                    $("#roles dd input:checkbox").each(function () {
                        if ($(this).prop("checked")) {
                            //arr.push($(this).val());
                        }
                    });
                    if(0 >= arr.length) {
                        //layer.msg('请至少要选择一个角色！', {icon:2,time:2000});
//                        return false;
                    }
//                    param.roles = arr;

                    arr = [];
                    $("#authoritys dd input:checkbox").each(function () {
                        if ($(this).prop("checked")) {
                           // arr.push($(this).val());
                        }
                    });
                    //param.menu_authoritys = arr;
                    
                    param.name = $('input[name=name]').val();
                    param.staff_code = $('input[name=staff_code]').val();
                    param.phone = $('input[name=phone]').val();
                    param.email = $('input[name=email]').val();
                    param.department = $('input[name=department]').val();
                    param.position = $('input[name=position]').val();
                    param.status = $('input[name=status]:checked').val();
                    param.identity = $('input[name=identity]:checked').val();

                    var staff_id = $('input[name=staff_id]').val();
                    if (staff_id) {
                        param.staff_id = staff_id;
                        K.doAjax(param, '/1fd3ab97ee/staff/manage/change');
                    } else {
                        console.log('add')
                        K.doAjax(param, '/1fd3ab97ee/staff/manage/add');
                    }
                }
            });
        });
    </script>
</block>