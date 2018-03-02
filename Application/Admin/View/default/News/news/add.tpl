<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/webuploader/0.1.5/webuploader.css"/>
</block>
<block name="body_main">
    <article class="page-container">
        <form class="form form-horizontal" id="form-notice-add">
            <input type="hidden" value="{$notice.news_id}" name="news_id"/>
            <input type="hidden" value="{$notice.head_icon}" name="head_icon"/>
            <input type="hidden" value="{$notice.thumbnail_url}" name="thumbnail_url"/>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>分类名称：</label>
                <div class="formControls col-xs-8 col-sm-9"> <span class="select-box">
                <select name="news_type_id" class="select">
                    <option value=""></option>
                    <volist name="type" id="item1">
                        <option value="{$item1.news_type_id}"
                        <php>if($notice['news_type_id'] == $item1['news_type_id']) {echo 'selected';}</php>
                        >{$item1.name}</option>
                    </volist>
                </select>
                </span></div>
            </div>
             <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>标签：</label>
                <div class="formControls col-xs-8 col-sm-9"> <span class="select-box">
				<select name="tags" class="select">
                    <option value=""></option>
                    <volist name="tags" id="item1">
                        <option value="{$item1}"
                        <php>if($notice['tags'] == $item1) {echo 'selected';}</php>
                        >{$item1}</option>
                    </volist>
                </select>
				</span></div>
            </div>

            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>标题：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" value="{$notice.title}" placeholder="" id="" name="title">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">头条：</label>
                <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                    <div class="radio-box">
                        <input type="checkbox" id="stick" name="stick" value="1"
                        <if condition="$notice.stick eq 1">checked="checked"</if>
                        />
                    </div>
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>排序权重：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" value="{$notice.weight|default=0}" placeholder="" id=""
                           name="weight">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">来源：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" value="{$notice.source}" placeholder="" id="" name="source">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">作者：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" value="{$notice.author}" placeholder="" id="" name="author">
                </div>
            </div>

            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">发布开始时间(默认立即生效)：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" id="datemin"
                           name="begin_time"
                           value="{$notice.begin_time}" class="input-text Wdate">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">发布结束时间：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" id="datemax"
                           name="end_time"
                           value=" {$notice.end_time}"
                           class="input-text Wdate">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">发布失效时间：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" id="datemax"
                           name="delete_time"
                           value="{$notice.delete_time}"
                           class="input-text Wdate">
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">内容描述：</label>
                <div class="formControls col-xs-8 col-sm-9">
							<textarea name="description" class="textarea" placeholder="255个字符以内"
                                      style="height:120px;" dragonfly="true">{$notice.description}</textarea>
                </div>
            </div>
            <div id="uploader" class="row cl">
                <label class="form-label col-xs-4 col-sm-2">封面图片(最大{$Think.config.UPLOAD_IMAGE_MAX_SIZE}M)：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <div id="uploader-demo"></div>
                    <div class="btns">
                        <div id="fileList" class="uploader-list"></div>
                        <div id="filePicker">选择图片</div>
                        <button class="btn btn-default radius ml-5" onclick="deleteImage1()" type="button">删除</button>
                    </div>
                </div>
            </div>

            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">详细内容：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <script id="editor" type="text/plain" style="width:100%;height:500px;"></script>
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

            var addImageToList = function (image_id, file_url) {
                var $list = $(image_id);
                if (!file_url) {
                    $list.empty();
                    return;
                }
                var $li = $(
                        '<div id="' + file_url + '" class="file-item thumbnail">' +
                        '<img src="' + file_url + '">' +
                        '<div class="info">' + '</div>' +
                        '</div>'
                );
                $list.empty();
                $list.append($li);
            };

            var image = new IMAGE('fileList', '#filePicker', 200, 100, true, function (e, i) {
                $("input[name=thumbnail_url]").val(i.thumbnail_url);
                $("input[name=head_icon]").val(i.image_url);
                $("#" + e.id + '#fileList').addClass("upload-state-done")
            });
            image.init();

            addImageToList('#fileList', "{$notice.thumbnail_url}");

            var ue = UE.getEditor('editor', {
                serverUrl: '/1fd3ab97ee/vendor/ueditor/index',
                /*
                 toolbars: [
                 ['fullscreen', '|', 'undo', 'redo', '|',
                 'bold', //加粗
                 'italic', //斜体
                 'underline', //下划线
                 'strikethrough', //删除线
                 '|',
                 'link', 'unlink', '|', 'simpleupload', //单图上传
                 'map', //Baidu地图
                 'gmap', //Google地图
                 'insertvideo', //视频
                 'background', //背景
                 ],
                 [
                 'source', //源代码
                 'indent', '|',  //首行缩进
                 'inserttable', //插入表格
                 'insertrow', //前插入行
                 'insertcol', //前插入列
                 'mergeright', //右合并单元格
                 'mergedown', //下合并单元格
                 'deleterow', //删除行
                 'deletecol', //删除列
                 'splittorows', //拆分成行
                 'splittocols', //拆分成列
                 'splittocells', //完全拆分单元格
                 'deletecaption', //删除表格标题
                 'inserttitle', //插入标题
                 'mergecells', //合并多个单元格
                 'deletetable', //删除表格
                 '|',
                 'cleardoc', //清空文档
                 ]
                 ]
                 */
            });

            ue.ready(function () {
                var note = '<php> echo $notice["content"];</php>';
                ue.setContent(note);  //赋值给UEditor
            });


        });
        $("#form-notice-add").validate({
            rules: {
                news_type_id: {
                    required: true,
                },

                title: {
                    required: true,
                    rangelength: [1, 100]
                },
                tags: {
                    required: true,
                    rangelength: [1, 50]
                },

                source: {
                    required: false,
                    rangelength: [1, 50]
                },
                description: {
                    required: false,
                    rangelength: [1, 255]
                },
                weight: {
                    required: true,
                    digits: true
                },
            },
            onkeyup: false,
            focusCleanup: true,
            success: "valid",
            submitHandler: function (form) {
                var parameter = {};
                // 判断是否需要有头条
                if ($('input[name=stick]:checkbox').is(':checked')) {
                    parameter.stick = 1;
                } else {
                    parameter.stick = 0;
                }

                if (1 == parameter.stick) {
                    if ('' == $('input[name=head_icon]').val()) {
                        layer.msg('头条至少要上传一张封面图片', {icon: 2, time: 2000})
                        return false;
                    }
                    var news_type_id = $('select[name=news_type_id]').val();
                    var news_id = '{$notice.news_id}';
                    var param = {news_type_id: news_type_id,};
                    K.doAjax(param, "/1fd3ab97ee/news/news/webstick", function (req) {
                        if (0 < req.number) {
                            layer.confirm('头条位置已被其他文章占用，是否更新为此篇文章？', {
                                btn: ['确认', '取消'] //按钮
                            }, function () {
                                saveNotice(parameter);
                            }, function () {
                                return;
                            });
                        } else {
                            saveNotice(parameter);
                        }
                    });
                } else {
                    saveNotice(parameter);

                }

            }
        });

        function saveNotice(parameter) {
            if ($('input[name=news_id]').val()) {
                var url = '/1fd3ab97ee/news/news/change';
                parameter.news_id = $('input[name=news_id]').val();
            } else {
                var url = '/1fd3ab97ee/news/news/add';
            }
            parameter.news_type_id = $('select[name=news_type_id]').val();
            parameter.description = $('textarea[name=description]').val();
            parameter.title = $('input[name=title]').val();
            parameter.tags = $('select[name=tags]').val();
            parameter.weight = $('input[name=weight]').val();
            parameter.source = $('input[name=source]').val();
            parameter.author = $('input[name=author]').val();
            parameter.begin_time = $('input[name=begin_time]').val();
            parameter.end_time = $('input[name=end_time]').val();
            parameter.head_icon = $('input[name=head_icon]').val();
            parameter.thumbnail_url = $('input[name=thumbnail_url]').val();
            if ((UE.getEditor('editor').hasContents())) {
                parameter.note = UE.getEditor('editor').getContent();
            }
            K.doAjax(parameter, url);
        }

        function removeIframe() {
            K.removeIframe();
        }

    </script>
</block>