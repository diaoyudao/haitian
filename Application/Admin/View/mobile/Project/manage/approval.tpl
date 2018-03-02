<extend name="./Application/Admin/View/mobile/base/context/common-new.tpl"/>
<block name="common_css">
	<link rel="stylesheet" type="text/css" href="/public/home/css/project/approval.css" />
</block>

<block name="head_left">
	<a onclick="removeIframe()"><img  class="head_left" src="/public/img/home/xlcweb/u608.png" alt="" /></a>
</block>

<block name="head_name">
	审核
</block>

<block name="body_main">
	<style>
		
	</style>
	<div class="body" style="position: fixed;width: 100%;top: 50px;bottom:0;padding-top: 10px;overflow-y: scroll;-webkit-overflow-scrolling:touch;">
		<div class="list clearFix"><span class="left">客户名称</span><span class="right">{$project.customer_name}</span></div>
		<div class="list clearFix"><span class="left">项目名称</span><span class="right">{$project.name}</span></div>
		<div class="list clearFix"><span class="left">项目时间</span><span class="right">{$project.begin_date}</span></div>
		<div class="list clearFix"><span class="left">项目规模</span><span class="right">{$project.scale_fee}万</span></div>
		<div class="list clearFix"><span class="left">项目状态</span><span class="right"><php>echo C('SON_STATUS_LIST')[$project['son_status']]</php></span></div>
		<div class="list clearFix"><span class="left width">项目情况</span><span class="right">{$project.context}</span></div>
		<div class="list clearFix">
			<div class="loading_box">
				<div class="mature-progress">
					<div class="mature-progress-bottom">

						<div class="mature-progress-box" id="mamture_progress">
							<span>提交</span>
							<span>审核</span>
							<span>审批</span>
							<span>分配</span>
							<span>完成</span>
							<div class="clear"></div>
							<div class="progress-box" id="progress_content" data-progress="<php>echo count($approve)</php>">
								<i class="progress-box-1"></i>
							</div>
							<foreach name="approve" item="v">
								<dl>
									<dd>
										<p><php>echo (new \DateTime($v['create_time']))->format('m-d')</php></p>
										<p><php>echo (new \DateTime($v['create_time']))->format('H:i')</php></p> 
									</dd>
								</dl>
							</foreach>
						</div>
						<div class="mature-progress-box bgtwos">
							<dl><dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl> <dl> <dt></dt> </dl>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="list clearFix"><span class="left">提交部门</span><span class="right">{$project.out_department_name}  {$approve[0].operator_name}</span>
		</div>

		<form class="form form-horizontal" id="form-notice-add" method="post">
			<if condition="'boss' == session('employee.role_type_code') && 2 == $project['approve_status']">
				<div class="list clearFix">			
					<span class="left" style="position: absolute;">转入部门</span>
					<div style="padding-left: 60px;">				
						<select name='handle_department_id'>
							<if condition="2 == $project['approve'] ">
								<volist name="department" id="item">
									<if condition="'information' == $item['department_type_id']">
										<option value="{$item.department_id}">{$item.name}</option>
									</if>
								</volist>
								<else/>
								<volist name="department" id="item">
									<if condition="$item['department_id'] != $project['out_department_id']">
										<option value="{$item.department_id}">{$item.name}</option>
									</if>
								</volist>
							</if>
						</select>
						<span style="position: absolute;right: 0;top: 10px;color:#4286F5;">选择部门</span>
					</div>
				</div>
			</if>
			<div class="list clearFix" style="border:none;">
				<textarea name="reply" id="" rows="3" style="width: 100%;resize:none;padding:5px 10px;border: 1px solid #E4E4E4;border-radius: 3px;" placeholder="批复内容（选填）"></textarea>
			</div>
			<div class="btn_box">
				<input onclick="Veto()" class="btn btn-default radius" type="button" value="否决">
				<input onclick="Agree()" class="btn btn-default radius" type="button" value="同意" style="background-color: #343643;color: #fff;">
			</div>
		</form>
	</div>
</block>

<block name="footer_js">
	<script>
		function removeIframe() {
			K.removeIframe();
		}
		// 进度条
		loading();
		function loading(){
			var num = $('.list').find('.loading_box').length;
			console.log('==',num)
			for(var i=0;i<num;i++){
				var lsg_number = $(".loading_box").eq(i).find('#progress_content').attr('data-progress');
				console.log(lsg_number);

				if ( lsg_number ==0 ) {
					$(".loading_box").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(1) dt").addClass('bgcolor');
				};

				if ( lsg_number ==1  ) {
					$(".loading_box").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(1) dt").addClass('bgcolor');
					$(".loading_box").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(2) dt").addClass('bgcolor');
					lsgload(i,55, '.progress-box-1');
				};

				if ( lsg_number ==2  ) {
					$(".loading_box").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(1) dt").addClass('bgcolor');
					$(".loading_box").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(2) dt").addClass('bgcolor');
					$(".loading_box").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(3) dt").addClass('bgcolor');
					lsgload(i,110, '.progress-box-1');
				};

				if ( lsg_number ==3  ) {
					$(".loading_box").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(1) dt").addClass('bgcolor');
					$(".loading_box").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(2) dt").addClass('bgcolor');
					$(".loading_box").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(3) dt").addClass('bgcolor');
					$(".loading_box").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl:nth-child(4) dt").addClass('bgcolor');
					lsgload(i,165, '.progress-box-1');
				};

				if ( lsg_number ==4) {
					$(".loading_box").eq(i).find(".mature-progress .mature-progress-bottom .bgtwos dl dt").addClass('bgcolor');
					lsgload(i,223, '.progress-box-1');
				};
			}
		}

		function lsgload(i,w, cls){
			console.log(1111111);
			$(".loading_box").eq(i).find(cls).css({
				width : w+'px'
			})
		}

		function Agree(){
			layer.open({
				title: '',
				content: '确定通过审核（审批）',
				btn: ['确定', '取消'],
				btn1: function(index){
					//弹窗确定按钮
					param = {}
					param.is_pass = 1;
					if('2' == '{$project.approve_status}') {
						param.handle_department_id = $('select[name=handle_department_id]').val()
					}
					saveNotice(param)
				}    
			});
		}
		function Veto(){
			layer.open({
				title: '',
				content: '确定要不予通过审核（审批）',
				btn: ['确定', '取消'],
				btn1: function(index){
					//弹窗确定按钮
					param = {}
					param.is_pass = 0;
					saveNotice(param)
				}    
			});
		}

		function saveNotice(param) {
			
			param.project_id = '{$project.project_id}';
			param.reply = $('textarea[name=reply]').val();            

			var url = '/service/project/manage/approve';

			K.doAjax(param, url, function(res){
				if (res.status && res.status == 'success') {	
					top.location.replace('/service?1');
					K.removeIframe()				
					console.log('over l ');					
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