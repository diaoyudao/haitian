<extend name="./Application/Admin/View/mobile/base/context/common.tpl"/>
<block name="common_css">

</block>
<block name="common_js">

</block>



<block name="body_main">
    <style>

        .head_box{
            width: 100%;
            height: 50px;
            background-color: #343643;
            position: relative;
            text-align: center;
            line-height: 50px;
            color: #fff;
            font-size: 16px;
        }
        .head_left,
        .head_right{
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
        }
        .head_left{
            left: 20px;
        }

        .head_right{
            right: 20px;
        }
        .nav_bar{
            position: fixed;
            bottom: 0;
            width: 100%;
            height: 60px;
            padding: 4px 0;
            border-top: 1px solid #C9C9C9;
            background-color: #fff;
        }
        .nav_bar ul{
            overflow: hidden;
        }
        .nav_bar ul li{
            float: left;
            width: 25%;
            text-align: center;
        }
        .nav_bar ul li p{
            font-size: 13px;
        }

        .nav_bar ul .checked{
            color: #4286F5;
        }   

        .body_main{
        }

        .nav_bar .Hui-iconfont{
            font-size: 20px;
        }
        #main-iframe{
            width: 100%;
        }

        .modal-me{
            position: fixed;
            z-index:100;
            width:100%;
            height:100%;
            background-color:rgba(255,255,255,0.5);  
            display: none;            
        }

        .modal-me .loading-me{
            position:absolute;
            top:50%;
            left:50%;
            margin-top:-15px;
            margin-left:-15px;                
        }

        .modal-me .loading-me .loading-img {
            width:30px;height:30px;
            display: block;
        }
    </style>
    <!-- loading div -->
        <div id="modal-demo-loading-me" class="modal-me" >
            <div class="loading-me">
                <img class="loading-img" src="/public/huiadmin/static/h-ui/images/loading-b.gif">
            </div>
        </div>

    <iframe id="main-iframe" scrolling="yes" frameborder="0" src="/service/home/index/index"></iframe>


    <div class="nav_bar">
        <ul>
            <li class="checked">
                <i class="Hui-iconfont Hui-iconfont-home"></i>
                <p>首页</p>
            </li>
            <li>
                <i class="Hui-iconfont Hui-iconfont-order"></i>
                <p>申请</p>
            </li>
            <li>
                <i class="Hui-iconfont Hui-iconfont-middle"></i>
                <p>项目</p>
            </li>
            <li>
                <i class="Hui-iconfont Hui-iconfont-user"></i>
                <p>客户</p>
            </li>
        </ul>
    </div>
</block>

<block name="footer_js">
    <script>
        $(function(){
            var url = location.search;   
            console.log(url);
            if (url.indexOf("?") != -1) {  
                var str = url.substr(1,1); 
                var li=url.substr(3,3); 
                console.log(str) ;
                console.log("li",li) ;
                if(str==0){
                    $("#main-iframe").attr("src","/service/home/index/index?"+li);
                    $(".nav_bar ul li").removeClass("checked");
                    $(".nav_bar ul li").eq(str).addClass("checked");
                }else if(str==1){
                    $("#main-iframe").attr("src","/service/project/manage/approve");
                    $(".nav_bar ul li").removeClass("checked");
                    $(".nav_bar ul li").eq(str).addClass("checked");
                }else if(str==2){
                    $("#main-iframe").attr("src","/service/project/manage/index");
                    $(".nav_bar ul li").removeClass("checked");
                    $(".nav_bar ul li").eq(str).addClass("checked");
                }else if(str==3){
                    $("#main-iframe").attr("src","/service/customer/manage/list");
                    $(".nav_bar ul li").removeClass("checked");
                    $(".nav_bar ul li").eq(str).addClass("checked");
                }
            }else{
                $(".nav_bar ul li").removeClass("checked");
                $(".nav_bar ul li").eq(0).addClass("checked");
            }
            document.getElementById("main-iframe").height=0;
            document.getElementById("main-iframe").height = window.innerHeight-60;  
            $(".nav_bar ul li").click(function(){
                $(".nav_bar ul li").removeClass("checked");
                $(this).addClass("checked");
                $(this).addClass("checked");
                if($(this).index()==0){
                    $("#main-iframe").attr("src","/service/home/index/index");
                    // location.href="/service?0"
                }else if($(this).index()==1){
                    $("#main-iframe").attr("src","/service/project/manage/approve");
                    // location.href="/service?1"
                }else if($(this).index()==2){
                    $("#main-iframe").attr("src","/service/project/manage/index");
                    // location.href="/service?2"
                }else if($(this).index()==3){
                    $("#main-iframe").attr("src","/service/customer/manage/list");
                    // location.href="/service?3"
                }
            }); 

            $('#modal-demo-loading-me').width($(window).width());
            $('#modal-demo-loading-me').height($(window).height());
        })

        function operation(e,n){
            var t = layer.open({type: 2, title: e, content: n,closeBtn: 0});
            layer.full(t)
        }

        function loading_show() {
                $('#modal-demo-loading-me').modal({backdrop: 'static', keyboard: false});
            }

            function loading_hide() {
                setTimeout("$('#modal-demo-loading-me').modal('hide')", 1000)
            }


    </script>
</block>