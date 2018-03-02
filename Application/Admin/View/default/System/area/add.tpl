<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/webuploader/0.1.5/webuploader.css"/>
</block>
<block name="body_main">
    <article class="page-container">
        <form class="form form-horizontal" id="form-notice-add">
            <switch name="Think.get.type">
                <case value="province">
                    <php>$id=province_id;$name=province_name;</php>
                </case>
                <case value="city">
                    <php>$id=city_id;$name=city_name;</php>
                </case>
                <default/>
                <php>$id=county_id;$name=county_name;</php>
                </php>
            </switch>
            <input type="hidden" name="pid" value="{$Think.get.pid}">
            <input type="hidden" name="id" value="{$area[$id]}">
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>名称：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" value="{$area[$name]}" placeholder="" id="" name="name">
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
    <script type="text/javascript" src="/public/huiadmin/lib/ueditor/1.4.3/ueditor.config.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/ueditor/1.4.3/ueditor.all.min.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/webuploader/0.1.5/webuploader.min.js"></script>
    <script type="text/javascript" src="/public/js/lib/uploadImage.js"></script>
    <script type="text/javascript" src="/public/js/admin/deleteImage.js"></script>
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
				areaName: {
                    required: true,
                    rangelength: [1, 100]
                },
            },
            onkeyup: false,
            focusCleanup: true,
            success: "valid",
            submitHandler: function (form) {
                var parameter = {};

                saveNotice(parameter);

            }
        });

        function saveNotice(parameter) {
            if ($('input[name=id]').val()) {
                var url = '/service/system/area/change';
            } else {
                var url = '/service/system/area/add';
            }

            parameter.name = $('input[name=name]').val();
            parameter.id = $('input[name=id]').val();
            parameter.pid = $('input[name=pid]').val();
            parameter.type = '{$Think.get.type}';
            console.log(parameter)
            K.doAjax(parameter, url);
        }

        function removeIframe() {
            K.removeIframe();
        }

    </script>
</block>