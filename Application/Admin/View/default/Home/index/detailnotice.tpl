<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">

</block>
<block name="common_js">

</block>

<block name="body_main">
    <style>
        .body {
            padding: 20px;
            /*padding-top: 0;*/
            overflow: hidden;
            /*margin-left: 10px;*/
            background-color: #fff;
            /*margin-right: 10px;*/
        }

        img {
            width: 32px;
            height: 32px;
            margin-right: 10px;
        }

        p {
            margin: 0;
            text-align: center;
        }

        .title {
            font-size: 18px;
            margin-bottom: 20px;
        }

        .info {
            font-size: 14px;
            margin-bottom: 40px;
        }

        .info span:first-child {
            margin-right: 20px;
        }

        .info span:last-child {
            margin-left: 5px;
        }

        .content {
            font-size: 13px;
            margin-top: 10px;
            text-align: left;
        }

        .preserve,
        .cancel {
            margin-top: 40px;
            /*width:    70px;*/
            /*height:30px;*/
            border-radius: 4px;
            color: #fff;
            font-size: 13px;
            line-height: 30px;
            text-align: center;
            cursor: pointer;
            float: left;
        }

        .cancel {
            /*margin-left: 20px;*/
        }

        .clear {
            clear: both;
        }
    </style>
    <div class="body">
        <p class="title">{$notice.title}</p>
        <p class="info">
            <span>{$notice.create_time|strtotime|date='Y/m/d H:i:s',###}</span>
            <span>{$notice.department_name}</span>
            <span>{$notice.employee_name}</span>
        </p>
        <p class="content">
            {$notice.context}
        </p>
        <div class="cancel">
            <button onclick="removeIframe()" class="btn btn-default radius" type="button">关闭</button>
        </div>
    </div>
</block>

<block name="footer_js">
    <script>
        function removeIframe() {
            K.removeIframe();
        }
    </script>
</block>