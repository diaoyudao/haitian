<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    
</block>
<block name="body_main">
    <article class="page-container">
        <form class="form form-horizontal mt-25" id="form-notice-add">
            <input type="hidden" value="{$data.config_auto_id}" name="config_auto_id"/>
            <div class="row cl ml-20"> 
                <label class="form-label "><span class="c-red">*</span>投资形式名称：</label> 
            </div> 
            <div class="row cl ml-20 mr-20">
                <div class="formControls ">
                    <input type="text" class="input-text" value="{$data.name}" placeholder="" name="name">
                </div>
            </div>                      
            <div class="row cl ml-20">
                <div class="ml-5 mt-25">
                    <button class="btn btn-primary radius mt-25" type="submit">&nbsp;保存&nbsp;
                    </button>
                    <button onClick="removeIframe();" class="btn btn-default radius ml-20 mt-25" type="button">
                        &nbsp;取消
                        &nbsp;</button>
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
                name: {
                    required: true,
                    rangelength: [1, 100]
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

            if ($('input[name=config_auto_id]').val()) {
                var url = '/service/system/manage/changefeetype';
                parameter.config_auto_id = $('input[name=config_auto_id]').val();
            } else {
                var url = '/service/system/manage/addfeetype';
            }

            parameter.name = $('input[name=name]').val();

            K.doAjax(parameter, url, function(res){
                if (res.status && res.status == 'success') {
                    window.parent.location.href="/service/system/manage/profile?t=2";
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