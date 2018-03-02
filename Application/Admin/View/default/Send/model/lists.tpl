<extend name="./Application/Admin/View/default/base/context/lists2.tpl"/>
<block name="menu_name">>短信模板管理</block>
<block name="page_name">>管理列表</block>
<block name="body_main">
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
			<volist name="model" id="item">
				<tr class="text-c">
					<td><input type="checkbox" value="{$item.sms_model_id}" name="check"></td>
					<td>{$i}</td>
					<td>{$item.sms_model_code}</td>
					<td>{$item.note}</td>

					<td class="td-manage">
						<a title="编辑" href="javascript:;"
						   onclick="model_edit('短信模板编辑','/service/send/model/change?id={$item.sms_model_id}',800,300)"
						   class="ml-5" style="text-decoration:none">
							<img style="width:14px;height:14px;" src="/public/img/iconfont/xe6df.png" /></a>
						<a title="删除" href="javascript:;" onclick="model_del(this,'{$item.sms_model_id}')" class="ml-5"
						   style="text-decoration:none">
							<img style="width:14px;height:14px;" src="/public/img/iconfont/xe6e2.png" />
						</a>
					</td>
				</tr>
			</volist>
			</tbody>
		</table>
		<div id="pager" style="margin-top:5px; text-align:center;"></div>
	</div>
</block>
<block name="footer_js">
	<script type="text/javascript">


		$(function () {

			/*  分页 */
			var page_size = '<php> echo empty($pager -> totalPages) ? 1 : $pager -> totalPages; </php>';
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
</block>