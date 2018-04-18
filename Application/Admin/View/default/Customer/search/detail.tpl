<extend name="./Application/Admin/View/default/base/context/common.tpl"/>
<block name="common_css">
	<!-- <link href="/public/css/customer/search/detail.css" rel="stylesheet" type="text/css" /> -->
</block>
<block name="common_js">

</block>

<block name="body_path_name">
	客户详情
</block>

<block name="body_main">
	<include file="./Application/Admin/View/default/base/css/detail.tpl" />

	<style>
		<if condition="1 != I('get.one')">
		.main-head{
			display: none;
		}
		</if>
		
	</style>


	<div class="info_box">
		<div class="info_box_top ">
			<div class="info_name left_box left_box1 box" onmouseover="showPN(1)" onmouseout="showPN(0)">
				<div class="cust-p-n">
				<notempty name="prev_cust">
				<i onclick="callNextCust({$prev_cust.customer_id},'{$prev_cust.name}','{$prev_cust.is_vip}')" class="Hui-iconfont cust-prev">&#xe67d;</i>
				</notempty>
				<notempty name="next_cust">
				<i onclick="callNextCust({$next_cust.customer_id},'{$next_cust.name}','{$next_cust.is_vip}')" class="Hui-iconfont cust-next">&#xe63d;</i>
				</notempty>
				</div>
				<p class="text-c">{$data.name}</p>
				<p>
					<if condition="'1' == $data['is_vip']">
						<img src="/public/img/admin/vip.png" alt="">
					</if>
					<if condition="'1' == $data['is_send']">
						<img class="ce_icon" src="/public/img/test/u8957.png" alt="">
					</if>
				</p>
				<p><img src="/public/img/project/address_icon.png" alt=""><span><if condition="4 eq $data['type']">海外，{$data.address}<else />中国<notempty name="data.province_name">，{$data.province_name}</notempty><notempty name="data.city_name">，{$data.city_name}</notempty><notempty name="data.county_name">，{$data.county_name}</notempty><notempty name="data.address">，{$data.address}</notempty></if></span></p>
				<p><img src="/public/img/project/<php>echo (1==$data['type']?'gov_icon.png':(2==$data['type']?'ScenicSpot_icon.png':(3==$data['type']?'enterprise.png':(5==$data['type']?'prise.png':(4==$data['type']?'overseas.png':'other.png')))))</php>" alt=""><span><switch name="data.type">
					<case value="1">政府单位</case>
					<case value="2">旅游景区</case>
					<case value="3">国有企业</case>
					<case value="5">民营企业</case>
					<case value="4">海外客户</case>
					<case value="0">其他</case>
				</switch></span></p>
			</div>
			<div class="right_box right_box1">
				<div class="right_box_content right_box_content1">
					<div class="left_box2">
						<div class="left_box_content2 info_situation box">
							<div class="table_box_top">
								<span class="table_box_title">基本情况</span>
									<span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true" ></span>
							</div>
							
							<ul class="screen_popup">
								<li><span class="glyphicon glyphicon-pencil check-mark"></span><span class="text" onclick="LsgLayerShow('客户资料','/service/customer/manage/change?customer_id={$data.customer_id}', 820, 500,80)">编辑资料</span></li>
							</ul>
							
							<p class="text_desc"><textarea style="width:100%;height:120px;border:none;resize:none" readonly="readonly">{$data.desc}</textarea></p>
						</div>
					</div>
					<div class="right_box2 info_label box">
						<div class="table_box_top">
							<span class="table_box_title">标签</span>
						</div>
						<input type="text" id="cust-tag" placeholder="输入标签,回车添加" style="height: 37px;width: 100%;padding: 0 10px;border: 1px solid #e0e0e0;" onkeydown="callTags(event)"/>
						<div class="icon_box" id="cust-tags-list">
							<volist name="data.tags" id="item">
								<p>{$item}<span class="glyphicon glyphicon-remove" aria-hidden="true"></span></p>
							</volist>							
						</div>
					</div>			
				</div>
			</div>
		</div>
		<div class="info_box_middle">
			<div class="info_service left_box left_box1 box">
				<div class="table_box_top">
					<span class="table_box_title">业务员</span>
					<if condition="'director' == session('employee.role_type_code') || 'boss' == session('employee.role_type_code')">
						<span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true" ></span>
					</if>
				</div>
				<ul class="screen_popup">
					<li><span class="glyphicon glyphicon-plus check-mark"></span><span class="text" <if condition="'director' == session('employee.role_type_code')"> onclick="LsgLayerShow('业务人员','/service/customer/manage/employee?id={$data.customer_id}', 400, 510,200)"</if> <if condition="'boss' == session('employee.role_type_code')">onclick="LsgLayerShow('业务人员','/service/customer/manage/departemployee?id={$data.customer_id}', 400, 510,200)"</if> >业务员</span></li>
				</ul>
				<volist name="data.employee" id="item" >					
					<p class="title">{$key}</p>
					<p class="content">
						<volist name="item" id="item2">
							<!--<img class="head" src="{$item2.thumbnail_url}" alt="{$item2.name}" title="{$item2.name}">-->
							<span style="margin-right: 6px;">{$item2.name}</span>
						</volist>
					</p>
				</volist>						
			</div>
			<div class="right_box right_box1">
				<div class="right_box_content right_box_content1 info_event box">
					<div class="table_box_top">
						<span class="table_box_title">客户大事件</span>
						<span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true" onclick=""></span>
					</div>
					<ul class="screen_popup">
							<li><span class="glyphicon glyphicon-pencil check-mark"></span><span class="text" onclick="LsgLayerShow('客户大事件','/service/customer/search/addevent?id={$data.customer_id}', 650, 430,200)">添加事件</span></li>
						<li onclick="All('/service/customer/search/allevent?id={$data.customer_id}')"><span class="glyphicon glyphicon-fullscreen check-mark"></span><span class="text" >全屏浏览</span></li>
					</ul>			
					<table class="event_table  table" border="0">
						<thead>
							<tr>
								<td >序号</th>
								<td >添加时间</th>
								<td >事件时间</th>
								<td >事件内容</th>
								<td > </th>
							</tr>
						</thead>
						<tbody id="event-list">
							
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="info_box_bottom ">
			<div class="info_contact left_box left_box1 box">
				<!-- <p><span>联系人</span><span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true" onclick="PopupShow()"></span></p> -->
				<div class="table_box_top">
					<span class="table_box_title">联系人</span>
						<span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true" ></span>
				</div>
				
				<ul class="screen_popup">
					<li><span class="glyphicon glyphicon-plus check-mark"></span><span class="text" onclick="LsgLayerShow('联系人管理','/service/customer/manage/contactsort?id={$data.customer_id}',  620, 550,200)">联系人管理</span>
					</li>
					<!-- <li>
					<span style="margin-left:30px;"><i class="Hui-iconfont cust-sort" style="font-weight:700">&#xe675;</i></span><span class="text" style="margin-left:8px;" onclick="LsgLayerShow('联系人排序','/service/customer/search/contactsort?id={$data.customer_id}', 700, 450,100)">联系人排序</span>
					</li> -->
				</ul>

				<volist name="data.contact" id="item" >
					<p class="title">{$key}</p>
					<div class="content">
						<volist name="item" id="item2">
							<div class="name_tel_box">
								<img class="head" src="{$item2.thumbnail_url}" alt="">
								<div class="name_tel">
									<p <eq name="item2.is_important" value="1">style="color: red;"</eq>>
										<notempty name="item2.name">{$item2.name}<else/>未知</notempty><notempty name="item2.position">，{$item2.position}</notempty><notempty name="item2.function">，<php>echo C('CONTACT_FUNCTION')[$item2['function']];</php></notempty><if condition="'0' == $item2['status']">（已离职）</if>
									</p>
									<span><notempty name="item2.phone"><php>$temp_phone=str_replace(',' ,'<br>' ,$item2['phone']);echo $temp_phone;</php><br></notempty><notempty name="item2.tel"><php>$temp_tel=str_replace(',', '<br>',$item2['tel']);echo $temp_tel;</php><else/>电话未知</notempty></span>
										<span><img src="/public/img/test/u9008.png" alt="" onclick="LsgLayerShow('联系人名片','/service/customer/search/addcard?contact_id={$item2.customer_contact_id}', 620, 620,200)"></span>
																<br>
								</div>
							</div>
						</volist>
					</div>
				</volist>				
			</div>
			<div class="right_box right_box1">
				<div class="right_box_content right_box_content1">
					<div class="box info_project">
						<div class="table_box_top">
							<span class="table_box_title">客户项目</span>
							<span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true" onclick=""></span>
						</div>
						<ul class="screen_popup">

								<li><span class="glyphicon glyphicon-pencil check-mark"></span><span class="text" onclick="LsgLayerShow('项目详情','/service/customer/search/addproject?id={$data.customer_id}', 800, 550,50)">新增项目</span></li>

							<li onclick="All('/service/customer/search/allproject?id={$data.customer_id}')"><span class="glyphicon glyphicon-fullscreen check-mark"></span><span class="text">全屏浏览</span></li>
						</ul>		
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
								
							</tbody>
						</table>

					</div>
						<div class="box info_records ">
							<div class="table_box_top">
								<span class="table_box_title">联络记录</span>
								<span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true" ></span>
							</div>
							<ul class="screen_popup">
								<!-- <li><span class="glyphicon glyphicon-time check-mark"></span><span class="text" onclick="LsgLayerShow('新定时提醒','/service/customer/search/addtiming', 800, 500,400)">新增提醒</span></li> -->
								<li onclick="All('/service/customer/search/allliaison?id={$data.customer_id}')"><span class="glyphicon glyphicon-fullscreen check-mark"></span><span class="text">全屏浏览</span></li>
							</ul>

								<div style="margin:10px 0 ">
									<div class="add_records" onclick="LsgLayerShow('联络记录','/service/customer/search/addliaison?id={$data.customer_id}', 800, 460,400)">
										<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增记录
									</div>
								</div>	
		
							<table class="records_table bottom_table">
								<thead>
									<tr>
										<th width="10">序号</th>
										<th>联络时间</th>
										<th>联络客户</th>
										<th>相关事宜</th>
										<th style="min-width: 200px;">联络内容</th>
										<th>负责人</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="liaison-list">

								</tbody>
							</table>
							<div id="liaison-pager" class="mt-25 text-c" ></div>
							<div class="clear"></div>
						</div>
				</div>

			</div>

		</div>
	</div>
