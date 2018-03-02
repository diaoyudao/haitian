<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/webuploader/0.1.5/webuploader.css"/>
</block>
<block name="body_main">
    <article class="page-container">
        <form class="form form-horizontal" id="form-notice-add">
            <input type="hidden" value="{$Think.get.id}" name="employee_id"/>
            <input type="hidden" value="{$employee.head_image}" name="head_image"/>
            <input type="hidden" value="{$employee.thumbnail_url}" name="thumbnail_url"/>
            <div class="row cl">
                <label class="form-label col-xs-3 col-sm-2"><span class="c-red"> </span>姓名：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <span>{$Think.session.employee.name}</span>                    
                </div>
            </div>            
            <div class="row cl">
                <label class="form-label col-xs-3 col-sm-2"><span class="c-red"> </span>性别：</label>
                <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                    <span><if condition="1 == session('employee.sex')">男<else/>女</if></span>
                </div>
            </div> 
            <div class="row cl">
                <label class="form-label col-xs-3 col-sm-2"><span class="c-red"> </span>部门：</label>
                <div class="formControls col-xs-8 col-sm-9"> <span >
                    {$Think.session.employee.department_name}                
                </span></div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2"><span class="c-red"> </span>职位：</label>
                <div class="formControls col-xs-8 col-sm-9"> <span >
                    {$Think.session.employee.role_name}      
                </span></div>
            </div>                     
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2"><span class="c-red"> </span>手机(账号)：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <span>{$Think.session.employee.phone}</span>                     
                </div>
            </div>  
            <div id="uploader" class="row cl">
                <label class="form-label col-xs-4 col-sm-2">头像图片：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <!--用来存放文件信息-->
                    <div id="uploader-demo"></div>
                    <div class="btns">
                        <div id="fileList" class="uploader-list"></div>
                        <div id="filePicker">选择图片</div>                        
                        <span style="margin-left:10px;color:#999;">尺寸：320X320像素</span>
                    </div>
                </div>
            </div>                    
            
            <div class="row cl ">
                <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2 pt-25 mt-25">
                    <button class="btn btn-primary radius" type="button" onclick="saveNotice()">保存
                    </button>                    
                </div>
            </div>
        </form>
    </article>
</block>
<block name="footer_js">
    <script type="text/javascript" src="/public/huiadmin/lib/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/webuploader/0.1.5/webuploader.min.js"></script>
    <script type="text/javascript" src="/public/js/lib/uploadImage.js"></script>
    <script type="text/javascript">

        $(function () {
            $('.skin-minimal input').iCheck({
                checkboxClass: 'icheckbox-blue',
                radioClass: 'iradio-blue',
                increaseArea: '20%'
            });

            var role_list = JSON.parse('<php>echo json_encode($role);</php>');

            // $('select[name=department_id]').change(function(){
            //     var temp = $(this).val();

            //     $('select[name=role_id]').empty();
            //     $.each(role_list, function(i,v) {
            //         if(temp == v.department_id) {
            //             console.log('role=',v.name);
            //             $('select[name=role_id]')
            //         .append('<option value="'+ v.role_id +'" selected>'+ v.name + '</option>');
            //         }
            //     });                
            // });

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

            var image = new IMAGE('fileList', '#filePicker', 100, 100, true, function (e, i) {
                $("input[name=thumbnail_url]").val(i.thumbnail_url);
                $("input[name=head_image]").val(i.image_url);
                $("#" + e.id + '#fileList').addClass("upload-state-done")
            });

            image.init();
            addImageToList('#fileList', "{$employee.thumbnail_url}");
            
        });

        function saveNotice() {
            var param = {};
            if("" != $('input[name=thumbnail_url]').val())
                param.thumbnail_url = $('input[name=thumbnail_url]').val();
            if("" != $('input[name=head_image]').val())
                param.head_image = $('input[name=head_image]').val();

            var url = '/service/employee/user/changeme';

            K.doAjax(param, url, function (response) {
                if (response.status && response.status == 'success') {
                    layer.msg('保存成功！', {icon: 1, time: 2000});
                    setTimeout("K.refreshParent()", 2000)
                } else {
                    if (response.message) {
                        layer.msg(response.message, {icon: 2, time: 2000});
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