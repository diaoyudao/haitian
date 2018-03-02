<extend name="./Application/Admin/View/default/base/context/common.tpl"/>
<block name="common_css">
    <link href="/public/swiper3.4.1/css/swiper.min.css" rel="stylesheet" type="text/css" />
    <link href="/public/css/work/manage/index.css" rel="stylesheet" type="text/css" />
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
        <select class="screen_department">
          <option value="volvo">2017年</option>
          <option value="saab">2016年</option>
          <option value="opel">2015年</option>
          <option value="audi">2014年</option>
        </select>
    </div>
    <div class="screen_box" style="padding-top: 0;margin-top: 20px;">
        <p class="title">1月</p>
        <ul>
            <li>
                <p>第一周</p>
                <div>
                    <img class="head" src="/public/img/test/u1423.png" alt="">
                    <p>黄月英</p>
                </div>
                <div>
                    <img class="head" src="/public/img/test/u1423.png" alt="">
                    <p>黄月英</p>
                </div>
                <div>
                    <img class="head" src="/public/img/test/u1423.png" alt="">
                    <p>黄月英</p>
                </div>
                <div>
                    <img class="head" src="/public/img/test/u1423.png" alt="">
                    <p>黄月英</p>
                </div>
                <div>
                    <img class="head" src="/public/img/test/u1423.png" alt="">
                    <p>黄月英</p>
                </div>
                <div>
                    <img class="head" src="/public/img/test/u1423.png" alt="">
                    <p>黄月英</p>
                </div>
            </li>
            <li>
                <p>第二周</p>
                <div>
                    <img class="head" src="/public/img/test/u1423.png" alt="">
                    <p>黄月英</p>
                </div>
                <div>
                    <img class="head" src="/public/img/test/u1423.png" alt="">
                    <p>黄月英</p>
                </div>
            </li>
        </ul>
        <p class="title">2月</p>
        <ul>
            <li>
                <p>第一周</p>
                <div>
                    <img class="head" src="/public/img/test/u1423.png" alt="">
                    <p>黄月英</p>
                </div>
                <div>
                    <img class="head" src="/public/img/test/u1423.png" alt="">
                    <p>黄月英</p>
                </div>
                <div>
                    <img class="head" src="/public/img/test/u1423.png" alt="">
                    <p>黄月英</p>
                </div>
                <div>
                    <img class="head" src="/public/img/test/u1423.png" alt="">
                    <p>黄月英</p>
                </div>
                <div>
                    <img class="head" src="/public/img/test/u1423.png" alt="">
                    <p>黄月英</p>
                </div>
                <div>
                    <img class="head" src="/public/img/test/u1423.png" alt="">
                    <p>黄月英</p>
                </div>
            </li>
        </ul>
    </div>
</div>
</block>

<block name="footer_js">
<script type="text/javascript" src="/public/swiper3.4.1/js/swiper.min.js"></script>
<script>
function operation(){
    layer_show("批复",'/service/work/examine/reply', 750, 500);
}

</script>
</block>