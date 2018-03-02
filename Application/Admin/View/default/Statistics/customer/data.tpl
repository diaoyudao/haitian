<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="common_css">
		<link href="/public/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">

</block>
<block name="menu_title">客户分布形势图</block>
<block name="body_main">
	<style>
		.titleName{
			padding: 20px;
			font-size: 14px;
			color: #688696;
		}
		.list{
			width: 80%;
			margin: auto;
			margin-top: 50px;
			padding-bottom: 20px;
		}
		.common{
			padding: 10px 0;
			height: 50px;
			border-bottom: 1px solid #999
		}
		.upsubscript{
			width: 16px;
			height: 16px;
		}
	</style>
	<div class="titleName"><a href="/service/statistics/customer/export">下载表格</a></div>
	<div id="map-wrap"  style="width: 80%; height: 800px;margin:auto;">
		<!-- 这里以后是地图 -->
		
	</div>
	<div class="list">
			<table >
				<tr class="common">
					<th>序号</th>
					<th>省</th>
					<th>项目数<span><img onclick="sortC(0)" class="upsubscript" src="/public/img/test/u360.png" alt=""></span></th>
					<th>政府单位<span><img onclick="sortC(1)" class="upsubscript" src="/public/img/test/u360.png" alt=""></span></th>
					<th>旅游景区<span><img onclick="sortC(2)" class="upsubscript" src="/public/img/test/u360.png" alt=""></span></th>
					<th>企业公司<span><img onclick="sortC(3)" class="upsubscript" src="/public/img/test/u360.png" alt=""></span></th>
					<th>其他<img onclick="sortC(4)" class="upsubscript" src="/public/img/test/u360.png" alt=""></th>
				</tr>
				<tbody id="context-list">
				<foreach name="data" item="item" key="i">
				<tr class="common">
					<td>{$i + 1}</td>
					<td>{$item.province_name}</td>
					<td>{$item.project_num|default=0}</td>
					<td>{$item.num1|default=0}</td>
					<td>{$item.num2|default=0}</td>
					<td>{$item.num3|default=0}</td>
					<td>{$item.num4|default=0}</td>					
				</tr>
				</foreach>
				</tbody>
			</table>
	</div>
	</block>
