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
                <label class="form-label col-xs-3 col-sm-2"><span class="c-red">*</span>姓名：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" value="{$employee.name}" placeholder="" name="name" />
                </div>
            </div>            
            <div class="row cl">
                <label class="form-label col-xs-3 col-sm-2"><span class="c-red">*</span>性别：</label>
                <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                    <div class="radio-box">
                        <input name="sex" type="radio" value="1" id="identity-1"
                        <if condition="empty($employee) or $employee.sex eq 1">checked</if>
                        >
                        <label for="identity-1">男</label>
                    </div>
                    <div class="radio-box">
                        <input type="radio" value="2" name="sex" id="identity-2"
                        <if condition="$employee.sex eq 2">checked</if>
                        >
                        <label for="identity-2">女</label>
                    </div>
                </div>
            </div> 
            <div class="row cl">
                <label class="form-label col-xs-3 col-sm-2"><span class="c-red">*</span>部门：</label>
                <div class="formControls col-xs-8 col-sm-9"> <span class="select-box">
                <select name="department_id" class="select">
                    <option value="">请选择部门</option>
                    <volist name="department" id="item2">
                        <option value="{$item2.department_id}" 
                        <php> if($employee['department_id'] == $item2['department_id']) {echo ' selected';} 
                        </php> 
                        >{$item2.name}</option>
                    </volist>
                </select>
                </span></div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>职位：</label>
                <div class="formControls col-xs-8 col-sm-9"> <span class="select-box">
                <select name="role_id" class="select">
                    <option value="">请选择职位</option>
                    <volist name="role" id="item2">                       
                        <option value="{$item2.role_id}" 
                        <php> if($employee['role_id'] == $item2['role_id']) {echo ' selected';} 
                        </php> 
                        >{$item2.name}</option>
                    </volist>
                </select>
                </span></div>
            </div>                     
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>手机(账号)：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" value="{$employee.phone}" placeholder="" name="phone">
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
                        <span style="margin-left:10px;color:#999;">尺寸：640X896像素</span>
                    </div>
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>登录密码：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="password" class="input-text" value="{$employee.password}" placeholder="" name="password">
                </div>
            </div>          
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>状态：</label>
                <div class="formControls col-xs-8 col-sm-9 skin-minimal">
                    <div class="radio-box">
                        <input name="status" type="radio" value="1" id="status-valied"
                        <php> if(empty($employee) || ((!empty($employee)) && $employee['status'] == 1) )
                            {echo ' checked ';} </php>
                        >
                        <label for="status-valied">启用</label>
                    </div>
                    <div class="radio-box">
                        <input type="radio" value="0" name="status" id="status-unvalied"
                        <php> if((!empty($employee)) && $employee['status'] == 0){echo ' checked ';} </php>
                        >
                        <label for="status-unvalied">禁用</label>
                    </div>
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
        $("#form-notice-add").validate({
            rules: {
                name: {
                    required: true,
                    rangelength: [1, 100]
                },
                department_id: {
                    required: true,
                },
                role_id: {
                    required: true,
                },  
                phone: {
                    digits:true,
                    rangelength:[11,11],
                    required: true,
                },   
                password: {
                    rangelength:[6,40],
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

        function saveNotice() {
            var parameter = {};

            if ($('input[name=employee_id]').val()) {
                var url = '/service/employee/user/change';
                parameter.news_id = $('input[name=department_id]').val();
            } else {
                var url = '/service/employee/user/add';
            }

            K.doAjaxSubmit('#form-notice-add', url, function (response) {
                if (response.status && response.status == 'success') {
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

        function removeIframe() {
            K.removeIframe();
        }

    </script>
</block>