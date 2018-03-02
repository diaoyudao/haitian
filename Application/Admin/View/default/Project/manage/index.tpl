<extend name="./Application/Admin/View/default/base/context/common.tpl"/>
<block name="common_css">
	<link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap-datetimepicker.min.css">
	<link rel="stylesheet" type="text/css" href="/public/bootstrap-select/css/bootstrap-select.min.css">
	<link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui/css/H-ui.min.css" />
	<link rel="stylesheet" type="text/css" href="/public/css/project/index.css" />
</block>
<block name="common_js">

</block>

<block name="body_path_name">
	项目管理
</block>

<block name="body_main">
	<style>
		
	</style>
	<div class="body">
		<div class="right_box">
			<div class="right_box_content">
				<div class="screen_box">
					<if condition="'boss' eq session('employee.role_type_code')">
						<select class="screen_department" name="department_id">
							<option value="">全部部门</option>
							<volist name="department" id="item">
								<option value="{$item.department_id}">{$item.name}</option>			  
							</volist>
						</select>
					</if>
					<select class="screen_department" placeholder="申请时间先后" name="order">
						<option value="1">申请时间先后</option>
						<option value="2">项目级别高低</option>
						<option value="3">项目规模多少</option>
						<option value="4">项目日期近远</option>
					</select>					
				</div>
				<div style="background-color: #fff;margin-top:10px;">
					<ul class="nav nav-tabs" style="background-color: #fff;padding:10px;padding-bottom: 0;">				
						<li role="presentation" class="active"><a href="#">合作中</a></li>
						<li role="presentation"><a href="#">ABC项目</a></li>
						<li role="presentation" ><a href="#">转交业务</a></li>
						<li role="presentation"><a href="#">储备项目</a></li>
						<li role="presentation"><a href="#">前期跟进</a></li>
						<li role="presentation"><a href="#">返回区域</a></li>
						<li role="presentation"><a href="#">结案项目</a></li>
						<li role="presentation"><a href="#">已结束</a></li>
					</ul>
					<div class="content_box total_content_box">
						<table class="table">
							<thead>
								<tr>
									<th>客户</th>
									<th>地区</th>
									<th>类型</th>
									<th>项目名称</th>
									<th>状态</th>
									<th>项目日期</th>
									<th>规模（万）</th>
									<th>操作</th>
									<th>关联客户</th>
								</tr>
							</thead>
							<tbody id="context-list">
								<!-- <tr>
									<td>成都市文殊院<img class="grade_icon" src="/public/img/project/a.png" alt=""></td>
									<td>四川省成都市</td>
									<td>政府单位</td>
									<td>灯会嘉年华</td>
									<td>ABC-进展中</td>
									<td>2017.07.01</td>
									<td>200</td>
									<td>
										<button type="button" class="btn btn-default">项目详情</button>
										<button type="button" class="btn btn-default">客户详情</button>
										<button type="button" class="btn btn-default">新建联络</button>
									</td>
								</tr>
								<tr>
									<td>成都市文殊院<img class="grade_icon" src="/public/img/project/a.png" alt=""></td>
									<td>四川省成都市</td>
									<td>政府单位</td>
									<td>灯会嘉年华</td> 
									<td>ABC-进展中</td>
									<td>2017.07.01</td>
									<td>200</td>
									<td>
										<button type="button" class="btn btn-default" onclick="LsgLayerShow('项目详情','/service/customer/search/addproject', 800, 750,100)">项目详情</button>
										<button type="button" class="btn btn-default">客户详情</button>
										<button type="button" class="btn btn-default" onclick="LsgLayerShow('联络记录','/service/customer/search/addliaison?id={$data.customer_id}', 800, 820,50)">新建联络</button>
									</td>
								</tr> -->
							</tbody>
						</table>
						<div id="pager0" class="mt-25 text-c" ></div>
						<div class="clear"></div>
					</div>
				</div>


			</div>
		</div>
	</div>
</block>

<block name="footer_js">
	<script type="text/javascript" src="/public/huiadmin/static/h-ui.admin/js/H-ui.admin.js"></script>
	<script type="text/javascript" src="/public/js/lib/common-1.js"></script>
