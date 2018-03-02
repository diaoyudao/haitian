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
        .body .inputbox{
            width: 300px;
            height: 35px;
            border: 1px solid #E4E4E4;
        }
        .ml{
            margin-left: 20px;
        }
        .mb{
            margin-bottom: 20px;
        }
       .body  textarea{
            width: 100%;
            resize:none;
        }
        .body .posa{
            position: absolute;
            width: 80%;
            bottom: 30px;
            left: 35px;
        }
    </style>
   <div class="body">
           

     <form  class="form form-horizontal" id="form-notice-add" action="" method=""> 
        <!-- <p class="title">通知标题</p> -->
        <label class="tab-line mb">通知标题</label>   
        <p class="mb"><input class="inputbox" name="title" type="text"></p>
         <if condition="session('employee')['role_type_code'] eq 'boss'">
         <label class="tab-line mb">通知部门</label>
        <br>
             <p class="mb" id="department">
                 <volist name="department" id="item">
                     <label><input name="department_id" type="checkbox" value="{$item.department_id}" />{$item.name} </label>
                 </volist>
             </p>
         </if>

       <label class="tab-line mb">通知内容</label>  
       <textarea name="context" id="" cols="30" rows="10"></textarea>
       <div class="row cl posa">
        <div class="">
            <button class="btn btn-primary radius" type="button" onclick="saveNotice()">发布
            </button>
            <button  onclick="removeIframe()" class="btn btn-default radius" type="button">
                &nbsp;&nbsp;取消
                &nbsp;&nbsp;</button>
            </div>
        </div>
    </form>

        
          
   </div>
</block>

<block name="footer_js">
    <script>
        function saveNotice() {
			var url = '/service/home/index/addnotice';
            var param={};
            var department_id=[];
            if($('#department').length >0){
				$.each($('input:checkbox:checked'),function(){
					department_id.push($(this).val())
				});
			}else {
				department_id=['{$Think.session.employee.department_id}'];
			}
			param.department_id=department_id;
			param.title=$('input[name=title]').val();

			param.context=$('textarea[name=context]').val();
		    K.doAjax(param, url);
		}

		function removeIframe() {
			K.removeIframe();
		}
    </script>
</block>