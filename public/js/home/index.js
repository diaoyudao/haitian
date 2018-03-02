var typeIndex
var modelsArry = [{
	options: ["1.8L 手动标准型",
		"1.8L 手动实用型",
		"1.8L 手动精英型",
		"1.8L 手动舒适型",
		"2.0L 手动标准型",
		"2.0L 手动舒适型",
		"2.0L CVT舒适型",
		"2.0L CVT豪华型",
		"1.5T 手动标准型",
		"1.5T 手动舒适型",
		"1.5T 自动舒适型",
		"1.5T 自动豪华型"
	]
}, {
	options: ["2.0T 手动标准型",
		"2.0 T 手动舒适型 ",
		"2.0 T 自动实用型 ",
		"2.0 T 自动舒适型 ",
		"2.0 T 自动豪华型 "
	]
}, {
	options: ["1.5L 手动基本型", 
	"1.5L 手动舒适型", 
	"1.5L 手动精英型", 
	"1.5L 自动智享型",
	"1.5L 自动尊享型", 
	"1.8L 手动舒适型",
	"1.8L 手动精英型", 
	"1.8L 自动尊享型 "]
}] //配置下拉框 选择车型

$(function() {

	//适配层
	function AdaperView() {
		var zoomWidth = 640,
			zoomHeight = 1026;
		var winWidth = $(window).width();
		var winHeight = $(window).height();
		var scx = winWidth / zoomWidth;
		var scy = winHeight / zoomHeight;
		var scale = "scale(" + scx + "," + scy + ")";
		var translateY = ((winHeight - zoomHeight * scy) / 2).toFixed(2);
		var translateX = ((winWidth - zoomWidth * scx) / 2).toFixed(2);
		var translate = "translate(" + translateX + "px," + translateY + "px)";
		$('#wrap').css({
			'transform': 'translate(' + translateX + 'px, ' + translateY + 'px) scale(' + scx + ',' + scy + ')',
			'-webkit-transform': 'translate(' + translateX + 'px, ' + translateY + 'px)  scale(' + scx + ',' + scy + ')',
			msTransform: 'translate(' + translateX + 'px, ' + translateY + 'px)  scale(' + scx + ',' + scy + ')',
			mozTransform: 'translate(' + translateX + 'px, ' + translateY + 'px)  scale(' + scx + ',' + scy + ')',
			oTransform: 'translate(' + translateX + 'px, ' + translateY + 'px)  scale(' + scx + ',' + scy + ')'
		});
	}
	AdaperView();

	//	window.addEventListener("resize", AdaperView); //屏幕大小改变，从新适配

});

var menu_word = [
	"鉴赏轩朗", "鉴赏X80", "鉴赏迈威"
]

function switchs(type, index) {
	var select = $("#select");
	select.on("change", function() {
		$(this).siblings("ul").remove();
		index = $(this).find("option:selected").data("optionsindex");
		Table(type, index); //切换车型时,更新配置信息
	});
}

var menu = 0;

$(".icon_menu").click(function() {
	menu++;
	if(menu == 1) {
		$(this).css({
			"background": "url(/public/img/home/icon_menur.png) no-repeat",
			"background-size": "contain"
		});
		$("#p3").find(".content").stop().animate({
			right: 0,
			opacity: 1
		});
		$(".top").css("background", "url(/public/img/home/icon_right.png)  no-repeat")

	} else {
		$(this).removeAttr("style");
		$("#p3").find(".content").stop().animate({
			right: "-50%",
			opacity: 0
		});
		menu = 0;
	}
}) //右侧菜单的点击隐藏

$(".menu").find(".top").click(function() {
	$(".icon_menu").removeAttr("style");
	$("#p3").find(".content").animate({
		right: "-50%",
		opacity: 0
	});
	menu = 0;
	$(this).css("background", "url(/public/img/home/icon_rights.png)  no-repeat")
})

