<extend name="./Application/Admin/View/mobile/base/context/common-new.tpl"/>

<block name="common_css">

</block>
<block name="common_js">

</block>

<block name="head_left">
    <a onclick="removeIframe()"><img class="head_left" src="/public/img/home/xlcweb/u608.png" alt=""/></a>
</block>


<block name="head_name">
    任务详情
</block>

<block name="body_main">
    <style>
        /*清除浮动*/
        .clearFix:after {
            content: "";
            display: block;
            height: 0;
            clear: both;
        }

        .body {
            padding: 0 10px 30px 10px;
        }

        .body .li {
            position: relative;
            width: 100%;
            padding: 15px 10px;
            border-bottom: 1px solid #E4E4E4;
        }

        .body .li .left {
            float: left;
            width: 20%;
            height: 100%;
        }

        .abs {
            line-height: 32px;
        }

        .body .li .right {
            float: left;
            width: 80%;
        }

        .body .li .right img {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .body .situation {
            width: 100%;
            margin-top: 20px;
            min-height: 150px;
            padding: 10px;
            resize: none;
            border-radius: 5px;
            border-color: #E4E4E4;
        }

        .body .btn {
            width: 100%;
            color: #fff;
            margin-top: 30px;
            outline: none;
            background-color: #343643;
        }
    </style>
    <div class="body ">
        <input type="hidden" name="task_id" value="{$Think.get.id}"/>
        <div class="li clearFix"><span class="left">截至时间</span><span
                    class="right">{$task.end_date|strtotime|date='m-d',###}</span></div>
        <div class="li clearFix"><span class="left">任务内容</span><span class="right">{$task.context}</span></div>
        <div class="li clearFix"><span class="left abs">创建人</span><span class="right"><img
                        src="{$task.create.thumbnail_url}" alt="">{$task.create.name}</span></div>
        <div class="li clearFix"><span class="left">创建时间</span><span
                    class="right"><span>{$task.create_time}</span></span></div>
        <div class="li clearFix"><span class="left abs">负责人</span><span class="right">

                      <if condition="count($task['handler']) eq 1">
                         <img src="{$task['handler'][0]['thumbnail_url']}" alt=""> {$task['handler'][0]['name']}
                          <elseif condition="count($task['handler']) eq 2"/>

                         <img src="{$task['handler'][0]['thumbnail_url']}" alt=""><img
                                  src="{$task['handler'][1]['thumbnail_url']}"
                                  alt="">
                         <else/>
                         <img src="{$task['handler'][0]['thumbnail_url']}" alt=""><img
                                  src="{$task['handler'][1]['thumbnail_url']}"
                                  alt="">{$task.handler|count}
                     </if>

                 </span></div>
        <div class="li clearFix">
            <label class="lsglabel"><input name="is_over" type="checkbox" value="1" style="vertical-align: sub;" <if condition="session('employee')['role_type_code'] eq 'director'">disabled</if>
                <php> if(!empty($task) && (!empty($task['over_time'])))
                    {echo ' checked ';} </php>
                /> 已完成</label>
        </div>
        <textarea name="over_context" id="" placeholder="描述任务完成情况" class="situation">{$task.over_context}</textarea>
        <if condition="session('employee')['role_type_code'] neq 'director'">
        <button class="btn" onclick="finish()">保存</button>
        </if>
    </div>
</block>

<block name="footer_js">
    <script>
		function removeIframe() {
			K.removeIframe();
		}

		function finish() {
			var url = '/service/task/manage/change';
			var param = {};
			param.over_context = $('textarea[name=over_context]').val();
			if (param.over_context == '') {
				layer.msg("请输入完成情况！", {icon: 2, time: 1500})
				return
			}


			param.task_id = $('input[name=task_id]').val();
			param.is_over = $('input[name=is_over]:checked').val();
			K.doAjax(param, url, function (response) {
				if (response.status && 'success' == response.status) {
					var str=parent.window.location.href
					str=str.replace(/\?(.*)/, "");
					parent.window.location.replace(str + '?0&2');
					removeIframe();
				} else {
					if (response.message) {
						layer.msg(response.message, {icon: 2, time: 1500})
					} else {
						layer.msg("后台错误!", {icon: 2, time: 1500})
					}
				}
			})

		}

    </script>
</block>