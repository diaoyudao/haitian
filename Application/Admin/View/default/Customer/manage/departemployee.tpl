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
        <p class="content">{$customer.name}</p>
        <div class="title wtitle">负责部门</div>
        <select class="select-box select mt-5" id="department">
            <notempty name="customer['business_id']"><option value="{$customer.business_id}">{$customer.business_name}</option></notempty>
            <notempty name="customer['information_id']"><option value="{$customer.information_id}">{$customer.information_name}</option></notempty>
        </select>
        <div class="title wtitle">业务人员<!-- <p style="float: right;">已选<span><php>echo count($select_employee);</php></span>人</p> --></div>
        <div class="content ul_box" style="height: 180px;width: 100%">
            <volist name="employee" id="item">
                <label id="{$item.department_id}"><input name="list" type="checkbox" value="{$item.employee_id}" depart="{$item.department_id}" <if condition="true == in_array($item['employee_id'], array_column($select_employee, 'employee_id'))">checked</if> /><img class="head" src="{$item.thumbnail_url}" alt="">{$item.name} </label>
            </volist>
        </div>
        <div class="preserve " style="margin-top: 20px"><button onclick="commit()" class="btn btn-primary radius" type="button">确定</button></div>
        <div class="cancel " style="margin-top: 20px"><button onclick="removeIframe()" class="btn btn-default radius" type="button">取消</button></div>
        <div class="clear"></div>
    </div>
</block>

<block name="footer_js">
    <script>
        var employee = JSON.parse('<php>echo json_encode($employee);</php>')
        var select_employee = JSON.parse('<php>echo json_encode($select_employee);</php>')
        var cur_department_id = null;
        $(function(){
            $('#department').change(function(){
                cur_department_id = $(this).val()
                showEmployee()
            })

            cur_department_id = $('#department').val()
            showEmployee()
        })
        function showEmployee(){
            $.each($('.ul_box label'), function(i,v){
                if(cur_department_id != $(v).attr('id')) {
                    $(this).hide();
                } else {
                    $(this).show();
                }
            })
        }

        function removeIframe() {
            var issit = '{$Think.get.issit}'
            if('' == issit) {
                K.removeIframe();
            } else {
                K.refreshParent();
            }            
        }

        function commit() {
            var url = '/service/customer/manage/departemployee';
            var $param = {}
            $param.list = [];
            var depart = [];
            var infor_li = [];
            $param.customer_id = '{$Think.get.id}'
            $('input[name=list]:checked').each(function(){
                $param.list.push({'department_id':$(this).attr('depart'),'employee_id':$(this).val()})                
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