<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
	<link href="/public/css/task/select.css" rel="stylesheet" type="text/css" />
	<link href="/public/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
</block>
<block name="body_main">
	<style>
		/*清除浮动*/
		.clearfix:after {
			content: "";
			display: block;
			height: 0;
			clear: both;
		}
		.body .th{
			width: 100%;
			padding-bottom: 10px;
			border-bottom: 1px solid #D7D7D7;
		}
		.body .left{
			width: 20%;
			float: left;
		}
		.body .right{
			width: 78%;
			float: left;
		}
		.body .information li{
			padding: 10px 0;
			border-bottom: 1px solid #D7D7D7;
		}
		.fr{
			float:right;
		}
		.body .page .all{
			line-height: 72px;
			margin-right: 20px;
			color: #9D969B;
		}
	</style>
	<div class="body">
			<div class="th clearfix">
				<div class="left">时间</div>
				<div class="right">内容</div>
			</div>
			<ul class="information" id="context-list">
				<li class="clearfix">
					<div class="left">2017-3-25</div>
				     <div class="right">内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容</div>	
				</li>
			</ul>

			<!-- 分页 -->
			<div class="page">
				<div id="liaison-pager" class="mt-25 text-c" ></div>
				<span class="fr all" id="total-row">共0条</span>
			</div>
			
	</div>
</block>

<block name="footer_js">
<script>
$(function(){
			callProject()
		})
var project_pg =1;
var project_total=null;

function callPage(obj) {
	if(project_pg == obj.curr) return;
	project_pg = obj.curr
	callProject()
}
function callProject() {
	if(null != project_total && (1 == project_total || project_total<project_pg)) {
		return;
	}
	var param={}
	param.pg = project_pg;
	param.customer_id = '{$Think.get.id}';
	var url = '/service/send/sms/list';
	K.doAjax(param, url, function(response) {
		if(response.status && 'success' == response.status) {
			if(project_total != response.total_page && 1 < response.total_page) {
				console.log('show pager')
				laypage({cont:"liaison-pager",pages:response.total_page,curr:1,
					jump:callPage
				});
				project_pg = 1
				$('#total-row').text('共'+response.counts+'条')
			}
			project_total = response.total_page;
			showProjectList(response)  			          
		}
	});
}
function showProjectList(res) {
	$('#context-list').empty()

	$.each(res.data, function(i,v){
		var str = '<li class="clearfix">';
		str += '<div class="left">'+v.create_time+'</div>';
		str += '<div class="right">'+ v.context +'</div></li>';
		
		$('#context-list').append(str);    	
	})
}

</script>
</block>