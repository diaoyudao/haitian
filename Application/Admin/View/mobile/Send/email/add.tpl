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
			width: 30%;
			float: left;
		}
		.body .right{
			width: 70%;
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
				<div class="right">内容</div>
			</div>
			<ul class="information">
				<li class="clearfix">
					<div class="left">2017-3-25</div>
				     <div class="right">内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容</div>	
				</li>
			</ul>

			<!-- 分页 -->
			<div class="page">
				<nav aria-label="Page navigation " class="fr">
					<ul class="pagination">
						<li>
							<a href="#" aria-label="Previous">
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
						<li><a href="#">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">5</a></li>
						<li>
							<a href="#" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</ul>
				</nav>
				<span class="fr all">1234条记录</span>
			</div>
			
	</div>
</block>

<block name="footer_js">
	<script>
		
	</script>
</block>
