<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="menu_title">用户管理</block>
<block name="body_main">
    <div class="page-container">

        <form class="form form-horizontal bk-gray pd-20 bg-fff" action="" method="get">
            <div class="text-l">
                <span class="select-box" style="width:120px;">
                    <select name="department_id" class="select">
                        <option value="">选择部门</option>
                        <volist name="department" id="item2">
                        <option value="{$item2.department_id}" 
                        <php> if(I('get.department_id') == $item2['department_id']) {echo ' selected';} 
                        </php> 
                        >{$item2.name}</option>
                    </volist>
                    </select>
                    </span> 
                <span class="select-box ml-10" style="width:120px;">
                    <select name="role_id" class="select">
                        <option value="">选择职位</option>
                        <volist name="role" id="item2">                       
                        
                        <option value="{$item2.role_id}" <if condition="I('get.role_id') eq $item2['role_id']">selected</if> >{$item2.name}</option>
                        
                    </volist>
                    </select>
                </span>
                <input type="text" name="name" value="{$Think.get.name}" style="width:90px" class="input-text ml-10" placeholder="姓名"/>
                <span class="select-box ml-10" style="width:120px;">
                    <select name="status" class="select">
                        <option value="">选择状态</option>
                        <option value="0"
                        <php>
                        if(I('get.status') === '0') {echo ' selected';}
                        </php>
                        >禁用</option>
                        <option value="1"
                        <php>
                          if(I('get.status') == 1) {echo ' selected';}
                          </php>
                        >启用</option>
                    </select>
                </span>
                
                <button name="" id="" class="btn btn-secondary radius" type="submit"><i class="Hui-iconfont">
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
                  onclick="notice_add('添加', '/service/employee/user/add')"
                  href="javascript:;"><img style="width:12px;height:12px;margin-top:-2px;"
                                           src="/public/img/iconfont/xe600-2.png"/>
                   添加
               </a></span> <span class="r">共有数据：<strong>{$counts}</strong> 条</span></div>
        <div class="mt-20 pb-20 bg-fff">
            <table class="table table-border table-bordered table-bg table-hover table-sort">
                <thead>
                <tr class="text-c">
                    <th width="25"><input type="checkbox" name="" value=""></th>
                    <th width="25">序号</th>
                    <th width="100">姓名</th>
                    <th >部门名称</th>
                    <th >职务</th>
                    <th width="100">上次登录</th>
                    <th width="100">登录次数</th>
                    <th width="80">状态</th>
                    <th width="90">操作</th>
                </tr>
                </thead>
                <tbody>
                <volist name="employees" id="item">
                    <tr class="text-c">
                        <td><input type="checkbox" value="{$item.employee_id}" name="check"></td>
                        <td>{$i}</td>
                        <td>{$item.name}</td>
                        <td>{$item.department_name}</td>
                        <td>{$item.role_name}</td>
                        <td>{$item.login_time}</td>
                        <td>{$item.login_quantity}</td> 
                        <td><if condition="$item.status eq 1"><span class="label label-success radius">启用</span>
                            <else/><span class="label label-danger radius">禁用</span>
                            </if>
                        </td>                    
                        <td>
                          <if condition="$item['employee_id'] neq C('SELF_SYSTEMADMIN.role_id')">
                            <a style="text-decoration:none" class="ml-5"
                               onClick="notice_edit('编辑'
                                    ,'/service/employee/user/change?id={$item.employee_id}')"
                               href="javascript:;" title="编辑">
                                <img style="width:14px;height:14px;" src="/public/img/iconfont/xe6df.png"/>
                            </a>
                            <a style="text-decoration:none" class="ml-5"
                               onClick="advert_del(this,'{$item.employee_id}')"
                               href="javascript:;"
                               title="删除">
                                <img style="width:14px;height:14px;" src="/public/img/iconfont/xe6e2.png"/>
                            </a>  
                          </if>                          
                        </td>
                    </tr>
                </volist>
                </tbody>
            </table>
            <div id="pager" style="margin-top:30px; text-align:center;"></div>
        </div>
    </div>
</block>

<block name="footer_js">
<script type="text/javascript">

        /*  分页 */
        var department_id = $("select[name=department_id]").val();
        var role_id = $("select[name=role_id]").val();
        var name = $("input[name=name]").val();        
        var status = $("select[name=status]").val();
        
        var param = '&department_id=' + department_id + '&role_id=' + role_id + '&name=' + name + '&status='+ status;
        var page_size = '<php> echo empty($pager -> totalPages) ? 1 : $pager -> totalPages; </php>';
        if (page_size > 1) {
            PAGER.create(page_size, param);
        }

        /*添加*/
        function notice_add(title, url) {
            layer_show(title, url, 800, 490);
        }

        function notice_edit(title, url, id, w, h) {
            layer_show(title, url, w, h);
        }

        /*删除*/
        function advert_del(obj, id) {
            layer.confirm('确认要删除吗？', function (index) {
                //此处请求后台程序，下方是成功后的前台处理……
                var param = {id: id};

                K.doAjaxDeleteById(obj, param, '/service/employee/user/delete');
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
                K.doAjax(param, '/service/employee/user/delete', function (response) {
                    if (response.status && response.status == 'success') {
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

        $(function() {
            var role_list = JSON.parse('<php>echo json_encode($role);</php>');

            // $('select[name=department_id]').change(function(){
            //     var temp = $(this).val();

            //     $('select[name=role_id]').empty();
            //     $('select[name=role_id]')
            //         .append('<option value=""></option>');
            //     $.each(role_list, function(i,v) {
            //         if(temp == v.department_id) {
            //             console.log('role=',v.name);
            //             $('select[name=role_id]')
            //         .append('<option value="'+ v.role_id +'" >'+ v.name + '</option>');
            //         }
            //     });                
            // });
        })

</script>        

</block>