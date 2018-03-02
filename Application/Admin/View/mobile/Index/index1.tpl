<extend name="./Application/Admin/View/mobile/base/context/common.tpl"/>

<block name="common_css">

</block>
<block name="common_js">

</block>

<!-- <block name="head_left">
    <img onclick="myself()" class="head_left" src="/public/img/home/xlcweb/u23.png" alt="" />
</block>

<block name="head_right">
    <img class="head_right" src="/public/img/home/xlcweb/u21.png" alt="" />
</block> -->

<!-- <block name="head_name">
    海天彩灯
</block> -->

<block name="body_main">
    <style>
        /*清除浮动*/
        .clearfix:after {
            content: "";
            display: block;
            height: 0;
            clear: both;
        }
    
        .headList{
            width: 100%;
            height: 70px;
             overflow: hidden;
            background-color: #343643;
        }
        .headList ul li {
            position: relative;
            text-align: center;
            float: left;
            width: 20%;
            color: #fff;
        }
        .headList ul li .circular{
            position: relative;
            margin:auto;
            width: 41px;
            height: 41px;
            text-align: center;
            border: 1px solid #fff;
            border-radius: 50%;
        }
         .headList ul li .circular .hint{
            position: absolute;
            right: -5px;
            top: 0;
            width: 18px;
            height: 18px;
            line-height: 18px;
            text-align: center;
            border: 2px solid #fff;
            border-radius: 50%;
            background-color: #4286F5;
        }
        .headList ul li .circular .pic{
            width: 24px;
            height: 24px;
            margin-top: 8px;
            margin-bottom: 8px;
        }
        .headList ul li .triangle{
            display: none;
            position: absolute;
            bottom:-25px;
            left: 50%;
            margin-left: -26px;
            width: 0;
            height: 0;
            border-left: 25px solid transparent;
            border-right: 25px solid transparent;
            border-bottom: 25px solid #fff;
        }
        /*显示隐藏*/
        .headList ul li .triangle.none{
            display: block;
        }
        .week{
            padding: 20px 10px 0 10px;
        }
        .week .weekContent li{
            padding: 10px;
            font-size: 13px;
            border-radius: 5px;
            border: 1px solid #E4E4E4;
        }
        .week .weekContent li .seqnumber{
            float: left;
            width: 8%;
            height: 100%;
        }
        .week .weekContent li .number{
            display: inline-block;
            width: 18px;
            height: 18px;
            color: #fff;
            line-height: 16px;
            font-style: normal;
            text-align: center;
            border: 2px solid #fff;
            border-radius: 50%;
            background-color: #2FBBE6;
        }
        .week .weekContent li  .textconernt{
            float: left;
            width: 90%;
        }
    </style>
    <!-- 头部导航 -->
    <div class="headList clearfix">
        <ul id="nav">
            <li>
                <div class="circular">
                    <img class="pic" src="/public/img/home/xlcweb/u48.png" alt="">
                    <div class="hint">1</div>
                </div>
                <p>本周</p>
                <div class="triangle none"></div>
            </li>
            <li>
                <div class="circular">
                    <img class="pic" src="/public/img/home/xlcweb/u30.png" alt="">
                    
                </div>
                <p>待办</p>
                <div class="triangle"></div>
            </li>
            <li>
                <div class="circular">
                    <img class="pic" src="/public/img/home/xlcweb/u35.png" alt="">
                    
                </div>
                <p>任务</p>
                <div class="triangle "></div>
            </li>
            <li>
                <div class="circular">
                    <img class="pic" src="/public/img/home/xlcweb/u14.png" alt="">
                    
                </div>
                <p>通知</p>
                <div class="triangle "></div>
            </li>
            <li>
                <div class="circular">
                    <img class="pic" src="/public/img/home/xlcweb/u19.png" alt="">
                   
                </div>
                 <p>日历</p>
                 <div class="triangle"></div>
            </li>
        </ul>
    </div>

    <!-- 本周内容 -->
    <div class="week">
        <ul class="weekContent">
            <li class="clearfix"> 
                <div class="seqnumber">
                    <i class="number">1</i>
                </div>
                <span class="textconernt">与重庆园博园进一步沟通，了解详细的项目需求</span>
            </li>
        </ul>

    </div>
</block>

<block name="footer_js">
    <script>
        // $(function(){
        //      $('#nav').find('li').click(function(){
        //         console.log($(this).index());
        //         $('#nav').find('li').removeClass('none');
        //         console.log(3213)
        //         $(this).addClass('none');
        //      })
        // })

    </script>
</block>