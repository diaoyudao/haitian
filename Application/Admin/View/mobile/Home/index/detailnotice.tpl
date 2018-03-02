<extend name="./Application/Admin/View/mobile/base/context/common-new.tpl"/>

<block name="common_css">

</block>
<block name="common_js">

</block>

<block name="head_left">
  <a onclick="removeIframe()"><img  class="head_left" src="/public/img/home/xlcweb/u608.png" alt="" /></a>
</block>


<block name="head_name">
  通知
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
    .body{
      padding:10px;
    }
    .body .title{
      line-height: 30px;
    }
    .mt{
      margin-top: 10px;
    }
    .mr{
      margin-right: 10px;
    }
    .body .content{
      font-size: 13px;
    }
  </style>
  <div class="body ">
    <!-- 标题 -->
    <div class="title">{$notice.title}</div>
    <!-- 个人信息 -->
    <div class="person mt"><span class="mr">{$notice.employee_name}</span><span>{$notice.create_time}</span></div>
    <!-- 通知内容 -->
    <div class="content mt">{$notice.context}</div>
  </div>
</block>

<block name="footer_js">
  <script>

  function removeIframe() {
    K.removeIframe();
  }
</script>
</block>