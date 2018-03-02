<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="menu_title">系统配置</block>

<block name="body_main">
    <style>
        .tabBar {
            border-bottom: 1px solid #e0e0e0
        }

        .tabBar span {
            background-color: #fff;
            cursor: pointer;
            display: inline-block;
            float: left;
            font-weight: normal;
            height: 45px;
            line-height: 45px;
            padding: 0 15px;
            text-align: center;
            color: #30baba;
        }

        .tabBar span.current {
            border-bottom: 3px solid #688696;
            background-color: #fff;
            color: #30baba;
        }

        .table tr {
            height: 60px;
            line-height: 60px;
        }

        .table tr .type {
            color: #30baba;
            font-size: 14px;
            width: 100px;
        }

        .table tr .txt {
            color: #333;
            font-size: 14px;
        }

        .tabCon {
            margin-top: -1px;
            padding: 0 20px;
            text-align: left;
        }

        .title-c {
            color: #30baba;
        }
    </style>
    <div class="page-container">
        <!-- <form class="form form-horizontal bk-gray pd-20 bg-fff" method="get">
            <div class="text-l ">
                <input type="text" 
                    class="input-text" style="width:300px"
                     placeholder="搜索客户名称、联系人"
                           name="name"
                           value="{$Think.get.name}" />
                
                <button name="" class="btn btn-primary  radius ml-15" 
                type="submit">&nbsp;搜索&nbsp;</button>
            </div>
        </form> -->
        <div class="mt-20 bk-gray pt-20 pb-20 bg-fff">
            <div id="tab_demo" class="HuiTab">
                <div class="tabBar clearfix">
                    <span class="tab-head ml-20">消息提醒配置</span>
                    <span class="tab-head">项目类型配置</span>
                    <span class="tab-head">投资形式配置</span>
                </div>
                <div class="tabCon">
                    <form class="form form-horizontal pt-20 pl-30 pb-30" method="post">

                        <div class="title-c text-l mt-20">
                            生日提醒
                        </div>
                        <div class="text-l mt-5">
                            客户联系人生日提前<input type="number"
                                            class="input-text ml-10 mr-10" style="width:80px" name="birthday_limit"
                                            onchange="changeData(this)" value="{$data.birthday_limit}"/>天提醒业务员
                        </div>
                        <div class="title-c text-l mt-30">
                            联络提醒
                        </div>
                        <div class="text-l mt-5">
                            设定联络日期，在该日期前<input type="number"
                                               class="input-text ml-10 mr-10" style="width:80px" name="liaison_limit"
                                               onchange="changeData(this)" value="{$data.liaison_limit}"/>天提醒业务员联络客户
                        </div>
                        <div class="title-c text-l mt-30">
                            任务提醒
                        </div>
                        <div class="text-l mt-5">
                            设定任务截止日期，在该日期前<input type="number"
                                                 class="input-text ml-10 mr-10" style="width:80px" name="task_limit"
                                                 onchange="changeData(this)" value="{$data.task_limit}"/>天提醒任务负责人
                        </div>
                        <div class="title-c text-l mt-30">
                            短信条数
                        </div>
                        <div class="text-l mt-5">
                            设定短信条数：短信剩余<input type="number"
                                                 class="input-text ml-10 mr-10" style="width:80px" name="sms_num"
                                                 onchange="changeData(this)" value="{$data.sms_num}"/>条
                        </div>

                    </form>
                </div>
                <!-- table end --> <!-- table begin -->
                <div class="tabCon">
                    <div class="cl pd-5 mt-20 bg-fff"><span class="l">
                   <a class="btn btn-primary radius" data-title="添加"
                      onclick="notice_add('新增数据', '/service/system/manage/addmodel')"
                      href="javascript:;"><img style="width:12px;height:12px;margin-top:-2px;"
                                               src="/public/img/iconfont/xe600-2.png"/>
                       新增数据
                   </a></span>
                    </div>
                    <div class="mt-20 bg-fff">
                        <table class="table table-border table-hover table-sort">
                            <thead>
                            <tr class="text-l ">
                                <th class="c-999" width="150">序号</th>
                                <th class="c-999">项目类型</th>
                                <th class="c-999" width="120">配&nbsp;&nbsp;&nbsp;&nbsp;置</th>
                            </tr>
                            </thead>
                            <tbody>
                            <volist name="models" id="item">
                                <tr class="text-l ">
                                    <td>{$i}</td>
                                    <td>{$item.name}</td>
                                    <td>
                                        <eq name="i" value="1">
                                            <a style="text-decoration:none" class="ml-5"
                                               onClick="notice_add('编辑','/service/system/manage/changemodel?id={$item.model_config_id}')"
                                               href="javascript:;" title="编辑">
                                                <img style="width:14px;height:14px;"
                                                     src="/public/img/iconfont/xe6df.png"/>
                                            </a>
                                            <else/>
                                            <a style="text-decoration:none" class="ml-5"
                                               onClick="notice_add('编辑','/service/system/manage/changemodel?id={$item.model_config_id}')"
                                               href="javascript:;" title="编辑">
                                                <img style="width:14px;height:14px;"
                                                     src="/public/img/iconfont/xe6df.png"/>
                                            </a>
                                            <a style="text-decoration:none" class="ml-5"
                                               onClick="advert_del(this,'{$item.model_config_id}')"
                                               href="javascript:;" title="删除">
                                                <img style="width:14px;height:14px;"
                                                     src="/public/img/iconfont/xe6e2.png"/>
                                            </a>
                                        </eq>


                                    </td>
                                </tr>
                            </volist>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- table end -->

                <!-- table begin -->
                <div class="tabCon">
                    <div class="cl pd-5 mt-20 bg-fff"><span class="l">
                   <a class="btn btn-primary radius" data-title="添加"
                      onclick="notice_add('新增数据', '/service/system/manage/addfeetype')"
                      href="javascript:;"><img style="width:12px;height:12px;margin-top:-2px;"
                                               src="/public/img/iconfont/xe600-2.png"/>
                       新增数据
                   </a></span>
                    </div>
                    <div class="mt-20 bg-fff">
                        <table class="table table-border table-hover table-sort">
                            <thead>
                            <tr class="text-l ">
                                <th class="c-999" width="150">序号</th>
                                <th class="c-999">投资形式</th>
                                <th class="c-999" width="60">配置</th>
                            </tr>
                            </thead>
                            <tbody>
                            <volist name="fee_type" id="item">
                                <tr class="text-l ">
                                    <td>{$i}</td>
                                    <td>{$item.name}</td>
                                    <td>
                                        <a style="text-decoration:none" class="ml-5"
                                           onClick="notice_add('编辑','/service/system/manage/changefeetype?id={$item.config_auto_id}')"
                                           href="javascript:;" title="编辑">
                                            <img style="width:14px;height:14px;" src="/public/img/iconfont/xe6df.png"/>
                                        </a>
                                    </td>
                                </tr>
                            </volist>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </div>
