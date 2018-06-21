<extend name="./Application/Admin/View/mobile/base/context/common-new.tpl"/>
<block name="common_css">

</block>
<block name="common_js">

</block>

<block name="head_left">
	<a onclick="removeIframe()"><img onclick="colse()"  class="head_left" src="/public/img/home/xlcweb/u608.png" alt="" /></a>
</block>

<block name="head_name">
	项目详情
</block>

<block name="body_main">
	<style>
		*{
			-webkit-overflow-scrolling: touch;
		}
		html,body{
			width:100%;
			height:100%;
		}
		body{
			overflow: auto;
		}
		.body{
			padding:0 10px;
			padding-bottom: 20px;
			overflow-y: scroll;
			/*overflow: auto;*/
		}
		/*清除浮动*/
		.clearFix:after {
			content: "";
			display: block;
			height: 0;
			clear: both;
		}

		.body .list{
			position: relative;
			padding: 10px 0;
			border-bottom: 1px solid #E4E4E4;
		}
		.body .list .left{
			width: 20%;
			float: left;
		}
		.body .list .right{
			width:80%;
			float: left;
		}

		.body .list select{
			border:0;
			width: 80px;
			-webkit-appearance: none;
			background: url(/public/img/home/xlcweb/u973.png) no-repeat;
			background-position: 100%;
		}
		.body .list input{
			position: absolute;
			width: 50%;
			top:10px;
			right: 0;
			border:0;
			opacity: 0;
		}
		.body .list .date_text{
			margin-left: 40px;
		}
		.body .list .calendar{
			position: absolute;
			width: 18px;
			height: 18px;
			top:12px;
			right: 5px;
		}
		.body .list  .see{
			float: right;
			color: #BFAEBF;

		}
		.body .list  .see img{
			
			margin-top: -4px;
		}
		.body .btn1{
			width: 100%;
			margin-top: 30px;
			
			font-size: 13px;
			border:0;
		}
		.body .btn1 .btncommon{
			margin: 0px;
			padding: 0;
			display: inline-block;
			width: 32.4%;
			height: 30px;
			border-radius: 5px;
			line-height: 30px;
			text-align: center;
			background-color: #E4E4E4;
		}
	</style>
	<div class="body">
	    <form action="" method="post" id="add-form-post">
	    <input type="hidden" name="project_id" value="{$project.project_id}"/>
		<input type="hidden" name="customer_id" value="{$customer_id}"/>
		<input type="hidden" name="approve_type" value=""/>
		<div class="list clearFix"><span class="left">客户名称</span><span class="right">{$customer_name}</span></div>
		<div class="list clearFix"><span class="left">项目名称</span><span class="right">{$project.name}</span></div>
		<div class="list clearFix"><span class="left">展出时间</span><span class="right">{$project.begin_date}-{$project.end_date}</span></div>
		<div class="list clearFix"><span class="left">项目相关客户</span><span class="right"><notempty name="other_cust"><php>$tmp_arr=array_column($other_cust,'name');echo implode(',',$tmp_arr);</php></notempty></span></div>
		<div class="list clearFix"><span class="left">展出规模(万)</span><span class="right">{$project.scale_fee}</span></div>
		<div class="list clearFix"><span class="left">时间时段</span><span class="right"><if condition="1 eq $project['time_type']">春节<else/>平时</if></span></div>
		<div class="list clearFix"><span class="left">展出场地</span><span class="right">{$project.address}</span></div>
		<div class="list clearFix"><span class="left">投资形式</span><span class="right"><volist name="fee_type" id="item"><if condition="$item['config_auto_id'] == $project['fee_type']">{$item.name}</if></volist></span></div>
		
		<div class="list clearFix"><span class="left">产值</span><span class="right">{$project.out_value}万</span></div>
		<div class="list clearFix"><span class="left">是否售票</span><span class="right"><php>echo (empty($project['is_ticket'])?'':('1'==$project['is_ticket']?'是':'否'));</php></span></div>
		<div class="list clearFix"><span class="left">日常门票</span><span class="right">{$project.ticket}</span></div>
		<div class="list clearFix"><span class="left">灯会期间门票</span><span class="right">{$project.run_ticket}</span></div>
		<div class="list clearFix"><span class="left width">日常客流</span><span class="right">{$project.peace_passenger}</span></div>
		<div class="list clearFix"><span class="left width">灯会期间客流</span><span class="right">{$project.run_passenger}</span></div>
		<div class="list clearFix"><span class="left width">性质及上下级关系</span><span class="right">{$project.relation}</span></div>
		<div class="list clearFix"><span class="left width">交通情况</span><span class="right">{$project.traffic}</span></div>
		<div class="list clearFix"><span class="left width">接待能力</span><span class="right">{$project.ability}</span></div>
		<div class="list clearFix"><span class="left width">收益情况</span><span class="right">{$project.income}</span></div>
		<div class="list clearFix"><span class="left width">运营方案</span><span class="right">{$project.programme}</span></div>
		<div class="list clearFix"><span class="left width">网络报道</span><span class="right">{$project.report}</span></div>
		<div class="list clearFix"><span class="left width">制作公司</span><span class="right"><php>echo ('本公司' == $project['company']?'本公司':$project['other_company']);</php></span></div>

		<div class="list clearFix"><span class="left width">项目状态</span><span class="right"><php>echo c('SON_STATUS_LIST')[$project['son_status']]</php></span></div>
		
		<div class="list clearFix"><span class="left">项目情况</span><span class="right">{$project.context}</span></div>
		<div class="list clearFix"><span class="left">项目总结</span><span class="right">{$project.summary}</span></div>
		</form>
		<div class="btn1">
			<if condition="(c('SELF_SYSTEMADMIN.role_id') != session('employee_id') && 'boss' == session('employee.role_type_code')) || ('information' eq session('employee.department_type_id') and 2 egt $project['status']) or ('business' eq session('employee.department_type_id') and (3 == $project['status'] or 5 == $project['status']))">
				<span class="btncommon" onclick="commit(1)">业务转交</span>
			</if>
			<if condition="(c('SELF_SYSTEMADMIN.role_id') != session('employee_id') && 'boss' == session('employee.role_type_code')) || ('business' eq session('employee.department_type_id')) && (3 == $project['status'] || 5 == $project['status'])">
				<span onclick="commit(2)" class="btncommon">返回跟进</span>
				<span onclick="commit(3)" class="btncommon">申请结案</span>
			</if>	
		</div>
	</div>	
