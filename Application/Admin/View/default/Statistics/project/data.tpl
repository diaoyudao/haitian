<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="common_css">
	<link href="/public/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">

</block>
<block name="menu_title">项目统计</block>
<block name="body_main">
	<style> 
		.body{
			width: 100%;
			padding: 20px;
			overflow: hidden;
			overflow-x: scroll;
		}
		.body .top{
			margin-top: 15px;
			width: 100%;
			height: 65px;
			padding: 10px 20px;
			background-color: #fff;
			border: 1px solid #999;
		}
		.body .download{
			float: right;
			line-height:45px;
			color: #688696;
		}
		.body  .customer{
			margin-top: 20px;
			width:100%;
			height:250px;
		}
		.body  .customer .customerNum{
			position: relative;
			width:28%;
			padding-top: 10px;
			height:250px;
			float: left;
			margin-right:2%;
			border: 1px solid #999;
			background-color: #fff;
		}
		.body  .customer .customerNum .title_head{
			margin: 20px;
			color: #688696;
		}
		.body  .customer .record{
			width:40%;

			height:250px;
			float: left;

		}
		.body  .customer .record .add{
			width: 100%;
			height: 115px;
			padding: 30px;
			background-color: #fff;
			border: 1px solid #999;
		}
		.body  .customer .record .add li{
			float: left;
			width: 33.3%;
		}
		.body  .customer .record .sign {
			margin-top: 20px;
		}
		/*新增客户图形表*/
		.body .addList{
			margin-top: 20px;
			width: 100%;
			height: 325px;
			border: 1px solid #999;
			background-color: #fff;
		}
		.body .addList .left {
      position: relative;
			float: left;
			width: 200px;
			height: 100%;
			margin-right: -200px;
			padding-top: 30px;
			border-right: 1px solid #999;

		}
		.body .addList .left .title{
			color: #688696;
			text-align: center;

		}
		.body .addList .left .date{
			width: 100%;
			height: 180px;
			margin-top: 40px;
			padding: 0 20px ;
			overflow: hidden;

		}
		.body .addList .left .date .pre{

			float: left;
			width: 35px;
			height: 35px;
			text-align: center;
			background-color: #F2F2F2;

		}
		.body .addList .left .date .yearly{

			float: left;
			width: 68px;
			height: 35px;
			line-height: 35px;
			text-align: center;
			margin: 0 10px;
			background-color: #F2F2F2;

		}
		.body .addList .left .date .pre .arrow{
			margin-top:6px;
		}
		
		.body .addList .left .date .month li{
			float: left;
			width: 35px;
			height: 35px;
			margin-left: 6px;
			margin-top: 5px;
			background-color: #F2F2F2;
			text-align: center;
			line-height: 35px;
			cursor:pointer
		}
		.body .addList .left .date .month li.ml{
			margin-left: 0;
		}
		/*选中的li变色*/
		.liColor{
			background-color: #688696;
		}
		.body .addList .addCustomer{
			width: 100%;
			height: 100%;
			float: left;

		}
        .month-select{
            background-color: #688696
        }
	</style>

	<div class="body">
		<div class="top">
          <if condition="'boss' == session('employee.role_type_code')">
			<select style="width: 140px;height: 40px;border: 1px solid #999;" name="department" id="">
				<option value="">全部部门</option>
                <volist name="department" id="item">
                    <option value="{$item.department_id}">{$item.name}</option>
                </volist>
			</select>
          </if>
			<span class="download"><a onclick="export2()">下载表格></a></span>
		</div>
		<div class="customer" >
			<!-- 客户数 -->
			<div class="customerNum">
				<span class="title_head">客户数</span>
				<div id="main" style="width:100%;height:70%;text-align: center;" ></div>
			</div>
			<!-- 客户分类 -->
			<div class="customerNum">
				<span class="title_head">客户分类</span>
				<div id="classify" style="width:100%;height: 70%;" ></div>
			</div>
			<div class="record">
				<div class="add">
					<ul >
						<li id="new_yesterday">0</li>
						<li id="new_this_month">0</li>			
						<li id="new_last_month">0</li>	
					</ul>
					<ul  style="margin-top: 30px">
						<li>昨日新增客户</li>
						<li>本月新增客户</li>			
						<li>上月新增客户</li>	
					</ul>
				</div>

				<div class="add sign">
					<ul >
						<li id="contract_yesterday">0</li>
						<li id="contract_this_month">0</li>			
						<li id="contract_last_month">0</li>	
					</ul>
					<ul  style="margin-top: 30px">
						<li>昨日新签合同</li>
						<li>本月新签合同</li>			
						<li>上月新签合同</li>	
					</ul>
				</div>
			</div>
		</div>

		<!-- 新增客户图形表 -->
		<div class="addList">
			<div class="left">
				<div class="title">新增客户</div>
				<!-- 年月 -->
				<div class="date">
					<div class="year">
						<div  class="pre new-previous"><img class="arrow" src="/public/img/test/pre.png" alt=""></div>
						<span class="yearly">{$year}</span>
						<div class="pre new-next"><img class="arrow" src="/public/img/test/u840.png" alt=""></div>

					</div>
					<ul id="new-month" class="month">
						<li class="ml">1</li>
						<li>2</li>
						<li>3</li>
						<li>4</li>
						<li class="ml" ">5</li>
						<li>6</li>
						<li>7</li>
						<li>8</li>
						<li class="ml">9</li>
						<li>10</li>
						<li>11</li>
						<li>12</li>		
					</ul>
				</div>
			</div>
			
			<!-- 新增客户柱状图 -->
			<div class="addCustomer">
				<div id="addCustomer" style="width:80%;height:100%; float: left;margin-left: 200px" ></div>
			</div>
		</div>
		<!-- 联络客户图形表 -->
		<div class="addList">
			<div class="left">
				<div class="title">联络客户</div>
				<!-- 年月 -->
				<div class="date">
					<div class="year">
						<div  class="pre lia-previous"><img class="arrow" src="/public/img/test/pre.png" alt=""></div>
						<span class="yearly">{$year}</span>
						<div class="pre lia-next"><img class="arrow" src="/public/img/test/u840.png" alt=""></div>

					</div>
					<ul id="lia-month" class="month">
						<li class="ml">1</li>
						<li>2</li>
						<li>3</li>
						<li>4</li>
						<li class="ml" ">5</li>
						<li>6</li>
						<li>7</li>
						<li>8</li>
						<li class="ml">9</li>
						<li>10</li>
						<li>11</li>
						<li>12</li>		
					</ul>
				</div>
			</div>
			
			<!-- 联络客户柱状图 -->
			<div class="addCustomer">
				<div id="liaison" style="width:80%;height:100%; float: left;margin-left: 200px;" ></div>
			</div>
		</div>
		<!-- 合同签订图形表 -->
		<div class="addList">
			<div class="left">
				<div class="title">合同签订</div>
				<!-- 年月 -->
				<div class="date">
					<div class="year">
						<div  class="pre cot-previous"><img class="arrow" src="/public/img/test/pre.png" alt=""></div>
						<span class="yearly ">{$year}</span>
						<div class="pre cot-next"><img class="arrow" src="/public/img/test/u840.png" alt=""></div>

					</div>
				</div>
			</div>
			
			<!-- 合同签订柱状图 -->
			<div class="addCustomer">
				<div id="contract" style="width:80%;height:100%; float: left;margin-left: 200px" ></div>
			</div>
		</div>
	</div>