//菜单点击增加动画
$("#p3").find(".router").click(function() {
	var i = $(this).data("router");
	$(this).find(".menu_icon").css({
		"background": "url(/public/img/home/icon" + i + "w.png)no-repeat",
		"background-position": "50px 30px"
	})
	$(this).find(".menu_word").css("color", "white");
	$(this).css("background", "rgba(255,0,0,0.7)");
})

var menu_click = [
	'xuanl', "x80", 'myway'
]

//每次点击页面都刷新一次
function init() {
	$("#p3").find(".menu_title").attr("src", "/public/img/home/menu_title" + a + ".png")
	$("#p3").find(".menu_car").attr("src", "/public/img/home/menu_car" + a + ".png");
	$("#p3").find(".menu_word1").text(menu_word[b]);
	$("#p3").find(".router1").attr("onclick", "mainHref('/car/video/" + menu_click[b] + "')")
	$("#p3").find(".router2").attr("onclick", "mainHref('/car/advantage/" + menu_click[b] + "')")
	$("#p3").find(".router3").attr("onclick", "mainHref('/car/config/" + menu_click[b] + "')")
	$("#p3").find(".router4").attr("onclick", "mainHref('/car/news/" + menu_click[b] + "')")
	$("#p3").find(".router5").attr("onclick", "mainHref('/car/bespeak/" + menu_click[b] + "')")
	$(".btm_btn").find(".btn" + c).css({
		"background": "url(/public/img/home/btm/btm_" + c + "r.png) no-repeat",
		"background-size": "contain",
		"background-position-x": "30px"
	})
}

var a;
var b = a - 1;
var c = a + 1
if(!a) {
	console.log("没有");
} else {
	init()
}

//提取用户信息
function sub(alert) {

	var i = $('.field option:selected').data("date");
	var data = { //用户信息
		name: $(".uesrname").val(), //名字
		phone: $(".uesrtel").val(), //电话
		area: $(".province option:selected").val(), //省份
		city: $(".city option:selected").val(), //市区
		shop4s: $(".nickname option:selected").val(), //经销商
	}
	console.log(data);

	if(data) {

		timer = setTimeout(function() {
			$(alert).hide();
			clearTimeout(timer);
		}, 500)

		if(data.name == "") {
			$(alert).show()
			$(alert).text("请填写您的姓名！");
			return;
		}

		if(data.phone == "") {
			$(alert).show()
			$(alert).text("请填写您的手机！");
			return;
		}

		if(!/^(13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9])\d{8}$/i.test(data.phone)) {
			$(alert).show()
			$(alert).text('手机号格式不正确');
			return;
		}

		if(data.area == "请选择省份") {
			$(alert).show()
			$(alert).text("请选择省份");
			return;
		}
	}
	return data;

}

//上传数据
function initEvent() {

	var alert = $(".alert")

	// 信息验证
	$("#p8").find(".sub").on('click', function() {
		console.log(window.location.href);

		var data = sub(alert);
		if(data) {
			$.post(window.location.href, data, function(res) {
				if(res.status == "ok") {
					commit = setTimeout(function() {
						$(alert).hide();
						clearTimeout(commit);
					}, 500)
					$(alert).show()
					$(alert).text("提交成功");
				} else {
					//					console.log(res)
				}
			})
		}

	})

}

initEvent();

function video() {
	var myvideo = document.getElementById("myvideo");
	// var myvideo_img = $(".videos_img");
	myvideo.addEventListener("play", function() {
		$(".btm_btn").hide()
		// myvideo_img.hide();
	})
	myvideo.addEventListener("pause", function() {
		myvideo_img.show();
		// $(".btm_btn").show()
	})
}

//表格htm文件名称

var dataTrs;

