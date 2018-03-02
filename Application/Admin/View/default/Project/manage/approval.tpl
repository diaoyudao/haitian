<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
	<link rel="stylesheet" type="text/css" href="/public/css/project/approval.css" />
</block>

<block name="body_main">
<style>

</style>
<div class="body">
  <form class="form form-horizontal" id="form-notice-add" method="post">
	<input type="hidden" name="project_id" value="{$project.project_id}" />
	<p class="title">创建人</p>
	<p class="content"><img src="{$approve[0].thumbnail_url}" alt=""><span class="name">{$approve[0].operator_name}</span>{$approve[0].out_department_name}</p>
	<if condition="2 == $project['approve_status'] 
		&& (1 == $project['approve'] || 2 == $project['approve'] 
		|| 3 == $project['approve'])">
	<p class="title">转入</p>
	<div class="content">
		<select class="screen_department" name='handle_department_id'>
		  <if condition="2 == $project['approve'] ">
		    <volist name="department" id="item">
		  	  <if condition="'information' == $item['department_type_id']">
		  	    <option value="{$item.department_id}">{$item.name}</option>
		  	  </if>
		    </volist>
		  <else/>
		    <volist name="department" id="item">
		      <if condition="$item['department_id'] != $project['out_department_id']">
		        <option value="{$item.department_id}">{$item.name}</option>
		      </if>
		    </volist>
		  </if>
		</select>
	</div>
	</if>
	<p class="title"><if condition="'boss' == session('employee.role_type_code')">审批<else/>审核</if>意见</p>
	<div class="content">
		    <label class="lsglabel"><input name="is_pass" type="radio" value="1" checked />同意 </label> 
		    <label class="lsglabel"><input name="is_pass" type="radio" value="0" />否决 </label>
	</div>
	<p class="title">任务完成情况</p>
	<textarea  class="content" name="reply" style="width:100%;height:140px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;"></textarea>
    <div class="mt-30">
	<button class="btn btn-primary radius" type="sumbit" >保存</button>
	<button class="btn btn-default radius ml-20" onclick="removeIframe();">取消</button>
    </div>
	<div class="clear"></div>
  </form>
</div>
</block>

<block name="footer_js">
<script>
$(function(){
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
})
        function saveNotice() {
            var parameter = {};
            var url = '/service/project/manage/approve';

            K.doAjaxSubmit('#form-notice-add', url, function(res){
            	if (res.status && res.status == 'success') {
					layer.msg('保存成功!', {icon: 1, time: 2000});
					window.parent.getApproveData();
                	K.removeIframe();
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
            window.parent.getApproveData();
            K.removeIframe();
        }
</script>
</block>