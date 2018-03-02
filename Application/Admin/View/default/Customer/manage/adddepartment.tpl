<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">

</block>
<block name="common_js">

</block>

<block name="body_main">
    <article class="page-container">
        <form class="form form-horizontal" id="form-notice-add">
            <input type="hidden" value="{$Think.get.id}" name="id"/>
            <div class="row cl">
                <label class="form-label col-xs-4 col-sm-2">请输入部门/科室名称：</label>
                <div class="formControls col-xs-8 col-sm-9">
                    <input type="text" class="input-text" value="{$department.department}" placeholder="" name="department" >
                </div>
            </div>
            <div class="row cl">
                <div class="col-xs-9 col-sm-9 col-xs-offset-3 col-sm-offset-3">
                    <button class="btn btn-primary radius" type="button" onclick="commit()">保存提交
                    </button>
                    <button onClick="K.removeIframe();" class="btn btn-default radius" type="button">
                        &nbsp;&nbsp;取消
                        &nbsp;&nbsp;</button>
                </div>
            </div>
        </form>
    </article>

</block>

<block name="footer_js">
    <script>

		$(function () {
			var t=$('input[name=department]').val();
			$('input[name=department]').val("").focus().val(t);
		});
//		function removeIframe() {
//			K.refreshParent();
//		}

		function commit() {
			var param={};
			if ("" =='{$Think.get.type}') {
				var url = '/service/customer/manage/adddepartment';
				param.customer_id=$('input[name=id]').val();
			} else {
				var url = '/service/customer/manage/changedepartment';
				param.customer_department_id=$('input[name=id]').val();
			}
			param.department=$('input[name=department]').val()?$('input[name=department]').val():'未知';
			K.doAjax(param, url)
		}
    </script>
</block>