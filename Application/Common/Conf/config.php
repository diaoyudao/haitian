<?php
return array(
    // 加载自定义配置文件
    'LOAD_EXT_CONFIG' => 'code_constant,encrypt,weixin',

    //'配置项'=>'配置值'
    //'CONTROLLER_LEVEL' => 3,  // 控制器层级
    
    // 允许访问的模型
    'MODULE_ALLOW_LIST' => array('Home', 'Admin'),

    // url不区分大小写
    'URL_CASE_INSENSITIVE' => true,
    // 设置禁止访问的模块列表
    'MODULE_DENY_LIST' => array('Common', 'Runtime'),
    // 设置url访问模式
    'URL_MODEL' => 1,
    'VAR_MODULE' => 'm',  // 默认模块获取变量
    'VAR_CONTROLLER' => 'c',  // 默认控制器获取变量
    'VAR_ACTION' => 'a',   // 默认操作获取变量

    // 不自动启动session
    'SESSION_AUTO_START' => false,

    // 显示页面Trace信息，开发调试时用
    'SHOW_PAGE_TRACE' => false,
    /* 日志设置 */
    'LOG_RECORD' => true, // 默认不记录日志
    'LOG_LEVEL' => 'WARN,NOTIC,INFO,DEBUG,SQL', // 允许记录的日志级别

    'REDIS_IP' => '172.16.30.128',
    'REDIS_POST' => 6379,

    // 关闭字段缓存，开发的时候关闭，因为可能频繁变动字段，生产环境可以打开。
    'DB_FIELDS_CACHE' => true,

    /* 数据库链接设置begin */
    'DB_PREFIX' => '',  // 配置数据表的前缀
    'DB_TYPE' => 'mysql', // 数据库类型
    'DB_HOST' => '172.16.30.125', // 服务器地址
    'DB_NAME' => 'haitian_cms', // 数据库名
    'DB_USER' => 'mysqluser', // 用户名
    'DB_PWD' => 'tt@test', // 密码 Jx2137*9@!
    'DB_PORT' => '3306', // 端口
    'DB_CHARSET' => 'utf8', // 数据库编码默认采用utf8
    'DB_DEBUG' => true, // 数据库调试模式 开启后可以记录SQL日志
    'DB_PARAMS' => [
        \PDO::ATTR_PERSISTENT => false,  // 使用长连接***
        \PDO::ATTR_CASE => \PDO::CASE_NATURAL  // 不区分字段大小写
    ],


    
    /* 数据库链接设置end */

    'URL_ROUTER_ON' => false,
    'URL_ROUTE_RULES' => [
        //    '/^my\/uuu$/' => 'User/Index',
        //    '/^my\/(\d{4})\/(\d{2})\/(\d{2})$/' => 'Index/day?year=:1&month=:2&day=:3',
    ],

);