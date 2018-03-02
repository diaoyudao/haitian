<extend name="./Application/Admin/View/mobile/base/context/common.tpl"/>
<block name="common_css">

</block>
<block name="common_js">

</block>

<block name="body_path_name">

</block>

<block name="body_main">
	<include file="./Application/Admin/View/default/base/css/allproject.tpl" />

	<div class="right_box_content right_box_content1">
		<div class="box info_project">
			<div class="table_box_top">
				<span class="table_box_title">客户项目</span>
			</div>	
			<table class="project_table bottom_table">
				<thead>
					<tr>
						<th>项目名称</th>
						<th>展出时间<span onclick="orderProject(0)" class="glyphicon glyphicon-sort" aria-hidden="true" style="color: #1296DB"></span></th>
						<th>展出规模<span onclick="orderProject(1)" class="glyphicon glyphicon-sort" aria-hidden="true" style="color: #1296DB"></span></th>									
						<th>资金形式</th>
						<th>项目情况</th>
						<th>制作公司</th>
						<th>项目等级</th>
						<th>项目状态</th>									
						<th></th>						
					</tr>
				</thead>
				<tbody id="project-list">
					<!-- <tr class="tr_border">
						<td>1</td>
						<td>桥面装饰彩灯</td>
						<td>平时</td>
						<td>11/15 - 11/30</td>
						<td>合作</td>
						<td>500</td>
						<td>前期跟进</td>
						<td>描述一下</td>
						<td>
							<span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="LsgLayerShow('项目详情','/service/customer/search/addproject', 800, 750,50)"></span>
						</td>
					</tr>
					 -->
				</tbody>
			</table>
		</div>
		<div id="liaison-pager" class="mt-25 text-c" ></div>
		<div class="clear"></div>
	</div>
</block>

<block name="footer_js">
	<script>
		$(function(){
			callProject()
		})
		function LsgLayerShow(title,url,w,h,y){
			console.log(111);
			layer.open({
				type: 2,
				area: [w+'px', h +'px'],
				fix: false, //不固定
				maxmin: true,
				shade:0.4,
				title: title,
				content: url,
				offset: y+'px'
			});
		}

var project_pg =1;
var project_total=null;

function callPage(obj) {
	if(project_pg == obj.curr) return;
	project_pg = obj.curr
	callProject()
}
function callProject(param) {
	if(null != project_total && (1 == project_total || project_total<project_pg)) {
		return;
	}
	var param= param || {}
	param.pg = project_pg;
	param.customer_id = '{$Think.get.id}';
	var url = '/service/customer/search/project';
	K.doAjax(param, url, function(response) {
		if(response.status && 'success' == response.status) {
			if(project_total != response.total_page && 1 < response.total_page) {
				console.log('show pager')
				laypage({cont:"liaison-pager",pages:response.total_page,curr:1,
					jump:callPage
				});
				project_pg = 1
			}
			project_total = response.total_page;
			showProjectList(response)            
		}
	});
}
function showProjectList(res) {
	$('#project-list').empty()

	$.each(res.data, function(i,v){
		// var str = '<tr class="tr_border">';
		// str += '<td>'+ (i+1) +'</td>';
		// str += '<td><a onclick="LsgLayerShow(\'项目详情\',\'/service/customer/search/addproject?r=1&project_id='+v.project_id+'\', 800, 750,200)">'+ v.name +'</a></td>';
		// str += '<td>'+ (1 == v.time_type?'春节':'平时') +'</td>';
		// str += '<td>'+ K.getDateFormat2(v.begin_date) +' - ' +K.getDateFormat2(v.end_date) +'</td>';
		// str += '<td>'+ v.model_name +'</td>';
		// str += '<td>'+ v.scale_fee +'</td>';
		// str += '<td>'+ v.status_name +'</td>';
		// str += '<td>'+ (v.context?v.context:'') +'</td>';
		// str += '<td><span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="LsgLayerShow(\'项目详情\',\'/service/customer/search/addproject?project_id='+v.project_id+'\', 800, 750,50)"></span></td></tr>';

		var str = '<tr class="tr_border">';
		str += '<td><a onclick="LsgLayerShow(\'项目详情\',\'/service/customer/search/addproject?r=1&project_id='+v.project_id+'\', 800, 900,50)">'+ v.name +'</a></td>';
		str += '<td>'+ (v.begin_date?v.begin_date:'') +' - ' + (v.end_date?v.end_date:'') +'</td>';
		str += '<td>'+ v.scale_fee +'</td>';
		str += '<td>'+ (v.fee_type?v.fee_type:'') +'</td>';
		str += '<td ><span>'+ (v.context?v.context:'') +'</span></td>';
		str += '<td>'+ (v.company?('本公司'!= v.company?(v.other_company):v.company):'') +'</td>';
		str += '<td>'+ (v.level?('Z' == v.level?'普通':(v.level+'级')):'') +'</td>';		
		str += '<td>'+ v.status_name +'</td>';		

		if('本公司' != v.company || 'boss' == '{$Think.session.employee.role_type_code}' || (((2 >= v.status && 'information' == '{$Think.session.employee.department_type_id}') || (2 < v.status && 'business' == '{$Think.session.employee.department_type_id}')))) {
			str += '<td><span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="LsgLayerShow(\'项目详情\',\'/service/customer/search/addproject?project_id='+v.project_id+'\', 800, 815,50)"></span><i onclick="delList(\'delproj\','+v.project_id+')" class="Hui-iconfont ml-10" style="font-size:16px;">&#xe6e2;</i></td></tr>';
		}else{
			str += '<td></td></tr>'
		}

		$('#project-list').append(str);    	
	})
}

var order_proj = [['begin_date','begin_date desc'],['scale_fee','scale_fee desc']];
var sort_proj = 0;
function orderProject(t) {
	console.log('==',t)
	var param = {}
	param.order = order_proj[t][sort_proj];
	project_pg = 1;
	project_total = null;
	$('#project-list').empty(); 
	sort_proj = (1== sort_proj? 0 :1);

	callProject(param)
}

function delList(func, id) {
    var title = '确认要删除？';

    layer.confirm(title, {
      btn: ['确认', '取消'] //可以无限个按钮      
    }, function(index, layero){
        window[func](id)
        layer.close(index);
    }, function(index){
        layer.close(index);
    });

}
function delproj(id) {
	var param={
		project_id: id
	}
	var url = '/service/project/manage/del';
	K.doAjax(param, url, function(res) {
		if(res.status && 'success' == res.status) {
			// 异步加载项目
			project_total = null;
			project_pg=1;
			$('#project-list').empty();
			callProject()
		} else {
			layer.msg('失败:'+(res.message?res.message:''), {icon: 2, time: 2000});
		}
	});
}

	</script>
</block>