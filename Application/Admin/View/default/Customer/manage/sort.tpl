<extend name="./Application/Admin/View/default/base/context/add.tpl"/>
<block name="common_css">

</block>
<block name="common_js">
</block>

<block name="body_main">
<style>
    .select-box-2{
            width:300px;height:120px !important;
            padding:0 10px;
            margin-top:0;
            overflow-x:auto;
            overflow-y:auto;
            border: 1px solid #e0e0e0;
            box-sizing: border-box;
            display: none;
        }
        .select-box-2 label{
            display: block;
            height:30px;
            line-height: 30px;
        }
        .select-box-2 label input{
            margin-right:10px;
        }
        .option-2{
            height:20px;
            line-height: 20px;
        }
        .btn{
            height:31px !important;
            font-size:14px !important;
        }
</style>
    <article class="page-container" >
        <form action="" method="post" id="add-form-post"> 
            <input type="hidden" id="customer_id" value="{$Think.get.id}">
            <input type="hidden" id="prev-cust-id">
          <div class="">          
            <p class="title">请选择期望位置的前一位客户</p>
            <p class="content">
            <input type="text" id="sort-input-cust" style="width:200px" class="input-text"><button class="btn btn-default radius ml-5" type="button" onclick="searchCust()">搜索</button>
            </p>
            <div id="sort-cust-list" class="select-box-2" >
              <label class="option-2" for="1"><input type="checkbox" value="" id="1">部门1</label>
              <label class="option-2" for="2"><input type="checkbox" value="" id="2">部门2</label>
            </div>
          </div>
          <div style="display: none;width:250px" id="txt-message">
            <div class="mt-25 pt-25 sort-txt">
            <p class="text-c">请确认，本客户将排到</p>
            <p class="text-c" id="sort-cust-name">***</p>
            <p class="text-c">之后一位！</p>
            </div>
          </div>  
          <div class="mt-20 pt-20">
            <button onclick="commit(1)" class="btn btn-primary radius" type="button">确认</button>
            <button onclick="K.removeIframe()" class="btn btn-default radius ml-10" type="button">取消</button>
            <button onclick="commit(2)" class="btn btn-primary radius ml-30" type="button">置顶</button>
          </div>
    </form> 
</article>
</block>
<block name="footer_js">
<script type="text/javascript">

function selectCust(me) {
    $("#sort-input-cust").val($(me).val());
    $("#prev-cust-id").val($(me).attr('id'));    
    $("#sort-cust-name").html($(me).val());

    $('#txt-message').show()
    $('#sort-cust-list').hide()
}

function searchCust() {
    if('' == $("#sort-input-cust").val()) {
        layer.msg('请先输入搜索条件！', {icon: 2, time: 2000});
        return;
    }
    var param = {}
    var url = '/service/customer/search/sortCust';

    param.name = $("#sort-input-cust").val();
    param.customer_id='{$Think.get.id}';
    param.type = '{$Think.get.ty}';

    K.doAjax(param, url,function(res){
        $('#txt-message').hide();
        $('#sort-cust-list').show();        
        $('#sort-cust-list').empty();
        if (res.status && res.status == 'success') {
            
            $.each(res.data, function(i,v) {
                var str = '<label class="option-2" for="1"><input onclick="selectCust(this)" type="checkbox" value="'+v.name+'" id="'+v.customer_id+'">'+v.name+'</label>';

                $('#sort-cust-list').append(str)
            })
        }
    });
}
 
function commit(tt) {
    if(1==tt && '' == $("#prev-cust-id").val()) {
        layer.msg('请先选择客户！', {icon: 2, time: 2000});
        return;
    }

    var param = {}
    param.customer_id = '{$Think.get.id}';
    param.prev_cust = $("#prev-cust-id").val();
    param.top = (2==tt)?1:0;
    param.type = '{$Think.get.ty}';

    var url = '/service/customer/manage/sort';

    K.doAjax(param, url,function(res){
        if (res.status && res.status == 'success') {
            //K.refreshParent()
            if('out' == '{$Think.get.t}') window.parent.setTypeList(4);
            else if('prov' == '{$Think.get.t}') window.parent.getProvLevel('{$Think.get.oid}');
            else if('city' == '{$Think.get.t}') window.parent.getCityLevel('{$Think.get.oid}');
            else if('county' == '{$Think.get.t}') window.parent.getCustList('{$Think.get.oid}');

            K.removeIframe();
        } else {
            if (res.message) {
                layer.msg(res.message, {icon: 2, time: 2000});
            } else {
                layer.msg('后台错误!', {icon: 2, time: 2000});
            }
        }
    });
}

</script>
</block>