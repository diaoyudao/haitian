<?php
return array(
    //'配置项'=>'配置值'

    'CONTROLLER_LEVEL' => 2,  // 控制器层级，默认1层
    'URL_MODEL' => 1,  // url 为普通模式
    'DEFAULT_CONTROLLER' => 'index',

    // 自动启动session
    'SESSION_AUTO_START' => false,
    'SESSION_OPTIONS' => [
        'name' => 'employee_id',
        'prefix' => '',
        'expire' => '36000',
    ],    

    'DEFAULT_FILTER' => 'trim', // 默认对输入的处理，去除两端空格

    // 加载自定义配置文件
    'LOAD_EXT_CONFIG' => 'menus_privilege,depend_privilege,code_constant',

    // 发生错误设置
    'ERROR_MESSAGE'          => '页面错误！请稍后再试～', //错误显示信息,非调试模式有效
    //'ERROR_PAGE'             => '/public', // 错误定向页面

    /* 模板引擎设置 */
    'TMPL_ACTION_ERROR'      => __DIR__. '/../View/' . 'Error/dispatch_jump.tpl', // 默认错误跳转对应的模板文件
    'TMPL_EXCEPTION_FILE'    => __DIR__. '/../View/' . 'Error/think_exception.tpl', // 异常页面的模板文件

    // 配置模板名称
    'DEFAULT_V_LAYER' => 'View',
    // 配置模板主题
    'DEFAULT_THEME' => 'default',
    // 模板后缀
    'TMPL_TEMPLATE_SUFFIX' => '.tpl',
    // 配置简化模板的目录层
    'TMPL_FILE_DEPR' => '/',

    'LOG_RECORD' => true, // 开启日志记录
    'LOG_LEVEL'  =>'WARN,NOTIC,INFO,DEBUG,SQL', // 只记录EMERG ALERT CRIT ERR 错误
);