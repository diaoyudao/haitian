<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="common_css">
    <link href="/public/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
</block>
<block name="common_js">

</block>
<block name="menu_title">任务统计</block>
<block name="body_main">
    <style>
        /*清除浮动*/
        .clearfix:after {
            content: "";
            display: block;
            height: 0;
            clear: both;
        }

        .color {
            color: #688696;
        }

        .fr {
            float: right;

        }

        .body {
            width: 100%;
            padding: 20px;
            overflow: hidden;
        }

        .body .top {
            margin-top: 15px;
            width: 100%;
            height: 100px;
            padding: 10px 20px;
            background-color: #fff;
            border: 1px solid #999;
        }

        .body .download {
            float: right;
            line-height: 45px;
            color: #688696;
        }

        .body .overview {
            margin-top: 20px;
            width: 100%;
            height: 230px;
            border: 1px solid #999;
            overflow: hidden;
            background-color: #fff;
        }

        .body .overview .left {
            float: left;
            width: 200px;
            height: 100%;

            line-height: 230px;
            text-align: center;
            font-size: 20px;
            color: #688696;
            border-right: 1px solid #999;
        }

        .body .overview .taskNum {
            width: 350px;
            height: 100%;
            float: left;
        }

        .body .overview .release {
            width: 18%;
            height: 180px;
            margin-top: 25px;
            margin-right: 40px;
            float: left;
            border: 1px solid #999;
        }

        .body .overview .release .headpic {
            width: 60px;
            height: 60px;
            margin: auto;
            margin-top: 20px;
            border-radius: 50%;
        }

        .body .overview .release .headpic img {
            width: 60px;
            height: 60px;

        }

        .body .overview .release .name {
            margin-top: 10px;
            text-align: center;
        }

        .body .data {
            margin-top: 20px;
            width: 100%;
            height: 300px;
            border: 1px solid #999;
            background-color: #fff;
        }

        .body .data .left {
            float: left;
            width: 200px;
            height: 100%;
            margin-right: -200px;
            padding-top: 40px;
            border-right: 1px solid #999;

        }

        .body .data .left .title {
            color: #688696;
            font-size: 20px;
            text-align: center;

        }

        .body  .left .date {
            width: 100%;
            height: 180px;
            margin-top: 40px;
            padding: 0 20px;
            overflow: hidden;

        }

       .pre {

            float: left;
            width: 20%;
            /*height: 35px;*/
            text-align: center;
            background-color: #F2F2F2;

        }
        .yearly {

            float: left;
            width: 56%;
            height: 30px;
            line-height: 30px;
            text-align: center;
            margin: 0 2%;
            background-color: #fff;
            color: #5B9BD5;

        }

        .pre .arrow {
            margin-top: 6px;
        }

        .body  .left .date .month li {
            float: left;
            width: 35px;
            height: 35px;
            margin-left: 6px;
            margin-top: 5px;
            background-color: #F2F2F2;
            text-align: center;
            line-height: 35px;
            cursor: pointer
        }
        .fff{
            background-color: #fff!important;
        }

        .body .data .left .date .month li.ml {
            margin-left: 0;
        }

        /*图表*/
        .body .data .chart {
            width: 100%;
            height: 100%;
            margin-left: 200px;
            overflow: hidden;
            overflow-x: scroll;
            float: left;
        }

        .body .completeList {
            float: left;
            width: 100%;
            height: 100%;
            margin-left: 200px;
        }

        .body .completeList .ul {
            margin-left: 50px;
            margin-top: 20px;
            width: 80%;
            font-size: 15px;
            padding-bottom: 40px;
        }

        .body .completeList .ul tr {
            height: 50px;
            margin-top: 20px;
            border-bottom: 1px solid #E4E4E4
        }

        .body .completeList .ul td {

            font-size: 15px;

        }

        .body .completeList .ul th {
            color: #9595B7;
            font-size: 15px;

        }

        /*列表里面的头像大小*/
        .tableHead {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            overflow: hidden;
        }
        /*上下图标*/
       .upsubscript{
            width: 16px;
            height: 16px;
        }
    </style>
    <div class="body">
        <div class="top">
            <notempty name="department">
                <div>
                    <select style="width: 140px;height: 40px;border: 1px solid #999;" name="department" id="">
                        <option value="0">全部部门</option>
                        <volist name="department" id="dt">
                            <option value="{$dt.department_id}"
                            <eq name="Think.get.department_id" value="$dt.department_id">selected</eq>
                            >{$dt.name}</option>
                        </volist>
                    </select>
                </div>

            </notempty>
            <div style="padding: 10px 0;">
                <div class="year" style=" float: left;width: 140px;">
                    <div class="pre previous"><img class="arrow" src="/public/img/test/pre.png" alt=""></div>
                    <span class="yearly"></span>
                    <div class="pre next"><img class="arrow" src="/public/img/test/u840.png" alt=""></div>
                </div>

                <span class="download">下载表格</span>
            </div>

        </div>

        <!-- 任务概览 -->
        <div class="overview">
            <div class="left">任务概览</div>
            <div class="taskNum">
                <div id="main" style="width:350px;height:80%;margin:auto;margin-top:20px;"></div>
            </div>
            <!-- 发布最多 -->
            <div style="width: 100%;margin-left: 550px;">
                <div class="release ">
                    <div class="headpic"><img src="{$overview.max_found.thumbnail_url}" alt=""></div>
                    <div class="name">{$overview.max_found.name}</div>
                    <div class="name color">任务发布最多</div>
                </div>
                <!-- 完成最多 -->
                <div class="release ">
                    <div class="headpic"><img src="{$overview.max_finish.thumbnail_url}" alt=""></div>
                    <div class="name">{$overview.max_finish.name}</div>
                    <div class="name color">任务完成最多</div>
                </div>
            </div>

        </div>
        <!-- 任务数据 -->
        <div class="data">
            <div class="left">

                <div class="title">任务月数据</div>
                <!-- 年月 -->
                <div class="date">

                    <div class="year">
                        <div class="pre previous"><img class="arrow" src="/public/img/test/pre.png" alt=""></div>
                        <span class="yearly"></span>
                        <div class="pre next"><img class="arrow" src="/public/img/test/u840.png" alt=""></div>

                    </div>
                </div>
            </div>
            <!-- 任务数据图表 -->
            <div class="chart">
                <div id="dataList" style="width:80%;height:100%; float: left;"></div>
            </div>
        </div>
        <!-- 任务日数据 -->
        <div class="data">
            <div class="left">

                <div class="title">任务日数据</div>
                <!-- 年月 -->
                <div class="date">

                    <div class="year">
                        <div class="pre previous"><img class="arrow" src="/public/img/test/pre.png" alt=""></div>
                        <span class="yearly"></span>
                        <div class="pre next"><img class="arrow" src="/public/img/test/u840.png" alt=""></div>

                    </div>
                    <ul id="month" class="month">
                        <volist name="monthlist" id="mo" mod="4">

                            <eq name="mod" value="0">
                                <if condition="$mo eq 0">
                                    <li class="ml fff" value="">{$i}</li>
                                    <else/>
                                    <li class="ml">{$i}</li>
                                </if>
                                <else/>
                                <if condition="$mo eq 0">
                                    <li  class="fff" >{$i}</li>
                                    <else/>
                                    <li >{$i}</li>
                                </if>
                            </eq>
                        </volist>

                    </ul>
                </div>
            </div>
            <!-- 任务数据图表 -->
            <div class="chart">
                <div id="dayList" style="width:80%;height: 100%; float: left;"></div>
            </div>
        </div>

        <!-- 任务完成榜 -->
        <div class="overview">
            <div class="left" style="margin-right: -200px">任务完成榜</div>
            <div class="completeList">
                <table class="ul">
                    <tr>
                        <th>序号</th>
                        <th>用户</th>
                        <th>部门</th>
                        <th>完成<span id="finish_order"><img class="upsubscript" src="/public/img/test/u360.png" alt=""></span></th>
                        <th>进行中<span id="on_order"><img class="upsubscript" src="/public/img/test/u360.png" alt=""></span></th>
                        <th>已过期<span id="expire_order"><img class="upsubscript" src="/public/img/test/u360.png" alt=""></span></th>
                    </tr>
                    <volist name="finishlist" id="fl">
                        <tr class="finish">
                            <td>{$i}</td>
                            <td><img class="tableHead" src="{$fl.thumbnail_url}" alt=""><span>{$fl.name}</span></td>
                            <td>{$fl.department}</td>
                            <td>{$fl.finish}</td>
                            <td>{$fl.active}</td>
                            <td>{$fl.expire}</td>
                        </tr>
                    </volist>
                </table>
            </div>
        </div>
    </div>