</block>

<block name="footer_js">
	<script>
		var customer_id = '{$data.customer_id}';
		
		$(function(){

			$(".info_box").click(function(){
				$(".screen_popup").hide();
			});

			$(".table_box_icon").click(function(e){
				e.stopPropagation();
				if($(this).parent().siblings(".screen_popup").css("display")=="none"){
					$(this).parent().siblings(".screen_popup").show();					
				}else{
					$(this).parent().siblings(".screen_popup").hide()
				}
			});	

			// 异步加载大事件
			callEvent()
			// 异步加载项目
			callProject()
			// 异步加载联络记录
			callLiaison()

			
			console.log('1==',document.body.scrollHeight)

			//父级iframe自适应子页面高度
			parent.document.getElementById("main-iframe").height=0;
			parent.document.getElementById("main-iframe").height=document.body.scrollHeight+20;

			setTimeout(function(){console.log('2==',document.body.scrollHeight)},3000);  

			$("#event-list").scroll(function(){  
				topCall(this, callEvent)
			});  
			$("#project-list").scroll(function(){  
				topCall(this, callProject)
			});
		})

		// 编辑资料
		function LsgLayerShow(title,url,w,h,y){
			$(".screen_popup").hide();
			var const_top = 70
			var p_h = $(parent.window).height() - const_top	
			var p_t = $(parent.document).scrollTop() 
			var o_y = p_t - const_top
			//console.log(p_h,h,p_t,o_y)
			p_h += ((const_top < p_t)?const_top:(0 < p_t?(const_top-p_t):0)) - 20
			
			o_y = (const_top>p_t)?10:(p_t-const_top+10)
			if(h>p_h) {
				h = p_h
			} else {
				o_y += (p_h -h)/2	
			}
			//console.log(p_h,h,p_t,o_y)
			layer.open({
				type: 2,
				area: [w+'px', h +'px'],
				fix: false, //不固定
				maxmin: true,
				shade:0.4,
				title: title,
				content: url,
				offset: o_y+'px',
				cancel: function(){
				    if("undefined" != typeof $dp) {
				    	$dp.hide();
				    }				    
			    }				
			});
		}

		function fullLayerShow(title,url,w,h,y){
			K.showFullSonPage(title,url)
			
		}

		function All(url){
			window.open(url); 
		}

		function topCall(me, callfunc) {	
			 viewH =$(me).height(),//可见高度  
			 contentH =$(me).get(0).scrollHeight,//内容高度  
			 scrollTop =$(me).scrollTop();//滚动高度  
			//if(contentH - viewH - scrollTop <= 100) { //到达底部100px时,加载新内容  
			if(scrollTop/(contentH -viewH)>=0.95){ //到达底部100px时,加载新内容  
				if($is_loading) return;
				callfunc()
			}  
		}		

