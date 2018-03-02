<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <LINK rel="Bookmark" href="/favicon.ico" >
    <LINK rel="Shortcut Icon" href="/favicon.ico" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="/public/huiadmin/lib/html5.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/respond.min.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/PIE_IE678.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/Hui-iconfont/1.0.7/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/css/style.css" />
    
    <!--[if IE 6]>
    <script type="text/javascript" src="/public/huiadmin/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>haitian</title>
</head>
<body>
<style>
body{
    background-color: #EEF5F9;
}  
.page-head{
    width:100%;
    height:60px;line-height: 60px;
    background-color: #fff;
    border-bottom: 1px #ccc solid;
    box-shadow: 0 3px 3px #ccc;
    font-size:16px;
    color:#30baba;
}
.page-head .title{
    margin-left: 20px;
}
</style>
<nav class="page-head">    
    <div class="title">形势备份
    </div>
</nav>

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
                <?php if(is_array($data)): $i = 0; $__LIST__ = $data;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><tr class="text-l">
                        <td><?php echo ($i); ?></td>
                        <td><?php echo ($item["operate_date"]); ?></td>
                        <td><?php echo ($item["abc_num"]); ?></td>
                        <td><?php echo ($item["note"]); ?></td>     
                        <td>
                        <button onclick="down('<?php echo ($item["id"]); ?>')" class="btn btn-primary radius" type="button">下载
                        </button>
                        <button onclick="del('<?php echo ($item["project_copy_id"]); ?>')" class="btn btn-primary radius ml-10" type="button">删除
                        </button>
                        </td>
                    </tr><?php endforeach; endif; else: echo "" ;endif; ?>
                </tbody>
            </table>
            <div class="right_box_content"><div id="pager" class="pb-20" style="margin:20px auto; text-align:center;"></div></div>
        </div>
</div>

<script type="text/javascript" src="/public/huiadmin/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/layer/2.1/extend/layer.ext.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/public/huiadmin/static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="/public/huiadmin/static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="/public/js/lib/common-1.js"></script>
<script type="text/javascript" src="/public/js/lib/list-1.js"></script>

    <script type="text/javascript">
        /*  分页 */
        var param = '';
        var page_size = '<?php echo empty($pager->totalPages) ? 1 : $pager->totalPages; ?>';
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

</body>
</html>