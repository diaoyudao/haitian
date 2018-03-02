<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="menu_title">部门管理</block>

<block name="body_main">
    <div class="page-container">

        <form class="form form-horizontal bk-gray pd-20 bg-fff" action="" method="get">
            <div class="text-l">
                <span class="select-box" style="width:120px;">
                    <select name="department_type_id" class="select">
                        <option value="">选择分类</option>
                        <volist name="Think.config.DEPARTMENT_TYPE" id="item1">
                            <option value="{$key}"
                            <php>if(I('get.department_type_id') ==
                                $key) {echo 'selected';}</php>
                            >{$item1}</option>
                        </volist>
                    </select>
                </span>                 
                <input type="text" name="name" value="{$Think.get.name}" style="width:104px" class="input-text ml-10" placeholder="部门名称"/>
                         
                <button name="" id="" class="btn btn-secondary radius ml-10" type="submit"><i class="Hui-iconfont">
                        &#xe665;</i> 搜索
                </button>
            </div>
        </form>

        <div class="cl pd-5 bg-1 bk-gray mt-20 bg-fff"><span class="l">
                <a href="javascript:;" onclick="del_more()"
                   class="btn btn-danger radius">
                    <img style="width:12px;height:12px;margin-top:-2px;" src="/public/img/iconfont/xe6e2-2.png"/>
                    批量删除</a>

               <a class="btn btn-primary radius" data-title="添加"
                  onclick="notice_add('添加', '/service/employee/department/add')"
                  href="javascript:;"><img style="width:12px;height:12px;margin-top:-2px;"
                                           src="/public/img/iconfont/xe600-2.png"/>
                   添加
               </a></span> <span class="r">共有数据：<strong>{$counts}</strong> 条</span></div>
        <div class="mt-20 bg-fff">
            <table class="table table-border table-bordered table-bg table-hover table-sort">
                <thead>
                <tr class="text-c">
                    <th width="25"><input type="checkbox" name="" value=""></th>
                    <th width="25">序号</th>
                    <th width="100">部门名称</th>
                    <th width="60">分类</th>
                    <th>备注</th>
                    <th width="90">操作</th>
                </tr>
                </thead>
                <tbody>
                <volist name="department" id="item">
                    <tr class="text-c">
                        <td><input type="checkbox" value="{$item.department_id}" name="check"></td>
                        <td>{$i}</td>
                        <td>{$item.name}</td>
                        <td><php> echo C('DEPARTMENT_TYPE')[$item['department_type_id']];</php></td>
                        <td>{$item.note}</td>
                        <td>
                            <a style="text-decoration:none" class="ml-5"
                               onClick="layer_show('编辑','/service/employee/department/change?id={$item.department_id}')"
                               href="javascript:;" title="编辑">
                                <img style="width:14px;height:14px;" src="/public/img/iconfont/xe6df.png"/>
                            </a>
                            <a style="text-decoration:none" class="ml-5"
                               onClick="advert_del(this,'{$item.department_id}')"
                               href="javascript:;"
                               title="删除">
                                <img style="width:14px;height:14px;" src="/public/img/iconfont/xe6e2.png"/>
                            </a>                            
                        </td>
                    </tr>
                </volist>
                </tbody>
            </table>
            <div id="pager" style="margin-top:5px; text-align:center;"></div>
        </div>
    </div>
</block>

<block name="footer_js">
<script type="text/javascript">

        /*  分页 */
        var department_type_id = $("select[name=department_type_id]").val();
        var name = $("input[name=name]").val();

        var param = '&department_type_id=' + department_type_id + '&name=' + name;
        var page_size = '<php> echo empty($pager -> totalPages) ? 1 : $pager -> totalPages; </php>';
        if (page_size > 1) {
            PAGER.create(page_size, param);
        }

        /*添加*/
        function notice_add(title, url) {
            layer_show(title, url, 800, 360);
        }

        /*删除*/
        function advert_del(obj, id) {
            layer.confirm('确认要删除吗？', function (index) {
                //此处请求后台程序，下方是成功后的前台处理……
                var param = {id: id};

                K.doAjaxDeleteById(obj, param, '/service/employee/department/delete');
            });
        }
        /*批量删除*/
        function del_more() {
            var param = {
                batch: 1,
                ids: []
            };
            $("input[name=check]").each(function () {
                if (this.checked) {
                    param.ids.push($(this).val());
                }
            });

            if (param.ids.length <= 0) {
                layer.msg('请选择需要删除的数据!',{icon:2,time:2000});
                return;
            }

            layer.confirm('确认要删除选中的所有记录吗？', function (index) {
                K.doAjax(param, '/service/employee/department/delete', function (response) {
                    if (response.status && response.status == 'ok') {
                        window.location.replace(window.location.href);
                    } else {
                        if (response.message) {
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