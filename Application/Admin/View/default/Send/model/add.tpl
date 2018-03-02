<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="body_main">
    <article class="page-container">
        <form class="form form-horizontal" id="form-admin-add">
            <input type="hidden" value="{$model.sms_model_id}" name="sms_model_id">
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>短信模板ID：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" value="{$model.sms_model_code}" placeholder="" id="sms_model_code"
                           name="sms_model_code">
                </div>
            </div>

            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>短信模板内容：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <textarea  type="text" class="input-text"  name="note" style="height: 100px;overflow-y: scroll;resize: none;">{$model.note}</textarea>
                </div>
            </div>

            <div class="row cl">
                <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                    <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
                    <button onClick="K.removeIframe();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
                </div>
            </div>
        </form>
    </article>
</block>

<block name="footer_js">
    <script type="text/javascript">
        $(function () {
            $('.skin-minimal input').iCheck({
                checkboxClass: 'icheckbox-blue',
                radioClass: 'iradio-blue',
                increaseArea: '20%'
            });

            $("#form-admin-add").validate({
                rules: {
					sms_model_code: {
                        required: true,

                    },
                    note: {
                        required: true,

                    }
                },

                onkeyup: false,
                focusCleanup: true,
                success: "valid",
                submitHandler: function (form) {
                    var param ={};

                    
                    param.sms_model_code = $('input[name=sms_model_code]').val();
					param.note = $('textarea[name=note]').val();

                    var sms_model_id = $('input[name=sms_model_id]').val();
                    if (sms_model_id) {
                        param.sms_model_id = sms_model_id;
                        K.doAjax(param, '/service/send/model/change');
						parent.parent.modelAjax()
                    } else {
                        K.doAjax(param, '/service/send/model/add');
						parent.parent.modelAjax()
                    }
                }
            });
        });
    </script>
</block>