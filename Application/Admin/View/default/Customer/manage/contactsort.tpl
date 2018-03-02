<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">

</block>
<block name="common_js">
</block>

<block name="body_main">
    <style>
        .context -box {
            width: 100%;
            height: 300px;
            margin: 0 auto;
            padding: 0 10px;
            overflow: hidden;
            box-sizing: border-box;
        }

        .left-box, .right-box {
            width: 47%;
        }

        .left-box label, .right-box label {
            /*display: block;*/
            height: 30px;
            margin-left: 10px;
            line-height: 30px;
        }

        .left-box {
            float: left;
            margin-left: 0
        }

        .right-box {
            float: right;
            margin-right: 0
        }

        .clear {
            clear: both;
        }

        .list-box {
            width: 100%;
            height: 340px;
            border: 1px solid #e0e0e0;
            box-sizing: border-box;
            display: block;
            overflow-y: auto;
        }

        .li-box {
            height: 30px;
            overflow-y: hidden;
        }

        .list-box li {
            height: 30px;
            line-height: 30px;
            width: 100%;
            overflow: hidden;
            border-bottom: 1px solid #e0e0e0;
            box-sizing: border-box;
        }

        .list-box li span {
            display: inline-block;
            margin-left: 10px;
            width: 80%;
            overflow: hidden;
        }

        .list-box li i {
            /*position: relative;*/
            /*display: inline-block;*/
            /*left: 10px;*/
            /*top:-10px;*/
            cursor:pointer;
            vertical-align: top;
        }

        .btn {
            height: 31px !important;
            font-size: 14px !important;
        }

        .active {
            background: #9c9c9c;
        }

        a {
            color: #06c;
            margin-left: 60px;
        }
        .layui-layer-btn{
            text-align: center;
        }
    </style>
    <article class="page-container">
        <div class=" cl context-box">
            <div class="left-box">
                <label>部门/科室</label>
                <a onclick="depLayerShow('添加部门/科室','/service/customer/manage/adddepartment?id={$customer_id}', 420, 200)">添加一个新部门/科室</a>
                <ul class="list-box" id="depart">
                    <volist name="depart" id='v'>
                        <li
                        <if condition="$i == 1">class="active"</if>
                        >
                        <span style="width: 74%;"
                              onclick="showContact('{$key}')">{$v.department|default='未知'}</span>
                        <i class="Hui-iconfont c-666 top">&#xe679;</i>
                        <i onclick="depLayerShow('编辑部门','/service/customer/manage/changedepartment?id={$v.customer_department_id}&type=change', 600, 300,100)"
                           class="Hui-iconfont c-666">&#xe60c;</i>
                        <i onclick="delDepart({$v.customer_department_id})" class="Hui-iconfont c-666">&#xe706;</i>
                        </li>
                    </volist>

                </ul>
                <ul class="list-box li-box mt-20" id="leave">
                    <li>
                        <span style="width: 74%;" onclick="showQuitContact()"
                        >已离职</span>
                    </li>
                </ul>

            </div>
            <div class="right-box">
                <label>联系人</label>
                <a onclick="conLayerShow('添加联系人','/service/customer/search/addcontact?id={$customer_id}')"
                   style="margin-left: 90px;">添加一个新联系人</a>
                <ul class="list-box" id="contact">
                    <volist name="data['contact'][0]" id='item'>
                        <li>
                            <span>{$item.name|default="未知"}</span>
                            <i onclick="delContact({$item.customer_contact_id})" class="Hui-iconfont c-666">&#xe706;</i>
                        </li>
                    </volist>
                </ul>
            </div>
            <div class="clear"></div>
        </div>

        <div class="mt-20">
            <button onclick="commit()" class="btn btn-primary radius ml-10" type="button">确认</button>
            <button onclick="K.refreshParent()" class="btn btn-default radius ml-20" type="button">取消</button>
        </div>
    </article>
