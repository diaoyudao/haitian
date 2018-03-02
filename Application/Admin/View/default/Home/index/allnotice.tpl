<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="common_css">
</block>
<block name="common_js">

</block>
<block name="menu_title">全部通知</block>
<block name="body_main">
    <style>
        a,
        a:hover {
            color: #000;
            text-decoration: none;
        }

        ul {

            list-style: disc;
            list-style-position: inside;
            color: #fff;
        }

        ul li {
            font-size: 13px;
            position: relative;
            height: 40px;
            line-height: 40px;
            border-bottom: 1px solid #E4E4E4;
        }

        ul li span:last-child {
            float: right;
            margin-right: 20px;
            color: #949494;
        }

        .disc {
            color: #2FBBE6 !important;

        }

        .mt-25 {
            position: absolute;
            bottom: 100px;
            width: 100%;
        }
    </style>
    <div style="padding:10px;">
        <div style="border: 1px solid #D7D7D7;padding: 20px 30px;background-color: #fff;height: 600px;position: relative;">
            <ul>
                <volist name="allnotice" id="item">
                    <li><a onclick="LsgLayerShow('通知','/service/home/index/detailnotice?id={$ne.notice_id}',700,800)"><span>{$item.title}</span><span>{$item.create_time|strtotime|date='Y/m/d H:i:s',###}</span></a></li>
                </volist>
            </ul>
            <div id="liaison-pager" class="mt-25 text-c"></div>
        </div>
    </div>
</block>
<block name="footer_js">
    <script>
		$(function () {
			var pg = '{$Think.get.pg}' ? '{$Think.get.pg}' : 1;
			var totalPages = '{$totalPages}' ? '{$totalPages}' : 1;
			laypage({
				cont: "liaison-pager",
				pages: totalPages,
				curr: pg,
				jump: function (e, first) {
					if (!first) {
						location.href = '?pg=' + e.curr;
					}
				}
			});

		});
		function LsgLayerShow(title, url, w, h) {
			layer.open({
				type: 2,
				area: [w + 'px', h + 'px'],
				fix: false,
				maxmin: true,
				shade: 0.4,
				title: title,
				content: url,
			});
		}
    </script>

</block>
