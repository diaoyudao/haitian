<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    <link rel="stylesheet" type="text/css" href="/public/css/project/approval.css" />
</block>

<block name="body_main">
<style>

</style>
<div class="body">
  <form class="form form-horizontal" id="form-notice-add" method="post">
  <div class="bk-gray bg-fff pb-20">
    <input type="hidden" name="project_id" value="{$project_id}" />
    <p class="title ml-10">分配给</p>
    <volist name="employee" id="item">
    <div class="content ml-20">               
        <label><input name="employee_id" type="checkbox" value="{$item.employee_id}" <if condition="true == in_array($item['employee_id'], $select_employee)">checked</if> /><span class="ml-15">{$item.name}</span></label> <br>                 
    </div>
    </volist>
    </div>
    <button class="btn btn-primary radius mt-20" type="sumbit" >保存</button>
    <div class="btn btn-default radius mt-20 ml-20" onclick="removeIframe();"><a>取消</a></div>
    <div class="clear"></div>
  </form>
</div>
</block>

<block name="footer_js">
<script>
$(function(){
    $("#form-notice-add").validate({
            rules: {
                employee_id: {
                    required: true,
                },                            
            },
            onkeyup: false,
            focusCleanup: true,
            success: "valid",
            submitHandler: function (form) {
                saveNotice();            
            }
        });
})
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
                    window.parent.getApproveData();
                    K.removeIframe();
                } else {
                    if (res.message) {
                        layer.msg(res.message, {icon: 2, time: 2000});
                    } else {
                        layer.msg('后台错误!', {icon: 2, time: 2000});
                    }
                }
            });
        }

        function removeIframe() {
            K.removeIframe();
        }
</script>
</block>