<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>

<block name="menu_name"> > 文章</block>
<block name="page_name"> > 资讯管理</block>
<block name="body_main">
    <div class="page-container">

        <form class="form form-horizontal" action="" method="get">
            <div class="text-c">
                <span>分类：</span>
                <span class="select-box" style="width:120px;">
                    <select name="news_type_id" class="select">
                        <option value=""></option>
                        <volist name="types" id="item1">
                            <option value="{$item1.news_type_id}"
                            <php>if(I('get.news_type_id') ==
                                $item1['news_type_id']) {echo 'selected';}</php>
                            >{$item1.name}</option>
                        </volist>
                    </select>
                    </span> 
                <span>标签：</span>
                <span class="select-box" style="width:120px;">
                    <select name="tags" class="select">
                        <option value=""></option>
                        <volist name="tags" id="item">
                            <option value="{$item}"
                            <php>if(I('get.tags') ==
                                $item) {echo 'selected';}</php>
                            >{$item}</option>
                        </volist>
                    </select>
                    </span>
                <span>名称：</span>
                <input type="text" name="title" value="{$Think.get.title}" style="width:104px" class="input-text"/>
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
                日期范围：
                <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="begin_time"
                       value="{$Think.get.begin_time}"
                       class="input-text Wdate" style="width:120px;">
                -
                <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="end_time"
                       value="{$Think.get.end_time}"
                       class="input-text Wdate" style="width:120px;">
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

               <a class="btn btn-primary radius" data-title="添加"
                  onclick="notice_add('添加', '/1fd3ab97ee/news/news/add')"
                  href="javascript:;"><img style="width:12px;height:12px;margin-top:-2px;"
                                           src="/public/img/iconfont/xe600-2.png"/>
                   添加
               </a></span> <span class="r">共有数据：<strong>{$counts}</strong> 条</span></div>
        <div class="mt-20">
            <table class="table table-border table-bordered table-bg table-hover table-sort">
                <thead>
                <tr class="text-c">
                    <th width="25"><input type="checkbox" name="" value=""></th>
                    <th width="25">序号</th>
                    <th width="60">分类</th>
                    <th width="100">标签</th>
                    <th>标题</th>
                    <th>描述</th>
                    <th width="25">顺序号</th>
                    <th width="">生效时间</th>
                    <th width="25">状态</th>
                    <th width="90">操作</th>
                </tr>
                </thead>
                <tbody>
                <volist name="notices" id="item">
                    <tr class="text-c">
                        <td><input type="checkbox" value="{$item.news_id}" name="check"></td>
                        <td>{$i}</td>
                        <td>{$item.menu_name}</td>
                        <td>
                            <notempty name="item.tags">
                                [&nbsp;{$item.tags}&nbsp;]
                            </notempty>
                        </td>
                        <td>{$item.title}</td>
                        <td>{$item.description}</td>
                        <td>{$item.weight}</td>
                        <td>{$item.begin_time} -
                            <php> echo ($item['end_time'] != '0000-00-00')? $item['end_time'] : '';</php>
                        </td>
                        <td>
                            <if condition="$item.delete_time != null">
                                <span class="label label-danger radius">失效</span>
                                <else/>
                                <span class="label label-success radius">生效</span>

                            </if>

                        </td>
                        <td>
                            <a style="text-decoration:none" class="ml-5"
                               onClick="notice_edit(this,'编辑','/1fd3ab97ee/news/news/change?news_id={$item.news_id}')"
                               href="javascript:;" title="编辑">
                                <img style="width:14px;height:14px;" src="/public/img/iconfont/xe6df.png"/>
                            </a>
                            <a style="text-decoration:none" class="ml-5"
                               onClick="article_del(this,'{$item.news_id}')"
                               href="javascript:;"
                               title="删除">
                                <img style="width:14px;height:14px;" src="/public/img/iconfont/xe6e2.png"/>
                            </a>
                            <a style="text-decoration:none" class="ml-5"
                               onClick="article_active(this,'{$item.news_id}')"
                               href="javascript:;"
                               title="生效">
                                <img style="width:14px;height:14px;" src="/public/img/iconfont/xe68f.png"/>
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
        var news_type_id = $("select[name=news_type_id]").val();
        var title = $("input[name=title]").val();
        var begin_time = $("input[name=begin_time]").val();
        var end_time = $("input[name=end_time]").val();
        var status = $("select[name=status]").val();
        var tags = $("select[name=tags]").val();
        var param = '&news_type_id=' + news_type_id + '&title=' + title + '&begin_time=' + begin_time + '&end_time=' + end_time + '&status=' + status+
                    '&tags='+tags;
        var page_size = '<php> echo empty($pager -> totalPages) ? 1 : $pager -> totalPages; </php>';
        if (page_size > 1) {
            PAGER.create(page_size, param);
        }

        /*添加*/
        function notice_add(title, url) {
            K.showFullSonPage(title, url);
        }

        /*编辑*/
        function notice_edit(obj, title, url, w, h) {
            
            var index = layer.open({
                type: 2,
                title: title,
                content: url
            });
            layer.full(index);
        }
        /*删除*/
        function article_del(obj, id) {

            layer.confirm('确认要删除吗？', function (index) {
                var param = {news_id: id};

                K.doAjaxDeleteById(obj, param, '/1fd3ab97ee/news/news/delete');
            });
        }
        /*生效*/
        function article_active(obj, id) {

            layer.confirm('确认要生效吗？', function (index) {
                var param = {news_id: id};

                K.doAjaxDeleteById(obj, param, '/1fd3ab97ee/news/news/active');
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

            layer.confirm('确认要删除选中的所有吗？', function (index) {
                K.doAjax(param, '/1fd3ab97ee/news/news/delete', function (response) {
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

            layer.confirm('确认要生效选中的所有吗？', function (index) {
                K.doAjax(param, '/1fd3ab97ee/news/news/active', function (response) {
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