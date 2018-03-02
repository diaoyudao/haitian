<extend name="./Application/Admin/View/mobile/base/context/common-new.tpl"/>
<block name="common_css">

</block>
<block name="common_js">

</block>

<block name="head_left">
	<a onclick="removeIframe()"><img  class="head_left" src="/public/img/home/xlcweb/u608.png" alt="" /></a>
</block>

<block name="head_name">
	<span>新增联络记录</span>
</block>

<block name="body_main">
	<style>
		.body{
			padding:0 10px;
			overflow: hidden;
		}
		/*清除浮动*/
		.clearFix:after {
			content: "";
			display: block;
			height: 0;
			clear: both;
		}
		.fl	{
			float: left;
		}
		.color{
			color: #868686;
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
		.body .list .right .pic{
			width: 30px;
			height: 30px;
			border-radius: 50%;
			overflow: hidden;
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
		.body .list select{
			border:0;
			width: 80px;
			-webkit-appearance: none;
			background: url(/public/img/home/xlcweb/u973.png) no-repeat;
			background-position: 100%;
		}
		.body .list .radio{
			display: inline-block;
			width: 25px;
			height: 25px;
			line-height: 25px;
			text-align: center;
			border: 1px solid #E4E4E4;
			border-radius: 50%;
			vertical-align: middle;
			margin-right: 5px;
		}
		.body .list .fail{
			margin-left: 20px;
		}
		.none{
			display: none;
		}
		.body  .situation{
			width: 100%;

			min-height: 50px;
			padding: 10px 0;
			resize : none;
			border:0;
			border-bottom:1px solid #E4E4E4;	
		}
		.body .list input{
			position: absolute;
			/*-webkit-appearance: none ;*/
			width: 60%;
			height:22px;
			top:10px;
			right: 0;
			border:0;
			background: transparent;
			-webkit-tap-highlight-color: rgba(255,0,0,0);
			-webkit-appearance: none;
			outline: none;
			/*border: 1px solid #cccccc;*/
			/*width: 458px;
			height:50px;*/
			/*opacity: 1;*/
			/*z-index: 100;*/
			/*background: url(/public/img/home/xlcweb/u975.png) no-repeat;
			background-size: 18px 18px;
			background-position: 98%;*/
		}
	
		.body .list input::-webkit-clear-button {
			
		}
		.body .list .date_text{
			margin-left: 60px;
		}
		.body .list .calendar{
			position: absolute;
			width: 18px;
			height: 18px;
			top:12px;
			right: 5px;
			background-color: #fff;
			z-index: 10;
		}
		.body .list .right	.open{
			margin-top: 30px;
		}
		.body .list .right	.switch{
			position: relative;
			float: right;
			width: 40px;
			height: 20px;
			border: 1px solid #E4E4E4;
			border-radius: 20px;
			background-color: #fff;
		}
		.body .list .right	.switch .switchbtn{
			position: absolute;
			top: -3px;
			left: -5px;
			display: inline-block;
			width: 25px;
			height: 25px;
			border-radius: 50%;
			background-color: #fff;
			border: 1px solid #E4E4E4;
		}
		/*开关*/
		.body .list .right .close1{
			background-color: #199ED8;
		}
		.body .list .right	.switch  .switchbtn.close2{
			left: 15px;

		}
	</style>
	<div class="body">
	  <form action="" method="post" id="add-form-post">
	    <input type="hidden" name="customer_id" value="{$customer.customer_id}"/>
	    <input name="important" type="hidden" value="0" />
		<input name="is_export" type="hidden" value="0" />
		<input name="status" type="hidden" value="1" />
		<input  name="liaison_time" type="hidden"/>
		<input  name="next_time" type="hidden"/>
		<!-- <input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" /> -->
		<div class="list clearFix"><span class="left">客户名称</span><span class="right">{$customer.name}</span></div>
		<div class="list clearFix"><span class="left color">相关事宜</span>
			<input class="right" size="30" type="text" name="outline" value="{$data.outline}">			
		</div>
		<div class="list clearFix">
			<span class="left color">联络人</span>
			<select class="right" name="customer_contact_id">
				<option value="">选择联络人</option>
				<volist name="contact" id="item">
				<option value="{$item.customer_contact_id}" >{$item.name}，{$item.department}</option>
				</volist>
			</select>
		</div>
		<div class="list clearFix">
			<span class="left color">联络时间</span>
			<div class="right">
				<img class="calendar" src="/public/img/home/xlcweb/u975.png" alt="">
				<!-- <img class="calendar" src="/public/img/home/xlcweb/u975.png" alt=""> -->
				<input style="opacity:1" id="liaison-time" class="datetime-local" type="date" style="width:130px;"/>				
				
			</div>

		</div>
		<div class="list clearFix">
			<span class="left color" style="margin-top: 12px">联络结果</span>
			<div class="right">
				<div class="sucess fl">
					<i class="radio" id="success"><img style="margin-top: 4px;" src="/public/img/home/xlcweb/u1060.png" alt=""></i>
					<span>成功</span>
				</div>
				<div class="fail fl">
					<i class="radio"><img class="none" style="margin-top: 4px;" src="/public/img/home/xlcweb/u1060.png" alt=""></i>
					<span>失败</span>
				</div>
			</div>
		</div>
		<textarea name="context" placeholder="联络内容" class="situation"></textarea>
		<div class="list clearFix">
			<span class="left color">下次联络</span>
			<div class="right">
					<img class="calendar" src="/public/img/home/xlcweb/u975.png" alt="">
				<input style="background:none;" class="datetime-local" type="date" id="next-time"/>
			</div>
			
		</div>
		<div class="list clearFix">
			<span class="left color">其他</span>
			<div class="right">
				<div class="color">标记重要的<i class="switch"><i onclick="on(this,1)" class="switchbtn"></i></i></div>
				<if condition="'boss' != session('employee.role_type_code')">
				<div class="open color">加入周报<i class="switch"><i onclick="on(this,2)" class="switchbtn"></i></i></div>
				</if>
			</div>
			
		</div>				
		<!-- <textarea name="" id="" placeholder="批复" style="height: 40px" class="situation"></textarea> -->
		<div class="btnsubmit "  onclick="commit()" >保存</div>
      </form>
	</div>	
</block>

<block name="footer_js">
	
	<script>
		$(function(){
			$('.sucess').click(function(){
				$('.sucess').find('img').removeClass('none');
				$('.fail').find('img').addClass('none');
			})
			$('.fail').click(function(){
				$('.fail').find('img').removeClass('none');
				$('.sucess').find('img').addClass('none');
			})

		})
		function removeIframe() {
			K.removeIframe();
		}
		function checkDate(){
			console.log('22222')
			var text=$("input[name=next_time]").val()
			var date=new Date();
			var now=new Date(text);
			console.log(text,now)
			if(now>=date){
				year=text.substring(0,4);
				month=text.substring(5,7);
				day=text.substring(8,10);
				hour=text.substring(11,13);
				minute=text.substring(14)
    			format=year+"-"+month+"-"+day+"-"+hour+"-"+minute;
				$('.date_text').text(format);
			}else{
				$('.date_text').text('请输入有效时间');
			}			
		}
		function changeTime(t1) {
			t1=t1.replace('T', ' ');
			if(19 <= t1.length) {
				t1 = t1.substr(0,19);
				return t1;
			}

			t1=K.getDateFormat5(t1)
			return t1
		}
		function on(a,t){
			var div2=$(a);
			var div1=div2.parent();
			if(div1.hasClass('close1')==true){
				div1.removeClass('close1');
				div2.removeClass('close2');
				if(1 == t) $('input[name=important]').val(0);
				if(2 == t) $('input[name=is_export]').val(0);
			}else{
				div1.addClass('close1');
				div2.addClass('close2');
				if(1 == t) $('input[name=important]').val(1);
				if(2 == t) $('input[name=is_export]').val(1);
			}
		}

		function commit() {
			var t1= $('#liaison-time').val();
			var t2= $('#next-time').val();
			// 转换手机时间
			if("" != t1) {
				//$("input[name='liaison_time']").val(changeTime(t1))
				$("input[name='liaison_time']").val(t1)
			}
			
			if("" != t2) {				
				$("input[name='next_time']").val(t2)
			}

			var f = $('#success').find('img').is(':hidden');
			if(f) $("input[name='status']").val(0)
			else $("input[name='status']").val(1)

			if($("input[name='liaison_time']").val()==""){
				console.log("请填写时间");
				layer.msg('请填写时间!', {icon: 2, time: 2000});
				return;
			}else if($("input[name='status']:checked").val()==""){
				console.log("请选择联络结果");
				layer.msg('请选择联络结果!', {icon: 2, time: 2000});
				return;
			}

			if ($('input[name=customer_liaison_id]').val()) {
				var url = '/service/customer/manage/changeLiaison';
			} else {
				var url = '/service/customer/manage/addLiaison';
			}

			K.doAjaxSubmit('#add-form-post', url, function(response) {
				if (response.status && response.status == 'success') {
					layer.msg('保存成功!', {icon: 1, time: 2000});
					setTimeout('K.removeIframe()', 2000);
					var type='{$Think.get.is_customer}';
					if(type == 'yes'){
						parent.window.location.replace(parent.window.location.href);
					}

	            } else {
	            	if (response.message) {
	            		layer.msg(response.message, {icon: 2, time: 2000});
	            	} else {
	            		layer.msg('后台错误!', {icon: 2, time: 2000});
	            	}
	            }
	        });
		} 

	</script>
</block>