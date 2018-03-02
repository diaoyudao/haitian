window.provinces = [];
window.cityOptions = [];
window.dealerOptions = [];

/*
Ajax 三级省市联动
日期：2012-7-18

settings 参数说明
-----
url:省市数据josn文件路径
prov:默认省份
city:默认城市
dist:默认地区（县）
nodata:无数据状态
required:必选项
------------------------------ */
(function ($) {
    $.fn.citySelect = function (settings) {
        if (this.length < 1) { return; };

        // 默认值
        settings = $.extend({
//          url: "../js/city.min.js",
            prov: null,
            city: null,
            dist: null,
            nodata: "none",
            required: false
        }, settings);


        var box_obj = this;
        var prov_obj = box_obj.find(".province");
        var city_obj = box_obj.find(".city");
        var dist_obj = box_obj.find(".dist");
        var prov_val = settings.prov;
        var city_val = settings.city;
        var dist_val = settings.dist;
        var select_prehtml = (settings.required) ? "" : "<option value=''>省份</option>";
        var city_json;

        // 赋值市级函数
        var cityStart = function () {
            var prov_id = prov_obj.get(0).selectedIndex;
            if (!settings.required) {
                prov_id--;
            };

            city_obj.html("<option value=''>城市</option>").attr("disabled", true);
            dist_obj.html("<option value=''>区县</option>").attr("disabled", true);

            if (prov_id < 0 || typeof (city_json.citylist[prov_id].c) == "undefined") {

                return;
            };

            // 遍历赋值市级下拉列表
            temp_html = "<option value=''>城市</option>";
            
            // 选择的省份
            var selected_province =  prov_obj.get(0).value;
            
            window.cityOptions = [];
             $.each(window.dealers, function (i, dealer) {
            	if ((dealer.sellcar & window.cartypeid) >0){
            		if (dealer.province == selected_province && window.cityOptions.indexOf(dealer.city) < 0 ){
            			window.cityOptions.push(dealer.city)
            		}
            	}
            });
            
            $.each(window.cityOptions, function (i, city) {
                temp_html += "<option value='" + city + "'>" + city + "</option>";
            });
            
            city_obj.html(temp_html).attr("disabled", false).css({ "display": "", "visibility": "" });
        };

        var init = function () {
            // 遍历赋值省份下拉列表
            temp_html = select_prehtml;

			
            $.each(window.dealers, function (i, dealer) {
            	if ((dealer.sellcar & window.cartypeid) >0){
            		if (provinces.indexOf(dealer.province) < 0){
            			provinces.push(dealer.province)
            		}
            	}
            });
            
            for (var i = 0; i < provinces.length; ++i){
            	var province = provinces[i];
            	 temp_html += "<option value='" + province + "'>" + province + "</option>";
            }
            
            prov_obj.html(temp_html);

            // 若有传入省份与市级的值，则选中。（setTimeout为兼容IE6而设置）
            setTimeout(function () {
                if (settings.prov != null) {
                    prov_obj.val(settings.prov);
                    cityStart();
                    setTimeout(function () {

                        var isFind = false;
                        for (var i = 0; i < window.dealers.length; i++) {
                            var item = window.dealers[i];
                            if (item.city == settings.city) {
                                isFind = true;
                            }
                        }
                        
                        

                        //alert(isFind);
                        if (settings.city != null && isFind) {
                            city_obj.val(settings.city);
                            setTimeout(function () {
                                if (settings.dist != null) {
                                    dist_obj.val(settings.dist);
                                };
                            }, 1);
                        };
                    }, 1);
                };
            }, 1);

            // 选择省份时发生事件
            prov_obj.bind("change", function () {
                cityStart();
                console.log(prov_obj.get(0).value + " "+ city_obj.get(0).value);
	            renderDealer(prov_obj.get(0).value, city_obj.get(0).value);
            });

            // 选择市级时发生事件
            city_obj.bind("change", function () {
                console.log(prov_obj.get(0).value + " "+ city_obj.get(0).value);
	           renderDealer(prov_obj.get(0).value, city_obj.get(0).value);
            });
        };

        // 设置省市json数据
        if (typeof (settings.url) == "string") {
            $.getJSON(settings.url, function (json) {
                city_json = json;
                init();
            });
        } else {
            city_json = settings.url;
            init();
        };
    };
})(jQuery);



function renderDealer(province, city){
	    $(".nickname").find("option").remove();
       	window.dealerOptions = [];
		$.each(window.dealers, function (i, dealer) {
    	if ((dealer.sellcar & window.cartypeid) >0){
	    	if (dealer.province == province 
					&& dealer.city == city
	    			&& window.dealerOptions.indexOf(dealer.nickname) < 0 
	    		){
	    			dealerOptions.push(dealer.nickname)
	    		}
	    	}    	
    	});
    
    	if(dealerOptions.length == 0){
    		console.log(dealerOptions);
    	}
    	else{
    		 $.each(window.dealerOptions, function (i, sellcar) {
//              temp_html += "<option value='" + sellcar + "'>" + sellcar + "</option>";
                $(".nickname").append("<option value='" + sellcar + "'>" + sellcar + "</option>")
            });
    	}
}