</block>
<block name="footer_js">

    <script id="tpl" type="text/html">
        <%for(var i = 0; i < list.length; i++) {%>
            <tr class="finish">
                <td><%:=i+1%></td>
                <td><img class="tableHead" src="<%:=list[i].thumbnail_url%>" alt=""><span><%:=list[i].name%></span></td>
            <td><%:=list[i].department%></td>
            <td><%:=list[i].finish%></td>
            <td><%:=list[i].active%></td>
            <td><%:=list[i].expire%></td>
            </tr>
        <%}%>
    </script>
    <script src="/public/js/lib/template.js"></script>
    <script id="tpla" type="text/html">
        <th>序号</th>
        <th>用户</th>
        <th>部门</th>
        <th>完成</th>
        <th>进行中<span id="on_order"><img class="upsubscript" src="/public/img/test/u360.png" alt=""></span></th>
        <th>已过期<span id="expire_order"><img class="upsubscript" src="/public/img/test/u360.png" alt=""></span></th>
    </script>
    <script src="/public/echarts/echarts.min.js"></script>
    <script>
		$(function () {
			var now_month={$now_month};

			$('#month li').each(function () {
				if('{$Think.get.month}' == ''){
					if($(this).index()== now_month){
						$(this).attr("style", "background:#688696!important")
					}
				}else {
					var temp='{$Think.get.month}'.substr(5)-1;
					console.log(temp)
					if($(this).index() == temp){
						$(this).attr("style", "background:#688696!important")
					}
				}

			})
			// 任务概览饼图
			var data = [
                {value:{$overview.finish_count}, name:'已完成'},
                {value:{$overview.pending_count}, name:'未完成'},
			]
			var myChart = echarts.init(document.getElementById('main'));
//			window.onresize = myChart.resize;

			option = {
				tooltip: {
					trigger: 'item',
					formatter: "{a} <br/>{b}: {c} ({d}%)"
				},
				color: ['#5B9BD5', '#ED7D31'],
				title: {
					subtext: '总数',
					text: '{$overview.count}',
					x: '29%',
					y: 'center',
					textAlign: 'center'
				},
				legend: {

					orient: 'vertical',
					x: '60%',
					y: 'middle',
					align: 'left',
					formatter: function (name) {
						var num
						for (var i = 0; i < data.length; i++) {
							if (name === data[i].name) {
								num = data[i].value
							}
						}

						return name + '    ' + num;
					},
					data: data

				},

				series: [
					{
						name: '任务',
						type: 'pie',
						radius: ['50%', '70%'],
						center: ['30%', '50%'],
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
						data: [
                            {value:{$overview.finish_count}, name:'已完成'},
                            {value:{$overview.pending_count}, name:'未完成'},

						],
					}
				]
			};

			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);

			//当前年
//			var myDate = new Date();
//			var newYear = myDate.getFullYear();
			var newYear = {$now_year};
			var yearly = $('.yearly');
			var department_id='{$Think.get.department_id}';
			var temp_month=now_month+1;
			var month=newYear+'-'+temp_month;

			yearly.text(newYear);
			$('.previous').click(function () {
				newYear -= 1;
				yearly.text(newYear);
				month=newYear+'-'+temp_month
				var url = '/service/statistics/task/data?department_id=' + department_id+'&year='+newYear+'&month='+month;
				window.location.replace(url);
			});
			$('.next').click(function () {
				newYear += 1;
				yearly.text(newYear);
				month=newYear+'-'+temp_month
				var url = '/service/statistics/task/data?department_id=' + department_id+'&year='+newYear+'&month='+month;
				window.location.replace(url);
			});

			$('.download').click(function () {
				var url = '/service/statistics/task/data?department_id=' + department_id+'&year='+newYear+'&action=export';
				window.location.replace(url);
			});
			$('#month').find('li').click(function () {
                if($(this).attr("class")!='fff'){
					$("#month li").eq($(this).index()).attr("style", "background:#688696").siblings().removeAttr("style");
                //post 操作
//                    now_month=$(this).index();
					tem_month=$(this).index()+1;
					if(temp_month<10){
						month=newYear+'-0'+tem_month;
					}else {
						month=newYear+'-'+tem_month;
					}
					postDay()
                }


			});


			$('select[name=department]').change(function () {
				department_id = $(this).val();
				var url = '/service/statistics/task/data?department_id=' + department_id+'&year='+newYear+'&month='+month;
				window.location.replace(url);
			});
			// 数据月图表
            var month_found=<php>echo json_encode($month['found'])</php>;
            var month_finish=<php>echo json_encode($month['finish'])</php>;
			var myDataList = echarts.init(document.getElementById('dataList'));

			window.addEventListener("resize", function () {

				myChart.resize();
				myDataList.resize();
				myDayList.resize();

			});
			option1 = {
				tooltip: {
					trigger: 'axis',
					axisPointer: {
						type: 'shadow'
					}
				},
				color: ['#688696', '#8BC34A'],
				legend: {
					data: ['新增任务', '完成任务'],
					x: '5%',
					y: '5%',
				},
				grid: {
					left: '3%',
					right: '4%',
					bottom: '3%',
					containLabel: true
				},
				xAxis: [
					{
						type: 'category',
						data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
					}
				],
				yAxis: [
					{
						type: 'value'
					}
				],
				series: [
					{
						name: '新增任务',
						type: 'bar',
						data: month_found
					},
					{
						name: '完成任务',
						type: 'bar',
						stack: '广告',
						data:month_finish
					},


				]
			}
			myDataList.setOption(option1);

			// 数据日图表
            var day_list=<php>echo json_encode($day_list)</php>;
            var day_found=<php>echo json_encode($day['found'])</php>;
            var day_finish=<php>echo json_encode($day['finish'])</php>;
			var myDayList = echarts.init(document.getElementById('dayList'));
			option2 = {
				tooltip: {
					trigger: 'axis',
					axisPointer: {
						type: 'shadow'
					}
				},
				color: ['#688696', '#8BC34A'],
				legend: {
					data: ['新增任务', '完成任务'],
					x: '5%',
					y: '5%',
				},
				grid: {
					left: '3%',
					right: '4%',
					bottom: '3%',
					containLabel: true
				},
				xAxis: [
					{
						type: 'category',
						data: day_list
					}
				],
				yAxis: [
					{
						type: 'value'
					}
				],
				series: [
					{
						name: '新增任务',
						type: 'bar',
						data: day_found
					},
					{
						name: '完成任务',
						type: 'bar',
						stack: '广告',
						data: day_finish
					},


				]
			}
			myDayList.setOption(option2);
			function postDay() {
				var url = '/service/statistics/task/getday';
				var param = {};
				param.department_id = department_id;
				param.month= month;
			    K.doAjax(param, url,function (e) {
                    if (e.status && e.status == "success") {
                        day_found=e.day.found;
                        day_finish=e.day.finish;
						day_list=e.day_list;
						myDayList = echarts.init(document.getElementById('dayList'));
						option3 = {
							tooltip: {
								trigger: 'axis',
								axisPointer: {
									type: 'shadow'
								}
							},
							color: ['#688696', '#8BC34A'],
							legend: {
								data: ['新增任务', '完成任务'],
								x: '5%',
								y: '5%',
							},
							grid: {
								left: '3%',
								right: '4%',
								bottom: '3%',
								containLabel: true
							},
							xAxis: [
								{
									type: 'category',
									data: day_list
								}
							],
							yAxis: [
								{
									type: 'value'
								}
							],
							series: [
								{
									name: '新增任务',
									type: 'bar',
									data: day_found
								},
								{
									name: '完成任务',
									type: 'bar',
									stack: '广告',
									data: day_finish
								},


							]
						}
						myDayList.setOption(option3);


					} else {
                        if (e.message) {
                            layer.msg(e.message, {icon: 2, time: 1500})
                        } else {
                            layer.msg("后台错误!", {icon: 2, time: 1500})
                        }
				    }
			    })
			}
			var finish_order=1;
			var on_order=1;
			var expire_order=1;
            $('#finish_order').click(function () {
            	if(finish_order == 2){
					finish_order=1;
				}else {
					finish_order=2;
				}
				postFinish("finish_order",finish_order);
			});
             $('#on_order').click(function () {
            	if(on_order == 2){
					on_order=1;
				}else {
					on_order=2;
				}
				postFinish("on_order",on_order);
			});
             $('#expire_order').click(function () {
            	if(expire_order == 2){
					expire_order=1;
				}else {
					expire_order=2;
				}
				postFinish("expire_order",expire_order);
			});

			function postFinish(type,val){
				var url = '/service/statistics/task/finishlist';
				var key=type;
				var param = {};
				param.department_id = department_id;
				param.year= newYear;
				param[key]=val;
				K.doAjax(param, url,function (e) {
					if (e.status && e.status == "success") {
                        var data=e.finishlist;
						var tpl = document.getElementById('tpl').innerHTML;
                        console.log(data);
						var ul=$('table');
						var finish=$('.finish');
						finish.remove();
						ul.append(template(tpl, {list:data}));


					} else {
						if (e.message) {
							layer.msg(e.message, {icon: 2, time: 1500})
						} else {
							layer.msg("后台错误!", {icon: 2, time: 1500})
						}
					}
				})

			}
		});


    </script>
</block>
