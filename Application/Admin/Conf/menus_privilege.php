<?php
return [
    /**
     * 菜单权限列表，列表中的菜单表示需要权限的菜单
     * 页面只显示两层菜单，第三层只作为权限控制用，是页面下的操作控制
     */
    'menu_privilege_list' => [
        [
            'iconfont' => 'xe625',
            'title' => '首页',
            'link' => '/service/home/index/index',            
        ],
        [
            'iconfont' => 'xe616',
            'title' => '项目管理',
            'alias' => '项目管理（总经理）',
            'link' => '',
            'children' => [
                [
                    'title' => '项目管理',
                    'link' => '/service/project/manage/index',
                ],
                [
                    'title' => '审批项目',
                    'link' => '/service/project/manage/approve',
                ],
            ]             
        ],        
        [
            'iconfont' => 'xe62b',
            'title' => '客户管理',
            'link' => '#',  
            'children' => [
                [
                    'title' => '客户列表',
                    'link' => '/service/customer/manage/index',
                ],
                [
                    'title' => '新增客户',
                    'link' => '/service/customer/manage/add',
                ],
            ]               
        ],
        [
            'iconfont' => 'xe637',
            'title' => '任务管理',
            'link' => '/service/task/manage/index',            
        ],
        [
            'iconfont' => 'xe70c',
            'title' => '工作报告',
            'alias' => '',
            'link' => '/service/work/manage/index',  
            'children' => [
                [
                    'title' => '工作报告（审批）',
                    'link' => '/service/work/examine/index',
                ],
                [
                    'title' => '工作报告（提交）',
                    'link' => '/service/work/submit/index',
                ],
            ]             
        ],        
        [
            'iconfont' => 'xe63b',
            'title' => '消息群发',
            'link' => '#',    
            'children' => [
                [
                    'title' => '短信群发',
                    'link' => '/service/send/sms/index',
                ],
                [
                    'title' => '邮件群发',
                    'link' => '/service/send/email/index',
                ],
            ]        
        ],
        [
            'iconfont' => 'xe61c',
            'title' => '形势统计',
            'link' => '#',
            'children' => [
                [
                    'title' => '形势统计',
                    'link' => '/service/statistics/situation/list',
                ],
                [
                    'title' => '形势备份',
                    'link' => '/service/statistics/situation/bak',
                ],
            ]            
        ],
        [
            'iconfont' => 'xe621',
            'title' => '数据统计',
            'link' => '#',
            'children' => [
                [
                    'title' => '客户分布',
                    'link' => '/service/statistics/customer/data',
                ],
                [
                    'title' => '项目统计',
                    'link' => '/service/statistics/project/data',
                ],
                [
                    'title' => '用户统计',
                    'link' => '/service/statistics/user/data',
                ],
                [
                    'title' => '任务统计',
                    'link' => '/service/statistics/task/data',
                ],
            ]          
        ],
        [
            'iconfont' => 'xe623',
            'title' => '操作日志',
            'link' => '/service/history/log/list',            
        ],
        [
            'iconfont' => 'xe62d',
            'title' => '用户管理',
            'link' => '#',   
            'children' => [
                [
                    'title' => '部门管理',
                    'link' => '/service/employee/department/list',
                ],
                [
                    'title' => '职位管理',
                    'link' => '/service/employee/role/index',
                ],
                [
                    'title' => '用户管理',
                    'link' => '/service/employee/user/index',
                ],
            ]         
        ],
        [
            'iconfont' => 'xe683',
            'title' => '搜索结果',
            'link' => '/service/system/search/index',            
        ],
        [
            'iconfont' => 'xe62e',
            'title' => '系统配置',
            'link' => '/service/system/manage/profile',
			'children' => [
				[
					'title' => '区域管理',
					'link' => '/service/system/area/lists',
				],
			]
		],
    ],
];