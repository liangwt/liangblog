<?php
return array(
    //'配置项'=>'配置值'
    'DB_HOST' => '127.0.0.1',
    'DB_TYPE' => 'mysql',
    'DB_NAME' => 'liangblog',
    'DB_USER' => 'root',
    'DB_PWD'  => '369125255L',
    /*	'DB_TYPE'    => 'mysql',
        'DB_NAME'    => 'liangblog',
        'DB_USER'    => 'root',
        'DB_PWD'     => '',*/

    'DB_PORT'              => '3306',
    'DB_PREFIX'            => 'blog_',
    'DB_CHARSET'           => 'utf8',
    //调试信息
    'SHOW_PAGE_TRACE'      =>  false,
    //错误信息
    'ERROR_PAGE'           => __ROOT__ . '/Public/404/error.html',
    //'DB_FIELD_CACHE'       => false,
    //'HTML_CACHE_ON'        => false,
    //'HTML_CACHE_TIME'      => 1,
    'URL_CASE_INSENSITIVE' => true,
    // 'TMPL_EXCEPTION_FILE' => APP_PATH.'/Public/exception/exception.tpl',
    'DEFAULT_MODULE'       => 'Home',  // 默认模块
    'SHOW_ERROR_MSG'       => true,
);
