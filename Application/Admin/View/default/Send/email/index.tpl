<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="common_css">
	<link href="/public/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">

</block>
<block name="menu_title">邮件群发</block>


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
			width: 428px;
			height: 708px;
			border: 1px solid #C9C9C9;
			overflow: hidden;
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
		.info-posit{
			text-align: right;
			left: 200px;
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
			height: 200px;
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
		label{
			float: right;
			margin-left: 5px;
		}
	</style>
	<div class="page-container">
		<div class="left_content" style="width: 430px;float: left;margin-right:-450px">
			<div class="select_box">
				<select  style="position: relative;" class="city" name="province">
					<option value="">选择省份</option>
					<volist name="province" id="item">
						<option value="{$item.province_id}">{$item.province_name}</option>
					</volist>
				</select>
				<select  style="position: relative;" class="city m_left" name="type">
					<option value="">选择类型</option>
					<option value="1">政府单位</option>
					<option value="2">旅游景区</option>
					<option value="3">企业公司</option>
					<option value="0">其他</option>
					<option value="4">海外客户</option>
				</select>
				<span class="glyphicon_box">
					<input  class="text_box m_left" type="text" name="name"  placeholder="搜索客户名称">
					<span class="glyphicon glyphicon-search" aria-hidden="true" onclick="searchCust()"></span>
				</span>				  

				<div class="check_all" style="overflow: hidden;">

					<form  class="check_button" action="" method="get"> 
						全选
						<label><input onchange="fnSelect(this)" id="checkAll" style="vertical-align: sub;" name="all" type="checkbox" value="" /> </label> 
					</form> 

				</div>
			</div>	

			<!-- 多选内容 -->
			<div class="check_box" style="width: 100%">
				<ul id="Huifold1" class="Huifold bg_color"  style="background-color: #fff" >
                      <!--   <li class="item">
						<h4>
							<span>重庆园博园</span>
							<form  class="checkbox_title" action="" method="get"> 
								<span>已选4/全部8</span>
								<span style="margin-left: 5px">全选</span>
								<input onclick="fnSelect2(this)" class="pitchOn" id="pitchOn" style="margin-top: -2px;" name="all" type="checkbox" value="" /> 
							</form> 
							<b style="margin-top: 1px">+</b>
						</h4>
						<div class="info" >
							<form  class="border_b" action="" method="get" > 
								<span>决策人</span>		
								<span><img class="spacing" src="/public/img/test/u707.png" alt="">孙权泽熙</span>
								<span class="info-posit abs">书记处书记</span>		
								<img class="tel abs" src="/public/img/test/tel.png" alt="">
								<img class="sms abs" src="/public/img/test/sms.png" alt="">
								<input onclick="fnSelect3(this,4)" value="4" style="margin-top: -2px;position: absolute;right: 5px;top: 50%;margin-top: -6px;" name="all" type="checkbox" />
							</form> 
							<form  class="border_b" action="" method="get" > 
								<span>其他</span>		
								<span><img class="spacing" src="/public/img/test/u707.png" alt="">孙权</span>
								<span class="info-posit abs">书记</span>		
								<img class="tel abs" src="/public/img/test/tel.png" alt="">
								<img class="sms abs" src="/public/img/test/sms.png" alt="">
								<input onclick="fnSelect3(this,5)" value="5" style="margin-top: -2px;position: absolute;right: 5px;top: 50%;margin-top: -6px;" name="all" type="checkbox" />
							</form> 
						</div>

					</li>
					<li class="item">
						<h4>
							<span>重庆园博园</span>
							<form  class="checkbox_title" action="" method="get"> 
								<span>已选4/全部8</span>
								<span style="margin-left: 5px">全选</span>
								<input onclick="fnSelect2(this)" class="pitchOn" id="pitchOn" style="margin-top: -2px;" name="all" type="checkbox" value="" /> 
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
								<input style="margin-top: -2px;position: absolute;right: 5px;top: 50%;margin-top: -6px;" name="all" type="checkbox"  onclick="fnSelect3(this,1)" value="1"/>
							</form> 
							<form  class="border_b" action="" method="get" > 
								<span>决策人</span>		
								<span><img class="spacing" src="/public/img/test/u707.png" alt="">孙权</span>
								<span style="margin-left:80px">书记</span>		
								<img class="tel abs" src="/public/img/test/tel.png" alt="">
								<img class="sms abs" src="/public/img/test/sms.png" alt="">
								<input style="margin-top: -2px;position: absolute;right: 5px;top: 50%;margin-top: -6px;" name="all" type="checkbox"  onclick="fnSelect3(this,2)" value="2"/>
							</form> 
						</div>

					</li> -->
                    </ul>
                </div>
            </div>
            <div style="width: 100%;float: right;">
            	<div class="right_content">
            		<div class="telOwner">
            			<span>收件人</span>
            			<span class="color3" id="select-total">已选0人</span>
            		</div>
            		<div class="">
            			<textarea name="email_add" readonly="readonly" style="margin-top: 10px;height: 65px;width: 100%;resize:none;" class="textinput"></textarea>
            		</div>	
            		<div class="mt-20">
            			<span>邮件标题</span>
            			<input name="title" class="input-text mt-5"/>
            		</div>
            		<div style="margin-top:20px">
            			<span>邮件内容</span>
            		</div>
            		<!-- <textarea name="email_txt" id="" class="textinput"></textarea> -->
            		<div id="editor" type="text/plain" class="mt-5" style="width:100%;height:300px;"></div>
            		<div >
            			<button class="sent" type="button" onclick="send()">发送</button>
            			<span class="record" onclick="operation('邮件记录','/service/send/email/list')">邮件记录</span>
            		</div>			
            	</div>	
            </div>	
        </div>
    </block>

    <block name="footer_js">
    <script type="text/javascript" src="/public/huiadmin/lib/ueditor/1.4.3/ueditor.config.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/ueditor/1.4.3/ueditor.all.min.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
    	<script>
	// 折叠
	$(function(){
		$.Huifold("#Huifold1 .item h4","#Huifold1 .item .info","fast",1,"click"); /*5个参数顺序不可打乱，分别是：相应区,隐藏显示的内容,速度,类型,事件*/

		var ue = UE.getEditor('editor', {
                serverUrl: '/service/vendor/ueditor/index',
                 toolbars: [
	                 ['fullscreen', '|', 'undo', 'redo', '|',
	                 'bold', //加粗
	                 'italic', //斜体
	                 'underline', //下划线
	                 'strikethrough', //删除线
	                 '|',
	                 'link', 'unlink', '|', 'simpleupload', //单图上传
	                 'map', //Baidu地图
	                 'background', //背景
	                 ],
	                 [
	                 'source', //源代码
	                 'indent', '|',  //首行缩进
	                 // 'inserttable', //插入表格
	                 // 'insertrow', //前插入行
	                 // 'insertcol', //前插入列
	                 // 'mergeright', //右合并单元格
	                 // 'mergedown', //下合并单元格
	                 // 'deleterow', //删除行
	                 // 'deletecol', //删除列
	                 // 'splittorows', //拆分成行
	                 // 'splittocols', //拆分成列
	                 // 'splittocells', //完全拆分单元格
	                 // 'deletecaption', //删除表格标题
	                 // 'inserttitle', //插入标题
	                 // 'mergecells', //合并多个单元格
	                 // 'deletetable', //删除表格
	                 '|',
	                 'cleardoc', //清空文档
	                 ]
                 ]
            });

            ue.ready(function () {
                // var note = '<php> echo $notice["content"];</php>';
                // ue.setContent(note);  //赋值给UEditor
            });
	});

	function EstopPropagation(){
		$(".pitchOn").click(function(e){
			e.stopPropagation()
		})
	}
	EstopPropagation();


	//全选/全选取消
	function fnSelect(obj){
		var checked=obj.checked;
		var tbody = $('.check_box');
		var inputs=tbody.find('input');
		var inputs1=tbody.find('input');
		for(var i = 0; i < inputs.length; i++) {
			var phone = $(inputs[i]).val();
			var phone1 = $(inputs1[i]).val();
			if('' == phone1) {
				inputs1[i].checked = checked;
			};
			if('' == phone) continue;

			inputs[i].checked = checked;

			var exist = searchPhone(phone)
			if(checked && 0 > exist) {
				$phones.push(phone)
			}

			if(!checked && 0 <= exist) {
				$phones.splice(exist,1)
			}
		}

		$('textarea[name=email_add]').val($phones.join())
		showSelTotal()

		var obj_infos = $('.check_box ul li').find('.info');
		console.log(obj_infos.length)
		for(var i = 0; i < obj_infos.length; i++) {
			setSelectNum($(obj_infos[i]))
		}	
	} 
	function fnSelect2(obj){
		console.log('fnSelect2')
		var checked=obj.checked;
		var parentNode=obj.parentNode.parentNode.parentNode; 

		var inputs=$(parentNode).find("input");
		console.log(inputs);
		for(var i = 0; i < inputs.length; i++) {				
			inputs[i].checked = checked;
		}

		for(var i = 0; i < inputs.length; i++) {
			console.log(inputs[i])
			var phone = $(inputs[i]).val();
			if('' == phone) continue;

			inputs[i].checked = checked;

			var exist = searchPhone(phone)
			if(checked && 0 > exist) {
				$phones.push(phone)
			}

			if(!checked && 0 <= exist) {
				$phones.splice(exist,1)
			}
		}

		$('textarea[name=email_add]').val($phones.join())
		showSelTotal()

		var temp_o = $(obj).parent().parent().next();
		setSelectNum(temp_o)
	} 
	// 操作/已完成
	function operation(title,url){
		layer_show(title, url, 750, 700);
	}
	function fnSelect3(me, phone) {
		if('' == phone) {
			var temp_o = $(me).parent().parent();
			setSelectNum(temp_o)
			return;
		}
		var exist = searchPhone(phone)
		var is = $(me).is(':checked')
		if(is) {
			if(0 > exist)
				$phones.push(phone)
		} else {
			if(0 <= exist)
				$phones.splice(exist,1)
		}
		$('textarea[name=email_add]').val($phones.join())

		showSelTotal()

		var temp_o = $(me).parent().parent();
		setSelectNum(temp_o)
	}

	function setSelectNum(obj) {
		var num = obj.find('input[type=checkbox]:checked').length
		var temp_s = obj.prev().find('form').find('span[name=sel]').html()

		var temp_arr = temp_s.split('全部')
		var temp_s = '已选' + num + '/' + '全部' + temp_arr[1]
		obj.prev().find('form').find('span[name=sel]').html(temp_s)
		if(num >= parseInt(temp_arr[1])) {
			console.log('yes')
			if(!obj.prev().find('form').find('input[type=checkbox]')[0].checked) 
			    obj.prev().find('form').find('input[type=checkbox]')[0].checked=true;
		} else {
			if(obj.prev().find('form').find('input[type=checkbox]')[0].checked) 
				obj.prev().find('form').find('input[type=checkbox]')[0].checked=false; 
		}
	}
	function showSelTotal() {
		$('#select-total').html('已选'+$phones.length+'人')
	}

	function searchPhone(phone) {
		for(var i=0; i<$phones.length; i++) {
			if(phone == $phones[i]) {
				return i;
			}
		}
		return -1;
	}

	function searchCust() {
		var param = {}
		if("" != $('select[name=province]').val()) {
			param.province_id = $('select[name=province]').val()
		}
		if("" != $('select[name=type]').val()) {
			param.type = $('select[name=type]').val()
		}
		if("" != $('input[name=name]').val()) {
			param.name = $('input[name=name]').val()
		}
		var url = '/service/send/sms/customer';
		K.doAjax(param, url, function(res) {
			if (res.status && res.status == 'success') {
				$datas = res.data
				$counts = res.counts
				showCustList()
				EstopPropagation()
			} else {
				if (res.message) {
					layer.msg(res.message, {icon: 2, time: 2000});
				} else {
					layer.msg('后台错误!', {icon: 2, time: 2000});
				}
			}
		});
	}

	var $phones = [];
	var $datas = [];
	var $counts = 0;

	var head = "";
	function showCustList() {
		$('#Huifold1').empty()
		var cust_n = null;
		var first = true;
		var str = '';       
		var total = 0;
		$.each($datas, function(i,v){   
			if(first || cust_n != v.cust_name) {
				if(first ){
					first = false;
					cust_n = v.cust_name

					addHead(v)
				} else {
					addEnd(str, total)

					cust_n = v.cust_name
					str = ""
					head =""
					total = 0

					addHead(v)
				}
			} 
			str += '<form  class="border_b" action="" method="get" > ';
			str += '<span>'+(1==v.func?'决策人':(2==v.func?'负责人':(3==v.func?'经办人':'其他')))+'</span>'     
			str += '<span><img class="spacing" src="'+v.url+'" alt="">'+(v.contact_name?v.contact_name:'未知')+'</span>'
			str += '<span class="info-posit abs">'+v.position+'</span>'
			if(v.phone)
				str += '<img class="tel abs" src="/public/img/test/tel.png" alt="">'
			if(v.email)
				str += '<img class="sms abs" src="/public/img/test/sms.png" alt="">'
			str += '<input style="margin-top: -2px;position: absolute;right: 5px;top: 50%;margin-top: -6px;" name="all" type="checkbox" onclick="fnSelect3(this,\''+v.email+'\')" value="'+v.email+'"/>'; 
			str += '</form>';

			total++
		})  

		if(0 < $counts) {
			addEnd(str, total)  
			$.Huifold("#Huifold1 .item h4","#Huifold1 .item .info","fast",1,"click");
		}
	}

	function addHead(v){
		head = '';

		head += '<li class="item">';
		head += '<h4><span>'+v.cust_name+'</span>';
		head += '<form  class="checkbox_title" action="" method="get"><span name="sel">已选0/全部0</span>';
		head += '<span style="margin-left: 5px">全选</span><input onchange="fnSelect2(this)" class="pitchOn" id="pitchOn" style="margin-top: -2px;" name="all" type="checkbox" value="" />';
		head += '</form><b style="margin-top: 1px">\+</b></h4><div class="info" >';

	}

	function addEnd(str, total){
		var tt = '全部'+ total;
		head = head.replace("全部0", tt);
		head += str + '</div></li>';        

		$('#Huifold1').append(head)
	}

	function send(){
		var param = {}
		param.emails = $phones
		param.title = $('input[name=title]').val();
		
		if ((UE.getEditor('editor').hasContents())) {
            param.context = UE.getEditor('editor').getContent();
        } else {
        	layer.msg('邮件内容不能为空!', {icon: 2, time: 2000});
        	return
        }

		var url = '/service/send/email/call';
		K.doAjax(param, url, function(res) {
			if (res.status && res.status == 'success') {
				$('#sms-num').text(res.num);

				layer.msg('发送成功', {icon: 1, time: 3000});               
			} else {
				if (res.message) {
					layer.msg(res.message, {icon: 2, time: 2000});
				} else {
					layer.msg('后台错误!', {icon: 2, time: 2000});
				}
			}
		});
	}
	
</script>
</block>