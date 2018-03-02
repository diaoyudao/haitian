<extend name="./Application/Admin/View/default/base/context/lists.tpl"/>
<block name="menu_title">搜索结果</block>

<block name="body_main">
<style>
.tabBar{
    border-bottom: 1px solid #e0e0e0
}
.tabBar span {
    background-color: #fff;
    cursor: pointer;
    display: inline-block;
    float: left;
    font-weight: normal;
    height: 45px;width: 70px;
    line-height: 45px;
    padding: 0 15px;
    text-align: center;
    color:#30baba;
}
.tabBar span.current{
    border-bottom: 3px solid #688696;
    background-color: #fff;
    color:#30baba;
}
.table  tr{
    height:60px;
    line-height: 60px;  
    text-align: left;
}
.table  tr .type{
    color:#30baba;  
    font-size:14px;
}
.table  tr .txt{
    color:#333;  
    font-size:14px;
    text-align: left;
}
.tabCon{
    margin-top:-1px;
    padding:0 20px;
    text-align: left;
}
</style>
<div class="page-container">
        <form class="form form-horizontal bk-gray pd-20 bg-fff" method="">
            <div class="text-l ">
                <input type="text" 
                    class="input-text" style="width:300px"
                     placeholder="搜索客户名称、联系人"
                           name="name"
                           value="{$Think.get.name}" />
                
                <button name="" class="btn btn-primary  radius ml-15" 
                type="button" onclick="resetCall()">&nbsp;搜索&nbsp;</button>
            </div>
        </form>
        <div class="mt-20 bk-gray pt-20 pb-20 bg-fff">
            <div id="tab_demo" class="HuiTab">
              <div class="tabBar clearfix" >
              <span onclick="callTab(0)" class="tab-head ml-20">全部</span>
              <span onclick="callTab(1)" class="tab-head">客户</span>
              <span onclick="callTab(2)" class="tab-head">联系人</span>
              </div>              
              <div class="tabCon">
                <if condition="empty(I('get.num')) || 0 == I('get.num')">
                <table class="table table-border ">
                    <tbody>
                    <volist name="data" id="item">
                      <tr class="text-l">                        
                        <td class="type" width="100">{$item.type}</td>
                        <td class="txt" width="200">                        
                        <a onclick="goTo('{$item.customer_id}')">
                        <if condition="'联系人' neq $item['type']">{$item.name}<else/>{$item.cust_name}</if>
                        </a>                        
                        </td>
                        <if condition="'联系人' eq $item['type']">
                        <td class="txt" width="100">{$item.name|default='未知'}</td>
                        <td class="txt" width="120">{$item.tel|default=''}</td>
                        <td class="txt">{$item.phone|default=''}</td>
                        </if>
                        <td class="txt"></td>
                      </tr>
                    </volist>
                    </tbody>
                </table>
                <div id="pager1" style="margin-top:5px; text-align:center;"></div>
                </if>   
              </div>
                         
              <div class="tabCon">
                  <if condition="1 == I('get.num')">
                  <table class="table table-border" >
                    <tbody>
                    <volist name="data" id="item">
                    <if condition="'联系人' neq $item['type']">
                      <tr class="text-l">                        
                        <td class="type" width="100">{$item.type}</td>
                        <td class="txt" ><a onclick="goTo('{$item.customer_id}')">{$item.name}</a></td>
                      </tr>
                    </if>
                    </volist>                   
                    </tbody>
                </table>
                <div id="pager2" style="margin-top:5px; text-align:center;"></div>
                </if>
              </div>             
              <div class="tabCon">
                <if condition="'2' == I('get.num')">
                  <table class="table table-border" >
                    <tbody>
                    <volist name="data" id="item">
                    <if condition="'联系人' eq $item['type']">
                      <tr class="text-l">
                        <td class="type" width="100">{$item.type}</td>
                        <td class="txt" width="100">{$item.cust_name}</td>
                        <td class="txt" width="100">{$item.name|default='未知'}</td>
                        <td class="txt" width="120">{$item.tel|default=''}</td>
                        <td class="txt">{$item.phone|default=''}</td>
                      </tr>
                    </if>
                    </volist>                   
                    </tbody>
                 </table>
                 <div id="pager3" style="margin-top:5px; text-align:center;"></div>
                 </if>
              </div>              
            </div>            
        </div>
</div>
</block>

<block name="footer_js">
    <script type="text/javascript">
function goTo(cust_id) {    
    url = '/service/customer/search/detail?customer_id=' + cust_id
    window.location.replace(url)
}
// 
var num = '{$Think.get.num|default=0}';

        $(function(){
          console.log('num',num)
          $.Huitab("#tab_demo .tabBar span","#tab_demo .tabCon","current","click",num);

            /*  分页 */        
          var name = $("input[name=name]").val();          

          var param = '&name=' + name + '&num=' + '{$Think.get.num|default=1}';
          var pg_t1 = '{$pager1_total|default=1}';
          var pg_t2 = '{$pager2_total|default=1}';
          var pg_t3 = '{$pager3_total|default=1}';
          console.log('pa2==',pg_t2)
          console.log('pa3==',pg_t3)
          if (0 == num && pg_t1 > 1) {
              PAGER.create(pg_t1, param, 'pager1');
          }
          if (1 == num && pg_t2 > 1) {
              PAGER.create(pg_t2, param, 'pager2');
          }
          if (2 == num && pg_t3 > 1) {
              PAGER.create(pg_t3, param, 'pager3');
          }

        });
  function resetCall() {
      var name = $("input[name=name]").val();
      if("" == name) {
        layer.msg('请输入搜索内容！', {icon: 2, time: 2000});
        return;
      }
      var url = "/service/system/search/index?name="+ name + '&num='+num;

      window.location.replace(url)
  }

  function callTab(tt) {
      num = tt;
      var name = $("input[name=name]").val();
      if("" == name) {
        layer.msg('请输入搜索内容！', {icon: 2, time: 2000});
        return;
      }

      var url = "/service/system/search/index?name="+ name + '&num='+tt; 
      window.location.replace(url)   
  }
</script>
</block>        