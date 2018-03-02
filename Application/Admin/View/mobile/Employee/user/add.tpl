<extend name="./Application/Admin/View/mobile/base/context/common-new.tpl"/>

<block name="common_css">

</block>
<block name="common_js">

</block>

<block name="head_left">
  <a onclick="removeIframe()"><img  class="head_left" src="/public/img/home/xlcweb/u1489.png" alt="" /></a>
</block>


<block name="head_name">
  我的
</block>

<block name="body_main">
  <style>	
    .bodycontent{
     padding: 10px;
     height: 100%;
   }
   .headpic{
     width: 65px;
     height: 65px;
     border-radius: 50%;
     border: 1px solid #E7E7E7;
     text-align: center;
     overflow: hidden;
     background-color: #F2F2F2;
     margin:20px auto;

   }
   .headpic img{
    width: 100%;

  }
  .information{
    width: 100%;
  }
  .information li{
    width: 100%;
    height: 40px;
    font-size: 14px;
    color: #868686;
    line-height: 40px;
    padding-left: 10px;
    border-bottom: 1px solid #E4E4E4;
  }
  .information li .left{
    margin-right: 20%;

  }
  .information li .modify{
    color: #4286F5;
  }
  .out{
    position: absolute;
    bottom: 20px;
    width: 95%;
    margin: auto;
    height: 40px;
    line-height: 40px;
    border-radius: 5px;
    background-color: #E4E4E4;
    text-align: center;
  }
  .password{
    padding: 10px 10px 10px 10px;
  }
  .password .list{
    margin-top: 30px;
  }
  .password input{
    width: 260px;
    height: 35px;
    line-height: 35px;
    margin-left: 20px;
    border: 1px solid #E4E4E4;
  }
  .optic{
    opacity: 0;
  }
  .none{
    display: none;
  }
  .password .goback{
    width:100px;
    margin: auto;
    margin-top: 20px;
    height: 40px;
    line-height: 40px;
    border-radius: 5px;
    background-color: #E4E4E4;
    text-align: center;
  }
</style>
<div class="bodycontent">
 <div class="headpic">
  <img src="/public/img/home/xlcweb/u1465.png" alt="">
</div>

<!-- 基本信息 -->
<ul class="information">
  <li><span class="left">姓名</span><span class="right">{$Think.session.employee.name}</span></li>
  <li><span class="left">部门</span><span class="right">{$Think.session.employee.department_name}</span></li>
  <li><span class="left">账号</span><span class="right">{$Think.session.employee.phone}</span></li>
  <li><span class="left">密码</span><span class="right modify" >修改</span></li>
</ul>

<!-- 退出登陆 -->
<a href="/service/login/employee/login"><div class="out">退出</div></a>
</div>

<!-- 修改密码 -->
<div class="password none">
  <div class="list">
   <span>旧密码<i class="optic">一</i></span>
   <input type="password" name="old-passwd">
 </div>
 <div class="list">
   <span>新密码<i class="optic">一</i></span>
   <input type="password" name="new-passwd">
 </div>
 <div class="list">
   <span>确认密码</span>
   <input type="password" name="new-passwd2">
 </div>
 <div class="goback" onclick="commit()">保存</div>
</div>
</block>

<block name="footer_js">
  <script>
    function removeIframe() {
      K.removeIframe();
    }
    $(function(){
     $('.modify').click(function(){
      $(".password").removeClass('none');
      $('.bodycontent').addClass('none');
    })
     $('.goback').click(function(){
      $(".bodycontent").removeClass('none');
      $('.password').addClass('none');
    })
   })

    function commit() {
      var new_pwd = $('input[name=new-passwd]').val()
      var new_pwd2 = $('input[name=new-passwd2]').val()
      var old_pwd = $('input[name=old-passwd]').val()
      if("" == new_pwd || "" == new_pwd2 || "" == old_pwd) {
        layer.msg('所有选项都不能为空!', {icon: 2, time: 2000});
        return;
      }
      if(new_pwd != new_pwd2) {
        layer.msg('新密码和确认密码必须相同!', {icon: 2, time: 2000});
        return;
      }
      var rex = /[0-9A-Za-z!@#\$%\^&\*]{8,20}/g;
      if(!new_pwd.match(rex)) {
        layer.msg('密码须大于7位，可含数字和字母!', {icon: 2, time: 3000});
        return;
      }
      if(new_pwd == old_pwd) {
        layer.msg('新密码和旧密码不能相同!', {icon: 2, time: 2000});
        return;
      }

      var param = {}
      var url = "/service/employee/password/change";

      param.old_passwd = old_pwd
      param.new_passwd = new_pwd
      K.doAjax(param, url, function(response) {
        if (response.status && response.status == 'success') {
                layer.msg('保存成功!', {icon: 1, time: 2000});
              } else {
                if (response.message) {
                  layer.msg(response.message, {icon: 2, time: 2000});
                } else {
                  layer.msg('后台错误!', {icon: 2, time: 2000});
                }
              }
          });
    }

 </script>
</block>