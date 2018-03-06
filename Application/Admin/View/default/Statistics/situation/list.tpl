<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="menu_title">形势统计</block>

<block name="body_main">
    <style>
        .more-d {
            position: absolute;
            margin: 20px;
            width: 500px;
            height: auto;
            overflow-x: hidden;
            padding: 0;
            line-height: 30px;
            box-sizing: border-box;
            padding-bottom: 20px;
        }

        .more-li {
            margin-top: -1px;
            padding: 10px;
            border: 1px solid #e0e0e0;
            box-sizing: border-box;
        }

        .more-line {
            margin: 8px 0;
            line-height: 20px;
        }

    </style>
    <div class="page-container">
        <form class="form form-horizontal bk-gray pd-20 bg-fff" method="get">
            <div class="text-l ">
                
                <span class="select-box" style="width:100px;">
                    <select name="department_id" class="select">
                        <option value="">全部部门</option>
                        <volist name="department" id="v">
                            <option value="{$v.department_id}" <if
                                    condition="I('get.department_id') eq $v['department_id']"> selected</if>>{$v.name}</option>
                        </volist>
                    </select>
                </span>
                <span class="select-box ml-10" style="width:100px;">
                    <select name="province_id" class="select">
                        <option value="">筛选地区</option>
                        <volist name="province" id="v">
                            <option value="{$v.province_id}"
                                <if condition="I('get.province_id') == $v['province_id']"> selected</if>
                            >{$v.province_name}</option>
                        </volist>
                    </select>
                </span>
                <span class="select-box ml-10" style="width:100px;">
                    <select name="light_proj" class="select">
                        <option value="">落实完成</option>
                        <option value="1" <if condition="I('get.light_proj') eq 1"> selected</if>>是</option>
                        <option value="0" <if condition="I('get.light_proj') == '0'"> selected</if>>否</option>
                    </select>
                </span>
                <span class="select-box ml-10" style="width:120px;">
                    <select name="proj_type" class="select">
                       <option value="">筛选项目类型</option>
                        <volist name="models" id="v">
                            <option value="{$v.model_config_id}" <if
                                    condition="I('get.proj_type') eq $v['model_config_id']"> selected</if>>
                            {$v.name}</option>
                        </volist>
                    </select>
                </span>
                <span class="select-box ml-10" style="width:100px;">
                    <select name="is_ticket" class="select">
                        <option value="">是否售票</option>
                        <option value="1" <if condition="I('get.is_ticket') eq 1"> selected</if>>是</option>
                        <option value="0" <if condition="I('get.is_ticket') == '0'"> selected</if>>否</option>
                    </select>
                </span>
                <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
                       class="input-text ml-10" style="width:100px"
                       name="begin_time" placeholder="开始时间"
                       value="{$Think.get.begin_time}"
                       class="input-text Wdate"/>
                <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
                       class="input-text" style="width:100px"
                       name="end_time" placeholder="结束时间"
                       value="{$Think.get.end_time}"
                       class="input-text Wdate"/>
                <span class="select-box ml-10" style="width:120px;">
                    <select name="company" class="select">
                        <option value="">筛选制作公司</option>
                        <volist name="companys" id="v">
                            <option value="{$v.name}" <if condition="I('get.company') eq $v['name']"> selected</if>>
                            {$v.name}</option>
                        </volist>
                    </select>
                </span>
                <span class="select-box ml-10" style="width:120px;">
                    <select name="level" class="select">
                        <option value="">筛选项目级别</option>
                        <volist name="Think.config.PROJECT_LEVEL_LIST" id="item">
                          <option value="{$key}" <if condition="I('get.level') eq $key"> selected</if>>{$item}</option>
                        </volist>
                    </select>
                </span>
                <input type="text" class="input-text ml-10" style="width:80px"
                       name="name" placeholder="项目名称"
                       value="{$Think.get.name}"/>
                <input type="text" class="input-text ml-10" style="width:70px"
                       name="pg_size" placeholder="显示条数"
                       value="{$Think.get.pg_size}"/>

                <button name="" class="btn btn-secondary radius ml-10" type="submit"><i class="Hui-iconfont">
                        &#xe665;</i> 搜索
                </button>
                <button name="" class="btn btn-link" type="button" onclick="init()">清空筛选条件
                </button>
            </div>
        </form>

        <div class="mt-20 bg-fff">
            <table class="table table-border table-bordered table-bg table-hover table-sort">
                <thead>
                <tr class="text-c">
                    <th width="70" class="c-666">客户名称</th>
                    <th width="70" class="c-666">项目名称</th>
                    <th width="15" class="c-666">落实完成</th>
                    <th width="50" class="c-666">项目类型</th>
                    <th width="60" class="c-666">展出时间</th>
                    <th width="40" class="c-666">规模(万元)</th>
                    <th width="20" class="c-666">投资形式</th>
                    <th width="20" class="c-666">售票</th>
                    <th width="150" class="c-666">场地情况</th>
                    <th class="c-666">项目情况</th>
                    <th width="65" class="c-666">制作公司</th>
                    <th width="35" class="c-666">等级标记</th>
                    <th width="40" class="c-666">状态</th>
                    <th width="70" class="c-666">操作</th>
                </tr>
                </thead>
                <tbody>
                <volist name="data" id="item">
                    <tr class="text-l">
                        <td>{$item.customer_name}</td>
                        <td>{$item.project_name}</td>
                        <td>
                            <php>echo (1==$item['light_proj']?'是':'否');</php>
                        </td>
                        <td>{$item.proj_type}</td>
                        <td>{$item.begin_date} ~ {$item.end_date}</td>
                        <td>{$item.scale_fee}</td>
                        <td>{$item.fee_type}</td>
                        <td>{$item.is_ticket}</td>
                        <td>
                            <ul>
                                <li class="more-line"><strong class="c-666">展出场地：</strong>{$item.address|default=''}
                                </li>
                                <li class="more-line"><strong class="c-666">日常门票：</strong>{$item.ticket|default=''}</li>
                                <li class="more-line"><strong class="c-666">交通情况：</strong>{$item.traffic|default=''}
                                </li>
                                <li class="more-line"><strong
                                            class="c-666">日常客流：</strong>{$item.peace_passenger|default=''}</li>
                                <li class="more-line"><strong
                                            class="c-666">性质及上下级关系：</strong>{$item.relation|default=''}</li>
                                <li class="more-line"><strong class="c-666">接待能力：</strong>{$item.ability|default=''}
                                </li>
                            </ul>
                        </td>
                        <td>
                            <ul>
                                <li class="more-line"><strong class="c-666">项目情况：</strong>{$item.context|default=''}
                                </li>
                                <li class="more-line"><strong
                                            class="c-666">灯会期间门票：</strong>{$item.run_ticket|default=''}</li>
                                <li class="more-line"><strong
                                            class="c-666">灯会期间客流：</strong>{$item.run_passenger|default=''}</li>
                                <li class="more-line"><strong class="c-666">收益情况：</strong>{$item.out_value|default=''}
                                </li>
                                <li class="more-line"><strong class="c-666">运营方案：</strong>{$item.programme|default=''}
                                </li>
                                <li class="more-line"><strong class="c-666">网络报道：</strong>{$item.report|default=''}</li>
                            </ul>
                        </td>
                        <td>
                            <php>echo str_replace(',','<br>',$item['company']);</php>
                        </td>
                        <if condition="'director' == session('employee.role_type_code') &&  'business' ==session('employee.department_type_id')">
                            <td>
                                <select name="set_level" onchange="changeLevel(this,'{$item.project_id}')"
                                        class="select" custid="{$item.customer_id}">
                                    <volist name="Think.config.PROJECT_LEVEL_LIST" id="v">
                                        <option value="{$key}"
                                        <if condition="$item['level'] eq $key"> selected</if>
                                        >{$v}</option>
                                    </volist>
                                </select>
                            </td>
                            <else/>
                            <td>
                                <notempty name="item.level">
                                    <php>echo c('PROJECT_LEVEL_LIST')[$item['level']];</php>
                                </notempty>
                            </td>
                        </if>
                        <td>
                            <php>echo
                                (0===strpos($item['company'],'本公司'))?(c('SON_STATUS_LIST')[$item['son_status']]):$item['other_status'];
                            </php>
                        </td>

                        <td class="text-c">
                            <a class="" href="javascript:;" title="配置业务员"
                            <if condition="'director' == session('employee.role_type_code')">
                                onclick="LsgLayerShow('配置业务员','/service/customer/manage/employee?issit=1&id={$item.customer_id}
                                ', 400, 500,200)"
                            </if>
                            <if condition="'boss' == session('employee.role_type_code')">
                                onclick="LsgLayerShow('配置业务员','/service/customer/manage/departemployee?issit=1&id={$item.customer_id}
                                ', 400, 500,200)"
                            </if>
                            ><i class="Hui-iconfont">&#xe68b;</i>
                            </a>
                            <a class="ml-10" href="javascript:;" title="修改项目"
                               onclick="LsgLayerShow('修改项目','/service/customer/search/addproject?project_id={$item.project_id}',800, 550,50)"><i
                                        class="Hui-iconfont">&#xe6df;</i>
                            </a>
                            <a class="ml-10" href="javascript:;" title="删除项目" onclick="delProj('{$item.project_id}')"><i
                                        class="Hui-iconfont">&#xe6e2;</i>
                            </a>
                        </td>

                    </tr>
                </volist>
                </tbody>
            </table>
            <div class="right_box_content">
                <div id="pager" class="pb-20" style="margin:20px auto; text-align:center;"></div>
            </div>
        </div>
    </div>
