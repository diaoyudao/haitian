<extend name="./Application/Admin/View/mobile/base/context/common-new.tpl"/>

<block name="common_css">

</block>
<block name="common_js">

</block>

<block name="head_left">
  <a onclick="removeIframe()"><img  class="head_left" src="/public/img/home/xlcweb/u608.png" alt="" /></a>
</block>


<block name="head_name">
  搜索
</block>

<block name="body_main">
  <style>	
    .search{
      position: relative;
      padding: 10px;
    }
    .search input{

      width: 100%;
      height: 60px;
      border: 0; 
      padding:10px 20px 0;
      line-height: 40px;
      border-bottom: 1px solid #E4E4E4;
    }
    .search .searchpic{
      position: absolute;
      top: 25px;
      right: 10px;  
      font-size: 20px;
      border:0;
      background-color: #fff;
    }
    .searchbox{
     margin-top: 30px;
     border: 1px solid #DDDDDD;
   }
   .searchbox #tab {
    width: 95%;
    margin: auto;
    border-bottom: 1px solid #DDDDDD;

  }

    .searchbox #tab li{
      float: left;
      width: 30%;
      height: 30px;
      line-height: 30px;
      text-align: center;
      color: #50BCC6;
     
    }
    .searchbox #tab li.bt{
      border-bottom: 3px solid #688696;
    }
    .searchcontent .box{
      display: none;
    }
    .searchcontent .box.block{
      display: block ;
    }
     .searchcontent .box ul{

      width: 95%;
      margin: auto;
      margin-bottom: 20px;
    }
    .searchcontent .box li{
      width: 100%;
      height: 30px;
      line-height: 30px;
      text-align: left;
      border-bottom: 1px solid #DDDDDD;
      
    }
    .searchcontent .box li span{
      display: inline-block;
      width: 30%;
      text-align: center;
    }
  </style>
  <div class="search">
    <form action="" method="get">
      <input type="text" name="name" placeholder="搜索客户名称、客户联络人">
      <button class="Hui-iconfont searchpic" type="submit">&#xe665;</button>
    </form>
    <!-- <php>var_dump($data);</php> -->
    <div class="searchbox cl">
        <ul id="tab" class="cl">
          <li class="bt">全部</li>
          <li>客户</li>
          <li>联系人</li>
        </ul>
        <div class="searchcontent">
          <div class="box all block">
            <ul>
             <volist name="data" id="item">
              <li>
                <span>{$item.type}</span>
                <span>
                  <if condition="'contact' neq $item['type']">
                    <a onclick="goTo('{$item.customer_id}','{$item.name}')">{$item.name}</a>
                  <else/>{$item.name}</if>
                </span>
                
              </li>
            </volist>
          </ul>
          </div>
          <div class="box customer">
            <ul>
            <volist name="data" id="item">
              <li>
                <if condition="'contact' neq $item['type']">
                <span>{$item.type}</span>
                <span><a onclick="goTo('{$item.customer_id}')">{$item.name}</a></span>
                </if>
              </li>
              </volist>
            </ul>
          </div>
          <div class="box contacts">
            <ul>
              <volist name="data" id="item">
               <if condition="'contact' eq $item['type']">
                <li>
                  <span>{$item.type}</span>
                  <span>{$item.type}</span>

                </li>
              </if>  
            </volist>
          </ul> 
        </div>
        </div>
    </div>
  </div>
</block>

<block name="footer_js">
  <script>
    $(function(){
        $('#tab').find('li').click(function () {
        var index = $(this).index();
        console.log(index);
        $('#tab').find('li').removeClass('bt');
        $(this).addClass('bt');
        $('.searchcontent').find('div').removeClass('block');
        $('.searchcontent').find('div').eq(index).addClass('block')
      })
    })
    function removeIframe() {
      K.removeIframe();
    }
    function goTo(cust_id,name) {
//    url = '/service/customer/search/detail?customer_id=' + cust_id
		window.parent.operation("", "/service/customer/search/detail?customer_id=" + cust_id+'&name='+name);
//    window.location.replace(url)
}
  </script>
</block>