<script>
$(function() {
	$(".nav-tabs li").click(function(){
		$(".nav-tabs li").removeClass("active");
		$(this).addClass("active");
		cur_index = $(this).index();
		if(0 == cur_index) $type = 4;
		else if(1 == cur_index) $type = 5;
		else if(2 == cur_index) $type = 3;
		else if(3 == cur_index) $type = 2;
		else if(4 == cur_index) $type = 1;
		else if(5 == cur_index) $type = 12;
		else if(6 == cur_index) $type = 6;
		else if(7 == cur_index) $type = 7;

		$cur_pg = 1;
		getProjData()
	});
			
	//进度条
	var lsg_number = $('#progress_content').attr('data-progress');

	if ( lsg_number ==0 ) {
		$(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(1) p").addClass('lan');
	};

	if ( lsg_number ==1  ) {
		$(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(1) p").addClass('lan');
		$(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(2) p").addClass('lan');
		lsgload(170, '.progress-box-1');
	};

	if ( lsg_number ==2  ) {
		$(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(1) p").addClass('lan');
		$(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(2) p").addClass('lan');
		$(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(3) p").addClass('lan');
		lsgload(330, '.progress-box-1');
	};

	if ( lsg_number ==3  ) {
		$(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(1) p").addClass('lan');
		$(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(2) p").addClass('lan');
		$(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(3) p").addClass('lan');
		$(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(4) p").addClass('lan');
		lsgload(500, '.progress-box-1');
	};

	if ( lsg_number ==4) {
		$(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(1) p").addClass('lan');
		$(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(2) p").addClass('lan');
		$(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(3) p").addClass('lan');
		$(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(4) p").addClass('lan');
		$(".mature-progress .mature-progress-bottom .mature-progress-box dl:nth-child(5) p").addClass('lan');
		lsgload(665, '.progress-box-1');
	};

	$('select[name=order]').change(function(){
		getProjData()
	})

	// 初始化数据
	getProjData()
});

function LsgLayerShow(title,url,w,h,y){
	$(".screen_popup").hide();
	layer_show(title,url,w,h)
	// layer.open({
	// 	type: 2,
	// 	area: [w+'px', h +'px'],
	// 	fix: false, 
	// 	maxmin: true,
	// 	shade:0.4,
	// 	title: title,
	// 	content: url,
	// 	offset: y+'px'
	// });
}

function lsgload(w, cls){
	console.log(1111111);
	$(cls).css({
		width : w+'px'
	})
}
// 操作/已完成
function operation(title,url){
	layer_show(title, url, 750, 700);
}

// 全局变量
var cur_index = 0;
var $type = 4 ; // 流程的选择项
var $datas = null; // 查询的数据列表
var $cur_pg = 1;  // cur页码
var $totalPage = null;  // 总页码

function getProjData() {
	getData(showProjList)
}

function pageData(obj) {
	if($cur_pg == obj.curr) return;
	$cur_pg = obj.curr
	getData(showProjList)
}

function getData(callback) {
	var url = '/service/project/search/list'
	var param = {}
	param.pg = $cur_pg
	param.type = $type
	param.order = $('select[name=order]').val()
	param.status = $('select[name=status]').val()
	param.department_id= $('select[name=department_id]').val()

	K.doAjax(param, url, function(response){
		if(response.status && 'success' ==response.status) {			
			$datas = response.data;
			if(null == response.total_page) {
				laypage({cont:"pager0",pages:0,curr:0,
					jump:null
				});
			} else if($totalPage != response.total_page) {
				laypage({cont:"pager0",pages:response.total_page,curr:1,
					jump:pageData
				});
				$cur_pg = 1
			}

			$totalPage = response.total_page;
            // 显示数据
            callback()
        }
    });
}

// 显示项目列表数据
function showProjList() {
	$('#context-list').empty()
	$.each($datas, function(i,v) {
		console.log(v)
		var str = '<tr><td>'+v.customer_name;
		if('Z' != v.level)
			str += '<img class="grade_icon" src="/public/img/project/'+v.level.toLowerCase()+'.png" alt="">';
		str += '</td><td>'+(4==v.type?v.address:v.province_name) + (v.city_name?v.city_name:'')+'</td>';
		str += '<td>'+(1==v.type?"政府单位":(2==v.type?"旅游景区":(3==v.type?"国有企业":(4==v.type?"海外客户":(5==v.type?"民营企业":"其他")))))+'</td>';
		str += '<td>'+v.project_name+'</td><td>'+v.status_name+'</td>';
		str += '<td>'+(v.begin_date?v.begin_date:'')+'</td><td>'+v.scale_fee+'</td>';
		str += '<td><button type="button" class="btn btn-default" onclick="LsgLayerShow(\'查看项目详情\',\'/service/customer/search/addproject?r=1&project_id='+v.project_id+'\', 800, 520,100)">项目详情</button><a href="/service/customer/search/detail?one=1&customer_id='+v.customer_id+'"><button type="button" class="btn btn-default">客户详情</button></a>';
		if('salesman' == '{$Think.session.employee.role_type_code}')
			str += '<button type="button" class="btn btn-default" onclick="LsgLayerShow(\'联络记录\',\'/service/customer/search/addliaison?id='+v.customer_id+'\', 800, 460,50)">新建联络</button>';
		str += '</td>';
		// other_cust
		if(v.other_cust) {
			str += '<td>';			
			$.each(v.other_cust, function(i_c,v_c){
				str += '<a href="/service/customer/search/detail?one=1&customer_id='+v_c.customer_id+'">'+v_c.name+'</a>' + '<br>';
			})
			str += '</td>';
		} else {
			str += '<td></td>';
		}

		str += '</tr>';
		$('#context-list').append(str);
	})
}
</script>
</block>