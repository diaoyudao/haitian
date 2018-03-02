<?php if (!defined('THINK_PATH')) exit();?><!--_meta 作为公共模版分离出去-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <LINK rel="Bookmark" href="/favicon.ico" >
    <LINK rel="Shortcut Icon" href="/favicon.ico" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="/public/huiadmin/lib/html5.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/respond.min.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/PIE-2.0beta1/PIE_IE678.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/Hui-iconfont/1.0.7/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/lib/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="/public/huiadmin/static/h-ui.admin/css/style.css" />
    
    <link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/public/bootstrap-time/css/bootstrap-datetimepicker.min.css">
    <link href="/public/css/customer/search/addproject.css" rel="stylesheet" type="text/css"/>

    <!--[if IE 6]>
    <script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <!--/meta 作为公共模版分离出去-->
    <title>后台管理</title>
    <meta name="keywords" content="后台管理系统模版">
    <meta name="description" content="后台管理系统模版">
</head>
<body>
<!-- body_main 自定义页面内容 **begin** -->

    <style>
        table tr td {
            width: 150px;
            padding-right: 10px;
            padding-bottom: 10px;
        }

        table tr td input {
            width: 100% !important;
        }

        table tr td span {
            font-size: 18px;
            margin-left: 10px;:
        }

        .lsglabel {
            margin-right: 20px;
            height: 20px;
            line-height: 20px;
            font-weight: 500;
        }

        .other-cust {
            width: 170px;
            height: 150px;
            overflow: auto;
        }

        .other-cust-li {
            height: 30px;
            line-height: 30px;
            white-space: nowrap;
        }

        .other-cust-li span {
            max-width: 135px;
            height: 30px;
            overflow: hidden;
            display: inline-block;
        }

        .search-img {
            position: relative;
            left: -25px;
            cursor: pointer;
        }

        .other-cust-box {
            position: absolute;
            left: 570px;
            top: 0;
        }

        .select-box-2 {
            width: 170px;
            height: 105px !important;
            padding: 0 10px;
            margin-top: 0;
            overflow-y: auto;
            border: 1px solid #e0e0e0;
            box-sizing: border-box;
            display: none;
        }

        .select-box-2 label {
            display: block;
            height: 30px;
            line-height: 30px;
            font-weight: 500;
        }

        .select-box-2 label input {
            margin-right: 10px;
        }

        input[type=radio] {
            vertical-align: top;
        }

        .option-2 {
            height: 20px;
            line-height: 20px;
        }

        .item-w {
            width: 170px !important;
        }

        .line-block {
            display: inline-block;
        }
    </style>
    <div class="body">
        <form action="" method="post" id="add-form-post">
            <input type="hidden" name="project_id" value="<?php echo ($project["project_id"]); ?>"/>
            <input type="hidden" name="customer_id" value="<?php echo ($customer_id); ?>"/>
            <input type="hidden" name="approve_type" value=""/>
            <input type="hidden" name="other_company" value=""/>
            <input type="hidden" name="in_department_id" value=""/>
            <input type="hidden" name="reply" value=""/>
            <input type="hidden" name="other_cust" value=""/>
            <?php if(1 == I('get.hm')): ?><div style="">
                    <div class="line-block" style="margin-top: 0;vertical-align: top">
                        <p class="title">客户名称</p>
                        <p class="content" style="">
                            <input class="input_text" name="customer_hm" style="width:150px;" readonly="readonly"/>
                        </p>
                    </div>
                    <div class="line-block ">
                        <p class="title">搜索</p>
                        <p class="content">
                            <input class="input_text ml-15" id="other-cust-search1" style="width:100px"/>
                            <i class="Hui-iconfont search-img" onclick="searchCust(1)">&#xe665;</i>
                        </p>
                        <div id="sort-cust-list1" class="select-box-2">
                            <label class="option-2" for="1"><input type="checkbox" value="" id="1">部门1</label>
                            <label class="option-2" for="2"><input type="checkbox" value="" id="2">部门2</label>
                        </div>
                    </div>
                </div><?php endif; ?>
            <div style="position:relative;">
                <div class="line-block" style="margin-top: 0;vertical-align: top">
                    <p class="title">项目名称</p>
                    <p class="content"><input class="input_text item-w" name="name" value="<?php echo ($project["name"]); ?>" type="text">
                    </p>
                </div>
                <div class="line-block ml-15 " style="margin-top: 0;vertical-align: top">
                    <p class="title">展出时间</p>
                    <p class="content">
                        <input type="text" name="begin_date" value="<?php echo ($project["begin_date"]); ?>" id="d-begin-date"
                               placeholder="开始时间" class="input-text" style="width:82px;height:37px"/>~
                        <input type="text" name="end_date" value="<?php echo ($project["end_date"]); ?>" id="d-end-date"
                               placeholder="结束时间" class="input-text" style="width:82px;height:37px"/>
                    </p>
                </div>
                <div class="line-block ml-15 ">
                    <p class="title">搜索</p>
                    <p class="content">
                        <input class="input_text item-w" id="other-cust-search2" style="width:100px"/>
                        <i class="Hui-iconfont search-img" onclick="searchCust(2)">&#xe665;</i>
                    </p>
                    <div id="sort-cust-list2" class="select-box-2">
                        <label class="option-2" for="1"><input type="checkbox" value="" id="1">部门1</label>
                        <label class="option-2" for="2"><input type="checkbox" value="" id="2">部门2</label>
                    </div>
                </div>
                <div class="other-cust-box">
                    <p class="title">项目关联客户列表</p>
                    <div class="content bk-gray other-cust" id="other-cust">
                        <?php if(is_array($other_cust)): $i = 0; $__LIST__ = $other_cust;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$it): $mod = ($i % 2 );++$i;?><div class="other-cust-li" id="<?php echo ($it["customer_id"]); ?>">
                                <span class="ml-10"><?php echo ($it["name"]); ?></span><span><i
                                            class="Hui-iconfont ml-5 c-red">&#xe706;</i></span>
                            </div><?php endforeach; endif; else: echo "" ;endif; ?>
                    </div>
                </div>

            </div>
            <div style="">

                <div class="line-block ">
                    <p class="title">项目类型</p>
                    <div class="content">
                        <select class="screen_department item-w" name="proj_type">
                            <?php if(is_array($models)): $i = 0; $__LIST__ = $models;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><option value="<?php echo ($item["model_config_id"]); ?>"
                                <?php if($item['model_config_id'] == $project['proj_type']): ?>selected<?php endif; ?>
                                ><?php echo ($item["name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                        </select>
                    </div>
                </div>
                <div class="line-block ml-15">
                    <p class="title">展出规模(万)</p>
                    <div class="content">
                        <input style="width: 100px;" class="input_text item-w" name="scale_fee"
                               value="<?php echo ($project["scale_fee"]); ?>" type="text">
                    </div>
                </div>

                <div class="line-block ml-15">
                    <p class="title">展出场地</p>
                    <div class="content">
                        <input class="input_text item-w" name="address" value="<?php echo ($project["address"]); ?>" type="text">
                    </div>
                </div>
                <div class="line-block">

                </div>
            </div>
            <div>
                <div class="line-block ">
                    <p class="title">时段</p>
                    <div class="content">
                        <label class="lsglabel"><input name="time_type" type="radio" value="0"
                            <?php if(empty($project['time_type'])): ?>checked<?php endif; ?>
                            />平时 </label>
                        <label class="lsglabel"><input name="time_type" type="radio" value="1"
                            <?php if('1' == $project['time_type']): ?>checked<?php endif; ?>
                            />春节 </label>
                    </div>
                </div>

                <div class="line-block  ml-15">
                    <p class="title">是否售票</p>
                    <div class="content">
                        <label class="lsglabel"><input name="is_ticket" type="radio" value="0"
                            <?php if(empty($project['is_ticket'])): ?>checked<?php endif; ?>
                            />否 </label>
                        <label class="lsglabel"><input name="is_ticket" type="radio" value="1"
                            <?php if('1' == $project['is_ticket']): ?>checked<?php endif; ?>
                            />是 </label>
                    </div>
                </div>
                <div class="line-block ml-15">
                    <p class="title">运营方案</p>
                    <div class="content">
                        <input class="input_text item-w" name="programme" value="<?php echo ($project["programme"]); ?>" type="text">
                    </div>
                </div>
                <div class="line-block ml-15">
                    <p class="title">日常门票</p>
                    <div class="content">
                        <input class="input_text item-w" name="ticket" value="<?php echo ($project["ticket"]); ?>" type="text">
                    </div>
                </div>
            </div>
            <div>
                <div class="line-block">
                    <p class="title">灯会期间门票</p>
                    <div class="content">
                        <input class="input_text item-w" name="run_ticket" value="<?php echo ($project["run_ticket"]); ?>" type="text">
                    </div>
                </div>
                <div class="line-block ml-15">
                    <p class="title">日常客流</p>
                    <div class="content">
                        <input class="input_text item-w" name="peace_passenger" value="<?php echo ($project["peace_passenger"]); ?>"
                               type="text">
                    </div>
                </div>
                <div class="line-block ml-15">
                    <p class="title">灯会期间客流</p>
                    <div class="content">
                        <input class="input_text item-w" name="run_passenger" value="<?php echo ($project["run_passenger"]); ?>"
                               type="text">
                    </div>
                </div>
                <div class="line-block ml-15">
                    <p class="title">性质及上下级关系</p>
                    <div class="content">
                        <input class="input_text item-w" name="relation" value="<?php echo ($project["relation"]); ?>" type="text">
                    </div>
                </div>
            </div>
            <div>

                <div class="line-block ">
                    <p class="title">交通情况</p>
                    <div class="content">
                        <input class="input_text item-w" name="traffic" value="<?php echo ($project["traffic"]); ?>" type="text">
                    </div>
                </div>
                <div class="line-block ml-15">
                    <p class="title">接待能力</p>
                    <div class="content">
                        <input class="input_text item-w" name="ability" value="<?php echo ($project["ability"]); ?>" type="text">
                    </div>
                </div>
                <div class="line-block ml-15">
                    <p class="title">收益情况</p>
                    <div class="content">
                        <input class="input_text item-w" name="out_value" value="<?php echo ($project["out_value"]); ?>" type="text">
                    </div>
                </div>
                <div class="line-block ml-15">
                    <p class="title">网络报道</p>
                    <div class="content">
                        <input class="input_text item-w" name="report" value="<?php echo ($project["report"]); ?>" type="text">
                    </div>
                </div>
            </div>

            <div>
                <p class="title">项目情况</p>
                <textarea class="content" name="context"
                          style="width:100%;height:100px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;"><?php echo ($project["context"]); ?></textarea>
            </div>
            <div>
                <div class="line-block">
                    <p class="title">制作公司</p>
                    <div class="content">
                        <select class="screen_department item-w" name="company">
                            <option value="本公司"
                            <?php if('本公司' == $project['company']): ?>selected<?php endif; ?>
                            >本公司</option>
                            <option value="三方公司"
                            <?php if('三方公司' == $project['company']): ?>selected<?php endif; ?>
                            >三方公司</option>
                        </select>
                    </div>
                </div>
                <div class="line-block ml-15">
                    <p class="title">投资形式</p>
                    <div class="content">
                        <select class="screen_department item-w" name="fee_type">
                            <option value="">请选择</option>
                            <?php if(is_array($fee_type)): $i = 0; $__LIST__ = $fee_type;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$item): $mod = ($i % 2 );++$i;?><option value="<?php echo ($item["config_auto_id"]); ?>"
                                <?php if($item['config_auto_id'] == $project['fee_type']): ?>selected<?php endif; ?>
                                ><?php echo ($item["name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                        </select>
                    </div>
                </div>
                <div class="line-block ml-15">
                    <p class="title">联合制作公司</p>
                    <div class="content">
                        <input name="common_company" value="<?php echo ($project["common_company"]); ?>" type="text"
                               class="input_text item-w"/>
                    </div>
                </div>
                <div class="line-block ml-15">
                    <p class="title">项目状态</p>
                    <div class="content">
                        <select class="screen_department advance item-w" name="status">
                            <?php if(empty($project)): if('information' == session('employee.department_type_id') || 'boss' == session('employee.department_type_id')): ?><option value="11">前期跟进</option>
                                    <option value="21">储备项目</option><?php endif; ?>
                                <?php if('business' == session('employee.department_type_id')): if(1 == $old_customer??0): ?><option value="41">合作中-常规跟进</option>
                                        <option value="42">合作中-进展中</option>
                                        <option value="43">合作中-待签</option>
                                        <option value="44">合作中-在建在展</option>
                                        <?php else: ?>
                                        <option value="31">转交业务-常规跟进</option>
                                        <option value="32">转交业务-进展中</option>
                                        <option value="33">转交业务-待签</option><?php endif; endif; ?>
                                <?php else: ?>
                                <?php if(1 == $project['status'] || 2 == $project['status']): ?><option value="11"
                                    <?php if(11 == $project['son_status']): ?>selected<?php endif; ?>
                                    >前期跟进</option>
                                    <option value="21"
                                    <?php if(21 == $project['son_status']): ?>selected<?php endif; ?>
                                    >储备项目</option><?php endif; ?>
                                <?php if(3 == $project['status']): ?><option value="31"
                                    <?php if(31 == $project['son_status']): ?>selected<?php endif; ?>
                                    >转交业务-常规跟进</option>
                                    <option value="32"
                                    <?php if(32 == $project['son_status']): ?>selected<?php endif; ?>
                                    >转交业务-进展中</option>
                                    <option value="33"
                                    <?php if(33 == $project['son_status']): ?>selected<?php endif; ?>
                                    >转交业务-待签</option><?php endif; ?>
                                <?php if(44 == $project['son_status']): ?><option value="44" selected="selected">合作中-在建在展</option><?php endif; ?>
                                <?php if(4 == $project['status'] && 44 != $project['son_status']): ?><option value="41"
                                    <?php if(41 == $project['son_status']){echo "selected";} ?>
                                    >合作中-常规跟进</option>
                                    <option value="42"
                                    <?php if(42 == $project['son_status']): ?>selected<?php endif; ?>
                                    >合作中-进展中</option>
                                    <option value="43"
                                    <?php if(43 == $project['son_status']): ?>selected<?php endif; ?>
                                    >合作中-待签</option>
                                    <option value="44"
                                    <?php if(44 == $project['son_status']): ?>selected<?php endif; ?>
                                    >合作中-在建在展</option><?php endif; ?>
                                <?php if(5 == $project['status']): ?><option value="51"
                                    <?php if(51 == $project['son_status']): ?>selected<?php endif; ?>
                                    >ABC-常规跟进</option>
                                    <option value="52"
                                    <?php if(52 == $project['son_status']): ?>selected<?php endif; ?>
                                    >ABC-进展中</option>
                                    <option value="53"
                                    <?php if(53 == $project['son_status']): ?>selected<?php endif; ?>
                                    >ABC-待签</option><?php endif; ?>
                                <?php if(6 == $project['status']): ?><option value="61"
                                    <?php if(61 == $project['son_status']): ?>selected<?php endif; ?>
                                    >已结案</option><?php endif; ?>
                                <?php if(7 == $project['status']): ?><option value="46"
                                    <?php if(46 == $project['son_status']): ?>selected<?php endif; ?>
                                    >合作中-已结束</option><?php endif; endif; ?>
                        </select>
                        <input class="input_text item-w" type="text" name="other_status"
                               value="<?php echo ((isset($project["other_status"]) && ($project["other_status"] !== ""))?($project["other_status"]):''); ?>" placeholder="项目状态" style="display:none">
                    </div>
                </div>
            </div>

            <div style="display: inline-block;" id="other_company" class="content">

                <div class=" other_company">
                    <label style="margin-left: 10px;border: none;margin-bottom: 10px; height: 20px;line-height: 20px;">点击选择三方公司</label>
                    <p style="position: absolute;top: 2px;left: 148px;height: 20px;line-height: 20px;cursor: pointer;margin-bottom: 0;">
                        添加<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"
                                style="font-size: 18px;vertical-align: sub;"></span></p>
                    <div class="other_list">

                    </div>
                </div>
                <div id="span">
                    找不到？搜一下！
                </div>
                <div id="search">
                    <p style="margin-bottom: 10px;">搜索：</p>
                    <input class="input_text" style="width: 100%;height: 30px;margin-bottom: 6px;" name="opponent_name"
                           placeholder="输入第三方公司名称"/>
                    <button name="" id="search_btn" class="btn btn-secondary  ml-10" type="button"
                            style="position: absolute;top: 33px;left: 428px;height: 30px !important;border-radius: 0;">
                        <i
                                class="Hui-iconfont">
                            &#xe665;</i>
                    </button>
                    <div class=" search_list">
                    </div>
                </div>
                <div id="test">
                    <p style="margin-bottom: 10px;">已选择的第三方公司：</p>
                    <div class="choose_list">

                    </div>
                </div>

            </div>

            <?php if(1 != I('get.r')): ?><div style="display: none" id="opponent">
                    <p class="title">第三方公司</p>
                    <div class="table_box">
                        <table class="opponent" id="opponent-list">

                        </table>
                    </div>
                </div><?php endif; ?>
            <p class="title">项目总结</p>
            <textarea class="content" name="summary"
                      style="width:100%;height:100px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;"><?php echo ($project["summary"]); ?></textarea>
            <div>
                <div class="line-block">
                    <p class="title">是否添加到形势统计</p>
                    <p class="content" style="height:39px;">
                        <label class="lsglabel"><input name="is_show_situation" type="radio" value="0"
                            <?php if(empty($project['is_show_situation'])): ?>checked<?php endif; ?>
                            />否 </label>
                        <label class="lsglabel"><input name="is_show_situation" type="radio" value="1"
                            <?php if('1' == $project['is_show_situation']): ?>checked<?php endif; ?>
                            />是 </label>
                    </p>
                </div>
                <div class="line-block ml-15">
                    <p class="title">落实完成</p>
                    <p class="content" style="height:39px;">
                        <label class="lsglabel"><input name="light_proj" type="radio" value="0"
                            <?php if(empty($project['light_proj'])): ?>checked<?php endif; ?>
                            />否 </label>
                        <label class="lsglabel"><input name="light_proj" type="radio" value="1"
                            <?php if('1' == $project['light_proj']): ?>checked<?php endif; ?>
                            />是 </label>
                    </p>
                </div>
            </div>
            <?php if(1 != I('get.r')): if((empty($project) || ('本公司' != $project['company']) || (6 != $project['status'] && 7 != $project['status']))): ?><div class="preserve">
                        <button onclick="commit(0)" class="btn btn-primary radius" type="button">保存</button>
                    </div>
                    <div class="cancel">
                        <button onclick="removeIframe()" class="btn btn-default radius" type="button">取消</button>
                    </div><?php endif; endif; ?>
            <div class="clear"></div>
        </form>
        <?php if((1 != I('get.r') && (6 != $project['status']??6 && 7 != $project['status']??7)) && c('SELF_SYSTEMADMIN.role_id') != session('employee_id')): ?><div class="btn_box cooperation_btn1">
                <?php if(empty($project)): if('business' == session('employee.department_type_id') && 1 == $old_customer??0): ?><button onclick="commit(4)" class="btn btn-warning radius" type="button" id="btn-mit4">申请结束
                        </button>
                        <?php else: ?>
                        <button onclick="commit(1)" class="btn btn-warning radius" id="btn-mit1" type="button">业务转交
                        </button>
                        <button onclick="commit(2)" class="btn btn-warning radius" type="button" id="btn-mit2">返回跟进
                        </button>
                        <button onclick="commit(3)" class="btn btn-warning radius" type="button">申请结案</button>
                        <button onclick="commit(5)" class="btn btn-warning radius" type="button">转合作中</button><?php endif; ?>
                    <?php else: ?>
                    <?php if('boss' == session('employee.role_type_code') || (('information' == session('employee.department_type_id') and 2 >= $project['status']) or ('business' == session('employee.department_type_id') and (3 == $project['status'] || 5 == $project['status'])))): ?><button onclick="commit(1)" class="btn btn-warning radius" type="button" id="btn-mit1">业务转交
                        </button><?php endif; ?>
                    <?php if(('boss' == session('employee.role_type_code') || 'business' == session('employee.department_type_id')) && (3 == $project['status'] || 5 == $project['status'])): ?><button onclick="commit(2)" class="btn btn-warning radius" type="button" id="btn-mit2">返回跟进
                        </button>
                        <button onclick="commit(3)" class="btn btn-warning radius" type="button" id="btn-mit3">申请结案
                        </button><?php endif; ?>
                    <?php if(('boss' == session('employee.role_type_code') || 'business' == session('employee.department_type_id')) && (44 == $project['son_status'] || 4 == $project['status'])): ?><button onclick="commit(4)" class="btn btn-warning radius" type="button" id="btn-mit4">申请结束
                        </button><?php endif; ?>
                    <?php if(('boss' == session('employee.role_type_code') || 'business' == session('employee.department_type_id')) && (3 == $project['status'] || 5 == $project['status'])): ?><button onclick="commit(5)" class="btn btn-warning radius" type="button" id="btn-mit5">转合作中
                        </button><?php endif; endif; ?>
            </div><?php endif; ?>
    </div>

<!-- body_main 自定义页面内容 **end** -->
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="/public/huiadmin/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/jquery.validation/1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="/public/huiadmin/lib/jquery.validation/1.14.0/messages_zh.min.js"></script>
<script type="text/javascript" src="/public/huiadmin/static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="/public/huiadmin/static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="/public/js/lib/common-1.js"></script>
<!-- footer_js 自定义javascript **begin** -->

    <!-- <script type="text/javascript" src="/public/bootstrap-time/js/jquery-1.8.3.min.js"></script> -->
    <script type="text/javascript" src="/public/bootstrap-time/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/public/bootstrap-time/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="/public/bootstrap-time/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="/public/huiadmin/lib/laydate/laydate.js"></script>
    <script>
		$(function () {
			$('.form_date').datetimepicker({
				language: 'zh-CN',
				weekStart: 1,
				todayBtn: 1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				minView: 2,
				forceParse: 0,
				format: 'yyyy-mm-dd',
			});

			laydate.render({
				elem: '#d-begin-date' //指定元素
			});
			laydate.render({
				elem: '#d-end-date' //指定元素
			});

			// 改变制作公司
			$('select[name=company]').change(function () {
				var v = $(this).val();
				if ("本公司" == v) {
					$('select[name=status]').show()
					$('input[name=other_status]').hide()
					$('.cooperation_btn1').show()
					$('#other_company').hide()
					$('#opponent').hide();
					$("#opponent table").empty();

				} else {
					$('select[name=status]').hide()
					$('input[name=other_status]').show()
					$('.cooperation_btn1').hide()
					$('#other_company').show()
				}
			})

			$('select[name=status]').change(function () {
				var v = $(this).val();
				if ('44' == v) {
					if ($('#btn-mit4')) {
						$('#btn-mit4').show();
					}
					if ($('#btn-mit1')) $('#btn-mit1').hide();
					if ($('#btn-mit2')) $('#btn-mit2').hide();
				} else {
					if ($('#btn-mit4')) {
						$('#btn-mit4').hide();
					}
					if ($('#btn-mit1')) $('#btn-mit1').show();
					if ($('#btn-mit2')) $('#btn-mit2').show();
				}
			})

			var cur_v = $('select[name=status]').val()
			if ('44' == cur_v) {
				if ($('#btn-mit4')) $('#btn-mit4').show();
				if ($('#btn-mit1')) $('#btn-mit1').hide();
				if ($('#btn-mit2')) $('#btn-mit2').hide();
			} else {
				if ($('#btn-mit4')) $('#btn-mit4').hide();
				if ($('#btn-mit1')) $('#btn-mit1').show();
				if ($('#btn-mit2')) $('#btn-mit2').show();
			}

			callOpponent(); //
			search();
			// 根据下拉框选项，隐藏显示按钮
			if ($(".advance").css("display") == "block") {
				$(".advance_btn").show();
				$(".advance").change(function () {
					if ($(".advance").val() == 2) {
						$(".advance_btn").show();
					} else {
						$(".advance_btn").hide();
					}
				})
			} else if ($(".business").css("display") == "block") {

				$(".business_btn").show();
			} else if ($(".cooperation").css("display") == "block") {
				$(".cooperation_btn1").show();
				$(".cooperation").change(function () {

					if ($(".cooperation").val() == 4 || $(".cooperation").val() == 5) {
						$(".cooperation_btn2").show();
						$(".cooperation_btn1").hide();
					} else {
						$(".cooperation_btn1").show();
						$(".cooperation_btn2").hide();
					}
				})
			}

			if ("本公司" != project_company) {
				$('select[name=status]').hide()
				$('input[name=other_status]').show()
				$('.cooperation_btn1').hide()
				$('#other_company').show()
			} else {
				$('#other_company').hide()
			}

		});

		function other_company_click(obj) {
			var id = $(obj).find('input').attr('id');
			var name = $(obj).find('input').val();
			var st = '<label for="' + id + '" onclick="choose_list_click(this);">' + '<input type="checkbox" id="' + id + '" value="' + name + '"  checked="checked" /><span alt="' + name + '" title="' + name + '">' + name + '</span>' + '</label>';

			if ($(obj).find('input').is(':checked')) {
				$('.search_list  input').each(function (i) {
					if ($(this).attr('id') == id) {
						$('.search_list  input')[i].checked = true;

					}
				});
				$('.choose_list').append(st)
			} else {
				$('.search_list  input').each(function (i) {
					if ($(this).attr('id') == id) {
						$('.search_list  input')[i].checked = false;
					}
				});
				$('.choose_list label').each(function () {
					if ($(this).attr('for') == id) {
						$(this).remove()
					}
				})
			}
			var $val = ',';

			$('.choose_list label input[type=checkbox]:checked').each(function () {
				$val += $(this).val() + ',';
			});
			$other_company = $val;
		}

		function search_list_click() {
			$('.search_list label input').click(function () {
				var id = $(this).attr('id');
				var name = $(this).val();
				var st = '<label for="' + id + '" onclick="choose_list_click(this)">' + '<input type="checkbox" id="' + id + '" value="' + name + '"  checked="checked" /><span alt="' + name + '" title="' + name + '">' + name + '</span>' + '</label>';

				if ($(this).is(':checked')) {
					$('.other_company  input').each(function (i) {
						if ($(this).attr('id') == id) {
							$('.other_company  input')[i].checked = true;

						}
					})
					$('.choose_list').append(st)
				} else {
					$('.other_list  input').each(function (i) {
						if ($(this).attr('id') == id) {
							$('.other_company  input')[i].checked = false;
						}
					});
					$('.choose_list label').each(function () {
						if ($(this).attr('for') == id) {
							$(this).remove()
						}
					})
				}

			});
		}

		function choose_list_click(obj) {

			var id = $(obj).find('input').attr('id');
			console.log(id)
			$(obj).remove()
			$('.other_list  input').each(function (i) {
				if ($(this).attr('id') == id) {
					$('.other_company  input')[i].checked = false;
				}
			});
			$('.search_list  input').each(function (i) {
				if ($(this).attr('id') == id) {
					$('.search_list  input')[i].checked = false;

				}
			})


		}


		function search() {
			$('#search_btn').click(function () {
				var $name = $('input[name=opponent_name]').val();
				var param ={};
				param.opponent_name = $name;
				var url = '/service/customer/search/search';
				K.doAjax(param, url, function (response) {
					if (response.status && 'success' == response.status) {
						$('.search_list').empty();
						$.each(response.data, function (i, v) {
							var str = '<label for="opp' + v.opponent_id + '">';

							if (-1 < $other_company.indexOf(',' + v.name + ',')) {
								str += '<input type="checkbox" id="opp' + v.opponent_id + '" value="' + v.name + '"  checked="checked" /><span alt="' + v.name + '" title="' + v.name + '">' + v.name + '</span>';
							} else {
								str += '<input type="checkbox" id="opp' + v.opponent_id + '" value="' + v.name + '"  /><span alt="' + v.name + '" title="' + v.name + '">' + v.name + '</span>';
							}

							str += '</label>';

							$('.search_list').append(str);
						})
						search_list_click()
					}
				});
			});
		}

		function ShowOpponent() {
			$(".other_company p").click(function () {
				$('#opponent').show();
				var tr = "<tr><td><input class='input_text' name='company_name' type='text' placeholder='公司名称'></td><td><input class='input_text' name='opp_address' type='text' placeholder='所在地'></td><td><input class='input_text' type='text' name='fee' placeholder='报价（万）'></td><td><input class='input_text' name='advantage' type='text' placeholder='优势'></td><td><input class='input_text' name='inferiority' type='text' placeholder='劣势'></td><td><span class='glyphicon glyphicon-floppy-disk' onclick='addOpponent(this)' aria-hidden='true'></span><span class='glyphicon glyphicon-remove-circle' onclick='delOpponent(this)' aria-hidden='true'></span></td></tr>"
				$("table").append(tr);
				RemoveTr();
			});
		}

		function removeIframe() {
			K.removeIframe();
		}

		//移除一行竞争对手信息
		function RemoveTr() {
			$(".opponent tr td span:last").click(function () {
				$(this).parents("tr").remove();
			});
		}

		RemoveTr();


		var project_company = '<?php echo ($project["company"]); ?>';
		if ('' == project_company) {
			project_company = '本公司';
		}
		var $other_company = ',' + '<?php echo ($project["other_company"]); ?>' + ',';

		function callOpponent(id) {
			var url = '/service/customer/search/opponent';
			K.doAjax({}, url, function (response) {
				if (response.status && 'success' == response.status) {
					$('.other_list').empty();
					$('.choose_list').empty();
//					var str = '<label style="margin-left:10px">点击选择三方公司</label>';
//					str += '<p style="position: absolute;top: 0px;right: 4px;height: 35px;line-height: 35px;cursor: pointer;">添加<span class="glyphicon glyphicon-plus-sign" aria-hidden="true" style="font-size: 18px;vertical-align: sub;"></span></p>';
//					$('.other_company').append(str);
					var str = '';
					ShowOpponent();
					$.each(response.data, function (i, v) {
//						var str = '<option value="' + v.name + '">' + v.name + '</option>';
						var str = '<label for="opp' + v.opponent_id + '" onclick="other_company_click(this)">';

						if (-1 < $other_company.indexOf(',' + v.name + ',')) {
							str += '<input type="checkbox" id="opp' + v.opponent_id + '" value="' + v.name + '"  checked="checked" /><span alt="' + v.name + '" title="' + v.name + '">' + v.name + '</span>';
							var st = '<label for="opp' + v.opponent_id + '" onclick="choose_list_click(this);">' + '<input type="checkbox" id="opp' + v.opponent_id + '" value="' + v.name + '"  checked="checked" /><span alt="' + v.name + '" title="' + v.name + '">' + v.name + '</span>' + '</label>';
							$('.choose_list').append(st);
						} else {
							if (id && id == v.opponent_id) {
								str += '<input type="checkbox" id="opp' + v.opponent_id + '" value="' + v.name + '"  checked="checked" /><span alt="' + v.name + '" title="' + v.name + '">' + v.name + '</span>';
								var st = '<label for="opp' + v.opponent_id + '" onclick="choose_list_click(this);">' + '<input type="checkbox" id="opp' + v.opponent_id + '" value="' + v.name + '"  checked="checked" /><span alt="' + v.name + '" title="' + v.name + '">' + v.name + '</span>' + '</label>';
								$('.choose_list').append(st);
							} else {
								str += '<input type="checkbox" id="opp' + v.opponent_id + '" value="' + v.name + '"  /><span alt="' + v.name + '" title="' + v.name + '">' + v.name + '</span>';
							}

						}

						str += '</label>';

						$('.other_list').append(str);

					})
				}
			});
		}

		function addOpponent(me) {
			// 判断是否有重名的
			var tt = $(me).parent().parent('tr');
			var name = tt.find('input[name=company_name]').val()

			var param = {
				name: name,
				address: tt.find('input[name=opp_address]').val(),
				fee: tt.find('input[name=fee]').val(),
				advantage: tt.find('input[name=advantage]').val(),
				inferiority: tt.find('input[name=inferiority]').val()
			}
			var same = 0;
			$('#opponent-list').find('input[name=company_name]').each(function () {
				if (name == $(this).val()) {
					same++;
				}
			})
			if (1 < same) {
				layer.msg('错误：重复的竞争对手名称！', {icon: 2, time: 2000});
				return;
			}

			var url = '/service/customer/manage/opponent';
			K.doAjax(param, url, function (response) {
				if (response.status && 'success' == response.status) {
					callOpponent(response.opponent_id)
					layer.msg('保存成功!', {icon: 1, time: 2000});
				} else {
					if (response.message) {
						layer.msg(response.message, {icon: 2, time: 2000});
					} else {
						layer.msg('后台错误!', {icon: 2, time: 2000});
					}
				}
			});
		}

		function delOpponent(me) {
			var name = $(me).parent().parent('tr').find('input[name=company_name]').val()
			if (!name) {
				return;
			}
			var url = '/service/customer/manage/delOpponent';
			var param = {
				name: name
			}
			K.doAjax(param, url, function (response) {
				if (response.status && 'success' == response.status) {
					// $('select[name=company]').empty();
					// $('select[name=company]').append('<option value="本公司">本公司</option>');
					// $.each(response.data, function(i,v){
					// 	var str='<option value="'+v.name+'">'+v.name+'</option>';
					// 	$('select[name=company]').append(str);
					// })
					callOpponent()
				} else {
					if (response.message) {
						layer.msg(response.message, {icon: 2, time: 2000});
					} else {
						layer.msg('后台错误!', {icon: 2, time: 2000});
					}
				}
			});
		}

		function commit($type) {
			if ('1' == '<?php echo ($_GET['hm']); ?>') {
				if ($('input[name=customer_id]').val() == "") {
					layer.msg('请选择客户!', {icon: 2, time: 2000});
					return;
				}
			}
			if ($("input[name='name']").val() == "") {
				layer.msg('请填写项目名称!', {icon: 2, time: 2000});
				return;
			}

			// 设置三方客户
			var str = '';
			$.each($('.other-cust-li'), function (i, v) {
				if ('' == str) str = $(this).attr('id');
				else str += ',' + $(this).attr('id');
			})
			if ('' != str) {
				$('input[name=other_cust]').val(str);
			}

			if (0 != $type && 3 >= $type && 'boss' == '<?php echo ($_SESSION['employee']['role_type_code']); ?>') {
				bossCall($type)
				return;
			}
			if (0 == $type) var title = '确认要保存？'
			else var title = '确认要申请该流程？'
			layer.confirm(title, {
				btn: ['确认', '取消'] //可以无限个按钮
			}, function (index, layero) {
				commitCall($type)
				layer.close(index);
			}, function (index) {
				layer.close(index);
			});
		}

		function bossCall($type) {
			var $department = JSON.parse('<?php echo json_encode($department); ?>');
			var str = '<div class="ml-20 mt-20 mr-20"><p class="title">转入</p>'
			str += '<select name="in_department_id" class="screen_department">';
			str += '<option value="">选择部门</option>';
			$.each($department, function (i, v) {
				if (1 == $type && 'business' == v.department_type_id) {
					str += '<option value="' + v.department_id + '">' + v.name + '</option>';
				} else if ((2 == $type || 3 == $type) && 'information' == v.department_type_id) {
					str += '<option value="' + v.department_id + '">' + v.name + '</option>';
				}
			})

			str += '</select>';
			str += '<p class="title">批注</p>';
			str += '<textarea  class="content" name="reply" style="width:100%;height:140px;resize:none;border: 1px solid #e0e0e0;overflow-y: scroll;"></textarea>';
			str += '</div>';

			layer.open({
				type: 1,
				title: '选择接收的部门',
				// skin: 'layui-layer-rim', //加上边框
				area: ['500px', '430px'], //宽高
				content: str,
				btn: ['提交', '取消'], //可以无限个按钮
				btn1: function (index, layero) {
					if ('' == $('select[name=in_department_id]').val()) {
						layer.msg('转入部门不能为空！', {icon: 2, time: 2000});
						exit;
					}

					$('input[name=in_department_id]').val($('select[name=in_department_id]').val());
					$('input[name=reply]').val($('textarea[name=reply]').val());

					commitCall($type);
					return true;
				},
				btn2: function (index) {
					$('input[name=in_department_id]').val('');
					$('input[name=reply]').val('');
					layer.close(index);
				},
			});
		}

		function commitCall($type) {
			var url = '/service/project/manage/add';

			$('input[name=approve_type]').val($type);

			var temp_arr = '';
			$.each($('.choose_list').find('input'), function (i, v) {
				if ($(this).is(':checked')) {
					if ('' != temp_arr) {
						temp_arr += ','
					}
					temp_arr += $(this).val();
				}
			})
			$('input[name=other_company]').val(temp_arr);

			K.doAjaxSubmit('#add-form-post', url, function (response) {
				if (response.status && response.status == 'success') {
					if ('1' == '<?php echo ($_GET['hm']); ?>') {
						layer.msg('添加成功！', {icon: 1, time: 2000});
						setTimeout('location.replace(location.href)', 2000);
						return;
					} else
						K.refreshParent()
				} else {
					if (response.message) {
						layer.msg(response.message, {icon: 2, time: 2000});
					} else {
						layer.msg('后台错误!', {icon: 2, time: 2000});
					}
				}
			});
		}

		function searchCust(num) {
			var name = $('#other-cust-search' + num).val();
			if ('' == name) return;
			var url = '/service/customer/search/list';
			K.doAjax({name: name}, url, function (res) {
				if (res.status && res.status == 'success') {
					$('#sort-cust-list' + num).show();
					$('#sort-cust-list' + num).empty();
					if (res.status && res.status == 'success') {
						$.each(res.data, function (i, v) {
							if (v.customer_id == $('input[name=customer_id]').val()) {
								return true;
							}
							var str = '<label class="option-2" for="1"><input onclick="selectCust(this,' + num + ')" type="checkbox" value="' + v.name + '" idv="' + v.customer_id + '" old="' + v.is_old_cust + '">' + v.name + '</label>';

							$('#sort-cust-list' + num).append(str)
						})
					}
				} else {
					layer.msg((res.message ? res.message : '后台错误!'), {icon: 2, time: 2000});
				}
			});
		}

		function selectCust(me, num) {
			$('#sort-cust-list' + num).hide()
			var id = $(me).attr('idv');
			// 是否存在
			console.log($('#' + id))
			if (
				console.log($('#' + id))) {
				return;
			}

			var str = '<div class="other-cust-li" id="' + id + '"><span class="ml-10">' + $(me).val();
			str += '</span><span><i class="Hui-iconfont ml-5 c-red" onclick="delOtherCust(\'' + id + '\')" >&#xe706;</i></span></div>';

			if (1 == num) {
				$('input[name=customer_id]').val(id);
				$('input[name=customer_hm]').val($(me).val());
			} else {
				$('#other-cust').append(str);
			}

			// 业务部需要设置老客户状态
			if ('business' == '<?php echo ($_SESSION['employee']['department_type_id']); ?>') {
				setOldCust($(me).attr('old'))
			}
		}

		function delOtherCust(id) {
			$('#' + id).remove();
		}

		// 设置老客户状态
		function setOldCust(old) {
			// status
			$('select[name=status]').empty();
			$('.cooperation_btn1').empty();
			if (0 == old) {
				$('select[name=status]').append('<option value="31" >转交业务-常规跟进</option>');
				$('select[name=status]').append('<option value="32" >转交业务-进展中</option>');
				$('select[name=status]').append('<option value="33" >转交业务-待签</option>');

				$('.cooperation_btn1').append('<button onclick="commit(1)" class="btn btn-warning radius" id="btn-mit1" type="button">业务转交</button>')
				$('.cooperation_btn1').append('<button onclick="commit(2)" class="btn btn-warning radius ml-5" type="button" id="btn-mit2">返回跟进</button>')
				$('.cooperation_btn1').append('<button onclick="commit(3)" class="btn btn-warning radius ml-5" type="button">申请结案</button>')
				$('.cooperation_btn1').append('<button onclick="commit(5)" class="btn btn-warning radius ml-5" type="button">转合作中</button>')
			} else {
				$('select[name=status]').append('<option value="41" >合作中-常规跟进</option>');
				$('select[name=status]').append('<option value="42" >合作中-进展中</option>');
				$('select[name=status]').append('<option value="43" >合作中-待签</option>');
				$('select[name=status]').append('<option value="44" >合作中-在建在展</option>');

				$('.cooperation_btn1').append('<button onclick="commit(4)" class="btn btn-warning radius" type="button" id="btn-mit4" style="display:none">申请结束</button>')
			}
		}

    </script>

<!--/footer_js 自定义javascript **end** -->

</body>
</html>