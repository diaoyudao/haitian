<extend name="./Application/Admin/View/default/base/context/common.tpl"/>
<block name="common_css">
    <link href="/public/swiper3.4.1/css/swiper.min.css" rel="stylesheet" type="text/css" />
    <link href="/public/css/work/examine/index.css" rel="stylesheet" type="text/css" />
</block>
<block name="common_js">
</block>

<block name="body_path_name">
        <span class="glyphicon glyphicon-arrow-left" style="margin-right: 10px" aria-hidden="true"></span>工作报告 > 详细报告
</block>

<block name="body_main">
<style>

</style>
<div class="body">
    <div class="swiper_box">
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                    <ul class="swiper-slide_ul">
                        <li>
                            <p>02月 第一周</p>
                            <p>2017/07/03-2017/07/09</p>
                        </li>
                        <li>
                            <p>4</p>
                            <p>区域转入项目</p>
                        </li>
                        <li>
                            <p>4</p>
                            <p>转公司处理项目</p>
                        </li>
                        <li>
                            <p>1 / 200</p>
                            <p>已签合同数/总规模（万）</p>
                        </li>
                        <li>
                            <p>1 / 150</p>
                            <p>待签合同数/总规模</p>
                        </li>
                    </ul>
                </div>
                <div class="swiper-slide">
                    <ul class="swiper-slide_ul">
                        <li>
                            <p>02月 第二周</p>
                            <p>2017/07/03-2017/07/09</p>
                        </li>
                        <li>
                            <p>4</p>
                            <p>区域转入项目</p>
                        </li>
                        <li>
                            <p>4</p>
                            <p>转公司处理项目</p>
                        </li>
                        <li>
                            <p>1 / 200</p>
                            <p>已签合同数/总规模（万）</p>
                        </li>
                        <li>
                            <p>1 / 150</p>
                            <p>待签合同数/总规模</p>
                        </li>
                    </ul>
                </div>
                <div class="swiper-slide">
                    <ul class="swiper-slide_ul">
                        <li>
                            <p>02月 第三周</p>
                            <p>2017/07/03-2017/07/09</p>
                        </li>
                        <li>
                            <p>4</p>
                            <p>区域转入项目</p>
                        </li>
                        <li>
                            <p>4</p>
                            <p>转公司处理项目</p>
                        </li>
                        <li>
                            <p>1 / 200</p>
                            <p>已签合同数/总规模（万）</p>
                        </li>
                        <li>
                            <p>1 / 150</p>
                            <p>待签合同数/总规模</p>
                        </li>
                    </ul>
                </div>
            </div>
            
            <!-- 如果需要导航按钮 -->
            <div class="swiper-button-prev" style="background: none;"><span class="glyphicon glyphicon-menu-left" aria-hidden="true" style="position: absolute;top:50%;margin-top:-6px;"></span></div>
            <div class="swiper-button-next" style="background: none;"><span class="glyphicon glyphicon-menu-right" aria-hidden="true" style="position: absolute;top:50%;margin-top:-6px;"></span></div>
            
        </div>
    </div>
    <div class="content_box">
        <div class="swiper-container1">
            <div class="swiper-wrapper head_box">
                <div class="swiper-slide bright">
                    <div class="line"></div><img class="head" src="/public/img/test/u1423.png" alt="">黄月英1
                </div>
                <div class="swiper-slide">
                    <div class="line"></div><img class="head" src="/public/img/test/u1423.png" alt="">黄月英2
                </div>
                <div class="swiper-slide ">
                    <div class="line"></div><img class="head" src="/public/img/test/u1423.png" alt="">黄月英3
                </div>
            </div>   
        </div>
        <div>
            <p class="week_content_title">本周工作内容</p>
            <table class="week_content table_box">
                <thead>
                    <tr>
                        <th>日期</th>
                        <th>分类</th>
                        <th>客户</th>
                        <th>联系人</th>
                        <th>工作内容</th>
                        <th>完成情况</th>
                        <th>具体情况</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="tr_border">
                        <td rowspan="2" class="date">07-23<br/>星期一</td>
                        <td><span class="emphasis follow_up">重点跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td>未完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                        </tr>
                        <tr>
                        <td><span class="routine follow_up">常规跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td class="complete">已完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                    </tr>
                    <tr class="tr_border">
                        <td rowspan="3" class="date week_background">07-24<br/>星期二</td>
                        <td><span class="bills follow_up">款项跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td>未完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                        </tr>
                        <tr>
                        <td><span class="emphasis follow_up">重点跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td class="complete">已完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                        </tr>
                        <tr>
                        <td><span class="emphasis follow_up">重点跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td>未完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                    </tr>
                    <tr class="tr_border">
                        <td rowspan="3" class="date">07-24<br/>星期三</td>
                        <td><span class="bills follow_up">款项跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td>未完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                        </tr>
                        <tr>
                        <td><span class="emphasis follow_up">重点跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td class="complete">已完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                        </tr>
                        <tr>
                        <td><span class="emphasis follow_up">重点跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td>未完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                    </tr>
                    <tr class="tr_border">
                        <td rowspan="1" class="date week_background">07-24<br/>星期四</td>
                        <td><span class="bills follow_up">款项跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td>未完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                    </tr>
                    <tr class="tr_border">
                        <td rowspan="3" class="date">07-24<br/>星期五</td>
                        <td><span class="bills follow_up">款项跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td>未完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                        </tr>
                        <tr>
                        <td><span class="emphasis follow_up">重点跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td class="complete">已完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                        </tr>
                        <tr>
                        <td><span class="emphasis follow_up">重点跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td>未完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                    </tr>
                    <tr class="tr_border">
                        <td rowspan="4" class="date week_background">07-24<br/>星期六</td>
                        <td><span class="bills follow_up">款项跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td>未完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                        </tr>
                        <tr>
                        <td><span class="emphasis follow_up">重点跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td class="complete">已完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                        </tr>
                        <tr>
                        <td><span class="emphasis follow_up">重点跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td>未完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                        </tr>
                        <tr>
                        <td><span class="emphasis follow_up">重点跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td>未完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                    </tr>
                    <tr class="tr_border">
                        <td rowspan="2" class="date">07-24<br/>星期七</td>
                        <td><span class="bills follow_up">款项跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td>未完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                        </tr>
                        <tr>
                        <td><span class="emphasis follow_up">重点跟进</span></td>
                        <td>重庆园博园</td>
                        <td><img class="head" src="/public/img/test/u1423.png" alt="">黄月英</td>
                        <td>七夕灯会</td>
                        <td class="complete">已完成</td>
                        <td>初次接触，介绍我司情况，并了解客户项目投标相关信息，获取招标书</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                    </tr>
                </tbody>
            </table>
            <p class="week_content_title">本周工作总结</p>
            <table class="week_summary table_box">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>本周工作计划</th>
                        <th>完成情况</th>
                        <th>未完成原因</th>
                        <th>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true" style="color: #000;padding-right: 20px"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="date">1</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet.</td>
                        <td>未完成</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing</td>
                    </tr>
                    <tr>
                        <td class="date">1</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet.</td>
                        <td>未完成</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing</td>
                    </tr>
                    <tr>
                        <td class="date">1</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet.</td>
                        <td>未完成</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing</td>
                    </tr>
                </tbody>
            </table>
            <p class="week_content_title">下周工作计划</p>
            <table class="next_week table_box">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>工作内容</th>
                        <th>备注</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="date">1</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet.</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td class="date">1</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet.</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td class="date">1</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet.</td>
                        <td>Lorem ipsum dolor sit amet, consectetur adipiscing</td>
                        <td>
                            <span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true"></span>
                            <ul class="screen_popup">
                                <li><span class="text" onclick="operation()">批复</span></li>
                            </ul>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</block>

<block name="footer_js">
<script type="text/javascript" src="/public/swiper3.4.1/js/swiper.min.js"></script>
<script>
function operation(){
        // layer_show("批复",'/service/work/examine/reply', 750, 500);
        layer_show("批复",'/service/work/examine/add', 750, 500);
}
window.onload = function() {
    var mySwiper = new Swiper ('.swiper-container', {
        direction: 'horizontal',
        loop: false,

        // 如果需要前进后退按钮
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',

    });
    var swiper = new Swiper('.swiper-container1', {
        pagination: '.swiper-pagination',
        slidesPerView: 'auto',
        paginationClickable: true,
        // spaceBetween: 30
    });
}
    function PeopleSwitch(){
        $(".swiper-container1 .swiper-slide").click(function(){
            $(".swiper-container1 .swiper-slide").removeClass("bright");
            $(this).addClass("bright");
        });
    };
    PeopleSwitch();

    function TableIcon(){
        $(".table_box .table_box_icon").click(function(){
            if($(this).siblings(".screen_popup").css("display")=="block"){
                $(this).siblings(".screen_popup").hide();
            }else{
                $(".table_box .screen_popup").hide();
                $(this).siblings(".screen_popup").show();
            }
        });
    }
    TableIcon();
</script>
</block>