</block>

<block name="footer_js">
    <script type="text/javascript">
		/*  分页 */
		var department_id = $("select[name=department_id]").val();
		var province_id = $("select[name=province_id]").val();
		var is_ticket = $("select[name=is_ticket]").val();
		var company = $("select[name=company]").val();
		var level = $("select[name=level]").val();
		var begin_time = $("input[name=begin_time]").val();
		var end_time = $("input[name=end_time]").val();
		var light_proj = $("select[name=light_proj]").val();
		var proj_type = $("select[name=proj_type]").val();
		var name = $("input[name=name]").val();
		var pg_size = $("input[name=pg_size]").val();
		var param = '&proj_type=' + proj_type + '&name=' + name + '&light_proj=' + light_proj + '&department_id=' + department_id + '&province_id=' + province_id + '&is_ticket=' + is_ticket + '&company=' + company + '&level=' + level + '&begin_time=' + begin_time + '&end_time=' + end_time + '&pg_size=' + pg_size;
		var page_size = '<php> echo empty($pager->totalPages) ? 1 : $pager->totalPages;</php>';
		if (page_size > 1) {
			PAGER.create(page_size, param);
		}

		function delProj(proj_id) {
			var param = {
				project_id: proj_id
			}
			var url = "/service/project/manage/del";
			layer.confirm('删除后不可恢复，请确认谨慎进行删除操作！', {
				btn: ['确认', '取消'] //可以无限个按钮
			}, function (index, layero) {
				K.doAjax(param, url, function (res) {
					if (res.status && res.status == 'success') {
						//K.refreshParent();
						window.location.reload();
					} else {
						if (res.message) {
							layer.msg(res.message, {icon: 2, time: 2000});
						} else {
							layer.msg('后台错误!', {icon: 2, time: 2000});
						}
					}
				});
				layer.close(index);
			}, function (index) {
				layer.close(index);
			});

		}

		function init() {
			window.location.href = "/service/statistics/situation/list";
		}

		function changeLevel(me, project_id) {
			var level = $(me).val()
			var cust = $(me).attr('custid');
			console.log(cust, level)
			var title = '确认要修改该项目的等级？';

			layer.confirm(title, {
				btn: ['确认', '取消'] //可以无限个按钮
			}, function (index, layero) {
				callChange(project_id, level)
				layer.close(index);
			}, function (index) {
				layer.close(index);
			});

		}

		function callChange(project_id, level) {
			var param = {
				level: level,
				project_id: project_id
			}
			var url = "/service/statistics/situation/changeAbc"
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					//K.refreshParent();
					window.location.reload();
				} else {
					if (res.message) {
						layer.msg(res.message, {icon: 2, time: 2000});
					} else {
						layer.msg('后台错误!', {icon: 2, time: 2000});
					}
				}
			});
		}

		function LsgLayerShow(title, url, w, h, y) {
			$(".screen_popup").hide();
			var height = $(parent.window).height() - 60;
			var offset = (height - h) / 2;
			// layer_show('客户资料','/service/customer/search/addevent', 750, 700);
			layer.open({
				type: 2,
				area: [w + 'px', h + 'px'],
				fix: false, //不固定
				maxmin: true,
				shade: 0.4,
				title: title,
				content: url,
				offset: offset + 'px'
			});
		}

