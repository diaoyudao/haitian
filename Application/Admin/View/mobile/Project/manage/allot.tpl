<extend name="./Application/Admin/View/mobile/base/context/common-new.tpl"/>
<block name="common_css">
    <link rel="stylesheet" type="text/css" href="/public/home/css/project/approval.css" />
</block>

<block name="head_left">
    <a onclick="removeIframe()"><img  class="head_left" src="/public/img/home/xlcweb/u608.png" alt="" /></a>
</block>

<block name="head_name">
    分配
</block>

<block name="body_main">
    <style>
        
    </style>
    <div class="body">
        <form class="form form-horizontal" id="form-notice-add" method="post">
            <input type="hidden" name="project_id" value="{$project_id}" />
            <p class="title ml-10">分配给</p>
            <volist name="employee" id="item">
            <div class="content ml-20">               
                <label><input name="employee_id" type="checkbox" value="{$item.employee_id}" <if condition="true == in_array($item['employee_id'], $select_employee)">checked</if> /><span class="ml-15">{$item.name}</span></label> <br>                 
            </div>
            </volist>
            <div class="btn_box">
                <button onclick="saveNotice()" class="btn btn-default radius" type="button" value="确定" style="background-color: #343643;color: #fff;padding:5px 30px">确定</button>
                
            </div>
        </form>
    </div>
</block>

<block name="footer_js">
    <script>
        function removeIframe() {
            K.removeIframe();
        }
        function saveNotice() {
            var param = {};
            param.project_id=$('input[name=project_id]').val();
            param.employee = [];
            var url = '/service/project/manage/allot';

            $('input[name=employee_id]:checked').each(function(){
                param.employee.push($(this).val())
            })

            K.doAjax(param, url, function(res){
                if (res.status && res.status == 'success') {
                    top.location.replace('/service?1');
                    K.removeIframe();                    
                    console.log('allor l ');             
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