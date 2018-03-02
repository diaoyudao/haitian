<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <LINK rel="Bookmark" href="/favicon.ico" >
    <LINK rel="Shortcut Icon" href="/favicon.ico" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="/public/huiadmin/lib/html5.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/respond.min.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/PIE_IE678.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/Hui-iconfont/1.0.7/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/css/style.css" />
    
    <!--[if IE 6]>
    <script type="text/javascript" src="/public/huiadmin/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>haitian</title>
</head>
<body>
<style>
body{
    background-color: #EEF5F9;
}  
.page-head{
    width:100%;
    height:60px;line-height: 60px;
    background-color: #fff;
    border-bottom: 1px #ccc solid;
    box-shadow: 0 3px 3px #ccc;
    font-size:16px;
    color:#30baba;
}
.page-head .title{
    margin-left: 20px;
}
</style>
<nav class="page-head">    
    <div class="title">形势统计
    </div>
</nav>

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
                        <?php if(is_array($department)): $i = 0; $__LIST__ = $department;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><option value="<?php echo ($v["department_id"]); ?>" <?php if(I('get.department_id') == $v['department_id']): ?>selected<?php endif; ?>><?php echo ($v["name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                    </select>
                </span>
                <span class="select-box ml-10" style="width:100px;">
                    <select name="province_id" class="select">
                        <option value="">筛选地区</option>
                        <?php if(is_array($province)): $i = 0; $__LIST__ = $province;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><option value="<?php echo ($v["province_id"]); ?>"
                                <?php if(I('get.province_id') == $v['province_id']): ?>selected<?php endif; ?>
                            ><?php echo ($v["province_name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                    </select>
                </span>
                <span class="select-box ml-10" style="width:100px;">
                    <select name="light_proj" class="select">
                        <option value="">落实完成</option>
                        <option value="1" <?php if(I('get.light_proj') == 1): ?>selected<?php endif; ?>>是</option>
                        <option value="0" <?php if(I('get.light_proj') == '0'): ?>selected<?php endif; ?>>否</option>
                    </select>
                </span>
                <span class="select-box ml-10" style="width:120px;">
                    <select name="proj_type" class="select">
                       <option value="">筛选项目类型</option>
                        <?php if(is_array($models)): $i = 0; $__LIST__ = $models;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><option value="<?php echo ($v["model_config_id"]); ?>" <?php if(I('get.proj_type') == $v['model_config_id']): ?>selected<?php endif; ?>>
                            <?php echo ($v["name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                    </select>
                </span>
                <span class="select-box ml-10" style="width:100px;">
                    <select name="is_ticket" class="select">
                        <option value="">是否售票</option>
                        <option value="1" <?php if(I('get.is_ticket') == 1): ?>selected<?php endif; ?>>是</option>
                        <option value="0" <?php if(I('get.is_ticket') == '0'): ?>selected<?php endif; ?>>否</option>
                    </select>
                </span>
                <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
                       class="input-text ml-10" style="width:100px"
                       name="begin_time" placeholder="开始时间"
                       value="<?php echo ($_GET['begin_time']); ?>"
                       class="input-text Wdate"/>
                <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"
                       class="input-text" style="width:100px"
                       name="end_time" placeholder="结束时间"
                       value="<?php echo ($_GET['end_time']); ?>"
                       class="input-text Wdate"/>
                <span class="select-box ml-10" style="width:120px;">
                    <select name="company" class="select">
                        <option value="">筛选制作公司</option>
                        <?php if(is_array($companys)): $i = 0; $__LIST__ = $companys;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><option value="<?php echo ($v["name"]); ?>" <?php if(I('get.company') == $v['name']): ?>selected<?php endif; ?>>
                            <?php echo ($v["name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                    </select>
                </span>
                <span class="select-box ml-10" style="width:120px;">
                    <select name="level" class="select">
                        <option value="">筛选项目级别</option>
                        <?php if(is_array(C("PROJECT_LEVEL_LIST"))): $i = 0; $__LIST__ = C("PROJECT_LEVEL_LIST");if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><option value="<?php echo ($key); ?>" <?php if(I('get.level') == $key): ?>selected<?php endif; ?>><?php echo ($item); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                    </select>
                </span>
                <input type="text" class="input-text ml-10" style="width:80px"
                       name="name" placeholder="项目名称"
                       value="<?php echo ($_GET['name']); ?>"/>
                <input type="text" class="input-text ml-10" style="width:70px"
                       name="pg_size" placeholder="显示条数"
                       value="<?php echo ($_GET['pg_size']); ?>"/>

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
                <?php if(is_array($data)): $i = 0; $__LIST__ = $data;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><tr class="text-l">
                        <td><?php echo ($item["customer_name"]); ?></td>
                        <td><?php echo ($item["project_name"]); ?></td>
                        <td>
                            <?php echo (1==$item['light_proj']?'是':'否'); ?>
                        </td>
                        <td><?php echo ($item["proj_type"]); ?></td>
                        <td><?php echo ($item["begin_date"]); ?> ~ <?php echo ($item["end_date"]); ?></td>
                        <td><?php echo ($item["scale_fee"]); ?></td>
                        <td><?php echo ($item["fee_type"]); ?></td>
                        <td><?php echo ($item["is_ticket"]); ?></td>
                        <td>
                            <ul>
                                <li class="more-line"><strong class="c-666">展出场地：</strong><?php echo ((isset($item["address"]) && ($item["address"] !== ""))?($item["address"]):''); ?>
                                </li>
                                <li class="more-line"><strong class="c-666">日常门票：</strong><?php echo ((isset($item["ticket"]) && ($item["ticket"] !== ""))?($item["ticket"]):''); ?></li>
                                <li class="more-line"><strong class="c-666">交通情况：</strong><?php echo ((isset($item["traffic"]) && ($item["traffic"] !== ""))?($item["traffic"]):''); ?>
                                </li>
                                <li class="more-line"><strong
                                            class="c-666">日常客流：</strong><?php echo ((isset($item["peace_passenger"]) && ($item["peace_passenger"] !== ""))?($item["peace_passenger"]):''); ?></li>
                                <li class="more-line"><strong
                                            class="c-666">性质及上下级关系：</strong><?php echo ((isset($item["relation"]) && ($item["relation"] !== ""))?($item["relation"]):''); ?></li>
                                <li class="more-line"><strong class="c-666">接待能力：</strong><?php echo ((isset($item["ability"]) && ($item["ability"] !== ""))?($item["ability"]):''); ?>
                                </li>
                            </ul>
                        </td>
                        <td>
                            <ul>
                                <li class="more-line"><strong class="c-666">项目情况：</strong><?php echo ((isset($item["context"]) && ($item["context"] !== ""))?($item["context"]):''); ?>
                                </li>
                                <li class="more-line"><strong
                                            class="c-666">灯会期间门票：</strong><?php echo ((isset($item["run_ticket"]) && ($item["run_ticket"] !== ""))?($item["run_ticket"]):''); ?></li>
                                <li class="more-line"><strong
                                            class="c-666">灯会期间客流：</strong><?php echo ((isset($item["run_passenger"]) && ($item["run_passenger"] !== ""))?($item["run_passenger"]):''); ?></li>
                                <li class="more-line"><strong class="c-666">收益情况：</strong><?php echo ((isset($item["out_value"]) && ($item["out_value"] !== ""))?($item["out_value"]):''); ?>
                                </li>
                                <li class="more-line"><strong class="c-666">运营方案：</strong><?php echo ((isset($item["programme"]) && ($item["programme"] !== ""))?($item["programme"]):''); ?>
                                </li>
                                <li class="more-line"><strong class="c-666">网络报道：</strong><?php echo ((isset($item["report"]) && ($item["report"] !== ""))?($item["report"]):''); ?></li>
                            </ul>
                        </td>
                        <td>
                            <?php echo str_replace(',','<br>',$item['company']); ?>
                        </td>
                        <?php if('director' == session('employee.role_type_code') && 'business' ==session('employee.department_type_id')): ?><td>
                                <select name="set_level" onchange="changeLevel(this,'<?php echo ($item["project_id"]); ?>')"
                                        class="select" custid="<?php echo ($item["customer_id"]); ?>">
                                    <?php if(is_array(C("PROJECT_LEVEL_LIST"))): $i = 0; $__LIST__ = C("PROJECT_LEVEL_LIST");if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><option value="<?php echo ($key); ?>"
                                        <?php if($item['level'] == $key): ?>selected<?php endif; ?>
                                        ><?php echo ($v); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                                </select>
                            </td>
                            <?php else: ?>
                            <td>
                                <?php if(!empty($item["level"])): echo c('PROJECT_LEVEL_LIST')[$item['level']]; endif; ?>
                            </td><?php endif; ?>
                        <td>
                            <?php echo (0===strpos($item['company'],'本公司'))?(c('SON_STATUS_LIST')[$item['son_status']]):$item['other_status']; ?>
                        </td>

                        <td class="text-c">
                            <a class="" href="javascript:;" title="配置业务员"
                            <?php if('director' == session('employee.role_type_code')): ?>onclick="LsgLayerShow('配置业务员','/service/customer/manage/employee?issit=1&id=<?php echo ($item["customer_id"]); ?>
                                ', 400, 500,200)"<?php endif; ?>
                            <?php if('boss' == session('employee.role_type_code')): ?>onclick="LsgLayerShow('配置业务员','/service/customer/manage/departemployee?issit=1&id=<?php echo ($item["customer_id"]); ?>
                                ', 400, 500,200)"<?php endif; ?>
                            ><i class="Hui-iconfont">&#xe68b;</i>
                            </a>
                            <a class="ml-10" href="javascript:;" title="修改项目"
                               onclick="LsgLayerShow('修改项目','/service/customer/search/addproject?project_id=<?php echo ($item["project_id"]); ?>',800, 550,50)"><i
                                        class="Hui-iconfont">&#xe6df;</i>
                            </a>
                            <a class="ml-10" href="javascript:;" title="删除项目" onclick="delProj('<?php echo ($item["project_id"]); ?>')"><i
                                        class="Hui-iconfont">&#xe6e2;</i>
                            </a>
                        </td>

                    </tr><?php endforeach; endif; else: echo "" ;endif; ?>
                </tbody>
            </table>
            <div class="right_box_content">
                <div id="pager" class="pb-20" style="margin:20px auto; text-align:center;"></div>
            </div>
        </div>
    </div>

<script type="text/javascript" src="/public/huiadmin/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/layer/2.1/extend/layer.ext.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/public/huiadmin/static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="/public/huiadmin/static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="/public/js/lib/common-1.js"></script>
<script type="text/javascript" src="/public/js/lib/list-1.js"></script>

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
		var page_size = '<?php echo empty($pager->totalPages) ? 1 : $pager->totalPages; ?>';
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

		var $list = JSON.parse('<?php echo json_encode($data) ?>');

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

</body>
</html>