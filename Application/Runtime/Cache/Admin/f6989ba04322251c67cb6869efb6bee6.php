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
    
    <link href="/public/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>

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
    <div class="title">短信群发
    </div>
</nav>

    <style>
        /*清除浮动*/
        .clearfix:after {
            content: "";
            display: block;
            height: 0;
            clear: both;
        }

        .left_content {
            width: 428px;
            height: 708px;
            border: 1px solid #C9C9C9;
            overflow: hidden;
            /*float: left;*/
        }

        /*公用*/
        .color1 {
            color: #3399CC;
        }

        .color2 {
            color: #FF7D6C;
        }

        .color3 {
            color: #949494;
        }

        .m_left {
            margin-left: 8px;
        }

        .spacing {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 5px;
        }

        .abs {
            position: absolute;
        }

        .bg_color {
            background-color: #EEF5F9;
        }

        .border_b {
            position: relative;
            background-color: #fff;
            line-height: 50px;
            border-bottom: 1px solid #E4E4E4;
        }

        .left_content .select_box {
            padding: 17px;
            background-color: #fff;
        }

        .left_content .select_box .city {
            width: 90px;
            height: 33px;
        }

        .left_content .select_box .text_box {
            width: 180px;
            height: 32px;
            margin-top: -1px;
            padding-left: 7px;
        }

        .left_content .select_box .glyphicon_box {
            position: relative;

        }

        .left_content .select_box .glyphicon_box .glyphicon-search {
            position: absolute;
            right: 10px;
        }

        .left_content .select_box .check_all {
            position: relative;
            margin-top: 30px;
            margin-left: 5px;
        }

        .left_content .select_box .check_all .check_button {
            float: right;
            margin-right: 15px;
        }

        .left_content .check_box {
            height: 590px;
            overflow-y: scroll;

        }

        /*折叠*/
        .Huifold .item {
            position: relative
        }

        .Huifold .item h4{margin:0;font-weight:bold;position:relative;border-top: 1px solid #fff;font-size:15px;line-height:22px;padding:7px 10px;background-color:#eee;cursor:pointer;padding-right:30px} .Huifold .item h4 b{position:absolute;display: block; cursor:pointer;right:10px;top:7px;width:16px;height:16px; text-align:center; color:#666} .Huifold .item .info{display:none;padding:10px} .checkbox_title {
            font-size: 14px;
            font-weight: 400;
            float: right;
            display: inline-block;
            margin-right: 10px;
        }

        .tel {
            top: 50%;
            margin-top: -12px;
            left: 300px;

        }

        .sms {
            top: 50%;
            margin-top: -12px;
            left: 330px;

        }

        .info-posit {
            text-align: right;
            left: 200px;
        }

        /*右边内容*/
        .right_content {
            height: 708px;
            border: 1px solid #C9C9C9;
            border-left: 0;
            padding: 40px 33px 0;
            background-color: #fff;
        }

        .right_content .telphone {
            margin-top: 10px;
            border: 1px solid #C9C9C9;
            height: 65px;
            overflow: hidden;
            overflow: auto;
        }

        .
        .textinput {
            margin-top: 10px;
            height: 65px;
            width: 100%;
            resize: none;
        }

        .right_content .sent {

            margin-top: 20px;
            width: 65px;
            height: 30px;
            line-height: 30px;
            background-color: #2E8DED;
            text-align: center;
            border: 0;
            color: #fff;
            border-radius: 3px;
        }

        .right_content .record {
            margin-top: 20px;
            color: #2E8DED;
            float: right;
        }

        textarea:disabled {
            background: #fff;
        }

        .page-container {
            overflow: hidden;
        }

        label {
            float: right;
            margin-left: 5px;
        }
    </style>
    <div class="page-container">
        <div class="left_content" style="width: 430px;float: left;margin-right:-450px">
            <div class="select_box">
                <select style="position: relative;" class="city" name="province" id="">
                    <option value="">选择省份</option>
                    <?php if(is_array($province)): $i = 0; $__LIST__ = $province;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><option value="<?php echo ($item["province_id"]); ?>"><?php echo ($item["province_name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                </select>
                <select style="position: relative;" class="city m_left" name="type">
                    <option value="">选择类型</option>
                    <option value="1">政府单位</option>
                    <option value="2">旅游景区</option>
                    <option value="3">企业公司</option>
                    <option value="0">其他</option>
                    <option value="4">海外客户</option>
                </select>
                <span class="glyphicon_box">
					<input class="text_box m_left" type="text" name="name" placeholder="搜索客户名称">
					<span class="glyphicon glyphicon-search" aria-hidden="true" onclick="searchCust()"></span>
				</span>
                <div class="check_all">
                    <span>剩余条数</span>
                    <span style="margin-left: 10px" id="sms-num"><?php echo ($sms_num); ?></span>
                    <form class="check_button" action="" method="get">
                        全选
                        <label><input onchange="fnSelect(this)" id="checkAll" style="vertical-align: sub;" name="all"
                                      type="checkbox" value=""/> </label>
                    </form>

                </div>
            </div>

            <!-- 多选内容 -->
            <div class="check_box">
                <ul id="Huifold1" class="Huifold bg_color" style="background-color: #fff">
                    <!-- <li class="item">
                       <h4>
                           <span style="width:150px;height:37px;hidden:overflow;display:inline-block;">重庆园博园重庆园博园重庆园博园重庆园博园园重庆园</span>
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
                               <input onclick="fnSelect3(this,4)" value="4" style="margin-top: -2px;position: absolute;right: 5px;top: 50%;margin-top: -6px;" name="all" type="checkbox" />
                           </form>
                           <form  class="border_b" action="" method="get" >
                               <span>决策人</span>
                               <span><img class="spacing" src="/public/img/test/u707.png" alt="">孙权</span>
                               <span style="margin-left:80px">书记</span>
                               <img class="tel abs" src="/public/img/test/tel.png" alt="">
                               <img class="sms abs" src="/public/img/test/sms.png" alt="">
                               <input onclick="fnSelect3(this,5)" value="5" style="margin-top: -2px;position: absolute;right: 5px;top: 50%;margin-top: -6px;" name="all" type="checkbox" />
                           </form>
                       </div>

                   </li>
                   <li class="item">
                       <h4>
                           <span >重庆园博园</span>
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


            <form action="" method="post">
                <div class="right_content" style="margin-left: 450px;">
                    <button class="sent" type="button" style="width: 100px;margin-top: -10px;margin-bottom: 20px;"
                            onclick="operation('短信模板管理','/service/send/model/lists')">短信模板管理
                    </button>
                    <div class="telOwner">
                        <span>接受人</span>
                        <span class="color3" id="select-total">已选0人</span>
                    </div>
                    <div class="">
                        <textarea name="sms_names" readonly="readonly"
                                  style="margin-top: 10px;height: 65px;width: 100%;resize:none;"
                                  class="textinput"></textarea>
                    </div>
                    <div class="" style="display: none;">
                        <textarea name="sms_phones" readonly="readonly"
                                  style="margin-top: 10px;height: 65px;width: 100%;resize:none;"
                                  class="textinput"></textarea>
                    </div>

                    <div id="model" style="margin-top:20px">
                        短信模板ID:
                        <span class="select-box" style="width: 120px;">
                            <select name="sms_model_id" class="select">
                                <option value=""></option>
                                <?php if(is_array($sms_model)): $i = 0; $__LIST__ = $sms_model;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><option value="<?php echo ($item["sms_model_code"]); ?>"><?php echo ($item["sms_model_code"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                            </select>
				        </span>
                    </div>

                    <textarea name="sms_txt" id="" style="	margin-top: 10px;height: 65px;width: 100%;resize:none;"
                              disabled
                              class="textinput"></textarea>
                    <div>
                        <button class="sent" type="button" onclick="send()">发送</button>
                        <span class="record" onclick="operation('短信记录','/service/send/sms/list')">短信记录</span>
                    </div>
                </div>
            </form>
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

    <script>
		// 折叠
		$(function () {
			$.Huifold("#Huifold1 .item h4", "#Huifold1 .item .info", "fast", 1, "click");
			/*5个参数顺序不可打乱，分别是：相应区,隐藏显示的内容,速度,类型,事件*/

		});

		function EstopPropagation() {
			$(".pitchOn").click(function (e) {
				e.stopPropagation()
			})
		}

		EstopPropagation();
		ModelChange()

		function ModelChange() {

			$('select[name=sms_model_id]').on("change", function () {
				var code = $('select[name=sms_model_id]').val();
				$.each($sms_model, function (i, v) {
					if (code == v.sms_model_code) {
						$('textarea[name=sms_txt]').text(v.note)
					}
				})

			});
		}

		//		modelClick()
		var $sms_model = JSON.parse('<?php echo json_encode($sms_model) ?>')

		//		var $sms_model = JSON.parse('<php>echo json_encode($sms_model)<php>');

		function modelAjax() {
			var param ={};
			var url = '/service/send/sms/modellist';
			K.doAjax(param, url, function (res) {
				if (res.status && res.status == 'success') {
					$sms_model = res.sms_model
					showModelList();
				} else {
					if (res.message) {
						layer.msg(res.message, {icon: 2, time: 2000});
					} else {
						layer.msg('后台错误!', {icon: 2, time: 2000});
					}
				}
			});

		}


		function showModelList() {

			$('select[name=sms_model_id]').empty();
			var str = '<option value=""></option>';
			$.each($sms_model, function (i, v) {
				str += '<option value="' + v.sms_model_id + '">' + v.sms_model_code + '</option>';
			});
			$('select[name=sms_model_id]').append(str);

		}

		//全选/全选取消
		function fnSelect(obj) {
			var checked = obj.checked;
			var tbody = $('.check_box');
			var inputs = tbody.find('input');
			for (var i = 0; i < inputs.length; i++) {
				var phone = $(inputs[i]).val();
				var name = $(inputs[i]).attr('contact');
				if ('' == phone) {
					inputs[i].checked = checked;
				}

				if ('' == phone) continue;

				inputs[i].checked = checked;

				ps = phone.split(",");
				var exist = searchPhone(ps[0])
				if (checked && 0 > exist) {
					for (var i = 0; i < ps.length; i++) {
						$phones.push(ps[i])
					}
					$names.push(name)
				}

				if (!checked && 0 <= exist) {
					$phones.splice(exist, ps.length)
					$names.splice(exist, 1)
				}

			}


			$('textarea[name=sms_phones]').val($phones.join())
			$('textarea[name=sms_names]').val($names.join())

			showSelTotal()

			var obj_infos = $('.check_box ul li').find('.info');
			console.log(obj_infos.length)
			for (var i = 0; i < obj_infos.length; i++) {
				setSelectNum($(obj_infos[i]))
			}
		}

		function fnSelect2(obj) {
			console.log('fnSelect2', obj, obj.checked)
			var checked = obj.checked;

			var parentNode = obj.parentNode.parentNode.parentNode;

			var inputs = $(parentNode).find("input");
			console.log(inputs);
			console.log(parentNode);
			for (var i = 0; i < inputs.length; i++) {
				inputs[i].checked = checked;
			}

			for (var i = 0; i < inputs.length; i++) {
				var phone = $(inputs[i]).val();
				ps = phone.split(",");
				var name = $(inputs[i]).attr('contact');
				if ('' == phone) continue;
				inputs[i].checked = checked;

				var exist = searchPhone(ps[0])
				if (checked && 0 > exist) {
					for (var i = 0; i < ps.length; i++) {
						$phones.push(ps[i])
					}
					$names.push(name)
				}

				if (!checked && 0 <= exist) {
					$phones.splice(exist, ps.length)
					$names.splice(exist, 1)
				}

			}

			$('textarea[name=sms_phones]').val($phones.join())
			$('textarea[name=sms_names]').val($names.join())

			showSelTotal()

			var temp_o = $(obj).parent().parent().next();
			setSelectNum(temp_o)
		}

		function fnSelect3(me, phone) {
			console.log('fnSelect3', phone)
			if ('' == phone) {
				var temp_o = $(me).parent().parent();
				setSelectNum(temp_o)
				return;
			}
			var name = $(me).attr('contact')

			var is = $(me).is(':checked')
			ps = phone.split(",");
			var exist = searchPhone(ps[0])
			if (is) {
				if (0 > exist) {
					for (var i = 0; i < ps.length; i++) {
						$phones.push(ps[i])
					}
					$names.push(name)
				}

			} else {

				if (0 <= exist) {
					$phones.splice(exist, ps.length);
					$names.splice(exist, 1)

				}
			}
			$('textarea[name=sms_phones]').val($phones.join())
			$('textarea[name=sms_names]').val($names.join())
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
			if (num >= parseInt(temp_arr[1])) {
				console.log('yes')
				if (!obj.prev().find('form').find('input[type=checkbox]')[0].checked)
					obj.prev().find('form').find('input[type=checkbox]')[0].checked = true;
			} else {
				if (obj.prev().find('form').find('input[type=checkbox]')[0].checked)
					obj.prev().find('form').find('input[type=checkbox]')[0].checked = false;
			}
		}

		function showSelTotal() {
			$('#select-total').html('已选' + $names.length + '人')
		}

		function searchPhone(phone) {
			for (var i = 0; i < $phones.length; i++) {
				if (phone == $phones[i]) {
					return i;
				}
			}
			return -1;
		}

		function searchName(name) {
			for (var i = 0; i < $names.length; i++) {
				if (name == $names[i]) {
					return i;
				}
			}
			return -1;
		}

		// 操作/已完成
		function operation(title, url) {
			layer_show(title, url, 1000, 700);
		}

		//
		function searchCust() {
			var param = {}
			if ("" != $('select[name=province]').val()) {
				param.province_id = $('select[name=province]').val()
			}
			if ("" != $('select[name=type]').val()) {
				param.type = $('select[name=type]').val()
			}
			if ("" != $('input[name=name]').val()) {
				param.name = $('input[name=name]').val()
			}
			var url = '/service/send/sms/customer';
			K.doAjax(param, url, function (res) {
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
		var $names = [];
		var $datas = [];
		var $counts = 0;
		var $sel_total = 0;

		var head = "";

		function showCustList() {
			$('#Huifold1').empty()
			var cust_n = null;
			var first = true;
			var str = '';
			var total = 0;
			$.each($datas, function (i, v) {
				if (first || cust_n != v.cust_name) {
					if (first) {
						first = false;
						cust_n = v.cust_name

						addHead(v)
					} else {
						addEnd(str, total)

						cust_n = v.cust_name
						str = ""
						head = ""
						total = 0

						addHead(v)
					}
				}
				str += '<form  class="border_b" action="" method="get" > ';
				str += '<span>' + (1 == v.func ? '决策人' : (2 == v.func ? '负责人' : (3 == v.func ? '经办人' : '其他'))) + '</span>'
				str += '<span><img class="spacing" src="' + v.url + '" alt="">' + (v.contact_name ? v.contact_name : '未知') + '</span>'
				str += '<span class="info-posit abs">' + v.position + '</span>'
				if (v.phone)
					str += '<img class="tel abs" src="/public/img/test/tel.png" alt="">'
				if (v.email)
					str += '<img class="sms abs" src="/public/img/test/sms.png" alt="">'
				str += '<input style="margin-top: -2px;position: absolute;right: 5px;top: 50%;margin-top: -6px;" name="all" type="checkbox" onclick="fnSelect3(this,\'' + v.phone + '\')" value="' + v.phone + '" contact="' + v.contact_name + '"/> ';
				str += '</form>';

				total++
			})

			if (0 < $counts) {
				addEnd(str, total)
				$.Huifold("#Huifold1 .item h4", "#Huifold1 .item .info", "fast", 1, "click");
			}
		}

		function addHead(v) {
			head = '';
			head += '<li class="item">';
			head += '<h4><span>' + v.cust_name + '</span>';
			head += '<form  class="checkbox_title" action="" method="get"><span name="sel">已选0/全部0</span>';
			head += '<span style="margin-left: 5px">全选</span><input onchange="fnSelect2(this)" id="pitchOn" class="pitchOn" style="margin-top: -2px;" name="all" type="checkbox" value="" />';
			head += '</form><b style="margin-top: 1px">\+</b></h4><div class="info" >';
		}

		function addEnd(str, total) {
			var tt = '全部' + total;
			head = head.replace("全部0", tt);
			head += str + '</div></li>';

			$('#Huifold1').append(head)
		}

		function send() {
			var param = {}
				param.phones = $phones;
			param.context = $('textarea[name=sms_txt]').val();
			param.sms_code = $('select[name=sms_model_id]').val();

			var url = '/service/send/sms/call';
			K.doAjax(param, url, function (res) {
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

</body>
</html>