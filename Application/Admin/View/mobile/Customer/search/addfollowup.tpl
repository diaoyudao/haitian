<extend name="./Application/Admin/View/mobile/base/context/common-new.tpl"/>
<block name="common_css">

</block>
<block name="common_js">

</block>

<block name="head_left">
    <a href="/service/customer/search/addproject?r=1&project_id=1001"><img  class="head_left" src="/public/img/home/xlcweb/u608.png" alt="" /></a>
</block>

<block name="head_name">
    返回跟进
</block>

<block name="body_main">
	<style>
		.body{
			padding:0 10px;
		}
		 /*清除浮动*/
        .clearFix:after {
            content: "";
            display: block;
            height: 0;
            clear: both;
        }
     	
		.body .list{
			position: relative;
			padding: 10px 0;
			border-bottom: 1px solid #E4E4E4;
		}
		.body .list .left{
			width: 20%;
			float: left;
		}
		.body .list .right{
			width:80%;
			float: left;
		}
		.body  .situation{
			width: 100%;
			margin-top: 20px;
			min-height: 150px;
			padding: 10px;
			resize : none;
			border:0;
			border-bottom:1px solid #E4E4E4;
			
		}
		.body .btnsubmit{
			width: 100%;
			height: 40px;
			line-height: 40px;
			color: #fff;
			margin-top: 20px;
			text-align: center;
			border-radius: 5px;
			background-color: #343643;
		}
	</style>
	<div class="body">
		<div class="list clearFix"><span class="left">客户名称</span><span class="right">重庆园博园</span></div>
		<div class="list clearFix"><span class="left">项目名称</span><span class="right">灯会嘉年华</span></div>
		<div class="list clearFix"><span class="left">相关部门</span><span class="right">区域信息中心一部</span></div>
		<textarea name="" id="" placeholder="原因" class="situation"></textarea>
		<div class="btnsubmit">提交</div>
	</div>	
</block>

<block name="footer_js">
	
	<script>
		
	</script>
</block>