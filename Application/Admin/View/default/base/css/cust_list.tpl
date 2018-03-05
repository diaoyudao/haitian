<style>
.main-head{
            display: none;
        }

        .swiper-container1{
            overflow: hidden;
            font-size: 14px;
            color: #6B6B6B;
        }

        .swiper-container1 .glyphicon-star{
            margin-right: 5px;
            color: #688696;
        }

        .head_box{
            margin:0;
        }

        .head_box{
            /*border-bottom: 1px solid #e0e0e0;*/
            /*height: 76px;*/
        }

        .head_box .swiper-slide{
            width: 113px;
            height: 50px;
            line-height: 50px;
            /*text-align: center;*/
            position: relative;
            float: left;
            cursor: pointer;
            padding: 0;
            overflow: hidden;
        }

        .head_box .swiper-slide+.swiper-slide{
            margin-left: 30px;
        }

        .head_box .title{
            color: #688696;
            text-align: center;
        }

        .swiper-slide div{
            position: absolute;
            right: 0;
            top: 0;
            height: 50px;
            width: 25px;
            /*background: red;*/
            /*background: -moz-linear-gradient(left,transparent -100%,white 70%,white,white,white);*/
            background: -moz-linear-gradient(left,transparent -100%,white 55%);
        }
        .swiper-slide div span{
            top: 50%;
            margin-top: -6px;
            position: absolute;
            right: -1px;
        }
        .swiper-slide-line{
            border-bottom: 3px solid #688696;
        }

        .left_box{
            position:relative;
            float:left;
            width:185px;
            height: 658px;
            margin-right:-300px;
            background-color: #fff;
            padding-bottom: 200px;
            font-size:13px;
            color:#688696;
        }
        .examination_box,
        .lately_box{
            /*padding:30px 20px 10px 20px;*/
            padding-top:30px;
            padding-bottom:10px;
            border-bottom: 1px solid #e0e0e0;
        }

        .examination_box{
            padding-top:0;
        }

        .add_box{
            padding: 20px 30px;
            border-bottom: 1px solid #e0e0e0;
            color:#fff;
        }

        .add_box div{
            background-color: #2E8DED;
            text-align: center;
            height: 31px;
            line-height: 31px;
            border-radius: 3px;
            cursor: pointer;
        }

        .add_box div span{
            margin-right: 5px;
        }

        .examination_ul,
        .total_ul,
        .lately_ul{
            /*padding-left: 20px;*/
            margin-top: 15px;
        }
        .examination_ul{
            padding: 20px 0;
            margin-top: 0;  
        }
        .examination_ul li,
        .total_ul li,
        .lately_ul li{
            height: 40px;
            line-height: 40px;
            position: relative;
            cursor: pointer;
            padding: 0 20px;
        }

        .examination_ul li+li{
            margin-top: 10px;
        }

        img{
            width: 24px;
            height: 24px;
            position: relative;
            top: -1px;
        }

        .examination_ul img,
        .total_ul img{

            margin-right: 15px;
        }

        .examination_ul li .num{
            min-width: 20px;
            height:20px;
            text-align: center;
            line-height: 20px;
            /*border: 1px solid #000;*/
            background-color: #30baba;
            border-radius: 50%;
            color:#fff;
            display: block;
            float: right;
            margin-top:10px;
        }
        .total_ul li .num{
            /*color:#fff;*/
            width: 50px;
            /*margin-left: 50px;*/
            display: block;
            float: right;
            text-align: right;
        }

        .bg_color{
            background-color: #D0E4EE;
        }

        .right_box{
            float: right;
            width:100%;
        }
        .right_box_content{
            margin-left: 185px;
            background-color: #EEF5F9;
            min-height: 658px;
            padding:20px 5px 20px 20px;
        }

        .right_box_content .title{
            float: left;
            font-size: 16px;
            color: #688696;
        }

        .right_box_content .num{
            font-size: 13px;
        }

        .head-search{
            display: block;
            float: right;
            /*margin-right: 30px;*/
            color: #333;
            float: right;
            position: relative;
        }

        .head-input{
            position: relative;
            left: 0;
            width: 140px;
            height: 26px;
            border: 1px solid #ccc;
            border-radius: 15px;
            background-color: #fff;
            padding-left: 10px;
            padding-right: 20px;
        }

        .glyphicon-search{
            position: absolute;
            right: 7px;
            color: #999;
            top: 8px;
        }

        .list_table{
            border: 1px solid #ccc;
            padding: 20px;
            background-color: #fff;
            padding-bottom: 0;
        }
        .glyphicon-sort{
            color: #4AAFE4;
            top: 2px;
            margin-left: 5px;
        }



        .glyphicon-time{
            margin-left: 10px;
            color: #ff6633;
        }

        .recently_box{
            display: none;
        }

        .recently_box .table thead tr th{
            color: #A1A1A1; 
        }

        .abc_box{
            display: none;
        }

        .screen_box .list_table{
            height: 570px;
            padding:0;
            /*padding-top: 20px;*/
            font-size: 13px;
            overflow-x: visible;
           /* overflow-y: hidden;*/
            box-sizing: border-box;
        }

        .screen_box .list_table .top{
            border-bottom: 1px solid #ccc;
            color: #688696;
            overflow: hidden;
        }

        .screen_box .list_table .top p{
            float: left;
            padding-left: 20px;
            margin: 0;
            margin-bottom: 10px; 
        }

        .screen_box .list_table ul{
            height: 497px;
            float: left;
            border-right: 1px solid #ccc;
            overflow-y: scroll;
            overflow-x:visible;
            box-sizing: border-box;
        }

        .screen_box .list_table ul li{
            position: relative;
            padding:0 20px;
            display: block;
            height: 48px;
            line-height: 48px;
            width: 99%;
            left:0;
            border-bottom: 1px solid #ccc;
            overflow: hidden;
        }

        .screen_box .list_table ul li span:first-child{
            position: absolute;
            right: 42px;
        }

        .screen_box .list_table ul li .glyphicon-menu-right{
            position: absolute;
            height: 100%;
            line-height: 48px;
            right: 20px;
        }

        .screen_box .list_table ul li:last-child{
            /*border-bottom: none;*/
        }

        .abc_box .table tbody tr td {
            margin: 0;
            height: 50px;
            vertical-align: middle;
            font-size: 13px;
        }
        .abc_box .table thead tr th{
            font-size: 13px;
            color: #A1A1A1; 
        }

        .recently_box .table tbody tr td p {
            margin: 0;
            height: 40px;
            vertical-align: middle;
            font-size: 13px;
            line-height: 40px;
        }

        .recently_box .table tbody tr td p img{
            /*width: 16px;
            height: 16px;*/
            margin-right: 10px;
        }
        .recently_box .table tbody tr td:first-child p:first-child{
            font-size: 16px;
        } 

        .recently_box .table tbody tr td:first-child img:nth-of-type(2){
            margin-left: 20px;
        }
        .recently_box .table tbody tr td p:last-child{
            color:#688696;
        }

        .recently_box .table thead tr th{
            font-size: 13px;
            color: #A1A1A1; 
        }

        .screen_box ul li {
            cursor: pointer;
        }

        .screen_box ul li img{
            margin-right: 10px; 
        }
        
        .screen_box .top p:nth-child(2),
        .screen_box .top p:nth-child(3),
        .screen_box .top p:nth-child(4){
            display: none;
        }

        .city_ul,
        .Customer_ul,
        .area_ul{
            display: none;
        }
        .cust-sort{
            position: absolute;
            z-index:99;
            right: 0px;
            top:0;
            font-size:20px;
        }

</style>        