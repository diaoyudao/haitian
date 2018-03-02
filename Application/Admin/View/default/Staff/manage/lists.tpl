<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="menu_name">>权限管理</block>
<block name="page_name">>管理员列表</block>
<block name="body_main">
    <div class="page-container">
        <form class="form form-horizontal" action="" method="get">
            <div class="text-c">
                <span>登录名:&nbsp; &nbsp;</span><input type="text" name="staff_code" id="staff_code" placeholder="" value="{$Think.get.staff_code}"
                       style="width:100px"
                       class="input-text">&nbsp;&nbsp;
                <span>姓名: &nbsp;&nbsp; </span> <input type="text" name="name" id="name" placeholder="" value="{$Think.get.name}"
                       style="width:100px"
                       class="input-text">

                <button name="" id="" class="btn btn-success" onclick="check_2()" type="submit"><i class="Hui-iconfont">
                        &#xe665;</i> 搜索
                </button>
            </div>
        </form>

        <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <a href="javascript:;" onclick="datadel()"
                   class="btn btn-danger radius"><img style="width:12px;height:12px;margin-top:-2px;" src="/public/img/iconfont/xe6e2-2.png" /> 批量删除
                </a>
                <a href="javascript:;"
                   onclick="admin_add('添加管理员','/1fd3ab97ee/staff/manage/add','800','700')"
                   class="btn btn-primary radius"><img style="width:12px;height:12px;margin-top:-2px;" src="/public/img/iconfont/xe600-2.png" /> 添加管理员
                </a>
            </span>
            <span class="r">共有数据：<strong>{$counts}</strong> 条</span>
        </div>
        <table class="table table-border table-bordered table-bg">
            <thead>
            <tr>
                <th scope="col" colspan="12">管理员列表</th>
            </tr>
            <tr class="text-c">
                <th width="25"><input type="checkbox" name="" value=""></th>
                <th width="80">登录名</th>
                <th width="60">姓名</th>
                <th>手机</th>
                <th>邮箱</th>
                <th>部门</th>
                <th>职位</th>
                <th>角色</th>
                <th>栏目权限</th>
                <th width="60">状态</th>
                <th width="80">重置密码</th>
                <th width="60">操作</th>
            </tr>
            </thead>
            <tbody>
            <volist name="staffs" id="item">
                <tr class="text-c">
                    <td><input type="checkbox" value="{$item.staff_id}" name="check"></td>
                    <td>{$item.staff_code}</td>
                    <td>{$item.name}</td>
                    <td>{$item.phone}</td>
                    <td>{$item.email}</td>
                    <td>{$item.department}</td>
                    <td>{$item.position}</td>
                    <td>{$item.role_names}</td>
                    <td>{$item.menu_authority_names}</td>
                    <td class="td-status">
                        <span class="label label-success radius">
                            <php> if($item['status'] == 0):</php>
                                未启用
                                <php> else :</php>
                                已启用
                            <php> endif;</php>
                        </span>
                    </td>
                    <td><a href="javascript:;"
                           onclick="reset_passwd('{$item.staff_id}')"
                           class="ml-5" style="text-decoration:none">重置</a></td>
                    <td class="td-manage">
                        <a title="编辑" href="javascript:;"
                           onclick="admin_edit('管理员编辑','/1fd3ab97ee/staff/manage/change?id={$item.staff_id}','1','800','700')"
                           class="ml-5" style="text-decoration:none">
                            <img style="width:14px;height:14px;" src="/public/img/iconfont/xe6df.png" /></a>
                        <a title="删除" href="javascript:;" onclick="admin_del(this,'{$item.staff_id}')" class="ml-5"
                           style="text-decoration:none">
                            <img style="width:14px;height:14px;" src="/public/img/iconfont/xe6e2.png" />
                        </a>
                    </td>
                </tr>
            </volist>
            </tbody>
        </table>
        <div id="pager" style="margin-top:5px; text-align:center;"></div>
    </div>
</block>
<block name="footer_js">
    <script type="text/javascript">
        function check_2() {

            if ($('#staff_code').val() == "登录名") {
                $('#staff_code').val('');
            }
            if ($('#name').val() == "姓名") {
                $('#name').val('');
            }

        }

        $(function () {

            var staff_code = "";
            if ($('#staff_code').val() != "登录名") {
                staff_code = $('#staff_code').val();
            }
            var name = "";
            if ($('#name').val() != "姓名") {
                controller = $('#name').val();
            }

    /*  分页 */
            var param = '&staff_code=' + staff_code + '&name=' + name;
        var page_size = '<php> echo empty($pager -> totalPages) ? 1 : $pager -> totalPages; </php>';
        if (page_size > 1) {
            PAGER.create(page_size);
        }
        });
        

        function reset_passwd(staff_id) {
            layer.confirm('确认要重置该用户密码？', function (index) {
                var param = {staff_id: staff_id};

                K.doAjax(param, '/1fd3ab97ee/staff/password/reset', function (response) {
                    if (response.status && response.status == 'ok') {
                        layer.msg('重置密码成功', {icon: 1, time: 2000});
                    } else {
                        if (response.message) {
                            layer.msg(response.message, {icon: 2, time: 1500});
                        } else {
                            layer.msg('后台错误!', {icon: 2, time: 1500});
                        }
                    }
                });
            });
        }

        /*管理员-增加*/
        function admin_add(title, url, w, h) {
            layer_show(title, url, w, h);
        }

        /*管理员-删除*/
        function admin_del(obj, id) {
            layer.confirm('确认要删除吗？', function (index) {
                //此处请求后台程序，下方是成功后的前台处理……
                var param = {staff_id: id};

                K.doAjaxDeleteById(obj, param, '/1fd3ab97ee/staff/manage/delete');
            });
        }

        /* 批量删除 */
        function datadel() {
            var param = {batch: true};
            param.ids = [];
            $("input[name=check]").each(function () {
                if (this.checked) {
                    param.ids.push($(this).val());
                }
            });
            if (param.ids.length <= 0) {
                layer.msg('请选择需要删除的数据!',{icon:2,time:2000});
                return;
            }

            K.doAjax(param, '/1fd3ab97ee/staff/manage/delete', function (response) {
                if (response.status && response.status == 'ok') {
                    window.location.reload();
                } else {
                    if (response.message) {
                        layer.msg(response.message, {icon:2,time:1500});
                    } else {
                        layer.msg('后台错误!',{icon:2,time:1500});
                    }
                }
            });
        }
        /*管理员-编辑*/
        function admin_edit(title, url, id, w, h) {
            layer_show(title, url, w, h);
        }
        /*管理员-停用*/
        function admin_stop(obj, id) {
            layer.confirm('确认要停用吗？', function (index) {
                //此处请求后台程序，下方是成功后的前台处理……

                $(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_start(this,id)" href="javascript:;" title="启用" style="text-decoration:none"><i class="Hui-iconfont">&#xe615;</i></a>');
                $(obj).parents("tr").find(".td-status").html('<span class="label label-default radius">已禁用</span>');
                $(obj).remove();
                layer.msg('已停用!',{icon: 5,time:1000});
            });
        }

        /*管理员-启用*/
        function admin_start(obj, id) {
            layer.confirm('确认要启用吗？', function (index) {
                //此处请求后台程序，下方是成功后的前台处理……
                $(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_stop(this,id)" href="javascript:;" title="停用" style="text-decoration:none"><i class="Hui-iconfont">&#xe631;</i></a>');
                $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
                $(obj).remove();
                layer.msg('已启用!', {icon: 6,time:1000});
            });
        }
    </script>
</block>