</block>

<block name="footer_js">
    <script type="text/javascript">

		function changeData(me) {
			var v = $(me).val()
			if ('' == v) {
				layer.msg('错误：参数不能为空！', {icon: 2, time: 1500})
				return;
			}
			var param = {}
				param.name = $(me).attr('name');
			param.value = v;

			K.doAjax(param, '/service/system/manage/change', function (e) {
				if (e.status && e.status == "success") {

				} else {
					if (e.message) {
						layer.msg(e.message, {icon: 2, time: 1500})
					} else {
						layer.msg("后台错误!", {icon: 2, time: 1500})
					}
				}
			});
		}

		$(function () {
			$.Huitab("#tab_demo .tabBar span", "#tab_demo .tabCon", "current", "click", "{$Think.get.t|default=0}")
		});

		function notice_add(title, url) {
			layer_show(title, url, 500, 400);
		}

		/*删除*/
		function advert_del(obj, id) {
			layer.confirm('确认要删除吗？', function (index) {
				//此处请求后台程序，下方是成功后的前台处理……
				var param = {id: id};

				K.doAjaxDeleteById(obj, param,'/service/system/manage/delmodel',function (res) {
					if (res.status && res.status == 'success') {
						window.location.href = "/service/system/manage/profile?t=1";
					} else {
						if (res.message) {
							layer.msg(res.message, {icon: 2, time: 2000});
						} else {
							layer.msg('后台错误!', {icon: 2, time: 2000});
						}
					}
				});
			});
		}
    </script>
</block>