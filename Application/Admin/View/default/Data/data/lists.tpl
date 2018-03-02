<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>

<block name="menu_name"> > 留资管理</block>
<block name="page_name"> > 预约管理</block>
<block name="body_main">
    <div class="page-container">

        <form class="form form-horizontal"  method="get" name="searchform">
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
                <span>姓名：</span>
                <input type="text" name="name" value="{$Think.get.name}" style="width:104px" class="input-text"/>
                <!--<span>状态：</span>
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
                    </span>-->
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
                <button name="" id="" class="btn btn-success" type="button" onclick="export_csv();"><i class="Hui-iconfont">
                        &#xe665;</i> 导出
                </button>
            </div>
        </form>


        <div class="mt-20">
            <table class="table table-border table-bordered table-bg table-hover table-sort">
                <thead>
                <tr class="text-c">
                    <th width="25"><input type="checkbox" name="" value=""></th>
                    <th width="25">序号</th>
                    <th>分类</th>
                    <th>姓名</th>
                    <th>电话</th>
                    <th>省份</th>
                    <th>城市</th>
                    <th>选择经销商</th>
                    <th>购车计划</th>
                    <th width="120">报名时间</th>
                </tr>
                </thead>
                <tbody>
                <volist name="notices" id="item">
                    <tr class="text-c">
                        <td><input type="checkbox" value="{$item.news_id}" name="check"></td>
                        <td>{$i}</td>
                        <td>{$item.menu_name}</td>
                        <td>{$item.name}</td>
                        <td>{$item.phone}</td>
                        <td>{$item.area}</td>
                        <td>{$item.city}</td>
                        <td>{$item.shop4s}</td>
                        <td>{$item.content}</td>
                        <td>{$item.create_time}</td>
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
        function export_csv() {

            document.searchform.action="/1fd3ab97ee/data/data/export";
            document.searchform.submit();
            document.searchform.action="/1fd3ab97ee/data/data/lists";

        }
        /*  分页 */
        var news_type_id = $("select[name=news_type_id]").val();
        var name = $("input[name=name]").val();
        var begin_time = $("input[name=begin_time]").val();
        var end_time = $("input[name=end_time]").val();
//        var status = $("select[name=status]").val();
//        var param = '&news_type_id=' + news_type_id + '&title=' + title + '&begin_time=' + begin_time + '&end_time=' + end_time + '&status=' + status;
        var param = '&news_type_id=' + news_type_id + '&name=' + name + '&begin_time=' + begin_time + '&end_time=' + end_time;
        var page_size = '<php> echo empty($pager -> totalPages) ? 1 : $pager -> totalPages; </php>';
        if (page_size > 1) {
            PAGER.create(page_size, param);
        }


    </script>
</block>