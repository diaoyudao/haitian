<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="common_css">
		<link href="/public/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">

</block>
<block name="menu_title">短信群发</block>


<block name="body_main">
	<style>
		/*清除浮动*/
		.clearfix:after {
			content: "";
			display: block;
			height: 0;
			clear: both;
		}
		.left_content{
			min-width: 428px;
			margin-right: -450px;
		
			height: 708px;
			border: 1px solid #C9C9C9;
			overflow: hidden;
			float: left;
			z-index: 100;
			
		}
		/*公用*/
		.color1{
			color: #3399CC;
		}
		.color2{
			color: #FF7D6C;
		}
		.color3{
			color: #949494;
		}
		.m_left{
			margin-left: 8px;
		}
		.spacing{
			width: 32px;
			height: 32px;
			border-radius: 50%;
			overflow: hidden;
			margin: 0 5px;
		}
		.abs{
			position: absolute;
		}
		.bg_color{
			background-color: #EEF5F9;
		}
		.border_b{
			position: relative;
			background-color: #fff;
			line-height: 50px;
			border-bottom: 1px solid #E4E4E4;
		}
		.left_content .select_box {
			padding: 17px;
			background-color: #fff;
		}
		.left_content .select_box .city{
			width: 90px;
			height: 33px;
		}
		.left_content .select_box .text_box{
			width: 180px;
			height: 32px;
			margin-top: -1px;
			padding-left: 7px;
		}
		.left_content .select_box .glyphicon_box{
			position: relative;

		}
		.left_content .select_box .glyphicon_box .glyphicon-search{
			position: absolute;
			right: 10px;
		}
	
		.left_content .select_box .check_all{
			position: relative;
			margin-top: 30px;
			margin-left: 5px;
		}
		.left_content .select_box .check_all .check_button{
			float: right;
			margin-right: 15px;
		}
		.left_content .check_box{
			height: 590px;
			overflow-y: scroll;
			
		}
		/*折叠*/
		.Huifold .item{ position:relative}
        .Huifold .item h4{margin:0;font-weight:bold;position:relative;border-top: 1px solid #fff;font-size:15px;line-height:22px;padding:7px 10px;background-color:#eee;cursor:pointer;padding-right:30px}
        .Huifold .item h4 b{position:absolute;display: block; cursor:pointer;right:10px;top:7px;width:16px;height:16px; text-align:center; color:#666}
	    .Huifold .item .info{display:none;padding:10px}
		.checkbox_title{
			font-size: 14px;
			font-weight: 400;
			float: right;
			display: inline-block;
			margin-right: 10px;
		}
		.tel{
			top: 50%;
			margin-top: -12px;
			left: 300px;

		}
		 .sms{
			top: 50%;
			margin-top: -12px;
			left: 330px;

		}

		/*右边内容*/
		.right_content{
			margin-left: 450px;
			height: 708px;
			border: 1px solid #C9C9C9;
			border-left: 0;
			padding: 40px 33px 0;
			background-color: #fff;
		}
		.right_content .telphone{
				margin-top: 10px;
				border: 1px solid #C9C9C9;
				height: 65px;
				overflow: hidden;
				overflow: auto;
		}
		.right_content .textinput{
				margin-top: 10px;
				height: 300px;
				width: 100%;
				resize:none;
		}
		.right_content .sent{
				
				margin-top: 20px;
				width: 65px;
				height: 30px;
				line-height: 30px;
				background-color: #2E8DED;
				text-align: center;
				border:0;
				color: #fff;
				border-radius: 3px;
		}
		.right_content .record{
			   margin-top: 20px;
			   color: #2E8DED;
				float: right;
		}
	</style>
	<div class="page-container">
			<div class="left_content">
				<div class="select_box">
				   <select  style="position: relative;" class="city" name="" id="">
					   <option value="0">四川省</option>
				    </select>
				    <select  style="position: relative;" class="city m_left" name="" id="">
				      <option value="0">旅游景区</option>
				    </select>
				    <span class="glyphicon_box">
				    	<input  class="text_box m_left" type="text" placeholder="搜索客户名称">
				    	<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
				    </span>
				  
				   
				    <div class="check_all">
				    		<span>剩余条数</span>
				    		<span style="margin-left: 10px">40000</span>
				    		<form  class="check_button" action="" method="get"> 
				    			全选
                                <label><input onchange="fnSelect(this)" id="checkAll" style="vertical-align: sub;" name="all" type="checkbox" value="" /> </label> 
	                        </form> 
							
				    </div>
				</div>	

				<!-- 多选内容 -->
				<div class="check_box">
					<ul id="Huifold1" class="Huifold bg_color"  style="background-color: #fff" >
                        <li class="item">
                            <h4>
                            <span>重庆园博园</span>
                            <form  class="checkbox_title clearfix" action="" method="get"> 
                            	<span>已选4/全部8</span>
				    			<span style="margin-left: 5px">全选</span>
                                <label><input onchange="fnSelect2(this)" id="pitchOn" style="margin-top: -2px"" name="all" type="checkbox" value="" /> </label> 
	                        </form> 
                            <b style="margin-top: 1px;float: right;">+</b>
                            </h4>
                            <div class="info" >
                            	<form  class="border_b" action="" method="get" > 
                            		<span>决策人</span>		
                            		<span><img class="spacing" src="/public/img/test/u707.png" alt="">孙权</span>
                            		<span style="margin-left:80px">书记</span>		
                            		<img class="tel abs" src="/public/img/test/tel.png" alt="">
                            		<img class="sms abs" src="/public/img/test/sms.png" alt="">
                            		<label><input style="margin-top: -2px;margin-left:139px" name="all" type="checkbox" value="" /> </label> 
                            	</form> 
                            	<form  class="border_b" action="" method="get" > 
                            		<span>决策人</span>		
                            		<span><img class="spacing" src="/public/img/test/u707.png" alt="">孙权</span>
                            		<span style="margin-left:80px">书记</span>		
                            		<img class="tel abs" src="/public/img/test/tel.png" alt="">
                            		<img class="sms abs" src="/public/img/test/sms.png" alt="">
                            		<label><input style="margin-top: -2px;margin-left:139px" name="all" type="checkbox" value="" /> </label> 
                            	</form> 
                            </div>
                           
                        </li>
                         <li class="item">
                            <h4>
                            <span>重庆园博园</span>
                            <form  class="checkbox_title" action="" method="get"> 
                            	<span>已选4/全部8</span>
				    			<span style="margin-left: 5px">全选</span>
                                <label><input style="margin-top: -2px"" name="all" type="checkbox" value="" /> </label> 
	                        </form> 
                            <b style="margin-top: 1px">+</b>
                            </h4>
                            <div class="info" >
                            	<form  class="border_b" action="" method="get" > 
                            		<span>决策人</span>		
                            		<span><img class="spacing" src="/public/img/test/u707.png" alt="">孙权</span>
                            		<span style="margin-left:80px">书记</span>		
                            		<img class="tel abs" src="/public/img/test/tel.png" alt="">
                            		<img class="sms abs" src="/public/img/test/sms.png" alt="">
                            		<label><input style="margin-top: -2px;margin-left:139px" name="all" type="checkbox" value="" /> </label> 
                            	</form> 
                            	<form  class="border_b" action="" method="get" > 
                            		<span>决策人</span>		
                            		<span><img class="spacing" src="/public/img/test/u707.png" alt="">孙权</span>
                            		<span style="margin-left:80px">书记</span>		
                            		<img class="tel abs" src="/public/img/test/tel.png" alt="">
                            		<img class="sms abs" src="/public/img/test/sms.png" alt="">
                            		<label><input style="margin-top: -2px;margin-left:139px" name="all" type="checkbox" value="" /> </label> 
                            	</form> 
                            </div>
                           
                        </li>
       
                    </ul>
                </div>
			</div>
			<div style="width: 100%;float: right;">
				<div class="right_content">
					<div class="telOwner">
						<span>收件人</span>
						<span class="color3">已选10人</span>
					</div>
					<div class="telphone">

					</div>	
					<div style="margin-top:20px">
						<span>邮件内容</span>
						
					</div>
					<textarea name="" id="" class="textinput"></textarea>
					<div >
						<button class="sent">发送</button>
						<span class="record" onclick="operation('短信记录','/service/send/sms/add')">邮件记录</span>
					</div>			
				</div>	
			</div>	
	</div>
</block>

<block name="footer_js">
<script>
	// 折叠
	$(function(){
	$.Huifold("#Huifold1 .item h4","#Huifold1 .item .info","fast",1,"click"); /*5个参数顺序不可打乱，分别是：相应区,隐藏显示的内容,速度,类型,事件*/
	});


	//全选/全选取消
	function fnSelect(obj){
		
		var checked=obj.checked;
		var tbody = $('.check_box');
		var inputs=tbody.find('input');
		console.log(inputs);
		for(var i = 0; i < inputs.length; i++) {
					
			inputs[i].checked = checked;
	    }
	} 
	function fnSelect2(obj){
	
		var checked=obj.checked;
		var parentNode=obj.parentNode.parentNode.parentNode.parentNode; 
		var inputs=$(parentNode).find("input");
		for(var i = 0; i < inputs.length; i++) {				
			inputs[i].checked = checked;
	    }
	} 
	// 操作/已完成
		function operation(title,url){
			layer_show(title, url, 750, 700);
		}
	
</script>
</block>