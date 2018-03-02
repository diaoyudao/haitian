<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    <link href="/public/css/customer/manage/employee.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">

</block>

<block name="body_main">
    <style>
        
    </style>

    <div class="body">
        <p class="title">客户</p>
        <p class="content">重庆园博园</p>
        <div class="title wtitle">维护该客户的我部业务人员<p style="float: right;">已选<span><php>echo count($select_employee);</php></span>人</p></div>
        <form action="" method="post" id="add-form-post">
        <div class="content ul_box">
            <label><input name="list" type="checkbox" value="" /><img class="head" src="/public/img/info/no_user.png" alt="">张三 </label>
            <label><input name="list" type="checkbox" value="" /><img class="head" src="/public/img/info/man.png" alt="">历史 </label>
            <label><input name="list" type="checkbox" value="" /><img class="head" src="/public/img/info/man.png" alt="">问问 </label>

            <volist name="employee" id="item">
                <label><input name="list" type="checkbox" value="{$item.employee_id}" /><img class="head" src="{$item.thumbnail_url}" alt="">{$item.name} </label>
            </volist>
        </div>
        <div class="preserve"><button onclick="commit()" class="btn btn-primary radius" type="button">确定</button></div>
        <div class="cancel"><button onclick="removeIframe()" class="btn btn-default radius" type="button">取消</button></div>
        <div class="clear"></div>
        </form>
    </div>
</block>

<block name="footer_js">
    <script>
        function removeIframe() {
            K.removeIframe();
        }
        function commit() {
            var url = '/service/customer/manage/employee';
            var $param = {}
            $param.list = [];
            $param.customer_id = '{$Think.get.id}'
            $('input[name=list]:checked').each(function(){
                $param.list.push($(this).val());
            })
             K.doAjax($param, url, function(response) {
                if (response.status && response.status == 'success') {
                    K.refreshParent();
                } else {
                    if (response.message) {
                        layer.msg(response.message, {icon: 2, time: 2000});
                    } else {
                        layer.msg('后台错误!', {icon: 2, time: 2000});
                    }
                }
            });
        } 
    </script>
</block>