function callTags(e) {  
	//网页内按下回车触发
	if(e.keyCode==13) {
		if("" != $('#cust-tag').val()) {
			var str = $('#cust-tag').val();
			var parameter={
				customer_id: customer_id,
				tags: str
			}
			var url = '/service/customer/manage/tags';
			K.doAjax(parameter, url, function(response) {
				if(response.status && 'success' == response.status) {
					$('#cust-tags-list').append('<p>'+ str +'<span class="glyphicon glyphicon-remove" aria-hidden="true"></span></p>');
				} else {
					console.log(4444);
					//layer.msg('失败:'+response.message, {icon: 5, time: 2000});
				}
			});
		}
	}
}

var $is_loading=false;
var event_pg =1;
var project_pg =1;
var liaison_pg =1;
var event_total=null;
var project_total=null;
var liaison_total=null;
var page_size = {$Think.config.ONE_PAGE_SIZE};  // 每页数量，和后台对应

function callEvent() {
	if(null != event_total && (1 == event_total || event_total<event_pg)) {
		return;
	}

	var param={}
	param.pg = event_pg;
	param.customer_id = '{$data.customer_id}';
	var url = '/service/customer/search/event';
	$is_loading = true;
	K.doAjax(param, url, function(response) {
		if(response.status && 'success' == response.status) {
			event_total = response.total_page;
			if(event_total >= event_pg) {				
				event_pg++;
			}
			console.log('event_pg==',event_pg)
			showEventList(response)
			$is_loading = false;
		} else {
			$is_loading = false;
		}
	},function(e){
		$is_loading = false;
	});
}	
function callProject(param) {
	if(null != project_total && (1 == project_total || project_total<project_pg)) {
		return;
	}
	var param = param || {}
	param.pg = project_pg;
	param.customer_id = '{$data.customer_id}';
	var url = '/service/customer/search/project';
	$is_loading = true;
	K.doAjax(param, url, function(response) {
		if(response.status && 'success' == response.status) {
			project_total = response.total_page;
			if(project_total >= project_pg) {				
				project_pg++;
			}
			console.log('project_pg==',project_pg)
			showProjectList(response) 
			$is_loading = false;           
		} else {
			$is_loading = false;
		}
	},function(e){
		$is_loading = false;
	});
}
function callLiaison() {
	if(null != liaison_total && liaison_total<liaison_pg) {
		return;
	}
	var param={}
	param.pg = liaison_pg;
	param.customer_id = '{$data.customer_id}';
	var url = '/service/customer/search/liaison';
	K.doAjax(param, url, function(response) {
		if(response.status && 'success' == response.status) {
			if(liaison_total != response.total_page && 1 < response.total_page) {
				laypage({cont:"liaison-pager",pages:response.total_page,curr:1,
					jump:liaisonPage
				});
				liaison_pg = 1
			}
			liaison_total = response.total_page;

			showLiaisonList(response)  

			//父级iframe自适应子页面高度
			parent.document.getElementById("main-iframe").height=0;
			parent.document.getElementById("main-iframe").height=document.body.scrollHeight+20;
		} 
	});
}
function liaisonPage(obj) {
	if(liaison_pg == obj.curr) return;
	liaison_pg = obj.curr
	callLiaison()
}
function showEventList(res) {
	var init_pg = event_pg-1;
	$.each(res.data, function(i,v){
		var str = '<tr class="">';
		str += '<td>'+ (i+1+((init_pg - 1)*page_size)) +'</td>';
		str += '<td>'+ v.create_time +'</td>';
		str += '<td>'+ v.occur_time +'</td>';
		str += '<td>'+ v.context +'</td>';
		str += '<td><span class="glyphicon glyphicon-pencil" aria-hidden="true"  onclick="LsgLayerShow(\'客户大事件\',\'/service/customer/search/addevent?event_id='+v.customer_event_id+'\', 650, 450,200)"></span><i onclick="delList(\'delevent\','+v.customer_event_id+')" class="Hui-iconfont">&#xe6e2;</i></td></tr>';

		$('#event-list').append(str);
	})
}
function showProjectList(res) { // 项目名称、展出时间、展出规模、资金形式、项目情况、制作公司、项目等级、项目状态
	var init_pg = project_pg-1;
	$.each(res.data, function(i,v){
		var str = '<tr class="tr_border">';
		str += '<td><a onclick="LsgLayerShow(\'查看项目详情\',\'/service/customer/search/addproject?r=1&project_id='+v.project_id+'\', 800, 550,50)">'+ v.name +'</a></td>';
		str += '<td>'+ (v.begin_date?v.begin_date:'') +' - ' + (v.end_date?v.end_date:'') +'</td>';
		str += '<td>'+ v.scale_fee +'</td>';
		str += '<td>'+ (v.fee_type?v.fee_type:'') +'</td>';
		str += '<td ><span>'+ (v.context?v.context:'') +'</span></td>';
		str += '<td>'+ (v.company?('本公司'!= v.company?(v.other_company):oper_show(v.company,v.common_company)):'') +'</td>';
		str += '<td>'+ (v.level?('Z' == v.level?'普通':(v.level+'级')):'') +'</td>';		
		str += '<td>'+ v.status_name +'</td>';		

		if('本公司' != v.company || 'boss' == '{$Think.session.employee.role_type_code}' || (((2 >= v.status && 'information' == '{$Think.session.employee.department_type_id}') || (2 < v.status && 'business' == '{$Think.session.employee.department_type_id}')))) {
			str += '<td><span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="LsgLayerShow(\'项目详情\',\'/service/customer/search/addproject?project_id='+v.project_id+'\', 800, 550,50)"></span><i onclick="delList(\'delproj\','+v.project_id+')" class="Hui-iconfont ml-10" style="font-size:16px;">&#xe6e2;</i></td></tr>';
		}else{
			str += '<td></td></tr>'
		}
		$('#project-list').append(str);    	
	})
}
function showLiaisonList(res) {
	$('#liaison-list').empty()

	$.each(res.data, function(i,v){
		var str = '<tr class="tr_border">';
		str += '<td>'+ (i+1) +'</td>';
		str += '<td>'+ (v.liaison_time) +'</td>';
		if(v.contact_name)
//			str += '<td><img class="head" src="'+v.contact_url+'" alt="">'+v.contact_name+'，'+v.contact_department+'</td>';
			str += '<td>'+v.contact_name+','+v.contact_department+'</td>';
		else str += '<td></td>';
		str += '<td>'+ (v.outline?v.outline:'') +'</td>';
		str += '<td><p>'+ ((1 == v.important)? ('<img src="/public/img/test/u8862.png" alt="">') :'')+ (v.context?v.context:"") +'</p>'+(v.reply?('<p class="reply">批复：'+v.reply+'</p>'):'')+'</td>';
//		str += '<td><img class="head" src="'+v.employee_url+'" alt="">'+v.employee_name+'</td>';
		str += '<td>'+v.employee_name+'</td>';

		str += '<td><span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="LsgLayerShow(\'联络记录\',\'/service/customer/search/addliaison?liaison_id='+v.customer_liaison_id+'\', 800, 820,400)"></span><i onclick="delList(\'delliaison\','+v.customer_liaison_id+')" class="Hui-iconfont ml-10" style="font-size:16px;">&#xe6e2;</i></td></tr>';		

		$('#liaison-list').append(str);    	
	})
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

function delevent(id) {
	var param={
		customer_event_id: id
	}
	var url = '/service/customer/manage/delevent';
	K.doAjax(param, url, function(res) {
		if(res.status && 'success' == res.status) {
			// 异步加载大事件
			event_total = null;
			event_pg=1;
			$('#event-list').empty();
			callEvent()
		} else {
			layer.msg('失败:'+(res.message?res.message:''), {icon: 2, time: 2000});
		}
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
function delliaison(id) {
	var param={
		customer_liaison_id: id
	}
	var url = '/service/customer/manage/delliaison';
	K.doAjax(param, url, function(res) {
		if(res.status && 'success' == res.status) {
			// 异步加载联络记录
			liaison_total = null;
			liaison_pg=1;
			$('#liaison-list').empty();
			callLiaison()
		} else {
			layer.msg('失败:'+(res.message?res.message:''), {icon: 2, time: 2000});
		}
	});
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

function callNextCust(id,name,is_vip) {
	try {
		K.doAjax({customer_id:id},'/service/customer/manage/history',function(res){});
	} catch(e){		
	}

	if("1" == "{$Think.get.one}") {
		window.location.href='/service/customer/search/detail?one=1&customer_id='+id;
	} else {
		window.parent.addTab(id,name,is_vip);
	}	
}
function showPN(t) {
	if(1 == t)
		$('.cust-p-n').show();
	else
		$('.cust-p-n').hide();
}
function oper_show(company,common_company) {
	return company + (common_company?(','+common_company):'')
}

</script>
</block>