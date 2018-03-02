<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="menu_title">职位管理</block>

<block name="body_main">
    <div class="page-container">
        <form class="form form-horizontal bk-gray pd-20 bg-fff" action="" method="get">
            <div class="text-l">
                <span class="select-box" style="width:120px;">
                    <select name="role_type_code" class="select">
                        <option value="">选择分类</option>
                        <volist name="Think.config.ROLE_TYPE" id="item1">
                            <option value="{$key}"
                            <php>if(I('get.role_type_code') ==
                                $key) {echo 'selected';}</php>
                            >{$item1}</option>
                        </volist>
                    </select>
                </span>                
                <input type="text" name="name" id="name" placeholder="职位名称" value="{$Think.get.name}" style="width:100px" class="input-text ml-10">

                <button name="" id="" class="btn btn-secondary radius ml-10" type="submit"><i class="Hui-iconfont">
                        &#xe665;</i> 搜索
                </button>
            </div>
        </form>

        <div class="cl pd-5 bg-1 bk-gray mt-20 bg-fff"><span class="l"> 
            <a href="javascript:;" onclick="datadel()"
                class="btn btn-danger radius">
                    <img style="width:12px;height:12px;margin-top:-2px;" src="/public/img/iconfont/xe6e2-2.png" />
                批量删除</a> 
            <a class="btn btn-primary radius" href="javascript:;"
                                                 onclick="admin_role_add('添加职位','/service/employee/role/add','800','500')">
                                                 <img style="width:12px;height:12px;margin-top:-2px;" src="/public/img/iconfont/xe600-2.png" />
                                                 添加职位</a> </span> <span class="r">共有数据：<strong>{$counts}</strong> 条</span>
        </div>

        <table class="table table-border table-bordered table-bg bg-fff mt-20">
            <thead>
            <tr>
                <th scope="col" colspan="10">职位列表</th>
            </tr>
            <tr class="text-c">
                <th width="25"><input type="checkbox" value="" name=""></th>
                <th width="200">职位名称</th>
                <th width="200">分类</th>
                <th >备注</th>
                <th width="70">操作</th>
            </tr>
            </thead>
            <tbody>
            <volist name="datas" id="item">
                <tr class="text-c">
                    <td><input type="checkbox" value="{$item.role_id}" name="check"></td>
                    <td>{$item.name}</td>
                    <td><php> echo C('ROLE_TYPE')[$item['role_type_code']];</php></td>
                    <td>{$item.note}</td>
                    <td class="f-14">
                        <a title="编辑" href="javascript:;"
                           onclick="admin_role_edit('职位编辑','/service/employee/role/change?id={$item.role_id}')"
                           style="text-decoration:none">
                           <img style="width:14px;height:14px;" src="/public/img/iconfont/xe6df.png" />
                        </a>
                        <a
                                title="删除" href="javascript:;" onclick="admin_role_del(this,'{$item.role_id}')" class="ml-5"
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

        $(function () {
            var department_id = $("select[name=department_id]").val();
            var role_type_code = $("select[name=role_type_code]").val();
            var name = $("input[name=name]").val();   

            /*  分页 */
            var param ='&department_id=' + department_id + '&role_type_code=' + role_type_code + '&name=' + name;
            /*  分页 */
            var page_size = '<php> echo empty($pager -> totalPages) ? 1 : $pager -> totalPages; </php>';
            if (page_size > 1) {
                PAGER.create(page_size);
            }

        });
        

        /*管理员-职位-添加*/
        function admin_role_add(title, url, w, h) {
            layer_show(title, url, w, h);
        }
        /*管理员-职位-编辑*/
        function admin_role_edit(title, url, id, w, h) {
            layer_show(title, url, w, h);
        }
        /*管理员-职位-删除*/
        function admin_role_del(obj, id) {
            layer.confirm('职位删除须谨慎，确认要删除吗？', function (index) {
                //此处请求后台程序，下方是成功后的前台处理……
                var param = {
                    role_id: id
                };

                K.doAjaxDeleteById(obj, param, '/service/employee/role/delete');
            });
        }
        /* 批量删除 */
        function datadel()
        {
            var param = {batch: true};
            param.ids=[];
            $("input[name=check]").each(function(){
                if(this.checked){
                    param.ids.push($(this).val());
                }
            });
            if(param.ids.length <= 0) {
                layer.msg('请选择需要删除的数据!',{icon:2,time:2000});
                return;
            }

            layer.confirm('职位删除须谨慎，确认要删除选中的职位吗？', function (index) {
                //此处请求后台程序，下方是成功后的前台处理……
                K.doAjax(param, '/service/employee/role/delete', function(response){
                    if(response.status && response.status == 'ok') {
                        window.location.reload();
                    } else {
                        if(response.message) {
                            layer.msg(response.message, {icon:2,time:1500});
                        } else {
                            layer.msg('后台错误!',{icon:2,time:1500});
                        }
                    }
                });
            });
        }
    </script>
</block>