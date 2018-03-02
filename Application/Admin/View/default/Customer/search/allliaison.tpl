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
		<div class="box info_records ">
			<div class="table_box_top">
				<span class="table_box_title">联络记录</span>
			</div>				
			<table class="records_table bottom_table">
				<thead>
					<tr>
						<th>序号</th>
						<th>联络时间</th>
						<th>联络客户</th>
						<th>相关事宜</th>
						<th>联络内容</th>
						<th>负责人</th>
					</tr>
				</thead>
				<tbody id="liaison-list">
					<!-- <tr class="tr_border">
						<td>1</td>
						<td>11/03 08:56</td>
						<td><img class="head" src="/public/img/test/u707.png" alt="">周瑜，办公室主任</td>
						<td>元宵灯会</td>
						<td>
							<p>
								<img src="/public/img/test/u8862.png" alt="">元宵灯会项目尾款支付问题，被告知正在支付流程中。已委托张主任催促款加快打款流程。
							</p>
							<p class="reply">批复：尾款到后再联系一下刘书记</p>
						</td>
						<td>
							<img class="head" src="/public/img/test/u707.png" alt="">黄月英
						</td>
						<td>
							<span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="LsgLayerShow('联络记录','/service/customer/search/addliaison', 800, 820,50)"></span>
						</td>
					</tr> -->
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
			callLiaison()
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

var liaison_pg =1;
var liaison_total=null;		

function callPage(obj) {
	if(liaison_pg == obj.curr) return;
	liaison_pg = obj.curr
	callLiaison()
}
function callLiaison() {
	if(null != liaison_total && liaison_total<liaison_pg) {
		return;
	}
	var param={}
	param.pg = liaison_pg;
	param.customer_id = '{$Think.get.id}';
	var url = '/service/customer/search/liaison';
	K.doAjax(param, url, function(response) {
		if(response.status && 'success' == response.status) {
			if(liaison_total != response.total_page && 1 < response.total_page) {
				laypage({cont:"liaison-pager",pages:response.total_page,curr:1,
					jump:callPage
				});
				liaison_pg = 1
			}
			liaison_total = response.total_page;

			showLiaisonList(response)            
		} 
	});
}
function showLiaisonList(res) {
	$('#liaison-list').empty()

	$.each(res.data, function(i,v){
		var str = '<tr class="tr_border">';
		str += '<td>'+ (i+1) +'</td>';
		str += '<td>'+ (v.liaison_time) +'</td>';
		if(v.contact_name)
			str += '<td><img class="head" src="'+v.contact_url+'" alt="">'+v.contact_name+'，'+v.contact_position+'</td>';
		else str += '<td></td>';
		str += '<td>'+ (v.outline?v.outline:'') +'</td>';
		str += '<td><p>'+ ((1 == v.important)? ('<img src="/public/img/test/u8862.png" alt="">') :'')+ (v.context?v.context:"") +'</p>'+(v.reply?('<p class="reply">批复：'+v.reply+'</p>'):'')+'</td>';
		str += '<td><img class="head" src="'+v.employee_url+'" alt="">'+v.employee_name+'</td>';
		if(0 == v.is_reply) {
			str += '<td><span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="LsgLayerShow(\'联络记录\',\'/service/customer/search/addliaison?liaison_id='+v.customer_liaison_id+'\', 800, 820,50)"></span><i onclick="delList(\'delliaison\','+v.customer_liaison_id+')" class="Hui-iconfont ml-10" style="font-size:16px;">&#xe6e2;</i></td></tr>';			
		} else 
		    str += '<td></td></tr>';

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

	</script>
</block>