function Table(type, index) {

	var type = "/public/js/home/htm/set" + type;
	//读取表格htm文件
	var data = $("<div></div>");
	data.load(type + ".htm", " ", function() {

		//获取表格文件的标签
		var dataTables = $(data).find("table");
		dataTrs = dataTables.find("tr");

		//获取主文件的标签
		var body = $(".set_box");
		//      var rmb = $(".nav").find("span").eq(0);
		//      var money = $(".nav").find("span").eq(1);

		//车型号位置

		var text = dataTrs.eq(1).find("td").eq(0).text();
		var num = dataTrs.eq(1).find("td").eq(index).text();
		//      rmb.text(text);
		//      money.text(num);
		var ul = $("<ul></ul>");

		//		        console.log(dataTrs.length);

		for(var i = 0; i < (dataTrs.length - 1); i++) {

			if($(dataTrs[i]).find("td").eq(1).text().trim() == "") {

				//新建标签
				//添加ul和ul里的标题
				var ul = $("<ul></ul>");
				var li = $("<li></li>");
				var firstspa = $("<span></span>");
				var lastspa = $("<span></span>");
				var text = $(dataTrs[i]).find("td").eq(0).text();
				body.append(ul);
				ul.append(li).addClass("box box" + i);
				li.append(firstspa);
				li.append(lastspa);
				//标题
				firstspa.append(text);

			} else {
				//								console.log("test2");
				var li = $("<li></li>");
				var firstspa = $("<span></span>");
				var lastspa = $("<span></span>");
				var text = $(dataTrs[i]).find("td").eq(0).text();

				var num = $(dataTrs[i]).find("td").eq(index).text();
				body.append(ul);
				//添加ul里其他li
				ul.append(li);
				li.append(firstspa);
				li.append(lastspa);
				//内容
				firstspa.append(text);
				lastspa.append(num);
			}

		}
		$(".set_box").find("ul").each(function(i, el) {
			if(i >= 2) {
				$(this).find("li>span:nth-child(2)").css("text-align", "center")
			}
		})

		$("#p6").find("ul>li:first-child>span:nth-child(2)").text("+").data("clknum", "-");

		$("#p6").find("ul>li:first-child").siblings().hide();

		$("#p6").find("ul>li:first-child").click(function() {
			var i = $(this).find("span:nth-child(2)").data("clknum")
			$(this).find("span:nth-child(2)").text(i);
			$(this).siblings().toggle();
			if(i == "+") {
				$(this).find("span:nth-child(2)").data("clknum", "-");
			}
			if(i == "-") {
				$(this).find("span:nth-child(2)").data("clknum", "+");
			}
		});
	});
}

var jsons = [
	"xuanl.json",
	"x80.json",
	"myway.json"
]

$("#p8").each(function() {
	var b = a-1 ;
	var url = "/public/js/home/json/"+jsons[b];
	var areaJson;
	var temp_html;
	var oProvince = $(this).find(".province");
	var oCity = $(this).find(".city");
	var oDistrict = $(this).find(".nickname");
	//初始化省
	var province = function() {
		$.each(areaJson, function(i, province) {
			temp_html += "<option value='" + province.p + "'>" + province.p + "</option>";
		});
		oProvince.html(temp_html);
		city();
	};
	//赋值市
	var city = function() {
		temp_html = "";
		var n = oProvince.get(0).selectedIndex;
		$.each(areaJson[n].c, function(i, city) {
			temp_html += "<option value='" + city.ct + "'>" + city.ct + "</option>";
		});
		oCity.html(temp_html);
		district();
	};
	//赋值县
	var district = function() {
		temp_html = "";
		var m = oProvince.get(0).selectedIndex;
		var n = oCity.get(0).selectedIndex;
		if(typeof(areaJson[m].c[n].d) == "undefined") {
			oDistrict.css("display", "none");
		} else {
			oDistrict.css("display", "inline");
			$.each(areaJson[m].c[n].d, function(i, district) {
				temp_html += "<option value='" + district.dt + "'>" + district.dt + "</option>";
			});
			oDistrict.html(temp_html);
		};
	};
	//选择省改变市
	oProvince.change(function() {
		city();
	});
	//选择市改变县
	oCity.change(function() {
		district();
	});
	//获取json数据
	$.getJSON(url, function(data) {
		areaJson = data;
		province();
	});
})