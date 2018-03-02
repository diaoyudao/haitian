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

	<div class="page-container">
		<form class="form form-horizontal" action="" method="get">

		</form>

		<div class="cl pd-5 bg-1 bk-gray mt-20">
			<a href="javascript:;"
			   onclick="model_add('添加管理员','/service/send/model/add',800,300)"
			   class="btn btn-primary radius"><img style="width:12px;height:12px;margin-top:-2px;" src="/public/img/iconfont/xe600-2.png" /> 添加短信模板
			</a>
		</div>
		<table class="table table-border table-bordered table-bg">
			<thead>
			<tr class="text-c">
				<th width="25"><input type="checkbox" name="" value=""></th>
				<th width="80">序号</th>
				<th width="60">短信模板Id</th>
				<th>短信模板内容</th>
				<th width="60">操作</th>
			</tr>
			</thead>
			<tbody>
			<?php if(is_array($model)): $i = 0; $__LIST__ = $model;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><tr class="text-c">
					<td><input type="checkbox" value="<?php echo ($item["sms_model_id"]); ?>" name="check"></td>
					<td><?php echo ($i); ?></td>
					<td><?php echo ($item["sms_model_code"]); ?></td>
					<td><?php echo ($item["note"]); ?></td>

					<td class="td-manage">
						<a title="编辑" href="javascript:;"
						   onclick="model_edit('短信模板编辑','/service/send/model/change?id=<?php echo ($item["sms_model_id"]); ?>',800,300)"
						   class="ml-5" style="text-decoration:none">
							<img style="width:14px;height:14px;" src="/public/img/iconfont/xe6df.png" /></a>
						<a title="删除" href="javascript:;" onclick="model_del(this,'<?php echo ($item["sms_model_id"]); ?>')" class="ml-5"
						   style="text-decoration:none">
							<img style="width:14px;height:14px;" src="/public/img/iconfont/xe6e2.png" />
						</a>
					</td>
				</tr><?php endforeach; endif; else: echo "" ;endif; ?>
			</tbody>
		</table>
		<div id="pager" style="margin-top:5px; text-align:center;"></div>
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


		$(function () {

			/*  分页 */
			var page_size = '<?php echo empty($pager -> totalPages) ? 1 : $pager -> totalPages; ?>';
			if (page_size > 1) {
				PAGER.create(page_size);
			}
		});




		/*管理员-增加*/
		function model_add(title, url, w, h) {
			layer_show(title, url, w, h);
		}

		/*管理员-删除*/
		function model_del(obj, id) {
			layer.confirm('确认要删除吗？', function (index) {

				//此处请求后台程序，下方是成功后的前台处理……
				var param = {sms_model_id: id};
				K.doAjaxDeleteById(obj, param, '/service/send/model/delete');
				parent.modelAjax()
			});
		}



		/*管理员-编辑*/
		function model_edit(title, url, w, h) {
			layer_show(title, url, w, h);
		}

	</script>

</body>
</html>