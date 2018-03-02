<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="common_css">
    <link href="/public/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
</block>
<block name="common_js">

</block>
<block name="menu_title">用户统计</block>
<block name="body_main">
    <style>
        /*清除浮动*/
        .clearfix:after {
            content: "";
            display: block;
            height: 0;
            clear: both;
        }

        .fr {
            float: right;

        }

        .body {
            width: 100%;
            padding: 20px;
        }

        .body .top {
            margin-top: 15px;
            width: 100%;
            height: 65px;
            padding: 10px 20px;
            background-color: #fff;
            border: 1px solid #999;
        }

        .body .download {
            float: right;
            line-height: 0px;
            color: #688696;
        }

        .body .table {
            margin-top: 15px;
            width: 100%;
            padding: 10px 20px 30px;
            border: 1px solid #999;
            background-color: #fff;
        }

        .body .table h1 {
            padding: 0;
            margin: 0;
            margin-top: 15px;
            font-size: 20px;
            color: #6886B0;
        }

        .body .date {
            margin-top: 30px;
        }

        .body .date select {
            width: 120px;
            height: 30px;
            float: left;
            border: 1px solid #999;
        }

        /*共同的小正方形*/
        .box {
            display: inline-block;
            width: 10px;
            height: 10px;
            margin-right: 5px;
        }

        .fail {

            background-color: #ED7D31;
        }

        .success {

            background-color: #688696;
        }
        .table_ul tr{
            width: 100%;
        }
        .table_ul td {
            width: 2.8%;
            height: 26px;
           padding: 3px;
            padding-bottom: 20px;
            display: inline-block;
        }

        .table_ul .first {
            width: 9%;
           white-space:nowrap
        }

        .table_ul tr:nth-child(2n-1) td {
            color: #ED7D31;
            border-bottom: 1px solid #E4E4E4;
        }

        .table_ul tr:nth-child(2n) td {
            color: #688696;

        }


        .table_ul tr:first-child  {
          
            border-bottom: 1px solid #000;
        }
        .table_ul tr:first-child td {
            color: #000;
            border-bottom: 0;
        }
        .table_ul tr:last-child td {
           
            border-bottom: 0;
        }
        .successAll {
            text-align: right;
            margin-right: 20px;
            color: #688696;
        }

        .failAll {
            text-align: right;
            margin-right: 20px;
            color: #ED7D31;
        }
    </style>
    <div class="body">
        <notempty name="department">
            <div class="top">
                <select style="width: 140px;height: 40px;border: 1px solid #999;" name="department" id="">
                    <option value="0">全部部门</option>
                    <volist name="department" id="dt">
                        <option value="{$dt.department_id}"
                        <eq name="Think.get.department_id" value="$dt.department_id">selected</eq>
                        >{$dt.name}</option>
                    </volist>
                </select>
            </div>
        </notempty>
        <div class="table">
            <h1>联络次数</h1>
            <span class="download">下载表格</span>

            <div class="date clearfix">
                <div class="form-group">
                    <div class="input-group date form_date" data-date="" data-date-format=" mm yyyy"
                         data-link-field="dtp_input2" data-link-format="yyyy-mm">
                        <input class="form-control" size="16" type="text" value="{$Think.get.month}" readonly
                               name="month"
                               style="background-color: #fff;border: 1px solid #e0e0e0;" placeholder="">
                        <span class="input-group-addon" style="background-color: #fff;border: 1px solid #e0e0e0;"><span
                                    class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon" style="background-color: #fff;border: 1px solid #e0e0e0;"><span
                                    class="glyphicon glyphicon-calendar"></span></span>
                    </div>
                </div>
                <span class="fr"><i class="box fail"></i>联络失败</span>
                <span style="margin-right: 30px;" class="fr"><i class="box success"></i>联络成功</span>
            </div>
            <table class="table_ul" style="margin-top:30px;">
                <tr>
                    <td class="first">成员</td>
                    <for start="1" end="$days+1" name="i">
                        <td>{$i}</td>
                    </for>

                    <td>总</td>
                </tr>
                <volist name="list" id="item">

                    <tr>
                        <td rowspan="2" class="first">{$item.name}</td>
                        <for start="1" end="$days+1" name="i">
                                <td>{$item.ok.$i}</td>
                        </for>
                        <td>{$item.total.ok}</td>
                    </tr>
                    <tr>
                        <td class="first"></td>
                        <for start="1" end="$days+1" name="i">
                                <td>{$item.failed.$i}</td>
                        </for>
                        <td>{$item.total.failed}</td>
                    </tr>

                </volist>
                <tr>
                    <td class="first"></td>
                    <for start="1" end="$days+1" name="i">
                        <td></td>
                    </for>
                    <td>{$total_ok}</td>
                </tr>
                <tr>
                    <td class="first"></td>
                    <for start="1" end="$days+1" name="i">
                        <td></td>
                    </for>
                    <td>{$total_failed}</td>
                </tr>

            </table>
        </div>
    </div>

</block>
<block name="footer_js">
    <script type="text/javascript" src="/public/bootstrap-time/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="/public/bootstrap-time/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script>
		$('.form_date').datetimepicker({
			format: 'yyyy-mm',
			weekStart: 1,
			autoclose: true,
			startView: 3,
			minView: 3,
			forceParse: false,
//			defaultDate : new Date(),
			language: 'zh-CN'
		});
		var now_month = '{$now_month}';

		if ($('input[name=month]').val() == '') {
			$('input[name=month]').val(now_month);
		}
		var month = $('input[name=month]').val();
		var department_id = $('select[name=department]').val()?$('select[name=department]').val():'';
		$('input[name=month]').change(function () {
			month = $(this).val();
			var url = '/service/statistics/user/data?month=' + month + '&department_id=' + department_id;
			window.location.replace(url);
		});



		$('select[name=department]').change(function () {
			department_id = $(this).val();
			console.log(department_id)
			var url = '/service/statistics/user/data?month=' + month + '&department_id=' + department_id;
			window.location.replace(url);
		})
        $('.download').click(function () {
			var url = '/service/statistics/user/data?month=' + month + '&department_id=' + department_id+'&action=export';
			window.location.replace(url);
		})
    </script>
</block>
