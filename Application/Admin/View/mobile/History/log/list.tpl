<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="menu_title">操作日志</block>

<block name="body_main">
<div class="page-container">
        <form class="form form-horizontal bk-gray pd-20 bg-fff" method="get">
            <div class="text-l ">
                <span class="c-666">选择时间：</span>
                <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM'})" 
                    class="input-text" style="width:120px"
                    id="delete_time"
                           name="delete_time"
                           value="{$Think.get.operate_time}"
                           class="input-text Wdate" />
                
                <button name="" class="btn btn-secondary radius" type="submit"><i class="Hui-iconfont">
                        &#xe665;</i> 搜索
                </button>
            </div>
        </form>

        <div class="mt-20 bg-fff">
            <table class="table table-border table-bordered table-bg table-hover table-sort">
                <thead>
                <tr class="text-c">
                    <th width="80" class="c-666">日期</th>
                    <th width="80" class="c-666">时间</th>
                    <th width="150" class="c-666">部门</th>
                    <th width="70" class="c-666">用户</th>
                    <th class="c-666">事件</th>
                    <th width="120" class="c-666">客户</th>
                    <th class="c-666">项目</th>
                    <th width="80" class="c-666">结果</th>
                </tr>
                </thead>
                <tbody>
                <volist name="data" id="item">
                    <tr class="text-c">
                        <td>{$item.create_time|'Y-m'}</td>
                        <td>{$item.create_time|'H:i:s'}</td>
                        <td>{$item.department_name}</td>
                        <td><img src="{$item.thumbnail_url}" />{$item.employee_name}</td>
                        <td>{$item.event}</td>
                        <td>{$item.customer_name}</td>
                        <td>{$item.project_name}</td>                        
                        <td><php>echo 1 == $item['resulte'] ? '成功' : '失败';</php></td>
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

        var operate_time = $("select[name=operate_time]").val();
        var param = '&operate_time=' + operate_time;
        var page_size = '<php> echo empty($pager -> totalPages) ? 1 : $pager -> totalPages; </php>';
        if (page_size > 1) {
            PAGER.create(page_size, param);
        }
</script>
</block>        