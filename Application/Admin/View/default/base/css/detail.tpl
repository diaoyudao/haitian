<style>
	.left_box{
		position:relative;
		float:left;
		width:250px;
		/*height: 500px;*/
		margin-right:-300px;
		background-color: #fff;
		padding-bottom: 200px;
		font-size:13px;
		color:#688696;
	}
	.right_box{
		float: right;
		width:100%;
	}
	.right_box_content{
		margin-left: 252px;
		background-color: #EEF5F9;
		min-height: 658px;
		padding:25px 30px;
	}

	.right_box_content .title{
		float: left;
		font-size: 16px;
		color: #688696;
	}

	.right_box_content .num{
		font-size: 13px;
	}
	.info_box{
		background-color: #F3F3F3;
		padding:20px;
		font-size: 13px;
		overflow: hidden;
	}

	.info_box p{
		margin: 0;
	}

	.info_box_top,
	.info_box_middle,
	.info_box_bottom{
		overflow: hidden;
	}

	.info_name{
		width: 280px;
		height:194px;
		border: 1px solid #ccc;
		background-color: #fff;
	}

	.info_situation{
		height: 194px;
		border: 1px solid #ccc;
		background-color: #fff;
		position: relative;
	}

	.info_label{
		width: 280px;
		height: 194px;
		border: 1px solid #ccc;
		background-color: #fff;
	}


	.left_box1{
		padding-bottom:0;
		margin-right: -280px;
	}
	.right_box1{
		/*height:194px;*/
	}
	.right_box_content1{
		margin-left: 300px;
		background-color: transparent;
		padding:0;
		min-height:0;
		overflow: hidden;
	}


	.left_box2{
		float: left;
		width: 100%;
	}

	.left_box_content2{
		margin-right: 300px;
	}

	.right_box2{
		float: right;
		margin-left: -280px;
	}

	.info_service{
		width: 280px;
		height: 300px;
		border: 1px solid #ccc;
		background-color: #fff;
		margin-top: 20px;
	}

	.info_contact{
		width: 280px;
		border: 1px solid #ccc;
		background-color: #fff;
		margin-top: 20px;
	}

	.info_event{
		height: 300px;
		border: 1px solid #ccc;
		background-color: #fff;
		margin-top: 20px;
		position: relative;
	}

	.box{
		padding:20px;	
		padding-top: 15px;
	}

	.info_name p:first-child{
		font-size: 18px;
	}

	.info_name .ce_icon{
		width: 18px;
		height: 18px;
		margin-left: 10px;
	}

	.info_name p+p{
		margin-top:15px; 
	}

	.info_name p span{
		margin-left: 10px;
		color: #797979;
	}

	.info_situation{
		color: #688696;
	}

	.info_situation p:first-child{
		font-size: 16px;
	}

	.info_situation p:last-child{
		position: relative;
		margin-top: 15px;
		height: 120px;

		display: -webkit-box;
		-webkit-line-clamp: 6;
		-webkit-box-orient: vertical;

		text-overflow:ellipsis;
		-o-text-overflow:ellipsis;
		overflow:hidden;


		/*-moz-binding:url('ellipsis.xml#ellipsis');*/
	}

	/*.info_situation p:last-child:after {
		background: linear-gradient(to right, rgba(255, 255, 255, 0), #FFFFFF 50%) repeat scroll 0 0 rgba(0, 0, 0, 0);
		bottom: 0;
		content: "...";
		padding: 0 5px 1px 30px;
		position: absolute;
		right: 0;
		top: 103px;
	}*/

	.head{
		width: 32px;
		height: 32px;
		margin-right: 5px; 
	}
	.info_event p:first-child,
	.info_service p:first-child,
	.info_contact p:first-child,
	.info_project p:first-child{
		font-size: 16px;
		color: #688696;
	}
	.info_service .title,
	.info_contact .title{
		margin-top: 10px;
		font-size: 12px;
		color: #3399CC;
		padding-left:5px;
	}

	.info_contact .title{
		margin-top: 20px;
	}

	.info_contact p:nth-child(2){
		margin-top: 10px;
	}


	.info_service .content,
	.info_contact .content{
		margin-top: 10px;
		padding-left:5px;
		font-size:14px;
	}

	.event_table {
		display: block;		
		overflow:hidden;
		border: none !important;
	}
	.event_table tbody {
		display: block;
		height:190px;
		overflow-y: auto;
	} 

	.event_table thead,
	.event_table thead tr{
		display: block;
		width:100%;
	}

	.event_table thead tr,
	.event_table tbody tr{
		border-top:none;
		border-bottom: 1px solid #e0e0e0;
	}

	.event_table thead tr td:nth-child(1),
	.event_table tbody tr td:nth-child(1){
		width: 8%;
	}

	.event_table thead tr td:nth-child(2),
	.event_table tbody tr td:nth-child(2){
		width: 15%;
	}

	.event_table thead tr td:nth-child(3),
	.event_table tbody tr td:nth-child(3){
		width: 15%;
	}

	.event_table thead tr td:nth-child(4),
	.event_table tbody tr td:nth-child(4){
 		width: 67%;
	}
	.event_table thead tr td:nth-child(5),
	.event_table tbody tr td:nth-child(5){
		white-space: nowrap;
		width: 8%;
	} 

	.event_table tbody tr td:nth-child(5) i{
		font-size:18px;
		margin-left: 15px;
	} 


	.project_table thead tr th:nth-child(1),
	.project_table tbody tr td:nth-child(1){
		white-space: inherit;
		min-width: 50px;
	}

	.project_table thead tr th:nth-child(2),
	.project_table tbody tr td:nth-child(2){
		white-space: inherit;
	}

	.project_table thead tr th:nth-child(3),
	.project_table tbody tr td:nth-child(3){
		 white-space: inherit;
	}

	.project_table thead tr th:nth-child(4),
	.project_table tbody tr td:nth-child(4){
		 white-space: inherit;
	}

	.project_table thead tr th:nth-child(5),
	.project_table tbody tr td:nth-child(5){
		 max-width: 250px;
		 white-space: inherit;		 
	}
	.project_table tbody tr td:nth-child(5) span{
		 height: 100px;
		 overflow-y: auto;	
		 overflow-x:hidden;	 
		 display: block;
	}

	.project_table thead tr th:nth-child(6),
	.project_table tbody tr td:nth-child(6){
		 white-space: inherit;
	}

	.project_table thead tr th:nth-child(7),
	.project_table tbody tr td:nth-child(7){		
		 white-space: inherit;
	}
	.project_table thead tr th:nth-child(8),
	.project_table tbody tr td:nth-child(8){
		white-space: inherit;
	}
	.project_table thead tr th:nth-child(9),
	.project_table tbody tr td:nth-child(9){
		width: 18px;
	}

	.event_table .glyphicon-pencil{
		margin-left: 5px;
	}

	/*tbody´ø¹ö¶¯Ìõend*/

	.info_project,
	.info_records{
		border: 1px solid #ccc;
		background-color: #fff;
		margin-top: 20px;
		position: relative;
	}

	.project_table tr, 
	.records_table tr{
		font-size: 13px;
		min-height: 36px;
		border-bottom: 1px solid #e0e0e0;
	}

	.bottom_table thead tr th,
	.bottom_table tbody tr td{
		font-size: 13px;
		white-space:nowrap ;
		height: 60px;
		padding-right: 10px;
		vertical-align: middle;
	}

	.bottom_table thead tr th{
		height: 30px;
		color: #868686;
	}

	.bottom_table thead tr th,
	.bottom_table tbody tr td{
		padding: 10px 0;
		padding-right: 10px;
	}

	.records_table tbody tr td:nth-last-child(3){
		white-space: inherit;
	}

	.records_table tbody tr td:nth-child(3){
		line-height: 60px;
	}

	.add_records{
		display:inline-block;
		padding:2px 10px;
		border-bottom: 1px solid #e0e0e0;
		color:#fff;
		margin-top: 10px;
		background-color: #2E8DED;
		text-align: center;
		border-radius: 3px;
		cursor: pointer;
	}

	.records_table tbody tr td:nth-child(5) img{
		width: 18px;
		height: 18px;
	}

	.records_table tbody tr td p img{
		width: 32px;
		height: 32px;
		margin-right: 5px; 
	}

	.records_table .reply{
		margin-top: 5px;
		color: #FF6633;
	}
	.glyphicon-pencil{
		cursor: pointer;
	}
	.info_contact .content  .name_tel_box{
		padding-left: 42px;
		position: relative;
	}

	.info_contact .content  .name_tel_box .head{
		position: absolute;
		top: 50%;
		left: 0;
		margin-top: -16px;
	}
	.info_contact .content  .name_tel_box .name_tel{
		display: inline-block;
		font-size: 13px;
	}

	.info_contact .content  .name_tel_box .name_tel p{
		font-size: 13px;
		margin-bottom: -5px;
		color: #1E1E1E;
		width: 160px;
	}


	.info_contact .content  .name_tel_box .name_tel span:nth-of-type(1){
		color: #797979;
	}
	.info_contact .content  .name_tel_box .name_tel span:nth-of-type(2){
		position: absolute;
		margin-top: 4px;
		right: 0;
	}
	.info_contact .content  .name_tel_box .name_tel span:nth-of-type(2) img{
		width: 18px;
		height: 18px;
		cursor: pointer;
	}
	.info_contact .content  .name_tel_box .name_tel p span{
		color: #993333 !important;
		margin-left: 10px; 
	}

	.table_box_top{
		overflow: hidden;
		margin-bottom:10px;
		font-size: 16px;
		color: #688696;
	}
	.table_box_title{
		font-size: 16px;
		color:#688696;
	}
	.table_box_icon{
		float:right;
		cursor: pointer;
		margin-top: 5px;
	}

	.screen_popup{
		position: absolute;
		right: 20px;
		border: 1px solid #e0e0e0;
		/*width: 120px;*/
		padding: 25px 0;
		background-color: #fff;
		display: none;
		z-index: 1;
	}
	.screen_popup li{
		/*padding-left: 20px;*/
		position: relative;
		cursor: pointer;
		color: #688696;
	}

	.screen_popup li .glyphicon{
		position: absolute;
		left: 30px;
		top: 4px;	
		/*display: none;*/
		cursor: default;
	}
	.screen_popup li+li{
		margin-top: 20px;
	}

	.screen_popup li .text{
		margin-left: 50px;
		margin-right: 30px;
	}
	.info_label .icon_box p{
		display: inline-block;
		background-color: #688696;
		color: #fff;
		padding: 2px 5px;
		margin-top: 10px;
	}
	.info_label .icon_box p+p{
		margin-left: 5px;
	}

	.info_label .icon_box p span{
		margin-left: 5px; 
	}

	.records_table thead tr th:nth-child(1), 
		.records_table tbody tr td:nth-child(1){
			width: 30px;
		}
		.records_table thead tr th:nth-child(2), 
		.records_table tbody tr td:nth-child(2){
			width: 80px;
		}
		.records_table thead tr th:nth-child(3), 
		.records_table tbody tr td:nth-child(3){
			width: 110px;
		}
		.records_table thead tr th:nth-child(4), 
		.records_table tbody tr td:nth-child(4){
			min-width: 60px;
			white-space: inherit;
		}
		.records_table thead tr th:nth-child(6), 
		.records_table tbody tr td:nth-child(6){
			width: 140px;
		}
		.records_table thead tr th:nth-child(7), 
		.records_table tbody tr td:nth-child(7){
			width: 20px;
		}
		.cust-p-n{
			position: absolute; 
			font-size:24px;
			font-weight: 600;
			display:none;
			width:275px;
			left:1px;
			color:#bbb ;
		}
		.cust-prev{
			display: inline-block;
			position: absolute;
			left:0;
			cursor: pointer;
		}
		.cust-next{
			display: inline-block;
			position: absolute;
			right:0;
			cursor: pointer;
		}
		.page-head{
    width:100%;
    height:60px;line-height: 60px;
    background-color: #fff;
    border-bottom: 1px #ccc solid;
    box-shadow: 0 3px 3px #ccc;
    font-size:16px;
    color:#30baba;
}
.page-head .title{
    margin-left: 20px;
}
i{
	cursor: pointer;
}
</style>