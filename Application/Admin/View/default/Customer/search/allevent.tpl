<extend name="./Application/Admin/View/mobile/base/context/common.tpl"/>
<block name="common_css">

</block>
<block name="common_js">

</block>

<block name="body_path_name">

</block>

<block name="body_main">
	<include file="./Application/Admin/View/default/base/css/allevent.tpl" />

	<div class="right_box_content right_box_content1 info_event box">
		<div class="table_box_top">
			<span class="table_box_title">客户大事件</span>
		</div>		
		<table class="event_table" >
			<thead>
				<tr>
					<th>序号</th>
					<th>添加时间</th>
					<th>事件时间</th>
					<th>事件内容</th>
					<th></th>
				</tr>
			</thead>
			<tbody id="event-list">
				<!-- <tr class="tr_border">
					<td>1</td>
					<td>2017-11-03</td>
					<td>2017-11-02</td>
					<td>学习十九大</td>
					<td>
						<span class="glyphicon glyphicon-pencil" aria-hidden="true"  onclick="LsgLayerShow('客户大事件','/service/customer/search/addevent', 750, 500,200)"></span>
					</td>
				</tr> -->
				
			</tbody>
		</table>
		<div id="liaison-pager" class="mt-25 text-c" ></div>
		<div class="clear"></div>
	</div>
</block>

<block name="footer_js">
	<script>
		$(function(){

			callEvent()
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

var event_pg =1;
var project_pg =1;
var liaison_pg =1;
var event_total=null;
var project_total=null;
var liaison_total=null;
var page_size = 7;  // 每页数量，和后台对应

function callEvent() {
	if(null != event_total && (1 == event_total || event_total<event_pg)) {
		return;
	}

	var param={}
	param.pg = event_pg;
	param.customer_id = '{$Think.get.id}';
	var url = '/service/customer/search/event';
	K.doAjax(param, url, function(response) {
		if(response.status && 'success' == response.status) {			
			if(event_total != response.total_page && 1 < response.total_page) {
				console.log('show pager')
				laypage({cont:"liaison-pager",pages:response.total_page,curr:1,
					jump:callPage
				});
				event_pg = 1
			}
			event_total = response.total_page;
			console.log('event_pg==',event_pg)
			showEventList(response)
			
		}
	});
}	

function callPage(obj) {
	if(event_pg == obj.curr) return;
	event_pg = obj.curr
	callEvent()
}

function showEventList(res) {
	$('#event-list').empty()

	$.each(res.data, function(i,v){
		var str = '<tr class="tr_border">';
		str += '<td>'+ (i+1) +'</td>';
		str += '<td>'+ v.create_time +'</td>';
		str += '<td>'+ v.occur_time +'</td>';
		str += '<td>'+ v.context +'</td>';
		str += '<td><span class="glyphicon glyphicon-pencil" aria-hidden="true"  onclick="LsgLayerShow(\'客户大事件\',\'/service/customer/search/addevent?event_id='+v.customer_event_id+'\', 750, 500,50)"></span><i onclick="delList(\'delevent\','+v.customer_event_id+')" class="Hui-iconfont">&#xe6e2;</i></td></tr>';

		$('#event-list').append(str);
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

	</script>
</block>