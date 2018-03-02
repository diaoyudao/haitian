<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="menu_title">形势备份</block>

<block name="body_main">
<div class="page-container">
        <form class="form form-horizontal bk-gray pd-20 bg-fff" method="get">
            <div class="text-l ">
                <button onclick="bak()" class="btn btn-primary radius ml-10" type="button">立即备份
                </button>                
            </div>
        </form>

        <div class="mt-20 bg-fff bk-gray pd-20">
            <div class="">
                <span style="font-size:18px;color:#688696 ">形式统计表备份记录</span>
            </div>
            <table class="table  table-hover table-sort">
                <thead>
                <tr class="text-l" style="border-bottom: 2px solid #e0e0e0">
                    <th width="40" class="c-666">序号</th>
                    <th width="120" class="c-666">备份时间</th>
                    <th width="80" class="c-666">ABC数量</th>
                    <th class="c-666">说明</th>
                    <th width="150" class="c-666"></th>                    
                </tr>
                </thead>
                <tbody>
                <volist name="data" id="item">
                    <tr class="text-l">
                        <td>{$i}</td>
                        <td>{$item.operate_date}</td>
                        <td>{$item.abc_num}</td>
                        <td>{$item.note}</td>     
                        <td>
                        <button onclick="down('{$item.id}')" class="btn btn-primary radius" type="button">下载
                        </button>
                        <button onclick="del('{$item.project_copy_id}')" class="btn btn-primary radius ml-10" type="button">删除
                        </button>
                        </td>
                    </tr>
                </volist>
                </tbody>
            </table>
            <div class="right_box_content"><div id="pager" class="pb-20" style="margin:20px auto; text-align:center;"></div></div>
        </div>
</div>
</block>

<block name="footer_js">
    <script type="text/javascript">
        /*  分页 */
        var param = '';
        var page_size = '<php> echo empty($pager->totalPages) ? 1 : $pager->totalPages;</php>';
        console.log('pa==',page_size)
        if (page_size > 1) {
            PAGER.create(page_size, param);
        }

  
function bak(me) {
    var param = {title: '请输入备份说明，并确认开始备份', formType: 2};
    layer.prompt(param, function(note, index){
        console.log(note)
        if('' == note) {
            layer.msg('备份说明不能为空!', {icon: 2, time: 2000});
            return;
        }
        callBak(note);
    });

}
function callBak(note) {
    var param = {note: note}
    var url = "/service/statistics/situation/bak"
    K.doAjax(param, url, function(res) {
        if (res.status && res.status == 'success') {                 
            //K.refreshParent();
            window.location.reload();
        } else {
            if (res.message) {
                layer.msg(res.message, {icon: 2, time: 2000});
            } else {
                layer.msg('后台错误!', {icon: 2, time: 2000});
            }
        }
    });
}

function down(id) {
    window.location.href = "/service/statistics/situation/down?id=" + id;    
}

function del(id) {
    var title = '确认要删除该备份记录？'    
    layer.confirm(title, {
      btn: ['确认', '取消'] //可以无限个按钮      
    }, function(index, layero){
        delCall(id)
        layer.close(index);
    }, function(index){
        layer.close(index);
    });
}

function delCall(id) {
    var param = {id: id}
    var url = "/service/statistics/situation/delbak"
    K.doAjax(param, url, function(res) {
        if (res.status && res.status == 'success') {                 
            //K.refreshParent();
            window.location.reload();
        } else {
            if (res.message) {
                layer.msg(res.message, {icon: 2, time: 2000});
            } else {
                layer.msg('后台错误!', {icon: 2, time: 2000});
            }
        }
    });
}

</script>
</block>        