</block>

<block name="footer_js">
	
	<script>

//		var pg_height=$(".body").height();
//		$(".body").css('height',pg_height+'px')
//		console.log($(".body").height())
		function checkDate(){
			var text=$(".date").val()
			$('.date_text').text(text);
		}
		function removeIframe() {
			K.removeIframe();
		}

function commit($type) {
	if(0 != $type && 3 >= $type && 'boss' == '{$Think.session.employee.role_type_code}') {
		bossCall($type)
		return;
	}
	if(0 == $type) var title = '确认要保存？'
	else var title = '确认要申请该流程？'	
	layer.confirm(title, {
      btn: ['确认', '取消'] //可以无限个按钮      
    }, function(index, layero){
        commitCall($type)
        layer.close(index);
    }, function(index){
        layer.close(index);
    });
}

function commitCall($type) {
	var url = '/service/project/manage/add';

	$('input[name=approve_type]').val($type);

	K.doAjaxSubmit('#add-form-post', url, function(response) {
		if (response.status && response.status == 'success') {
			// K.refreshParent()
			console.log(window.parent.frames['main-iframe'].contentWindow)
			window.parent.frames['main-iframe'].contentWindow.getProjData();
			K.removeIframe();
        } else {
        	if (response.message) {
        		layer.msg(response.message, {icon: 2, time: 2000});
        	} else {
        		layer.msg('后台错误!', {icon: 2, time: 2000});
        	}
        }
    });
}	

function bossCall($type) {
	var $department = JSON.parse('<php>echo json_encode($department);</php>');
	var str = '<div class="ml-20 mt-20 mr-20"><p class="title">转入</p>'
	str += '<select name="in_department_id" class="screen_department">';
	str += '<option value="">选择部门</option>';
	$.each($department,function(i,v){
		if(1 == $type && 'business' == v.department_type_id) {
			str += '<option value="'+v.department_id+'">'+v.name+'</option>';
		} else if((2 == $type || 3 == $type) && 'information' == v.department_type_id) {
			str += '<option value="'+v.department_id+'">'+v.name+'</option>';
		} 		
	})
	
	str += '</select>';	
	str += '<p class="title">批注</p>';
	str += '<textarea  class="content" name="reply" style="width:100%;height:140px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;"></textarea>';	
	str += '</div>';

	layer.open({
	  type: 1,
	  title: '选择接收的部门',
	 // skin: 'layui-layer-rim', //加上边框
	  area: ['500px', '430px'], //宽高
	  content: str,
	  btn: ['提交', '取消'], //可以无限个按钮
	  btn1: function(index,layero){
	  	if('' == $('select[name=in_department_id]').val()) {
	  		layer.msg('转入部门不能为空！', {icon: 2, time: 2000});
	  		exit;
	  	}

	  	$('input[name=in_department_id]').val($('select[name=in_department_id]').val());
	  	$('input[name=reply]').val($('textarea[name=reply]').val());

	  	commitCall($type);
	  	return true;
	  },
	  btn2: function(index){
	  	$('input[name=in_department_id]').val('');
	  	$('input[name=reply]').val('');
	  	layer.close(index);
	  },
	});
}
	</script>
</block>