<block name="footer_js">
	<script src="/public/echarts/echarts.min.js"></script>
	<script src="/public/echarts/china.js"></script>
	<script>
		// 初始化echarts示例mapChart
        var mapChart = echarts.init(document.getElementById('map-wrap'));
        // mapChart的配置
        var $data = JSON.parse('<php>echo json_encode($data);</php>');
        var option = {
			   
			    tooltip : {
			        trigger: 'item',
			        show:true,
			        formatter:function(res){
			       		for (var i = 0; i <$data.length; i++) {

			       			if($data[i].num1==undefined){
			       				$data[i].num1=0
			       			}
			       			if($data[i].num2==undefined){
			       				$data[i].num2=0
			       			}
			       			if($data[i].num3==undefined){
			       				$data[i].num3=0
			       			}
			       			if($data[i].num4==undefined){
			       				$data[i].num4=0
			       			}
			       			// return 111;
			       			if(res.name==$data[i].province_name){

			       				// return 111;
			       				return res.name+'<br>'+'政府单位:'+$data[i].num1+'<br>'+'旅游景区'+$data[i].num2+'<br>'+'企业公司:'+$data[i].num3+'<br>'+'其他:'+$data[i].num4;

			       			}
			       			
			       		}

			        }
			    },
			  
			    dataRange: {
			        min: 0,
			        max: 2500,
			        x: 'left',
			        y: 'bottom',
			        text:['高','低'],           // 文本，默认为数值文本
			        calculable : true
			    },
			    
			    roamController: {
			        show: true,
			        x: 'right',
			        mapTypeControl: {
			            'china': true
			        }
			    },

			    series : [
			    	// {
			     //        name: '项目数',
			     //        type: 'map',
			     //        mapType: 'china',
			     //        roam: false,
			          
			           
			     //        itemStyle:{
			     //            normal:{label:{show:true}},
			     //            emphasis:{label:{show:true}}
			     //        },
			     //        data:[
			     //            {name: '北京',value: 0}, 
			     //            {name: '天津',value: 0},
			     //            {name: '上海',value: 0},
			     //            {name: '重庆',value: 0},
			     //            {name: '河北',value: 0},
			     //            {name: '河南',value: 0},
			     //            {name: '云南',value: 0},
			     //            {name: '辽宁',value: 0},
			     //            {name: '黑龙江',value: 0},
			     //            {name: '湖南',value: 0},
			     //            {name: '安徽',value: 0},
			     //            {name: '山东',value: 0},
			     //            {name: '新疆',value: 0},
			     //            {name: '江苏',value: 0},
			     //            {name: '浙江',value: 0},
			     //            {name: '江西',value: 0},
			     //            {name: '湖北',value: 0},
			     //            {name: '广西',value: 0},
			     //            {name: '甘肃',value: 0},
			     //            {name: '山西',value: 0},
			     //            {name: '内蒙古',value: 0},
			     //            {name: '陕西',value: 0},
			     //            {name: '吉林',value: 0},
			     //            {name: '福建',value: 0},
			     //            {name: '贵州',value: 0},
			     //            {name: '广东',value: 0},
			     //            {name: '青海',value: 0},
			     //            {name: '西藏',value: 0},
			     //            {name: '四川',value: 0},
			     //            {name: '宁夏',value: 0},
			     //            {name: '海南',value: 0},
			     //            {name: '台湾',value: 0},
			     //            {name: '香港',value: 0},
			     //            {name: '澳门',value: 0}
			     //        ]
			     //    },
			        {
			            name: '政府单位',
			            type: 'map',
			            mapType: 'china',

			            roam: false,
			            // label:{
			            // 	normal:{
			            // 		formatter: '{b}: {c}',
			            // 	}
			            // },

			            itemStyle:{
			                normal:{label:{show:true}},
			                emphasis:{label:{show:true}}
			            },
			            data:[
			                {name: '北京',value: 0}, 
			                {name: '天津',value: 0},
			                {name: '上海',value: 0},
			                {name: '重庆',value: 0},
			                {name: '河北',value: 0},
			                {name: '河南',value: 0},
			                {name: '云南',value: 0},
			                {name: '辽宁',value: 0},
			                {name: '黑龙江',value: 0},
			                {name: '湖南',value: 0},
			                {name: '安徽',value: 0},
			                {name: '山东',value: 0},
			                {name: '新疆',value: 0},
			                {name: '江苏',value: 0},
			                {name: '浙江',value: 0},
			                {name: '江西',value: 0},
			                {name: '湖北',value: 0},
			                {name: '广西',value: 0},
			                {name: '甘肃',value: 0},
			                {name: '山西',value: 0},
			                {name: '内蒙古',value: 0},
			                {name: '陕西',value: 0},
			                {name: '吉林',value: 0},
			                {name: '福建',value: 0},
			                {name: '贵州',value: 0},
			                {name: '广东',value: 0},
			                {name: '青海',value: 0},
			                {name: '西藏',value: 0},
			                {name: '四川',value: 0},
			                {name: '宁夏',value: 0},
			                {name: '海南',value: 0},
			                {name: '台湾',value: 0},
			                {name: '香港',value: 0},
			                {name: '澳门',value: 0}
			            ]
			        },
				        {
				            name: '旅游景区',
				            type: 'map',
				            mapType: 'china',
				            itemStyle:{
				                normal:{label:{show:true}},
				                emphasis:{label:{show:true}}
				            },
				            data:[
				                {name: '北京',value: 0},
				                {name: '天津',value: 0},
				                {name: '上海',value: 0},
				                {name: '重庆',value: 0},
				                {name: '河北',value: 0},
				                {name: '安徽',value: 0},
				                {name: '新疆',value: 0},
				                {name: '浙江',value: 0},
				                {name: '江西',value: 0},
				                {name: '山西',value: 0},
				                {name: '内蒙古',value: 0},
				                {name: '吉林',value: 0},
				                {name: '福建',value: 0},
				                {name: '广东',value: 0},
				                {name: '西藏',value: 0},
				                {name: '四川',value: 0},
				                {name: '宁夏',value: 0},
				                {name: '香港',value: 0},
				                {name: '澳门',value: 0}
				            ]
				        },
				        {
				        	name: '企业公司',
				        	type: 'map',
				        	mapType: 'china',
				        	itemStyle:{
				        		normal:{label:{show:true}},
				        		emphasis:{label:{show:true}}
				        	},
				        	data:[
				        	{name: '北京',value: 0},
				        	{name: '天津',value: 0},
				        	{name: '上海',value: 0},
				        	{name: '广东',value: 0},
				        	{name: '台湾',value: 0},
				        	{name: '香港',value: 0},
				        	{name: '澳门',value: 0}
				        	]
				        },
				        {
				        	name: '其他',
				        	type: 'map',
				        	mapType: 'china',
				        	itemStyle:{
				        		normal:{label:{show:true}},
				        		emphasis:{label:{show:true}}
				        	},
				        	data:[
				        	{name: '北京',value: 0},
				        	{name: '天津',value: 0},
				        	{name: '上海',value: 0},
				        	{name: '广东',value: 0},
				        	{name: '台湾',value: 0},
				        	{name: '香港',value: 0},
				        	{name: '澳门',value: 0}
				        	]
				        }
			    ]
        }

		//option.series[0].data
		$.each($data, function(i,v){
			$.each(option.series[0].data, function(i2,v2){
				//console.log(v.province_name, v2.name)
				if(0 <= v.province_name.indexOf(v2.name)) {
					console.log('find', v.province_name);
					v2.value = v.project_num
				}
			})
		})

     	mapChart.setOption(option);
	
	var source_datas = JSON.parse('<php>echo json_encode($data)</php>')

	var sort_sta = [false,false,false,false,false];
	var sort_name = ['project_num','num1','num2','num3','num4'];
	function sortC(tt) {
		source_datas = source_datas.sort(function(a, b){
            if(sort_sta[tt]) {
                if(parseInt(a[sort_name[tt]]) < parseInt(b[sort_name[tt]])) return -1;
                else if(parseInt(a[sort_name[tt]]) > parseInt(b[sort_name[tt]])) return 1;
                else return 0;
            } else {
                if(parseInt(a[sort_name[tt]]) < parseInt(b[sort_name[tt]])) return 1;
                else if(parseInt(a[sort_name[tt]]) > parseInt(b[sort_name[tt]])) return -1;
                else return 0;
            }
            
        });
        sort_sta[tt] = !sort_sta[tt]

        changeSort()
	}

	function changeSort() {
		$('#context-list').empty();
		console.log(source_datas)
		$.each(source_datas, function(i,v){
			var str='<tr class="common">';
			str += '<td>'+(i + 1)+'</td>';
			str += '<td>'+ v.province_name +'</td>';
			str += '<td>'+ v.project_num +'</td>';
			str += '<td>'+ (v.num1?v.num1:0) +'</td>';
			str += '<td>'+ (v.num2?v.num2:0) +'</td>';
			str += '<td>'+ (v.num3?v.num3:0) +'</td>';
			str += '<td>'+(v.num4?v.num4:0)+'</td></tr>';

			$('#context-list').append(str)
		})
	}

	</script>
</block>
