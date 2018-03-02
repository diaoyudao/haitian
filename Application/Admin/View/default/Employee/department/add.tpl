<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    
</block>
<block name="body_main">
    <article class="page-container">
        <form class="form form-horizontal" id="form-notice-add">
            <input type="hidden" value="{$department.department_id}" name="department_id"/>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>分类：</label>
                <div class="formControls col-xs-8 col-sm-9"> <span class="select-box">
                <select name="department_type_id" class="select">
                    <option value=""></option>
                    <volist name="Think.config.DEPARTMENT_TYPE" id="item1">
                        <option value="{$key}" 
                        <php> if($department['department_type_id'] == $key) {echo ' selected';} </php>
                        >{$item1}</option>
                    </volist>
                </select>
                </span></div>
            </div>           
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>部门名称：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" value="{$department.name}" placeholder="" name="name">
                </div>
            </div>            
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">备注：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <textarea name="note" class="textarea" placeholder="255个字符以内"
                        style="height:120px;" dragonfly="true">{$department.note}</textarea>
                </div>
            </div>
            <div class="row cl">
                <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
                    <button class="btn btn-primary radius" type="submit">保存提交
                    </button>
                    <button onClick="removeIframe();" class="btn btn-default radius" type="button">
                        &nbsp;&nbsp;取消
                        &nbsp;&nbsp;</button>
                </div>
            </div>
        </form>
    </article>
</block>
<block name="footer_js">
    <script type="text/javascript" src="/public/huiadmin/lib/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript">

        $(function () {
            $('.skin-minimal input').iCheck({
                checkboxClass: 'icheckbox-blue',
                radioClass: 'iradio-blue',
                increaseArea: '20%'
            });

            
        });
        $("#form-notice-add").validate({
            rules: {
                department_type_id: {
                    required: true,
                },
                name: {
                    required: true,
                    rangelength: [1, 100]
                },
                note: {
                    required: false,
                    rangelength: [1, 500]
                },                
            },
            onkeyup: false,
            focusCleanup: true,
            success: "valid",
            submitHandler: function (form) {
                saveNotice();            
            }
        });

        function saveNotice() {
            var parameter = {};

            if ($('input[name=department_id]').val()) {
                var url = '/service/employee/department/change';
                parameter.department_id = $('input[name=department_id]').val();
            } else {
                var url = '/service/employee/department/add';
            }
            parameter.department_type_id = $('select[name=department_type_id]').val();
            parameter.note = $('textarea[name=note]').val();
            parameter.name = $('input[name=name]').val();

            K.doAjax(parameter, url);
        }

        function removeIframe() {
            K.removeIframe();
        }

    </script>
</block>