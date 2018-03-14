<extend name="./Application/Admin/View/mobile/base/context/common-new.tpl"/>

<block name="common_css">
    <link rel="stylesheet" type="text/css" href="/public/css/home/scrollbar.css"/>
</block>
<block name="common_js">

</block>

<block name="head_left">
    <img onclick="myself(1001)" class="head_left" src="/public/img/home/xlcweb/u23.png" alt=""/>
</block>

<block name="head_right">
    <img onclick="search()" class="head_right" src="/public/img/home/xlcweb/u21.png" alt=""/>
</block>

<block name="head_name">
    海天彩灯
</block>

<block name="body_main">
    <style>
        html, body {
            height: 100%;
        }

        a {
            text-decoration: none !important;

        }

        /*清除浮动*/
        .clearFix:after {
            content: "";
            display: block;
            height: 0;
            clear: both;
        }

        .headList {
            width: 100%;
            height: 70px;
            position: fixed;
            top: 50px;
            z-index: 10;
            overflow: hidden;
            background-color: #343643;
        }

        .headList ul li {
            position: relative;
            text-align: center;
            float: left;
            width: 20%;
            color: #fff;
        }

        .headList ul li .circular {
            position: relative;
            margin: auto;
            width: 41px;
            height: 41px;
            text-align: center;
            border: 1px solid #fff;
            border-radius: 50%;
        }

        .headList ul li .circular .hint {
            position: absolute;
            right: -5px;
            top: 0;
            width: 18px;
            height: 18px;
            line-height: 14px;
            text-align: center;
            border: 2px solid #fff;
            border-radius: 50%;
            background-color: #4286F5;
        }

        .headList ul li .circular .pic {
            width: 24px;
            height: 24px;
            margin-top: 8px;
            margin-bottom: 8px;
        }

        .headList ul li .triangle {
            display: none;
            position: absolute;
            bottom: -25px;
            left: 50%;
            margin-left: -26px;
            width: 0;
            height: 0;
            border-left: 25px solid transparent;
            border-right: 25px solid transparent;
            border-bottom: 25px solid #fff;
        }

        .tab {
            margin-top: 50px;
        }

        /*显示隐藏*/
        .headList ul li .triangle.none {
            display: block;
        }

        .contentlist {
            display: none;
            position: fixed;
            width: 100%;
            top: 120px;
            bottom: 10px;
            overflow: scroll;
            -webkit-overflow-scrolling:touch;

            padding: 20px 10px 0 10px;

        }

        /*显示隐藏*/
        .contentlist.none {
            display: block;
        }

        .contentlist .weekContent li {
            padding: 9px;
            font-size: 13px;
            margin-top: 20px;
            border-radius: 5px;
            border: 1px solid #E4E4E4;
        }

        .contentlist .weekContent li .seqnumber {
            float: left;
            width: 8%;
            /*height: 100%;*/
        }

        .contentlist .weekContent li .number {
            display: inline-block;
            width: 18px;
            height: 18px;
            color: #fff;
            line-height: 16px;
            font-style: normal;
            text-align: center;
            border: 2px solid #fff;
            border-radius: 50%;
            background-color: #2FBBE6;
        }

        .contentlist .weekContent li .textconernt {
            float: left;
            width: 90%;
        }

        /*待办信息是否已读*/
        .contentlist .weekContent li .read {
            display: inline-block;
            width: 5px;
            height: 5px;
            margin-right: 10px;
            vertical-align: middle;
            border-radius: 50%;
            background-color: #000;
        }

        .contentlist .weekContent li .read.none {
            display: none;

        }

        /*日期*/
        .contentlist .weekContent li .date {
            width: 18%;
            float: left;
        }

        .contentlist .weekContent li .textdate {
            float: left;
            width: 82%;
        }

        /*日历*/
        .datelist {
            position: relative;
            width: 100%;
        }

        .datelist h1 {
            width: 100%;
            height: 45px;
            margin: 0;
            padding: 0;
            text-align: center;
            font-size: 14px;
            line-height: 45px;
            border: 1px solid #E4E4E4;
        }

        .datelist .pre {
            position: absolute;
            top: 11px;
            left: 40px;
        }

        .datelist .next {
            position: absolute;
            top: 11px;
            right: 40px;
        }

        .datelist li {
            margin-top: 20px;
            float: left;
            width: 14%;
            text-align: center;
        }

        .date_body li {
            position: relative;
            float: left;
            margin-top: 20px;
            width: 14%;
            line-height: 40px;
            text-align: center;
        }

        .date_body li.active {
            background-color: #F2F2F2;
        }

        .date_body li img {
            position: absolute;
            width: 14px;
            height: 14px;
            right: 18px;
            bottom: -2px;
        }

        /*弹框*/
        .up .mr {
            margin-right: 20px;
        }

        .up .mt {
            margin-top: 20px;
        }

        .up .border-top {
            height: 40px;
            line-height: 40px;
            border-top: 1px solid #E4E4E4;
        }

        .up .border-top .left {
            float: left;
            color: #868686;
            text-align: center;
            width: 50%;
            border-right: 1px solid #E4E4E4;
        }

        .up .border-top .right {
            float: left;
            width: 50%;
            color: #4286F5;
            text-align: center;

        }

        /*时间提醒弹窗*/
        .dayremind {
            width: 100%;
            padding: 10px;
            overflow: hidden;
            overflow-y: scroll;
        }

        .dayremind li {
            width: 100%;
            padding: 10px 0;
            border-bottom: 1px solid #E4E4E4;
        }

        /*通知*/
   

    </style>
    <!-- 头部导航 -->

    <div class="headList clearFix">
        <ul id="nav">
            <li>
                <div class="circular">
                    <img class="pic" src="/public/img/home/xlcweb/u48.png" alt="">
                    <if condition="count($work) gt 0">
                        <div class="hint">{$work|count}</div>
                    </if>
                </div>
                <p>本周</p>
                <div class="triangle none"></div>
            </li>
            <li>
                <div class="circular">
                    <img class="pic" src="/public/img/home/xlcweb/u30.png" alt="">
                    <if condition="count($wait) gt 0">
                        <div class="hint">{$wait|count}</div>
                    </if>
                </div>
                <p>待办</p>
                <div class="triangle"></div>
            </li>
            <li>
                <div class="circular">
                    <img class="pic" src="/public/img/home/xlcweb/u35.png" alt="">
                    <if condition="count($task) gt 0">
                        <div class="hint">{$task|count}</div>
                    </if>
                </div>
                <p>任务</p>
                <div class="triangle "></div>
            </li>
            <li>
                <div class="circular">
                    <img class="pic" src="/public/img/home/xlcweb/u14.png" alt="">

                </div>
                <p>通知</p>
                <div class="triangle "></div>
            </li>
            <li>
                <div class="circular">
                    <img class="pic" src="/public/img/home/xlcweb/u19.png" alt="">

                </div>
                <p>日历</p>
                <div class="triangle"></div>
            </li>
        </ul>
    </div>

    <div class="tab">
        <!-- 本周内容 -->
        <div class="contentlist none">
            <ul class="weekContent">
                <volist name="work" id="wk">
                    <li class="clearFix">
                        <div class="seqnumber">
                            <i class="number">{$i}</i>
                        </div>
                        <p class="textconernt">{$wk.context}</p>

                    </li>
                </volist>

            </ul>

        </div>
        <!-- 待办内容 -->
        <div class="contentlist" id="deal">
            <div class="up" style="display:none;">
                <div class="title">重庆园博园</div>
                <div style="padding:20px;">
                    <div>
                        <span class="mr">经办人</span><span class="mr personnel">吕蒙</span><span
                                class="position">基建科科长</span>
                    </div>
                    <div class="mt days">07-14</div>
                </div>
                <div class="border-top">
                    <div class="left">不在提示</div>
                    <div class="right">
                        <img src="/public/img/home/xlcweb/u582.png" alt="">拨打电话
                    </div>
                </div>
            </div>
            <ul class="weekContent">
                <php>$arr=['1'=>'审核','2'=>'审批','3'=>'分配']</php>
                <volist>
                    <volist name="wait" id="wt">
                        <li>
                            <switch name="wt.type">
                                <case value="task">
                                    <p class="textlist"><i class="read"></i><a onclick="task({$wt.task_id})">新任务需要完成：{$wt.context}</a></p>
                                </case>
                                <case value="contact">
                                    <p class="textlist"
                                       onclick="showUp('{$wt.customer_contact_id}','{$wt.customer_name}','{$wt.next_time|strtotime|date="m-d",###}')">
                                        <i class="read"></i>{$wt.customer_name}的{$wt.name}生日，联系客户送上祝福</p>
                                </case>
                                <case value="liaison">
                                    <p class="textlist"><i class="read"></i><a onclick="detail('/service/customer/search/detail?customer_id={$wt.customer_id}&index=1')"  >客户：{$wt.customer_name}的项目：{$wt.project_name}需要跟进</a>
                                    </p>
                                </case>
                                <default/>
                                <p class="textlist"><i class="read"></i><a onclick="approve({$wt.approve})" >项目：{$wt.name}需要{$arr[$wt[approve_status]]}</a></p>
                            </switch>

                        </li>
                    </volist>
                </volist>

            </ul>

        </div>
        <!-- 任务内容 -->
        <div class="contentlist">
            <ul class="weekContent">
                <volist name="task" id="tk">
                    <li class="clearFix" onclick="task('{$tk.task_id}')">
                        <a href="#">
                            <div class="date">
                                {$tk.end_date|strtotime|date='m-d',###}
                            </div>
                            <p class="textdate">{$tk.context}</p>
                        </a>
                    </li>
                </volist>

            </ul>

        </div>

        <!-- 通知 -->
        <div class="contentlist notice" id="wrapper">
            
                <ul class="weekContent" id="thelist" >
                    <volist name="allnotice" id="ne">
                        <li class="clearFix" onclick="notice({$ne.notice_id})">
                            <p class="textlist">{$ne.title}</p>
                        </li>
                    </volist>
                </ul>
                
        </div>
        <!-- 日历 -->
        <div class="contentlist">
            <div class="datelist">
                <h1><span id="year"></span> <span id="month"></span>月</h1>
                <span class="pre">&lt;</span>
                <span class="next">&gt;</span>

                <ol>
                    <li>日</li>
                    <li>一</li>
                    <li>二</li>
                    <li>三</li>
                    <li>四</li>
                    <li>五</li>
                    <li>六</li>

                </ol>
            </div>
            <ul class="date_body">
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>
                <li></li>

            </ul>
        </div>
    </div>
</block>

<block name="footer_js">
    <script src="/public/js/home/iscroll.js"></script>
    <script src="/public/js/home/zepto.min.js"></script>
    <script src="/public/js/home/dropload.min.js"></script>

    <script>
		$(function () {
			$('#nav').find('li').click(function () {
				var index = $(this).index();
				console.log(index);
				$('#nav').find('li .triangle').removeClass('none');
				$(this).find('.triangle').addClass('none');
				$('.tab').find('.contentlist').removeClass('none');
				$('.tab').find('.contentlist').eq(index).addClass('none')
			})

			var urlhear = location.search;
			if (urlhear.indexOf("?") != -1) {
				var str = urlhear.substr(1, 1);
				console.log("==str", str);
				$('#nav').find('li .triangle').removeClass('none');
				$('#nav li').eq(str).find('.triangle').addClass('none');
				$('.tab').find('.contentlist').removeClass('none');
				$('.tab').find('.contentlist').eq(str).addClass('none')
			}

			// 待办信息是否已读

//             $('#deal').find('li').click(function(){
//                var title=$("#deal").find('.title').text();
//                var name=$("#deal").find('.personnel').text();
//                var position=$("#deal").find('.position').text();
//                var days=$("#deal").find('.days').text();
//                layer.open({
//                  type: 1,
//                  title:title,
//                  area: ['300px', '186px'],
//                  shadeClose: true,
//                  content: '\<\div class="up"><div style="padding:20px;"><div><span class="mr">经办人</span><span class="mr">'+name+'</span><span>'+position+'</span></div><div class="mt">'+days+'</div></div><div class="border-top"><div class="left">不在提示</div><div class="right"><a href="tel:1345858455"><img src="/public/img/home/xlcweb/u582.png" alt="">拨打电话</a></div></div>\<\/div>'
//                 });
//                $(this).find('.textlist .read').removeClass('none');
//             })


			//日历
			var nowDate = new Date();
			var dateYear = nowDate.getFullYear();
			var dateMon = nowDate.getMonth();
			var tMonth = dateMon;
			var yearMonth;

			function calendar(tMonth) {
				//根据传入的月份重新算时间
				var oDate = new Date();
				oUl = $('.date_body');
				var aLi = oUl.find('li');
				oDate.setMonth(tMonth);
				oDate.setDate(1);
				var iYear = oDate.getFullYear();
				var iMonth = oDate.getMonth();
				var iDay = oDate.getDay();
				if (iMonth < 9) {
					yearMonth = iYear + '-' + '0' + (iMonth + 1)
				} else {
					yearMonth = iYear + '-' + (iMonth + 1)
				}
				$('#year').text(iYear);
				$('#month').text(iMonth + 1);
				//初始化一下
				for (var i = 0; i < aLi.length; i++) {
					aLi[i].innerHTML = "";
					aLi[i].style.height = "40px";
					aLi[i].className = "";
				}
				var iSum = 0; //存本月天数
				var bLeap = false;//是否是闰年
				if (iYear % 4 == 0 && iYear % 100 !== 0 || iYear % 400 == 0) bLeap = true;
				switch (iMonth + 1) {
					case 1:
					case 3:
					case 5:
					case 7:
					case 8:
					case 10:
					case 12:
						iSum = 31;
						break;
					case 4:
					case 6:
					case 9:
					case 11:
						iSum = 30;
						break;
					case 2:
						if (bLeap) iSum = 29;
						else iSum = 28;
						break;
				}
				for (var i = 1; i <= iSum; i++) {
					aLi[iDay].innerHTML = i;
					iDay++;
				}

				for (var i = 0; i < aLi.length; i++) {
					if (aLi[i].innerHTML == nowDate.getDate() && iYear == dateYear && iMonth == dateMon) {
						aLi[i].className = "active";
					}

				}

				//把没字的格子折叠起来
				for (var i = 0; i < aLi.length; i++) {
					if (aLi[i].innerHTML == "") {
						aLi[i].style.height = "0px";
					}
				}
			}

			calendar(tMonth);
			$('.pre').click(function () {
				calendar(--tMonth);
//                     prompt([2,4,5]);
				monthList()
			})
			$('.next').click(function () {
				calendar(++tMonth);
//                     prompt([3,4,5]);
				monthList()
			})



			// 提示事件(时钟)
			function prompt(a) {
				var days
				for (var i = 0; i < a.length; i++) {
					days = a[i];
					var $li = $('.date_body').find('li');
					$li.each(function (i, el) {
						if ($(el).text() == days) {
							var day;
							var year = $('#year').text();
							var month = ($('#month').text() > 9) ? $('#month').text() : ('0' + $('#month').text());
							if (days < 10) {
								day = year + '-' + month + '-0' + days;
							} else {
								day = year + '-' + month + '-' + days;
							}
							$(el).append('<img src="/public/img/home/xlcweb/u410.png" onclick="remind(\''+day+'\')"/>');
						}
					})
				}

			}

			monthList();

			function monthList() {
				var param ={};
				param.month = yearMonth;
				var url = '/service/home/index/monthlist';
				K.doAjax(param, url, function (response) {
					if (response.status && 'success' == response.status) {
						prompt(response.list);
					} else {
						if (response.message) {
							layer.msg(response.message, {icon: 2, time: 1500})
						} else {
							layer.msg("后台错误!", {icon: 2, time: 1500})
						}
					}
				});
			}
			

			// 手机分页
	
			var myScroll;
			var pg = 1;
			var total_page = 1;
			pullUpAction()

			function pullUpAction() {
				$is_loading = true;
				window.parent.loading_show();
				var param = {
					pg: pg
				};
				var url = '/service/home/index/allnotice';
				K.doAjax(param, url, function (e) {
					if (e.status && e.status == "success") {
						var el = $('#thelist');
						for (i = 0; i < e.notice.length; i++) {
							var str = '<li class="clearFix" onclick="notice(' + e.notice[i].notice_id + ')"> ';
							str += '<p class="textlist"> ' + e.notice[i].title + '</p></li>';
							el.append(str)
						}
						pg++;
						total_page = e.totalPages;
						$is_loading = false;
						window.parent.loading_hide();
					} else {
						if (e.message) {
							$is_loading = false;
							window.parent.loading_hide();
							layer.msg(e.message, {icon: 2, time: 1500})
						} else {
							$is_loading = false;
							window.parent.loading_hide();
							layer.msg("后台错误!", {icon: 2, time: 1500})
						}
					}
				})
			}
            callScroll('thelist')
            var $is_loading=false;
            function callScroll(c) {
                $('.contentlist').scroll(function(){

                    var viewH =$(this).height(),//可见高度
                    contentH =$('#'+c).height(),//内容高度
                    scrollTop =$(this).scrollTop();//滚动高度
                    if(total_page >20){
                        return;
                    }
                    if(total_page>=pg && total_page>1){
                        if(contentH - viewH - scrollTop <= 1) { //到达底部50px时,加载新内容

                            if($is_loading) return;
                            pullUpAction();
                        }
                    }
                    
                });
            } 
          
    });

		function remind(day) {
			var param ={};
			param.day = day;
			var url = '/service/home/index/daylist';
			K.doAjax(param, url, function (response) {
				if (response.status && 'success' == response.status) {
					var str= '<div id="remind"><ul class="dayremind">';
					$.each(response.list, function (i, v) {
						str +='<li><p style="margin: 0;">'+v.customer_name+'</p></li>';
//                            '<p>'+v.project_name+'</p>';
					});
					str +='</ul></div>';

					layer.open({
						type: 1,
						title:response.day+'相关事宜',
						area: ['300px', '400px'],
						shadeClose: true,
						content: str
					});
//						console.log(response)
				} else {
					if (response.message) {
						layer.msg(response.message, {icon: 2, time: 1500})
					} else {
						layer.msg("后台错误!", {icon: 2, time: 1500})
					}
				}
			});
		}






		//项目联系框
		function showUp(id, customer_name, next_time) {
			var param ={};
			param.id = id;
			console.log(param)
			var url = '/service/home/index/contactdetails';
			$(this).find('.textlist .read').addClass('none');
			console.log($(this))
			K.doAjax(param, url, function (response) {
				if (response.status && 'success' == response.status) {
					var title = customer_name;
					var name = response.wait.name;
					var position = response.wait.department + response.wait.position;
					var days = next_time;
					var phone = response.wait.phone;

					layer.open({
						type: 1,
						title: title,
						area: ['300px', '186px'],
						shadeClose: true,
						content: '\<\div class="up"><div style="padding:20px;"><div><span class="mr">经办人</span><span class="mr">' + name + '</span><span>' + position + '</span></div><div class="mt">' + days + '</div></div><div class="border-top"><div style="text-align:center"><a href="tel:' + phone + '"><img src="/public/img/home/xlcweb/u582.png" alt="">拨打电话</a></div></div>\<\/div>'
					});
				} else {
					if (response.message) {
						layer.msg(response.message, {icon: 2, time: 1500})
					} else {
						layer.msg("后台错误!", {icon: 2, time: 1500})
					}
				}
			});


		}


		// 任务
		function task(id) {
			window.parent.operation("", "/service/home/index/addtask?id=" + id);
			// window.parent.location.href="/service/home/index/addtask?id="+id;
		}

		// 通知
		function notice(id) {

			// window.parent.location.href="/service/home/index/addnotice"
			window.parent.operation("", "/service/home/index/detailnotice?id=" + id);
		}


		// 我的
		function myself(id) {
			// window.parent.location.href="/service/employee/user/change?id=id"
			window.parent.operation("", "/service/employee/user/change?id=" + id);
		}

		// 搜索
		function search() {
			// window.parent.location.href="/service/system/search/index"
			window.parent.operation("", "/service/system/search/index");
		}

		// 搜索
		function approve(approve) {
			$('#main-iframe', window.parent.document).attr("src","/service/project/manage/approve?type="+approve);
			$(".nav_bar ul li", window.parent.document).removeClass("checked");
			$(".nav_bar ul li", window.parent.document).eq(1).addClass("checked");
		}

		// 搜索
		function detail(url) {
			// window.parent.location.href="/service/system/search/index"
			window.parent.operation("", "" + url);
		}

    </script>
    <!-- <script>
       
            // document.addEventListener('DOMContentLoaded', loaded, false);
        </script> -->
</block>