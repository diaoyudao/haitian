<extend name="./Application/Admin/View/default/base/context/lists2.tpl"/>

<block name="menu_name"> > 内容管理</block>
<block name="page_name"> > 区域管理</block>

<block name="body_main">
    <style>
        .layui-layer-btn{
            text-align: center;
        }
    </style>
    <div class="page-container">
        <switch name="list_type">
            <case value="province">
                <php>$id=province_id;$name=province_name;</php>
            </case>
            <case value="city">
                <php>$id=city_id;$name=city_name;$get=I('get.province_id');</php>
            </case>
            <default/>
            <php>$id=county_id;$name=county_name;$get=I('get.city_id');</php>
            </php>
        </switch>
        <form class="form form-horizontal" action="" method="get">
            <div class="text-c">
                <input type="hidden" name="province_id" value="{$Think.get.province_id}">
                <input type="hidden" name="city_id" value="{$Think.get.city_id}">
            </div>
        </form>

        <div class="cl pd-5 bg-1 bk-gray mt-20 text-c"><span class="l">
               <a class="btn btn-primary radius" data-title="添加"
                  onclick="notice_add('添加', '/service/system/area/add?pid={$get}&type={$list_type}')"
                  href="javascript:;"><img style="width:12px;height:12px;margin-top:-2px;"
                                           src="/public/img/iconfont/xe600-2.png"/>
                   添加
               </a></span> <span>
                <switch name="list_type">
                    <case value="province">省级列表</case>
                    <case value="city">市级列表</case>
                    <default/>
                    区县列表
                </switch>
            </span><span class="r">共有数据：<strong>{$counts}</strong> 条</span></div>
        <div class="mt-20">
            <table class="table table-border table-bordered table-bg table-hover table-sort">
                <thead>
                <tr class="text-c">
                    <th width="25"><input type="checkbox" name="" value=""></th>
                    <th width="25">序号</th>
                    <th>名称</th>
                    <th width="120">操作</th>
                </tr>
                </thead>
                <tbody>
                <volist name="lists" id="item">

                    <tr class="text-c">
                        <td><input type="checkbox" value="{$item[$id]}" name="check"></td>
                        <td>{$i}</td>
                        <td>
                            <if condition="$list_type != 'county'">
                                <a onClick="notice_edit(this,'{$item[$name]}','/service/system/area/lists?{$id}={$item[$id]}')"
                                >{$item[$name]}</a>
                                <else/>{$item[$name]}</if>
                        </td>

                        <td>
                            <a style="text-decoration:none" class="ml-5"
                               onClick="notice_edit(this,'编辑','/service/system/area/change?id={$item[$id]}&type={$list_type}')"
                               href="javascript:;" title="编辑">
                                <img style="width:14px;height:14px;" src="/public/img/iconfont/xe6df.png"/>
                            </a>
                            <a style="text-decoration:none" class="ml-5"
                               onClick="del_area('{$item[$id]}','{$list_type}')"
                               href="javascript:;" title="编辑">
                                <img style="width:14px;height:14px;" src="/public/img/iconfont/xe6e2.png"/>
                            </a>

                        </td>
                    </tr>
                </volist>
                </tbody>
            </table>
            <div id="pager" style="margin-top:5px; text-align:center;"></div>
        </div>
    </div>
</block>
<block name="footer_js">
    <script type="text/javascript">

		/*  分页 */
		//        var news_type_id = $("select[name=news_type_id]").val();
		//        var title = $("input[name=title]").val();
		//        var begin_time = $("select[name=begin_time]").val();
		var city_id = $('input[name=city_id]').val();
		var province_id = $('input[name=province_id]').val();
		var param = '&province_id=' + province_id + '&city_id=' + city_id;

		var page_size = '<php> echo empty($pager -> totalPages) ? 1 : $pager -> totalPages; </php>';
		if (page_size > 1) {
			PAGER.create(page_size, param);
		}

		/*添加*/
		function notice_add(title, url) {
//			K.showFullSonPage(title, url);
			layer_show(title, url, 500, 200);
		}

		/*编辑*/
		function notice_edit(obj, title, url, w, h) {

//			var index = layer.open({
//				type: 2,
//				title: title,
//                fixed:false,
//				content: url
//			});
//			layer.full(index);
			var height = document.body.clientHeight - 120;
			var width = document.body.clientWidth;
			layer_show(title, url, width, height);
		}

		function del_area(id, type) {
			var param ={};
			param.id = id;
			param.type = type;
			var url = '/service/system/area/delarea';
			layer.confirm('确认要删除选中的所有记录吗？', function (index) {
				K.doAjax(param, url, function (e) {
					if (e.status && e.status == "success") {
						layer.msg("删除成功!",{icon: 1, time: 1500});
						setTimeout('window.location.replace(window.location.href)', 1000);
//					window.location.replace(window.location.href);
					} else {
						if (e.message) {
							layer.msg(e.message, {icon: 2, time: 1500})
						} else {
							layer.msg("后台错误!", {icon: 2, time: 1500})
						}
					}
				});
			});
		}


    </script>
</block>