<extend name="./Application/Admin/View/mobile/base/context/add.tpl"/>
<block name="common_css">
    <link href="/public/home/css/customer/search/addcard.css" rel="stylesheet" type="text/css"/>
</block>
<block name="common_js">

</block>

<block name="body_main">
    <style>
        .content .label_festival {
            padding: 0 2px;
            border: 1px solid #FF6633;
            border-radius: 3px;
            font-size: 11px;
            margin-left: 10px;
            color: #FF6633;
        }

        a:hover {
            text-decoration: none;
        }

        .preserve,
        .cancel {
            position: absolute;
            bottom: 0;
            margin-top: 40px;
            color: #03A9F4;
            font-size: 13px;
            line-height: 40px;
            text-align: center;
            cursor: pointer;
            width: 50%;
            border-top: 1px solid #E4E4E4;
        }

        .preserve {
            left: 0;
        }

        .cancel {
            border-left: 1px solid #E4E4E4;
            right: 0;
        }

        .Hui-iconfont-tel2 {
            font-size: 16px;
            margin-right: 10px;
        }

        .preserve a i,
        .cancel a i {
            color: #03A9F4;
        }

        .preserve a span,
        .cancel a span {
            color: #4286F5
        }

        .icolor {
            color: #4286F5
        }

        .hui {
            color: #949494 !important;
        }

        .hui a i,
        .hui a span {
            color: #949494 !important;
        }
    </style>
    <div class="body">

        <p class="title"><img class="head" src="/public/img/test/u707.png" alt=""><span>{$data.name}</span></p>


        <p class="content" style="margin:20px 0; "><span>经办人</span>{$data.department}</p>
        <p class="content"><span class="hui">生日</span>{$data.birthday}
            <if condition="$data['is_remind'] eq 1"><span class="label_festival">提醒</span></if>
        </p>

        <p class="content"><span class="hui">手机号码</span>{$data.phone}</p>
        <p class="content"><span class="hui">座机号码</span>
            <empty name="data.tel">
                未填写
                <else/>
                {$data.tel}
            </empty>
        </p>


        <p class="content"><span class="hui">微信号码</span>{$data.weixin}</p>
        <p class="content"><span class="hui">QQ号码</span>{$data.qq}</p>
        <p class="content"><span class="hui">邮箱地址</span>{$data.email}</p>
        <notempty name="data.tel">
            <div class="preserve">
                <a href="tel:{$data.tel}"><i class="Hui-iconfont Hui-iconfont-tel2"></i><span
                            class="">拨打座机</span></a>
            </div>
            <else/>
            <div class="preserve hui">
                <a href="javascript:void(0);"><i class="Hui-iconfont Hui-iconfont-tel2"></i><span
                            class="hui">拨打座机</span></a>
            </div>
        </notempty>
        <notempty name="data.phone">
            <div class="cancel"><a href="tel:{$data.phone}"><i class="Hui-iconfont Hui-iconfont-tel2"></i><span
                            class="">拨打手机</span><a>
            </div>
            <else/>
            <div class="cancel hui"><a href="javascript:void(0);"><i class="Hui-iconfont Hui-iconfont-tel2"></i><span
                            class="hui">拨打手机</span><a>
            </div>
        </notempty>
        <div class="clear"></div>
    </div>
</block>

<block name="footer_js">
    <script>
		function removeIframe() {
			K.removeIframe();
		}
    </script>
</block>