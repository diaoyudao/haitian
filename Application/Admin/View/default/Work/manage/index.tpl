<extend name="./Application/Admin/View/default/base/context/common.tpl"/>
<block name="common_css">
    <link href="/public/swiper3.4.1/css/swiper.min.css" rel="stylesheet" type="text/css"/>
    <link href="/public/css/work/manage/index.css" rel="stylesheet" type="text/css"/>
</block>
<block name="common_js">
</block>

<block name="body_path_name">
    工作报告
</block>

<block name="body_main">
    <style>

    </style>
    <div class="body">
        <div class="screen_box">
            <select class="screen_department" name="year">
                <volist name="year_list" id="yy">
                    <option value="{$yy}"
                    <eq name="Think.get.year" value="$yy">selected</eq>
                    >{$yy}年</option>

                </volist>
            </select>
        </div>
        <div class="screen_box" style="padding-top: 0;margin-top: 20px;">
            <volist name="list" id="item">
                <p class="title">{$key}月</p>
                <ul>
                    <volist name="item" id="vv">
                        <li>
                            <p>第{$vv.num}周</p>
                            <volist name="vv.info" id="v">
                                <div>
                                    <img class="head" src="{$v.thumbnail_url}" alt="">
                                    <p>{$v.name}</p>
                                </div>
                            </volist>
                        </li>
                    </volist>
                </ul>
            </volist>

        </div>
    </div>
</block>

<block name="footer_js">
    <script type="text/javascript" src="/public/swiper3.4.1/js/swiper.min.js"></script>
    <script>
		$('select[name=year]').change(function () {
			var year = $(this).val();
			var url = '/service/work/manage/index?year=' + year;
			window.location.replace(url);
		})

    </script>
</block>