</block>
<block name="footer_js">
	<script src="/public/echarts/echarts.min.js"></script>
	<script>

	$(function(){
		$('select[name=department]').change(function(){
            $depart = $(this) .val()
            callAll();
        })
	    // 客户数
	    cust_data = [  
    	    {value:0, name:'政府单位'},
    	    {value:0, name:'旅游景区'},
    	    {value:0, name:'企业公司'},
    	    {value:0, name:'其他客户'},
    	    {value:0, name:'海外客户'}
	    ];
	    myChart = echarts.init(document.getElementById('main'));
	    
	    //客户分类数据
	    classify=[
    	    {value:0, name:'普通'},
    	    {value:0, name:'VIP'},
	    ];

        // 客户分类
        myChart2 = echarts.init(document.getElementById('classify'));
        // 指定图表的配置项和数据
        option = {
        	tooltip: {
        		trigger: 'item',
        		formatter: "{a} <br/>{b}: {c} ({d}%)"
        	},
        	color:['#5B9BD5','#ED7D31','#A5A5A5','#FFC000','#4472C4'],
        	title: {
        		subtext: '总数',
        		text: '0', 
        		x: '29%',
        		y: 'center',
            textAlign: 'center'
        	},
        	legend: {

        		orient: 'vertical',
        		x: '50%',
        		y:'middle',
        		align: 'left',
        		formatter: function (name) {
        			var num 
        			for (var i = 0; i < cust_data.length; i++) {
        				if (name === cust_data[i].name) {
        					num = cust_data[i].value
        				}
        			}
        			
        			return name +'    '+ num;
        		},
        		data:cust_data
        	},

        	series: [
        	{
        		name:'客户来源',
        		type:'pie',
        		radius: ['50%', '70%'],
        		center:['30%','50%'],
        		avoidLabelOverlap: false,
        		label: {
        			normal: {
        				show: false,
        				position: 'center'
        			},
        		},
        		labelLine: {
        			normal: {
        				show: false
        			}
        		},
        		data:[
        		{value:1, name:'政府单位'},
        		{value:2, name:'旅游景区'},
        		{value:3, name:'企业公司'},
        		{value:4, name:'其他客户'},
        		{value:5, name:'海外客户'}
        		],
        	}
        	]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
        option2 = {
        	tooltip: {
        		trigger: 'item',
        		formatter: "{a} <br/>{b}: {c} ({d}%)"
        	},
        	color:['#5B9BD5','#ED7D31','#A5A5A5','#FFC000','#4472C4'],

        	legend: {

        		orient: 'vertical',
        		x: '60%',
        		y:'middle',
        		align: 'left',
        		formatter: function (name) {
        			var num 
        			for (var i = 0; i < classify.length; i++) {
        				if (name === classify[i].name) {
        					num = classify[i].value
        				}
        			}
        			
        			return name +'    '+ num;
        		},
        		data:classify
        		
        	},

        	series: [
        	{
        		name:'客户来源',
        		type:'pie',
        		radius: ['50%', '70%'],
        		center:['30%','50%'],
        		avoidLabelOverlap: false,
        		label: {
        			normal: {
        				show: false,
        				position: 'center'
        			},
        		},
        		labelLine: {
        			normal: {
        				show: false
        			}
        		},
        		data:[
            {value:55, name:'普通'},
        		{value:22, name:'VIP'},
        		],
        	}
        	]
        };
        myChart2.setOption(option2);

		$('.new-previous,.lia-previous,.cot-previous').click(function(){   
			previous(this);            
		})
	
		$('.new-next,.lia-next,.cot-next').click(function(){      
			next(this);
		})

        function previous(me){
            console.log($(me).parent().find('.yearly'))
            var yearly = $($(me).parent().find('.yearly'));
            var newYear = yearly.text()
            newYear=parseInt(newYear) -1
            yearly.text(newYear);

            callTemp(me, newYear)            
        }
        function next(me){
            var yearly = $($(me).parent().find('.yearly'));
            var newYear = yearly.text()
            newYear=parseInt(newYear) + 1
            yearly.text(newYear);

            callTemp(me, newYear)   
        }

        function callTemp(me, year) {
            var m = $(me).parent().next('ul').find('li.month-select').text()
            m = (m>=10)?m:'0'+m
            var t = $(me).attr('class')
            if(0 <= t.indexOf('new-')) {
                $new_time = year + '-' + m
                newCustomer()
            } else if(0 <= t.indexOf('lia-')) {                
                $lia_time = year + '-' + m
                console.log($lia_time)
                liaison()
            } else if(0 <= t.indexOf('cot-')) {
                $year = year;
                contract()
            }
        }

		$('#lia-month').find('li').click(function(){			
			$("#lia-month li").eq($(this).index()).addClass('month-select').attr("style","background:#688696").siblings().removeAttr("style").removeClass('month-select');
            var y = $(this).parent().prev().find('span.yearly').text()
            var m = $(this).text()

            $lia_time = y + '-' + (m>=10?m:'0'+m)
            console.log($lia_time)
            liaison()
		})

		// 新增客户柱状图
		myAdd = echarts.init(document.getElementById('addCustomer'));
		option3 = {
			tooltip : {
				trigger: 'axis',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                   type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
           color:['#5B9BD5','#ED7D31','#A5A5A5','#FFC000','#4472C4'],
           title: {

           	text: ['新增客户数总计'], 
           	x: '10%',
           	y: '5%',
           	textStyle:{
           		fontWeight:'normal',
           		color:'#000',
           		fontSize:'14px'	
           	}
           },
           legend: {
           	x: '25%',
           	y: '5%',
           	data:['政府单位','旅游景区','企业公司','其他客户','海外客户']
           },
           toolbox: {
           	show : true,
           	orient: 'vertical',
           	x: 'right',
           	y: 'center',
    	        // feature : {
    	        //     // mark : {show: true},
    	        //     // dataView : {show: true, readOnly: false},
    	        //     // magicType : {show: true, type: ['stack', 'tiled']},
    	        //     // restore : {show: true},
    	        //     // saveAsImage : {show: true}
    	        // }
    	    },
    	    calculable : true,
    	    xAxis : [
    	    {
    	    	type : 'category',
    	    	data : ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28']
    	    }
    	    ],
    	    yAxis : [
    	    {
    	    	type : 'value'
    	    }
    	    ],
    	    series : [
    	    {
    	    	name:'政府单位',
    	    	type:'bar',
    	    	stack:'广告',
    	    	data:[0, 0, 0, 0]
    	    },
    	    {
    	    	name:'旅游景区',
    	    	type:'bar',
    	    	stack: '广告',
    	    	data:[0,0,0]
    	    },
    	    {
    	    	name:'企业公司',
    	    	type:'bar',
    	    	stack: '广告',
    	    	data:[0,0,0]
    	    },
    	    {
    	    	name:'其他客户',
    	    	type:'bar',
    	    	stack: '广告',
    	    	data:[0,0,0]
    	    },
    	    {
    	    	name:'海外客户',
    	    	type:'bar',
    	    	stack: '广告',
    	    	data:[0,0,0]
    	    },
    	    ]
    	};
        // 使用刚指定的配置项和数据显示图表。
        myAdd.setOption(option3);


        $('#new-month').find('li').click(function(){
            console.log('month')
        	$("#new-month li").eq($(this).index()).addClass('month-select').attr("style","background:#688696").siblings().removeAttr("style").removeClass('month-select');

            var y = $(this).parent().prev().find('span.yearly').text()
            var m = $(this).text()

            $new_time = y + '-' + (m>=10?m:'0'+m)
            console.log($new_time)
            newCustomer()
        })

        // 联络客户柱状图
        myLiaison = echarts.init(document.getElementById('liaison'));
        option4 = {
        	tooltip : {
        		trigger: 'axis',
                    axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                   type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
               }
           },
           color:['#5B9BD5','#ED7D31','#A5A5A5','#FFC000','#4472C4'],
           title: {

           	text: ['联络客户数总计'], 
           	x: '10%',
           	y: '5%',
           	textStyle:{
           		fontWeight:'normal',
           		color:'#000',
           		fontSize:'14px'	
           	}
           },
           legend: {
           	x: '25%',
           	y: '5%',
           	data:['政府单位','旅游景区','企业公司','其他客户','海外客户']
           },
           toolbox: {
           	show : true,
           	orient: 'vertical',
           	x: 'right',
           	y: 'center',

           },
           calculable : true,
           xAxis : [
           {
           	type : 'category',
           	data : ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28']
           }
           ],
           yAxis : [
           {
           	type : 'value'
           }
           ],
           series : [
           {
           	name:'政府单位',
           	type:'bar',
           	stack:'广告',
           	data:[0,0,0]
           },
           {
           	name:'旅游景区',
           	type:'bar',
           	stack: '广告',
           	data:[0,0,0]
           },
           {
           	name:'企业公司',
           	type:'bar',
           	stack: '广告',
           	data:[0,0,0]
           },
           {
           	name:'其他客户',
           	type:'bar',
           	stack: '广告',
           	data:[0,0,0]
           },
           {
           	name:'海外客户',
           	type:'bar',
           	stack: '广告',
           	data:[0,0,0]
           },
           ]
       };
        // 使用刚指定的配置项和数据显示图表。
        myLiaison.setOption(option4);


        // 合同签订
        myContract = echarts.init(document.getElementById('contract'));
        option5 = {
        	tooltip: {
        		trigger: 'axis',
        		axisPointer: {
        			type: 'cross',
        			crossStyle: {
        				color: '#999'
        			}
        		}
        	},

        	xAxis: [
        	{
        		type: 'category',
        		data: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
        		axisPointer: {
        			type: 'shadow'
        		}
        	}
        	],
        	yAxis: [
        	{
        		type: 'value',
        		name: '签订合同',

        		interval: 50,
        		axisLabel: {
        			formatter: '{value} '
        		}
        	},
        	{
        		type: 'value',
        		name: '合同规模（万）',

        		interval: 100,
        		axisLabel: {
        			formatter: '{value}'
        		}
        	}
        	],
        	series: [
        	{
        		name:'签订合同',
        		type:'bar',
        		data:[]
        	},

        	{
        		name:'合同规模',
        		type:'line',
        		yAxisIndex: 1,
        		data:[]
        	}
        	]	

        };
        myContract.setOption(option5);

        // init
        $("#new-month li").eq(parseInt($new_m)-1).addClass('month-select').attr("style","background:#688696").siblings().removeAttr("style").removeClass('month-select');
        $("#lia-month li").eq(parseInt($new_m)-1).addClass('month-select').attr("style","background:#688696").siblings().removeAttr("style").removeClass('month-select');

        callAll()
    })
	
    function export2() {
      var href = "/service/statistics/project/export";
      href += '?new_time=' + $new_time + '&lia_time=' + $lia_time + '&year=' + $year;
      if($('select[name=department]')) {
        href += '&department_id=' + $('select[name=department]').val()
      }
      
      window.location.href = href;
    }

</script>
<include file="./Application/Admin/View/default/base/son/project.tpl"/>
</block>
