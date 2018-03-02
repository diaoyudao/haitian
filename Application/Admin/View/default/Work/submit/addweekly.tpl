<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
    <link href="/public/css/work/submit/addweekly.css" rel="stylesheet" type="text/css"/>
</block>

<block name="body_main">
    <style>

    </style>
    <div class="body">
        <form class="form form-horizontal" id="form-notice-add" type="post">
            <input type="hidden" name="work_export_id" value="{$Think.get.id}">
            <input type="hidden" name="date" value="{$Think.get.date}">
            <p class="title">分类</p>
            <div class="content">
                <select class="screen_department" name="type">
                    <option value="0"
                    <php>if($export['type'] == 0){echo 'selected';} </php>
                    >常规跟进</option>
                    <option value="1"
                    <php>if($export['type'] == 1){echo 'selected';} </php>
                    >重点跟进</option>
                    <option value="2"
                    <php>if($export['type'] == 2){echo 'selected';} </php>
                    >款项跟进</option>
                </select>
            </div>
            <p class="title">客户</p>
            <div class="content">
                <select class="screen_department" name="customer_id">
                    <volist name="customers" id="item">
                        <option value="{$item.customer_id}"
                        <php>if($export['customer_id'] == $item['customer_id']){echo 'selected';} </php>
                        >{$item.name}</option>
                    </volist>
                </select>
            </div>
            <p class="title">联系人</p>
            <div class="content">
                <select class="screen_department" name="contact">
                    <volist name="contact" id="cc">
                        <option value="{$cc.customer_contact_id}"
                        <php>if($export['customer_contact_id'] ==
                            $cc['customer_contact_id']){echo 'selected';} </php>
                        >{$cc.name}</option>
                    </volist>
                </select>
            </div>
            <p class="title">项目</p>
            <div class="content">
                <select class="screen_department" name="project">
                    <volist name="project" id="pp">
                        <option value="{$pp.project_id}"
                        <php>if($export['project_id'] == $pp['project_id']){echo 'selected ';}</php>
                        >{$pp.name}</option>
                    </volist>
                </select>
            </div>
            <p class="title">工作内容</p>
            <p class="content"><input class="input_text" type="text" name="desc" value="{$export.desc}"></p>
            <p class="title">完成情况</p>
            <div class="content">
                <label class="lsglabel"><input name="is_over" type="radio" value="1"
                    <php> if(empty($export) || ((!empty($export)) && $export['is_over'] == 1) )
                        {echo ' checked ';} </php>
                    /> 已完成</label>
                <label class="lsglabel"><input name="is_over" type="radio" value="0"
                    <php> if((!empty($export)) && $export['is_over'] == 0)
                        {echo ' checked ';} </php>
                    /> 未完成</label>
            </div>
            <p class="title">具体情况</p>
            <textarea class="content" style="width:100%;height:140px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;"
                      name="context">{$export.context}</textarea>
            <div class="row cl">
                <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
                    <button class="btn btn-primary radius" type="submit">保存提交
                    </button>
                    <button onClick="removeIframe();" class="btn btn-default radius" type="button">
                        &nbsp;&nbsp;取消
                        &nbsp;&nbsp;
                    </button>
                </div>
            </div>
        </form>
    </div>
</block>

<block name="footer_js">
    <script>
		$('select[name=customer_id]').change(function () {
			var customer_id = $(this).val();
			listPost(customer_id);
		});


		function listPost(id) {
			var param ={};
			param.customer_id = id;

            

			var url = '/service/work/submit/lists';
			K.doAjax(param, url, function (e) {
				if (e.status && e.status == "success") {
					console.log(e)
					var contact = $('select[name=contact]');
					var project = $('select[name=project]');
					project.empty();
					contact.empty();
					for (var i = 0; i < e.contact.length; i++) {
						var option = $('<option value="' + e.contact[i]['project_id'] + '">' + e.contact[i]['name'] + '</option>');
						option.appendTo(contact);
					}
					for (var j = 0; j < e.project.length; j++) {
						var options = $('<option value="' + e.project[j]['project_id'] + '">' + e.project[j]['name'] + '</option>');
						options.appendTo(project);
					}

				} else {
					if (e.message) {
						layer.msg(e.message, {icon: 2, time: 1500})
					} else {
						layer.msg("后台错误!", {icon: 2, time: 1500})
					}
				}

			})
		}

		$("#form-notice-add").validate({
			// rules: {
			// 	context: {
			// 		required: true,
			// 	},
			// 	is_over: {
			// 		required: true,
			// 	},
			// 	desc: {
			// 		required: false,
			// 		rangelength: [1, 100]
			// 	},
			// },
			// onkeyup: false,
			// focusCleanup: true,
			// success: "valid",
			submitHandler: function (form) {
				saveNotice();
			}
		});

		function saveNotice() {
			var parameter = {};

            if($("select[name='type']").val()==null){
                console.log("请选择分类");
                layer.msg('请选择分类!', {icon: 2, time: 2000});
                return;
            }else if($("select[name='customer_id']").val()==null){
                console.log("请选择客户");
                layer.msg('请选择客户!', {icon: 2, time: 2000});
                return;
            }else if($("select[name='contact']").val()==null){
                console.log("请选择联系人");
                layer.msg('请选择联系人!', {icon: 2, time: 2000});
                return;
            }
            console.log("--------------");

			if ($('input[name=work_export_id]').val()) {
				var url = '/service/work/submit/changeweekly';
				parameter.work_export_id = $('input[name=work_export_id]').val();
			} else {
				var url = '/service/work/submit/addweekly';
			}
			parameter.type = $('select[name=type]').val();
			parameter.customer_id = $('select[name=customer_id]').val();
			parameter.project_id = $('select[name=project]').val();
			parameter.customer_contact_id = $('select[name=contact]').val();
			parameter.context = $('textarea[name=context]').val();
			parameter.is_over = $('input[type=radio][name=is_over]:checked').val();
			parameter.desc = $('input[name=desc]').val();
			parameter.date = $('input[name=date]').val();

			K.doAjax(parameter, url);
		}
		function removeIframe() {
			K.removeIframe();
		}
    </script>
</block>