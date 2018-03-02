<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>

<block name="menu_name"> > 首页管理</block>
<block name="page_name"> > 轮播图管理</block>
<block name="body_main">
    <div class="page-container">
        <form class="form form-horizontal" action="" method="get">
            <div class="text-c">
                <span>状态：</span>
                <span class="select-box" style="width:120px;">
                    <select name="status" class="select">
                        <option value="">全部</option>
                        <option value="1"
                        <php>if(null !==I('get.status') && I('get.status') ==
                            1) {echo 'selected';}</php>
                        >失效</option>
                        <option value="2"
                        <php>if(I('get.status') ==
                            2) {echo 'selected';}</php>
                        >生效</option>
                    </select>
                    </span>
                <button name="" id="" class="btn btn-success" type="submit"><i class="Hui-iconfont">
                        &#xe665;</i> 搜索
                </button>
            </div>
        </form>

        <div class="cl pd-5 bg-1 bk-gray mt-20"><span class="l">
                <a href="javascript:;" onclick="del_more()"
                                                                   class="btn btn-danger radius">
                    <img style="width:12px;height:12px;margin-top:-2px;" src="/public/img/iconfont/xe6e2-2.png"/>
                    批量删除</a>
                <a href="javascript:;" onclick="active_more()"
                                class="btn btn-danger radius">
                    <img style="width:12px;height:12px;margin-top:-2px;" src="/public/img/iconfont/xe68f-2.png"/>
                    批量生效</a>
                <a class="btn btn-primary radius" data-title="新增"
                   onclick="advert_add('新增','/1fd3ab97ee/index/banner/add')"
                   href="javascript:;"><img style="width:12px;height:12px;margin-top:-2px;"
                                            src="/public/img/iconfont/xe600-2.png"/>
                    新增</a></span> <span class="r">轮播图数量限制1-8张，当前的轮播图总数：<strong>{$counts}</strong> 张
                    ,当前生效的轮播图数量：<strong>{$count1}</strong> 张</span>
                    </div>
        <div class="mt-20">
            <table class="table table-border table-bordered table-bg table-hover table-sort">
                <thead>
                <tr class="text-c">
                    <th width="25"><input type="checkbox" name="" value=""></th>

                    <th width="25">序号</th>
                    <th width="100">图片名称</th>
                    <th width="">头图</th>
                    <th width="100">状态</th>
                    <th width="25">顺序号</th>
                    <th width="90">操作</th>
                </tr>
                </thead>
                <tbody>
                <volist name="lists" id="item">
                    <tr class="text-c">
                        <td><input type="checkbox" value="{$item.banner_id}" name="check"></td>
                        <td>{$i}</td>
                        <td>{$item.name}</td>
                        <td><img src="{$item.thumbnail_url}" style="width:100px;height:150px;"></td>
                        <td><if condition="$item.delete_time != null">
                                <span class="label label-danger radius">失效</span>
                                <else/>
                                <span class="label label-success radius">生效</span>

                            </if>

                        </td>
                        <td>{$item.weight}</td>
                        <td class="f-14 td-manage"><a style="text-decoration:none" class="ml-5"
                                                      onClick="advert_edit('编辑','/1fd3ab97ee/index/banner/change?banner_id={$item.banner_id}')"
                                                      href="javascript:;" title="编辑">
                                <img style="width:14px;height:14px;" src="/public/img/iconfont/xe6df.png"/></a>
                            <a style="text-decoration:none" class="ml-5"
                                    onClick="advert_del(this,'{$item.banner_id}')"
                                    href="javascript:;"
                                    title="删除"><img style="width:14px;height:14px;"
                                                    src="/public/img/iconfont/xe6e2.png"/>
                            </a>
                            <a style="text-decoration:none" class="ml-5"
                                    onClick="advert_active(this,'{$item.banner_id}')"
                                    href="javascript:;"
                                    title="生效"><img style="width:14px;height:14px;"
                                                    src="/public/img/iconfont/xe68f.png"/>
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

        var status = $("select[name=status]").val();
        var param = '&status=' + status;
        var page_size = '<php> echo empty($pager -> totalPages) ? 1 : $pager -> totalPages; </php>';
        if (page_size > 1) {
            PAGER.create(page_size, param);
        }

        /*添加*/
        function advert_add(title, url) {
            K.showFullSonPage(title, url);
        }

        /*编辑*/
        function advert_edit(title, url, w, h) {
            K.showFullSonPage(title, url);
        }

        /*删除*/
        function advert_del(obj, id) {
            layer.confirm('确认要删除吗？', function (index) {
                //此处请求后台程序，下方是成功后的前台处理……
                var param = {banner_id: id};

                K.doAjaxDeleteById(obj, param, '/1fd3ab97ee/index/banner/delete');
            });
        }
        /*生效*/
        function advert_active(obj, id) {
            layer.confirm('确认要生效吗？', function (index) {
                //此处请求后台程序，下方是成功后的前台处理……
                var param = {banner_id: id};

                K.doAjaxDeleteById(obj, param, '/1fd3ab97ee/index/banner/active');
            });
        }

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
                K.doAjax(param, '/1fd3ab97ee/index/banner/delete', function (response) {
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
        function active_more() {
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
                layer.msg('请选择需要生效的数据!',{icon:2,time:2000});
                return;
            }

            layer.confirm('确认要生效选中的所有记录吗？', function (index) {
                K.doAjax(param, '/1fd3ab97ee/index/banner/active', function (response) {
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