<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="body_main">
    <article class="page-container">
        <form action="" method="post" class="form form-horizontal" id="form-admin-role-add">
            <input type="hidden" name="role_id" value="{$Think.get.id}">
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>分类：</label>
                <div class="formControls col-xs-7 col-sm-8"> <span class="select-box">
                <select name="role_type_code" class="select">
                    <option value="">请选择分类</option>
                    <volist name="Think.config.ROLE_TYPE" id="item1">
                        <option value="{$key}" 
                        <php> if($role['role_type_code'] == $key) {echo ' selected';} </php>
                        >{$item1}</option>
                    </volist>
                </select>
                </span></div>
            </div>  
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>职位名称：</label>
                <div class="formControls col-xs-7 col-sm-8">
                    <input type="text" class="input-text" value="{$role['name']}" placeholder="" id="name" name="name"
                           datatype="*4-16"
                           nullmsg="用户账户不能为空">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3">职位权限：</label>
                <div class="formControls col-xs-7 col-sm-8">
                    <php> $i=0;foreach( ((new \Admin\Common\Base())->getMenu()) as $menus):</php>
                    <dl class="permission-list">
                        <dt>
                            <label>
                                <input type="checkbox" value="{$menus.link}" name="user-Character-0"
                                       id="user-Character-<php>echo $i++;</php>"
                                    <php> 
                                    if(in_array($menus['link'],$role['menus'])) {echo ' checked ';} 
                                    </php>
                                />
                                {$menus['title']}</label>
                        </dt>
                        <dd>
                            <php> $j=0;foreach( $menus['children'] as $menu):</php>
                            <dl class="cl permission-list2">
                                <dt>
                                    <label class="">
                                        <input type="checkbox" value="{$menu['link']}"
                                               name="user-Character-<php>echo $i;</php>-<php>echo $j++;</php>"
                                               id="user-Character-<php>echo $i;</php>-<php>echo $j;</php>"
                                        <php> if(in_array($menu['link'],$role['menus'])) {echo ' checked ';} </php>
                                        >
                                        {$menu['title']}</label>
                                </dt>

                                <dd>
                                    <php> $k=0;foreach( $menu['children'] as $page):</php>
                                    <label class="">
                                        <input type="checkbox" value="{$page['title']}"
                                               name="user-Character-<php>echo $i;</php>-<php>echo $j;</php>-0"
                                               id="user-Character-<php>echo $i;</php>-<php>echo $j;</php>-<php>echo $k++;</php>"
                                        <php> if(false !== strpos($role['menus'],
                                            $page['title'])) {echo ' checked ';} </php>
                                        >
                                        {$page['title']}</label>
                                    <php> endforeach;</php>
                                </dd>
                            </dl>
                            <php> endforeach;</php>
                        </dd>
                    </dl>
                    <php> endforeach;</php>

                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3">备注：</label>
                <div class="formControls col-xs-7 col-sm-8">
                    <textarea id="note" name="note" cols="" rows="" class="textarea" placeholder="100个字符以内"
                              dragonfly="true" onKeyUp="textarealength(this,100)">{$role['note']}</textarea>
                    <p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>
                </div>
            </div>

            <div class="row cl">
                <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                    <button type="submit" class="btn btn-success radius" id="admin-role-save" name="admin-role-save"><i
                                class="icon-ok"></i> 确定
                    </button>
                    <button onClick="K.removeIframe();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
                </div>
            </div>
        </form>
    </article>

</block>

<block name="footer_js">
    <script type="text/javascript">
        $(function () {
            $(".permission-list dt input:checkbox").click(function () {
                var temp = $(this).closest("dl");
                temp.find("dd input:checkbox").prop("checked", $(this).prop("checked"));
                if (temp.hasClass('permission-list2')) {
                    temp.parent().prev("dt").find("input:checkbox").prop("checked", $(this).prop("checked"));
                }
            });
            $(".permission-list2 dd input:checkbox").click(function () {
                var l = $(this).parent().parent().find("input:checked").length;
                var l2 = $(this).parents(".permission-list").find(".permission-list2 dd").find("input:checked").length;
                if ($(this).prop("checked")) {
                    $(this).closest("dl").find("dt input:checkbox").prop("checked", true);
                    $(this).parents(".permission-list").find("dt").first().find("input:checkbox").prop("checked", true);
                } else {
                    if (l == 0) {
                        $(this).closest("dl").find("dt input:checkbox").prop("checked", false);
                    }
                    if (l2 == 0) {
                        $(this).parents(".permission-list").find("dt").first().find("input:checkbox").prop("checked", false);
                    }
                }
            });

            $(".permission-list dt input:checkbox").each(function () {
                if ($(this).prop("checked")) {
                    //$(this).parents(".permission-list").find("dt").first().find("input:checkbox").prop("checked", true);
                }
            });

            $(".permission-list dd input:checkbox").each(function () {
                if ($(this).prop("checked")) {
                    $(this).closest("dl").find("dt input:checkbox").prop("checked", true);
                    $(this).parents(".permission-list").find("dt").first().find("input:checkbox").prop("checked", true);
                }
            });

            $("#form-admin-role-add").validate({
                rules: {
                    name: {
                        required: true,
                        minlength: 2,
                    },
                },

                onkeyup: false,
                focusCleanup: true,
                success: "valid",
                submitHandler: function (form) {
                    var param ={};
                    var arr = [];

                    $(".permission-list dt input:checkbox").each(function () {
                        if ($(this).prop("checked")) {
                            // var temp = $(this).parents(".permission-list2");
                            // if (0 < temp.length) {
                            //     var temp2 = temp.find("dd input:checkbox");
                            //     if (temp2.length <= 0) {
                            //         arr.push($(this).val());
                            //     }
                            // }
                            arr.push($(this).val());
                        }
                    });

                    $(".permission-list2 dd input:checkbox").each(function () {
                        if ($(this).prop("checked")) {
                            arr.push($(this).val());
                        }
                    });

                    param.privileges = [];

                    $.each(arr, function(i,v) {
                        if('#' != v) {
                            param.privileges.push(v);
                        }
                    });

                    param['name'] = $('#name').val();
                    param['note'] = $('#note').val();
                    param['department_id'] = $('select[name=department_id]').val();
                    param['role_type_code'] = $('select[name=role_type_code]').val();

                    var role_id = $('input[name=role_id]').val();
                    if (role_id) {
                        param['role_id'] = role_id;
                        K.doAjax(param, '/service/employee/role/change');
                    } else {
                        K.doAjax(param, '/service/employee/role/add');
                    }

                    return false;
                }
            });
        });
    </script>
</block>