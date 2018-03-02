<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/webuploader/0.1.5/webuploader.css"/>
</block>
<block name="body_main">
    <article class="page-container">
        <form class="form form-horizontal" id="form-add" enctype="multipart/form-data">
            <input type="hidden" value="{$type.news_type_id}" name="news_type_id"/>
            <input type="hidden" value="{$type.head_icon}" name="head_icon"/>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>分类名称：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" value="{$type.name}" placeholder="" id="" name="name">
                </div>
            </div>
            <!--<div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">描述：</label>
                <div class="formControls col-xs-8 col-sm-9">
							<textarea name="desc" cols="" rows="6" class="textarea" placeholder="500个字符以内"
                                      style="height:200px;" dragonfly="true">{$type.desc}</textarea>
                </div>
            </div>
            <div id="uploader" class="row cl">
                <label class="form-label col-xs-4 col-sm-2">图片(最大{$Think.config.UPLOAD_IMAGE_MAX_SIZE}M)：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <div id="uploader-demo"></div>
                    <div class="btns">
                        <div id="fileList" class="uploader-list"></div>
                        <div id="filePicker">选择图片</div>
                        <button class="btn btn-default radius ml-5" onclick="deleteImage1()" type="button">删除</button>
                    </div>
                </div>
            </div>-->
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">失效时间：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" id="delete_time"
                           name="delete_time"
                           value="{$type.delete_time}"
                           class="input-text Wdate">
                </div>
            </div>
            <div class="row cl">
                <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
                    <button class="btn btn-primary radius" type="submit">保存</button>
                    <button onClick="K.removeIframe();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
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


            $("#form-add").validate({
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

                    if ($('input[name=news_type_id]').val()) {
                        var url = '/1fd3ab97ee/news/type/change';
                    } else {
                        var url = '/1fd3ab97ee/news/type/add';
                    }
                    K.doAjaxSubmit('#form-add', url, function (response) {
                        if (response.status && response.status == 'ok') {
                            parent.window.location.reload(parent.window.location.href);
                        } else {
                            if (response.message) {
                                layer.msg(response.message, {icon: 2, time: 1500});
                            } else {
                                layer.msg('后台错误!', {icon: 2, time: 1500});
                            }
                        }
                    });
                }
            });
        });

        function removeIframe() {
            K.removeIframe();
        }

    </script>
</block>