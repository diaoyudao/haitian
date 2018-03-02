<style>
.main-head{
			display: none;
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
			font-size: 24px;
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
			overflow : hidden;
			text-overflow: ellipsis;
			height: 120px;

			display: -webkit-box;
			-webkit-line-clamp: 2;
			-webkit-box-orient: vertical;

			display: -moz-box;
			-moz-line-clamp: 2!important;
			-moz-box-orient: vertical;
		}

		.info_situation p:last-child:after {
			background: linear-gradient(to right, rgba(255, 255, 255, 0), #FFFFFF 50%) repeat scroll 0 0 rgba(0, 0, 0, 0);
			bottom: 0;
			content: "...";
			padding: 0 5px 1px 30px;
			position: absolute;
			right: 0;
			top: 103px;
		}

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

		/*tbody带滚动条start*/
		.event_table th{
			color:#868686;
		}

		.event_table th,
		.event_table td{
			font-size: 13px;
			height: 36px;
			border-bottom: 1px solid #e0e0e0;
		}

		.event_table tbody{
			overflow-y: scroll;
		}

		.event_table tbody {
			display:block;
			height: 200px;
			overflow-y:scroll;
		}

		.event_table thead, 
		.event_table tbody tr {
			display:table;
			width:100%;
			/*table-layout:fixed;*/
		}

		.event_table thead tr th,
		.event_table tbody tr td{

		}

		.event_table thead tr th:first-child,
		.event_table tbody tr td:first-child{
			padding-left: 10px;
			width: 50px;
		}

		.event_table thead tr th:nth-child(2),
		.event_table tbody tr td:nth-child(2){
			width: 100px;
		}

		.event_table thead tr th:nth-child(3),
		.event_table tbody tr td:nth-child(3){
			width: 100px;
		}

		.event_table thead tr th:last-child,
		.event_table tbody tr td:last-child{
			white-space: nowrap;
			width: 50px;
		}

		.event_table tbody tr td:nth-child(5) i{
			font-size:18px;
			margin-left: 15px;
		}

		.event_table thead {
			width: calc( 100% - 1em );
		}
		.event_table .glyphicon-pencil{
			cursor: pointer;
			margin-left: 5px;
		}

		/*tbody带滚动条end*/	

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
		
		.info_event{
			margin-left: 0;
			height: inherit;
			border:none;
		}
		.event_table tbody{
			overflow-y: auto;
			height: inherit;
		}
		i{
			cursor: pointer;
		}
</style>