</block>
<block name="footer_js">
    <script type="text/javascript">


		var $datas = JSON.parse('<php>echo json_encode($data);</php>');
		if ($datas['depart'].length > 0) {
			var customer_department_id = $datas['depart'][0]['customer_department_id'];
		} else {
			var customer_department_id = '';
		}
		$("#depart li span").click(function () {
			$(this).parent().siblings().removeClass('active');
			$("#leave li").removeClass('active');
			$(this).parent().addClass('active');
			var index = $(this).parent().index();
			customer_department_id = $datas['depart'][index]['customer_department_id'];
			if (customer_department_id != '') {
				$('.right-box a').show();
			}
			console.log(customer_department_id);
		});
		$("#leave li span").click(function () {
			$("#depart li").removeClass('active');
			$(this).parent().addClass('active');
			customer_department_id = '';
			if (customer_department_id == '') {
				$('.right-box a').hide();
			}
			console.log(customer_department_id);
		});
		if (customer_department_id == '') {
			$('.right-box a').hide();
		}
		initli();
		$("#depart li .top").click(function () {
			var index = $(this).parent().index();
			var weight1 = $datas['depart'][index]['weight'];
			var weight2 = $datas['depart'][index - 1]['weight'];
			$datas['depart'][index]['weight'] = weight2;
			$datas['depart'][index - 1]['weight'] = weight1;
			sortC($datas['depart']);
			if ($(this).parent().prev()) {          // 如果存在下一个元素
				$(this).parent().prev().before($(this).parent());
			}

			initli();
		});

		function sortContact(num) {
			var index = $(this.event.currentTarget).parent().index();
			var weight1 = $datas['contact'][num][index]['weight'];
			var weight2 = $datas['contact'][num][index - 1]['weight'];
			$datas['contact'][num][index]['weight'] = weight2;
			$datas['contact'][num][index - 1]['weight'] = weight1;
			sortC($datas['contact'][num]);
			if ($(this.event.currentTarget).parent().prev()) {          // 如果存在下一个元素
				$(this.event.currentTarget).parent().prev().before($(this.event.currentTarget).parent());
			}

			initli();

		}

		function sortLeaveContact() {
			var index = $(this.event.currentTarget).parent().index();
			var weight1 = $datas['leave'][index]['weight'];
			var weight2 = $datas['leave'][index - 1]['weight'];
			$datas['leave'][index]['weight'] = weight2;
			$datas['leave'][index - 1]['weight'] = weight1;
			sortC($datas['leave']);
			if ($(this.event.currentTarget).parent().prev()) {          // 如果存在下一个元素
				$(this.event.currentTarget).parent().prev().before($(this.event.currentTarget).parent());
			}
			initli();

		}


		function initli() {
			$("ul li").each(function (i) {
//				$("ul:eq(" + j + ") li").each(function (i, v) {
					if (i == 0) {
						$(this).find('i').eq(0).hide();
					} else {
						$(this).find('i').eq(0).show();
					}
//				});
			})

		}

		function sortC(tt) {
			tt = tt.sort(function (a, b) {
				if (parseInt(a['weight']) < parseInt(b['weight'])) return -1;
				else if (parseInt(a['weight']) > parseInt(b['weight'])) return 1;
				else return 0;
			});
		}

		function showContact(tt) {
			$('#contact').empty();
			$.each($datas['contact'][tt], function (i, v) {
				var str = '<li>';
				str += '<span>' + (v.name ? v.name : '未知') + '</span>';
				str += '<i onclick="delContact(' + v.customer_contact_id + ')"class="Hui-iconfont c-666">&#xe706;</i></li>'

				$('#contact').append(str);
			})
			initli();
		}

		function showQuitContact() {
			$('#contact').empty();
			$.each($datas['leave'], function (i, v) {
				var str = '<li>';
				str += '<span>' + (v.name ? v.name : '未知') + '</span>';
				str += '<i  onclick="sortLeaveContact()" class=" Hui-iconfont c-666">&#xe679;</i><i onclick="delContact(' + v.customer_contact_id + ')" class="Hui-iconfont c-666">&#xe706;</i></li>'

				$('#contact').append(str);
			})
			initli();
		}


		function depLayerShow(title, url, w, h, y) {
			layer.open({
				type: 2,
				area: [w + 'px', h + 'px'],
				fix: false, //不固定
				maxmin: true,
				shade: 0.4,
				title: title,
				content: url,
				offset: y + 'px'
			});
		}

		//var $layer_dig_id = null;
		function conLayerShow(title,url) {
			window.location.href = url + '&type=add&customer_department_id=' + customer_department_id;
//			console.log(url)
//			$layer_dig_id = parent.layer.open({
//				type: 2,
//				area: [w + 'px', h + 'px'],
//				fix: false, //不固定
//				maxmin: true,
//				shade: 0.4,
//				title: title,
//				content: url + '&type=add&customer_department_id=' + customer_department_id,
//				offset: y + 'px'
//			});
		}

		function delDepart(id) {
			layer.confirm('删除后当前部门下的员工变为已离职，请确认谨慎进行删除操作!', {
					btn: ['确定', '取消'] //按钮
				}, function () {
					var url = '/service/customer/manage/deldepartment';
					var param ={}
						param.customer_department_id = id;
					K.doAjax(param, url, function (e) {
						if (e.status && e.status == "success") {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							setTimeout("location.replace(location.href)", 2);
							return;
						} else {
							if (e.message) {
								layer.msg(e.message, {icon: 2, time: 1500})
							} else {
								layer.msg("后台错误!", {icon: 2, time: 1500})
							}
						}
					})
				}
			);
		}

		function delContact(id) {
			layer.confirm('删除后不可恢复，请确认谨慎进行删除操作!', {
					btn: ['确定', '取消'] //按钮
				}, function () {
					var url = '/service/customer/manage/delcontact';
					var param ={}
						param.customer_contact_id = id;
					K.doAjax(param, url, function (e) {
						if (e.status && e.status == "success") {
							layer.msg('删除成功!', {icon: 1, time: 2000});
							setTimeout("location.replace(location.href)", 2);
							return;
						} else {
							if (e.message) {
								layer.msg(e.message, {icon: 2, time: 1500})
							} else {
								layer.msg("后台错误!", {icon: 2, time: 1500})
							}
						}
					})
				}
			);
		}

		function commit() {
			var url = '/service/customer/manage/sortdepartment';
			var param ={};
			param.data = $datas;

			K.doAjax(param, url)
		}
    </script>
</block>