//		var $list = JSON.parse('<php>echo json_encode($data);</php>');

		function showAddr(id) {
			cur = {};
			$.each($list, function (i, v) {
				if (id == v.project_id) {
					cur = v;
				}
			})

			var str = '<div class="more-d">'
			str += '<div class="more-li" style="margin-top:0">展出场地：' + (cur.address ? cur.address : '') + '</div>';
			str += '<div class="more-li">日常门票：' + (cur.ticket ? cur.ticket : '') + '</div>';
			str += '<div class="more-li">交通情况：' + (cur.traffic ? cur.traffic : '') + '</div>';
			str += '<div class="more-li">日常客流：' + (cur.peace_passenger ? cur.peace_passenger : '') + '</div>';
			str += '<div class="more-li">性质及上下级关系：' + (cur.relation ? cur.relation : '') + '</div>';
			str += '<div class="more-li">接待能力：' + (cur.ability ? cur.ability : '') + '</div>';
			str += '</div>';

			layer.open({
				type: 1,
				title: '场地详情',
				// skin: 'layui-layer-rim', //加上边框
				area: ['550px', '400px'], //宽高
				content: str,
			});
		}

		function showProj(id) {
			cur = {};
			$.each($list, function (i, v) {
				if (id == v.project_id) {
					cur = v;
				}
			})

			var str = '<div class="more-d">'
			str += '<div class="more-li" style="margin-top:0">项目情况：' + (cur.context ? cur.context : '') + '</div>';
			str += '<div class="more-li">灯会期间门票：' + (cur.run_ticket ? cur.run_ticket : '') + '</div>';
			str += '<div class="more-li">灯会期间客流：' + (cur.run_passenger ? cur.run_passenger : '') + '</div>';
			str += '<div class="more-li">收益情况：' + (cur.income ? cur.income : '') + '</div>';
			str += '<div class="more-li">运营方案：' + (cur.programme ? cur.programme : '') + '</div>';
			str += '<div class="more-li">网络报道：' + (cur.report ? cur.report : '') + '</div>';
			str += '</div>';

			layer.open({
				type: 1,
				title: '项目详情',
				// skin: 'layui-layer-rim', //加上边框
				area: ['550px', '400px'], //宽高
				content: str,
			});
		}

    </script>
</block>        