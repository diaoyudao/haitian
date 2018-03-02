<?php if (!defined('THINK_PATH')) exit();?><!--_meta 作为公共模版分离出去-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <LINK rel="Bookmark" href="/favicon.ico" >
    <LINK rel="Shortcut Icon" href="/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="/public/css/lsg-main/main.css">
    <link rel="stylesheet" type="text/css" href="/public/bootstrap-3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/Hui-iconfont/1.0.7/iconfont.css" />
    
	<!-- <link href="/public/css/customer/search/detail.css" rel="stylesheet" type="text/css" /> -->

    



    <!--/meta 作为公共模版分离出去-->
    <title>后台管理</title>
    <meta name="keywords" content="后台管理系统模版">
    <meta name="description" content="后台管理系统模版">
    <style>
        body{
            background-color: #eee;
        }
        .main-head{
            width:100%;
            height:60px;
            line-height: 60px;
            background-color: #fff;
            color:#30baba;
            font-size:16px;
            padding-left: 30px;
            margin:0;
            border-bottom: 1px #ccc solid;
            box-shadow: 0 3px 3px #ccc;
        }
    </style>
</head>
<body>

<div class="main-head">
    
	客户详情

</div>
<!-- body_main 自定义页面内容 **begin** -->

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
		width: 14px;
		height: 14px;
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

	<style>
		<?php if(1 != I('get.one')): ?>.main-head{
			display: none;
		}<?php endif; ?>
		
	</style>


	<div class="info_box">
		<div class="info_box_top ">
			<div class="info_name left_box left_box1 box" onmouseover="showPN(1)" onmouseout="showPN(0)">
				<div class="cust-p-n">
				<?php if(!empty($prev_cust)): ?><i onclick="callNextCust(<?php echo ($prev_cust["customer_id"]); ?>,'<?php echo ($prev_cust["name"]); ?>','<?php echo ($prev_cust["is_vip"]); ?>')" class="Hui-iconfont cust-prev">&#xe67d;</i><?php endif; ?>
				<?php if(!empty($next_cust)): ?><i onclick="callNextCust(<?php echo ($next_cust["customer_id"]); ?>,'<?php echo ($next_cust["name"]); ?>','<?php echo ($next_cust["is_vip"]); ?>')" class="Hui-iconfont cust-next">&#xe63d;</i><?php endif; ?>
				</div>
				<p class="text-c"><?php echo ($data["name"]); ?></p>
				<p>
					<?php if('1' == $data['is_vip']): ?><img src="/public/img/admin/vip.png" alt=""><?php endif; ?>
					<?php if('1' == $data['is_send']): ?><img class="ce_icon" src="/public/img/test/u8957.png" alt=""><?php endif; ?>
				</p>
				<p><img src="/public/img/project/address_icon.png" alt=""><span><?php if(4 == $data['type']): ?>海外，<?php echo ($data["address"]); else: ?>中国<?php if(!empty($data["province_name"])): ?>，<?php echo ($data["province_name"]); endif; if(!empty($data["city_name"])): ?>，<?php echo ($data["city_name"]); endif; if(!empty($data["county_name"])): ?>，<?php echo ($data["county_name"]); endif; if(!empty($data["address"])): ?>，<?php echo ($data["address"]); endif; endif; ?></span></p>
				<p><img src="/public/img/project/<?php echo (1==$data['type']?'gov_icon.png':(2==$data['type']?'ScenicSpot_icon.png':(3==$data['type']?'enterprise.png':(5==$data['type']?'prise.png':(4==$data['type']?'overseas.png':'other.png'))))) ?>" alt=""><span><?php switch($data["type"]): case "1": ?>政府单位<?php break;?>
					<?php case "2": ?>旅游景区<?php break;?>
					<?php case "3": ?>国有企业<?php break;?>
					<?php case "5": ?>民营企业<?php break;?>
					<?php case "4": ?>海外客户<?php break;?>
					<?php case "0": ?>其他<?php break; endswitch;?></span></p>
			</div>
			<div class="right_box right_box1">
				<div class="right_box_content right_box_content1">
					<div class="left_box2">
						<div class="left_box_content2 info_situation box">
							<div class="table_box_top">
								<span class="table_box_title">基本情况</span>
									<span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true" ></span>
							</div>
							
							<ul class="screen_popup">
								<li><span class="glyphicon glyphicon-pencil check-mark"></span><span class="text" onclick="LsgLayerShow('客户资料','/service/customer/manage/change?customer_id=<?php echo ($data["customer_id"]); ?>', 820, 500,80)">编辑资料</span></li>
							</ul>
							
							<p class="text_desc"><textarea style="width:100%;height:120px;border:none;resize:none" readonly="readonly"><?php echo ($data["desc"]); ?></textarea></p>
						</div>
					</div>
					<div class="right_box2 info_label box">
						<div class="table_box_top">
							<span class="table_box_title">标签</span>
						</div>
						<input type="text" id="cust-tag" placeholder="输入标签,回车添加" style="height: 37px;width: 100%;padding: 0 10px;border: 1px solid #e0e0e0;" onkeydown="callTags(event)"/>
						<div class="icon_box" id="cust-tags-list">
							<?php if(is_array($data["tags"])): $i = 0; $__LIST__ = $data["tags"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><p><?php echo ($item); ?><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></p><?php endforeach; endif; else: echo "" ;endif; ?>							
						</div>
					</div>			
				</div>
			</div>
		</div>
		<div class="info_box_middle">
			<div class="info_service left_box left_box1 box">
				<div class="table_box_top">
					<span class="table_box_title">业务员</span>
					<?php if('director' == session('employee.role_type_code') || 'boss' == session('employee.role_type_code')): ?><span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true" ></span><?php endif; ?>
				</div>
				<ul class="screen_popup">
					<li><span class="glyphicon glyphicon-plus check-mark"></span><span class="text" <?php if('director' == session('employee.role_type_code')): ?>onclick="LsgLayerShow('业务人员','/service/customer/manage/employee?id=<?php echo ($data["customer_id"]); ?>', 400, 510,200)"<?php endif; ?> <?php if('boss' == session('employee.role_type_code')): ?>onclick="LsgLayerShow('业务人员','/service/customer/manage/departemployee?id=<?php echo ($data["customer_id"]); ?>', 400, 510,200)"<?php endif; ?> >业务员</span></li>
				</ul>
				<?php if(is_array($data["employee"])): $i = 0; $__LIST__ = $data["employee"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><p class="title"><?php echo ($key); ?></p>
					<p class="content">
						<?php if(is_array($item)): $i = 0; $__LIST__ = $item;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item2): $mod = ($i % 2 );++$i;?><!--<img class="head" src="<?php echo ($item2["thumbnail_url"]); ?>" alt="<?php echo ($item2["name"]); ?>" title="<?php echo ($item2["name"]); ?>">-->
							<span style="margin-right: 6px;"><?php echo ($item2["name"]); ?></span><?php endforeach; endif; else: echo "" ;endif; ?>
					</p><?php endforeach; endif; else: echo "" ;endif; ?>						
			</div>
			<div class="right_box right_box1">
				<div class="right_box_content right_box_content1 info_event box">
					<div class="table_box_top">
						<span class="table_box_title">客户大事件</span>
						<span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true" onclick=""></span>
					</div>
					<ul class="screen_popup">
							<li><span class="glyphicon glyphicon-pencil check-mark"></span><span class="text" onclick="LsgLayerShow('客户大事件','/service/customer/search/addevent?id=<?php echo ($data["customer_id"]); ?>', 650, 430,200)">添加事件</span></li>
						<li onclick="All('/service/customer/search/allevent?id=<?php echo ($data["customer_id"]); ?>')"><span class="glyphicon glyphicon-fullscreen check-mark"></span><span class="text" >全屏浏览</span></li>
					</ul>			
					<table class="event_table  table" border="0">
						<thead>
							<tr>
								<td >序号</th>
								<td >添加时间</th>
								<td >事件时间</th>
								<td >事件内容</th>
								<td > </th>
							</tr>
						</thead>
						<tbody id="event-list">
							
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="info_box_bottom ">
			<div class="info_contact left_box left_box1 box">
				<!-- <p><span>联系人</span><span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true" onclick="PopupShow()"></span></p> -->
				<div class="table_box_top">
					<span class="table_box_title">联系人</span>
						<span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true" ></span>
				</div>
				
				<ul class="screen_popup">
					<li><span class="glyphicon glyphicon-plus check-mark"></span><span class="text" onclick="LsgLayerShow('联系人管理','/service/customer/manage/contactsort?id=<?php echo ($data["customer_id"]); ?>',  620, 550,200)">联系人管理</span>
					</li>
					<!-- <li>
					<span style="margin-left:30px;"><i class="Hui-iconfont cust-sort" style="font-weight:700">&#xe675;</i></span><span class="text" style="margin-left:8px;" onclick="LsgLayerShow('联系人排序','/service/customer/search/contactsort?id=<?php echo ($data["customer_id"]); ?>', 700, 450,100)">联系人排序</span>
					</li> -->
				</ul>

				<?php if(is_array($data["contact"])): $i = 0; $__LIST__ = $data["contact"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><p class="title"><?php echo ($key); ?></p>
					<div class="content">
						<?php if(is_array($item)): $i = 0; $__LIST__ = $item;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item2): $mod = ($i % 2 );++$i;?><div class="name_tel_box">
								<img class="head" src="<?php echo ($item2["thumbnail_url"]); ?>" alt="">
								<div class="name_tel">
									<p <?php if(($item2["is_important"]) == "1"): ?>style="color: red;"<?php endif; ?>>
										<?php if(!empty($item2["name"])): echo ($item2["name"]); else: ?>未知<?php endif; if(!empty($item2["position"])): ?>，<?php echo ($item2["position"]); endif; if(!empty($item2["function"])): ?>，<?php echo C('CONTACT_FUNCTION')[$item2['function']]; endif; if('0' == $item2['status']): ?>（已离职）<?php endif; ?>
									</p>
									<span><?php if(!empty($item2["phone"])): $temp_phone=str_replace(',' ,'<br>' ,$item2['phone']);echo $temp_phone; else: if(!empty($item2["tel"])): $temp_tel=str_replace(',', '<br>',$item2['tel']);echo $temp_tel; else: ?>电话未知<?php endif; endif; ?></span>
										<span><img src="/public/img/test/u9008.png" alt="" onclick="LsgLayerShow('联系人名片','/service/customer/search/addcard?contact_id=<?php echo ($item2["customer_contact_id"]); ?>', 620, 620,200)"></span>

								</div>
							</div><?php endforeach; endif; else: echo "" ;endif; ?>
					</div><?php endforeach; endif; else: echo "" ;endif; ?>				
			</div>
			<div class="right_box right_box1">
				<div class="right_box_content right_box_content1">
					<div class="box info_project">
						<div class="table_box_top">
							<span class="table_box_title">客户项目</span>
							<span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true" onclick=""></span>
						</div>
						<ul class="screen_popup">

								<li><span class="glyphicon glyphicon-pencil check-mark"></span><span class="text" onclick="LsgLayerShow('项目详情','/service/customer/search/addproject?id=<?php echo ($data["customer_id"]); ?>', 800, 550,50)">新增项目</span></li>

							<li onclick="All('/service/customer/search/allproject?id=<?php echo ($data["customer_id"]); ?>')"><span class="glyphicon glyphicon-fullscreen check-mark"></span><span class="text">全屏浏览</span></li>
						</ul>		
						<table class="project_table bottom_table">
							<thead>
								<tr>
									<th>项目名称</th>
									<th>展出时间<span onclick="orderProject(0)" class="glyphicon glyphicon-sort" aria-hidden="true" style="color: #1296DB"></span></th>
									<th>展出规模<span onclick="orderProject(1)" class="glyphicon glyphicon-sort" aria-hidden="true" style="color: #1296DB"></span></th>									
									<th>资金形式</th>
									<th>项目情况</th>
									<th>制作公司</th>
									<th>项目等级</th>
									<th>项目状态</th>									
									<th></th>
								</tr>
							</thead>
							<tbody id="project-list">
								
							</tbody>
						</table>

					</div>
						<div class="box info_records ">
							<div class="table_box_top">
								<span class="table_box_title">联络记录</span>
								<span class="glyphicon glyphicon-option-vertical table_box_icon" aria-hidden="true" ></span>
							</div>
							<ul class="screen_popup">
								<!-- <li><span class="glyphicon glyphicon-time check-mark"></span><span class="text" onclick="LsgLayerShow('新定时提醒','/service/customer/search/addtiming', 800, 500,400)">新增提醒</span></li> -->
								<li onclick="All('/service/customer/search/allliaison?id=<?php echo ($data["customer_id"]); ?>')"><span class="glyphicon glyphicon-fullscreen check-mark"></span><span class="text">全屏浏览</span></li>
							</ul>

								<div style="margin:10px 0 ">
									<div class="add_records" onclick="LsgLayerShow('联络记录','/service/customer/search/addliaison?id=<?php echo ($data["customer_id"]); ?>', 800, 460,400)">
										<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增记录
									</div>
								</div>	
		
							<table class="records_table bottom_table">
								<thead>
									<tr>
										<th>序号</th>
										<th>联络时间</th>
										<th>联络客户</th>
										<th>相关事宜</th>
										<th>联络内容</th>
										<th>负责人</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="liaison-list">

								</tbody>
							</table>
							<div id="liaison-pager" class="mt-25 text-c" ></div>
							<div class="clear"></div>
						</div>
				</div>

			</div>

		</div>
	</div>

<!-- body_main 自定义页面内容 **end** -->
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="/public/huiadmin/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/public/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="/public/huiadmin/static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/jquery.validation/1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/jquery.validation/1.14.0/messages_zh.min.js"></script>
<script type="text/javascript" src="/public/js/lib/common-1.js"></script>

<!-- footer_js 自定义javascript **begin** -->

	<script>
		var customer_id = '<?php echo ($data["customer_id"]); ?>';
		
		$(function(){

			$(".info_box").click(function(){
				$(".screen_popup").hide();
			});

			$(".table_box_icon").click(function(e){
				e.stopPropagation();
				if($(this).parent().siblings(".screen_popup").css("display")=="none"){
					$(this).parent().siblings(".screen_popup").show();					
				}else{
					$(this).parent().siblings(".screen_popup").hide()
				}
			});	

			// 异步加载大事件
			callEvent()
			// 异步加载项目
			callProject()
			// 异步加载联络记录
			callLiaison()

			
			console.log('1==',document.body.scrollHeight)

			//父级iframe自适应子页面高度
			parent.document.getElementById("main-iframe").height=0;
			parent.document.getElementById("main-iframe").height=document.body.scrollHeight+20;

			setTimeout(function(){console.log('2==',document.body.scrollHeight)},3000);  

			$("#event-list").scroll(function(){  
				topCall(this, callEvent)
			});  
			$("#project-list").scroll(function(){  
				topCall(this, callProject)
			});
		})

		// 编辑资料
		function LsgLayerShow(title,url,w,h,y){
			$(".screen_popup").hide();
			var const_top = 70
			var p_h = $(parent.window).height() - const_top	
			var p_t = $(parent.document).scrollTop() 
			var o_y = p_t - const_top
			//console.log(p_h,h,p_t,o_y)
			p_h += ((const_top < p_t)?const_top:(0 < p_t?(const_top-p_t):0)) - 20
			
			o_y = (const_top>p_t)?10:(p_t-const_top+10)
			if(h>p_h) {
				h = p_h
			} else {
				o_y += (p_h -h)/2	
			}
			//console.log(p_h,h,p_t,o_y)
			layer.open({
				type: 2,
				area: [w+'px', h +'px'],
				fix: false, //不固定
				maxmin: true,
				shade:0.4,
				title: title,
				content: url,
				offset: o_y+'px',
				cancel: function(){
				    if("undefined" != typeof $dp) {
				    	$dp.hide();
				    }				    
			    }				
			});
		}

		function fullLayerShow(title,url,w,h,y){
			K.showFullSonPage(title,url)
			
		}

		function All(url){
			window.open(url); 
		}

		function topCall(me, callfunc) {	
			 viewH =$(me).height(),//可见高度  
			 contentH =$(me).get(0).scrollHeight,//内容高度  
			 scrollTop =$(me).scrollTop();//滚动高度  
			//if(contentH - viewH - scrollTop <= 100) { //到达底部100px时,加载新内容  
			if(scrollTop/(contentH -viewH)>=0.95){ //到达底部100px时,加载新内容  
				if($is_loading) return;
				callfunc()
			}  
		}		

function callTags(e) {  
	//网页内按下回车触发
	if(e.keyCode==13) {
		if("" != $('#cust-tag').val()) {
			var str = $('#cust-tag').val();
			var parameter={
				customer_id: customer_id,
				tags: str
			}
			var url = '/service/customer/manage/tags';
			K.doAjax(parameter, url, function(response) {
				if(response.status && 'success' == response.status) {
					$('#cust-tags-list').append('<p>'+ str +'<span class="glyphicon glyphicon-remove" aria-hidden="true"></span></p>');
				} else {
					console.log(4444);
					//layer.msg('失败:'+response.message, {icon: 5, time: 2000});
				}
			});
		}
	}
}

var $is_loading=false;
var event_pg =1;
var project_pg =1;
var liaison_pg =1;
var event_total=null;
var project_total=null;
var liaison_total=null;
var page_size = <?php echo (C("ONE_PAGE_SIZE")); ?>;  // 每页数量，和后台对应

function callEvent() {
	if(null != event_total && (1 == event_total || event_total<event_pg)) {
		return;
	}

	var param={}
	param.pg = event_pg;
	param.customer_id = '<?php echo ($data["customer_id"]); ?>';
	var url = '/service/customer/search/event';
	$is_loading = true;
	K.doAjax(param, url, function(response) {
		if(response.status && 'success' == response.status) {
			event_total = response.total_page;
			if(event_total >= event_pg) {				
				event_pg++;
			}
			console.log('event_pg==',event_pg)
			showEventList(response)
			$is_loading = false;
		} else {
			$is_loading = false;
		}
	},function(e){
		$is_loading = false;
	});
}	
function callProject(param) {
	if(null != project_total && (1 == project_total || project_total<project_pg)) {
		return;
	}
	var param = param || {}
	param.pg = project_pg;
	param.customer_id = '<?php echo ($data["customer_id"]); ?>';
	var url = '/service/customer/search/project';
	$is_loading = true;
	K.doAjax(param, url, function(response) {
		if(response.status && 'success' == response.status) {
			project_total = response.total_page;
			if(project_total >= project_pg) {				
				project_pg++;
			}
			console.log('project_pg==',project_pg)
			showProjectList(response) 
			$is_loading = false;           
		} else {
			$is_loading = false;
		}
	},function(e){
		$is_loading = false;
	});
}
function callLiaison() {
	if(null != liaison_total && liaison_total<liaison_pg) {
		return;
	}
	var param={}
	param.pg = liaison_pg;
	param.customer_id = '<?php echo ($data["customer_id"]); ?>';
	var url = '/service/customer/search/liaison';
	K.doAjax(param, url, function(response) {
		if(response.status && 'success' == response.status) {
			if(liaison_total != response.total_page && 1 < response.total_page) {
				laypage({cont:"liaison-pager",pages:response.total_page,curr:1,
					jump:liaisonPage
				});
				liaison_pg = 1
			}
			liaison_total = response.total_page;

			showLiaisonList(response)  

			//父级iframe自适应子页面高度
			parent.document.getElementById("main-iframe").height=0;
			parent.document.getElementById("main-iframe").height=document.body.scrollHeight+20;
		} 
	});
}
function liaisonPage(obj) {
	if(liaison_pg == obj.curr) return;
	liaison_pg = obj.curr
	callLiaison()
}
function showEventList(res) {
	var init_pg = event_pg-1;
	$.each(res.data, function(i,v){
		var str = '<tr class="">';
		str += '<td>'+ (i+1+((init_pg - 1)*page_size)) +'</td>';
		str += '<td>'+ v.create_time +'</td>';
		str += '<td>'+ v.occur_time +'</td>';
		str += '<td>'+ v.context +'</td>';
		str += '<td><span class="glyphicon glyphicon-pencil" aria-hidden="true"  onclick="LsgLayerShow(\'客户大事件\',\'/service/customer/search/addevent?event_id='+v.customer_event_id+'\', 650, 450,200)"></span><i onclick="delList(\'delevent\','+v.customer_event_id+')" class="Hui-iconfont">&#xe6e2;</i></td></tr>';

		$('#event-list').append(str);
	})
}
function showProjectList(res) { // 项目名称、展出时间、展出规模、资金形式、项目情况、制作公司、项目等级、项目状态
	var init_pg = project_pg-1;
	$.each(res.data, function(i,v){
		var str = '<tr class="tr_border">';
		str += '<td><a onclick="LsgLayerShow(\'查看项目详情\',\'/service/customer/search/addproject?r=1&project_id='+v.project_id+'\', 800, 550,50)">'+ v.name +'</a></td>';
		str += '<td>'+ (v.begin_date?v.begin_date:'') +' - ' + (v.end_date?v.end_date:'') +'</td>';
		str += '<td>'+ v.scale_fee +'</td>';
		str += '<td>'+ (v.fee_type?v.fee_type:'') +'</td>';
		str += '<td ><span>'+ (v.context?v.context:'') +'</span></td>';
		str += '<td>'+ (v.company?('本公司'!= v.company?(v.other_company):oper_show(v.company,v.common_company)):'') +'</td>';
		str += '<td>'+ (v.level?('Z' == v.level?'普通':(v.level+'级')):'') +'</td>';		
		str += '<td>'+ v.status_name +'</td>';		

		if('本公司' != v.company || 'boss' == '<?php echo ($_SESSION['employee']['role_type_code']); ?>' || (((2 >= v.status && 'information' == '<?php echo ($_SESSION['employee']['department_type_id']); ?>') || (2 < v.status && 'business' == '<?php echo ($_SESSION['employee']['department_type_id']); ?>')))) {
			str += '<td><span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="LsgLayerShow(\'项目详情\',\'/service/customer/search/addproject?project_id='+v.project_id+'\', 800, 550,50)"></span><i onclick="delList(\'delproj\','+v.project_id+')" class="Hui-iconfont ml-10" style="font-size:16px;">&#xe6e2;</i></td></tr>';
		}else{
			str += '<td></td></tr>'
		}
		$('#project-list').append(str);    	
	})
}
function showLiaisonList(res) {
	$('#liaison-list').empty()

	$.each(res.data, function(i,v){
		var str = '<tr class="tr_border">';
		str += '<td>'+ (i+1) +'</td>';
		str += '<td>'+ (v.liaison_time) +'</td>';
		if(v.contact_name)
			str += '<td><img class="head" src="'+v.contact_url+'" alt="">'+v.contact_name+'，'+v.contact_department+'</td>';
		else str += '<td></td>';
		str += '<td>'+ (v.outline?v.outline:'') +'</td>';
		str += '<td><p>'+ ((1 == v.important)? ('<img src="/public/img/test/u8862.png" alt="">') :'')+ (v.context?v.context:"") +'</p>'+(v.reply?('<p class="reply">批复：'+v.reply+'</p>'):'')+'</td>';
		str += '<td><img class="head" src="'+v.employee_url+'" alt="">'+v.employee_name+'</td>';

		str += '<td><span class="glyphicon glyphicon-pencil" aria-hidden="true" onclick="LsgLayerShow(\'联络记录\',\'/service/customer/search/addliaison?liaison_id='+v.customer_liaison_id+'\', 800, 820,400)"></span><i onclick="delList(\'delliaison\','+v.customer_liaison_id+')" class="Hui-iconfont ml-10" style="font-size:16px;">&#xe6e2;</i></td></tr>';		

		$('#liaison-list').append(str);    	
	})
}

function delList(func, id) {
    var title = '确认要删除？';

    layer.confirm(title, {
      btn: ['确认', '取消'] //可以无限个按钮      
    }, function(index, layero){
        window[func](id)
        layer.close(index);
    }, function(index){
        layer.close(index);
    });

}

function delevent(id) {
	var param={
		customer_event_id: id
	}
	var url = '/service/customer/manage/delevent';
	K.doAjax(param, url, function(res) {
		if(res.status && 'success' == res.status) {
			// 异步加载大事件
			event_total = null;
			event_pg=1;
			$('#event-list').empty();
			callEvent()
		} else {
			layer.msg('失败:'+(res.message?res.message:''), {icon: 2, time: 2000});
		}
	});
}
function delproj(id) {
	var param={
		project_id: id
	}
	var url = '/service/project/manage/del';
	K.doAjax(param, url, function(res) {
		if(res.status && 'success' == res.status) {
			// 异步加载项目
			project_total = null;
			project_pg=1;
			$('#project-list').empty();
			callProject()
		} else {
			layer.msg('失败:'+(res.message?res.message:''), {icon: 2, time: 2000});
		}
	});
}
function delliaison(id) {
	var param={
		customer_liaison_id: id
	}
	var url = '/service/customer/manage/delliaison';
	K.doAjax(param, url, function(res) {
		if(res.status && 'success' == res.status) {
			// 异步加载联络记录
			liaison_total = null;
			liaison_pg=1;
			$('#liaison-list').empty();
			callLiaison()
		} else {
			layer.msg('失败:'+(res.message?res.message:''), {icon: 2, time: 2000});
		}
	});
}

var order_proj = [['begin_date','begin_date desc'],['scale_fee','scale_fee desc']];
var sort_proj = 0;
function orderProject(t) {
	console.log('==',t)
	var param = {}
	param.order = order_proj[t][sort_proj];
	project_pg = 1;
	project_total = null;
	$('#project-list').empty(); 
	sort_proj = (1== sort_proj? 0 :1);

	callProject(param)
}

function callNextCust(id,name,is_vip) {
	try {
		K.doAjax({customer_id:id},'/service/customer/manage/history',function(res){});
	} catch(e){		
	}

	if("1" == "<?php echo ($_GET['one']); ?>") {
		window.location.href='/service/customer/search/detail?one=1&customer_id='+id;
	} else {
		window.parent.addTab(id,name,is_vip);
	}	
}
function showPN(t) {
	if(1 == t)
		$('.cust-p-n').show();
	else
		$('.cust-p-n').hide();
}
function oper_show(company,common_company) {
	return company + (common_company?(','+common_company):'')
}

</script>

<!--/footer_js 自定义javascript **end** -->

</body>
</html>