<?php
return [
    'SELF_SYSTEMADMIN' => [
        'role_id' => '1000',
        'name' => '超级系统管理员',
    ],

    'SELF_ROOT_DIR' => '/home/www/haitian',  // 本地根目录路径
    'ADMIN_ALIAS' => '/service',  // 本地根目录路径

    'ADMIN_WEB_NAME' => '海天彩灯',  // 后台网站名称
    'WEB_NAME' => 'text',  // 前台网站名称
    
    'ONE_PAGE_SIZE' => 15,   // 单页显示的列表记录数



    'VERIFY_ID' => '_37&45%8#_',  // 验证码特殊标记
    'VERIFY_KEY' => '_37&45%8#_',  // 验证码加密
    'VERIFY_TIMEOUT' => 60,  // 验证码过期时间，秒

    'INIT_PASSWORD' => 'haitian888',  // 初始密码


    /* 默认显示的图片 */
    'DEFAULT_SHOW_IMAGE' => '/public/img/admin/error.gif',

    'DEFAULT_MAX_DATA' => '2299-1-1',  // 默认最大时间

    /* 文件上传 */
    'UPLOAD_FILE_ROOT_PATH' => '/home/www/haitian',  // 公告附件上传地址根目录，目录必须存在，不然会报错
    'UPLOAD_FILE_SAVE_PATH' => '/datas/file/',  // 公告附件上传地址子目录，目录可以不存在，系统会自动创建
    'UPLOAD_FILE_MAX_SIZE' => 5000000,  // 附件上传大小限制
    'UPLOAD_IMAGE_MAX_SIZE' => 2,  // 图片上传大小限制,2M

    /* 大文件上传 */
    'UPLOAD_LARGE_FILE_ROOT_PATH' => '/home/www/haitian',  // 大文件上传地址根目录，目录必须存在，不然会报错
    'UPLOAD_LARGE_FILE_SAVE_PATH' => '/datas/large_file/file/',  // 大文件上传地址子目录，目录可以不存在，系统会自动创建
    'UPLOAD_LARGE_FILE_TEMP_PATH' => '/datas/large_file/temp/',  // 大文件上传地址子目录，目录可以不存在，系统会自动创建
    'UPLOAD_LARGE_FILE_ONCE_SIZE' => 3145728,  // 附件单次上传大小限制，3M,3145728

    'IMAGE_SAVE_PATH_TEMP' => 'temp',  // 附件上传临时目录限制
    'IMAGE_SAVE_PATH_ROOT' => '/home/www/haitian',  // 图片上传地址根目录,网站根目录
    'IMAGE_SAVE_PATH' => '/datas/image/source',  // 图片上传地址子目录，相应于根目录
    'IMAGE_PREVIEW_PATH' => '/datas/image/thumbnail',  // 缩略图相对地址，相应于根目录

    // 默认员工头像
    'DEFAULT_EMPLOYEE_IMAGE' => '/public/img/info/no_user.png',
    // 部门类型
    'DEPARTMENT_TYPE' => [
        'boss' => '总经理',
        'information' => '区域中心',
        'business' => '业务部',
        'other' => '其他',
    ],

    // 角色类型
    'ROLE_TYPE' =>  [
        'boss' => '总经理',
        'director' => '主任',
        'salesman' => '业务员',
        'other' => '其他',
    ],

    // 客户类型 1政府单位，2旅游景区，3企业公司，4其他，5海外客户
    'CUSTOMER_TYPE' => [
        '0' => '其他',
        '1' => '政府单位',
        '2' => '旅游景区',
        '3' => '国有企业',        
        '4' => '海外客户',
        '5' => '民营企业',
    ],

    // 项目状态 1：前期跟进，2：储备项目，3转交业务；4：合作中，5：abc；6：已结束
    'PROJ_STATUS_LIST' => [
        '1' => '前期跟进',
        '2' => '储备项目',
        '3' => '转交业务',
        '4' => '合作中',
        '5' => 'abc',
        '6' => '已结案',
        '7' => '已结束',
    ],
    // 子状态。
    'SON_STATUS_LIST' => [
        '11' => '前期跟进',
        '21' => '储备项目',
        '31' => '转交业务-常规跟进',
        '32' => '转交业务-进展中',
        '33' => '转交业务-待签',
        '41' => '合作中-常规跟进',
        '42' => '合作中-进展中',
        '43' => '合作中-待签',
        '44' => '合作中-在建在展',
        '46' => '合作中-已结束',
        '51' => 'abc-常规跟进',
        '52' => 'abc-进展中',
        '53' => 'abc-待签',
        '61' => '已结案',
        '71' => '已结束2',
    ],
    // 客户联系人功能1：决策人，2负责人，3经办人，4其他
    'CONTACT_FUNCTION' => [
        '1' => '决策人',
        '2' => '负责人',
        '3' => '经办人',
        '4' => '其他',
    ],
    // 流程 1：转发，2返回跟进，3申请结案，4申请结束，5转合作中',
    'APPROVE_LIST' => [
        '1' => '业务转交',
        '2' => '返回跟进',
        '3' => '申请结案',
        '4' => '申请结束',
        '5' => '转合作中',
    ],
    // 当前流程状态 提交审核，2：审核通过，3：审批通过，4：分配/完成',
    'APPROVE_STATUS_LIST' => [
        '1' => '申请',
        '2' => '审核',
        '3' => '审批',
        '4' => '分配',
    ],
    // 项目等级列表
    'PROJECT_LEVEL_LIST' => [
        'A' => 'A级',
        'B' => 'B级',
        'C' => 'C级',
        'H' => '合作中',
        'Z' => '普通',
    ],
    // 保存最近多少个访问的客户数量
    'CUSTOMER_HIS_NUM' => 4,

    // 保存形式统计文件路径
    'PROJECT_COPY_PATH' => '/statistics/down/',
    'PROJECT_COPY_PATH_S' => '/down/',
    'PROJECT_FILE_PREFIX' => 'project-',
];