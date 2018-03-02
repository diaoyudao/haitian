<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">
	<link href="/public/css/task/select.css" rel="stylesheet" type="text/css" />
	<link href="/public/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
</block>
<block name="body_main">
	<style>
		/*清除浮动*/
		.clearfix:after {
			content: "";
			display: block;
			height: 0;
			clear: both;
		}
		.body .th{
			width: 100%;
			padding-bottom: 10px;
			border-bottom: 1px solid #D7D7D7;
		}
		.body .left{
			width: 15%;
			float: left;
		}
		.body .left2{
			width: 15%;
			float: left;
		}
		.body .right{
			width: 68%;
			float: left;
		}
		.body .information li{
			padding: 10px 0;
			border-bottom: 1px solid #D7D7D7;
		}
		.fr{
			float:right;
		}
		.body .page .all{
			line-height: 72px;
			margin-right: 20px;
			color: #9D969B;
		}
	</style>
	<div class="body">
			<div class="th clearfix">
				<div class="left">时间</div>
				<div class="left2">标题</div>
				<div class="right">内容</div>
			</div>
			<ul class="information" id="context-list">
			  <volist name="data" id="it">
				<li class="clearfix">
					<div class="left">{$it.create_time}</div>
					<div class="left">{$it.title}</div>
				     <div class="right">{$it.context}</div>	
				</li>
			  </volist>
			</ul>

			<!-- 分页 -->
			<div class="page">
				<div id="pager" class="mt-25 text-c" ></div>
				<span class="fr all" id="total-row">共{$counts}条</span>
			</div>
			
	</div>
</block>

<block name="footer_js">
<script>

    var page_size = '<php> echo empty($pager -> totalPages) ? 1 : $pager -> totalPages; </php>';
        if (page_size > 1) {
            PAGER.create(page_size, param);
        }

</script>
</block>