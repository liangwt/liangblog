<?php
/**
 * Created by PhpStorm.
 * User: LiangWentao
 * Date: 12/29/2016
 * Time: 18:59
 */
function stripFirstCharst($str=""){
    $str = htmlspecialchars_decode($str);
    $firstCharst = stristr($str, "<br/>",true);
    return $firstCharst;
}

/**
 * 根据ip地址确定地址信息
 * @param string $ip
 * @param string $AK
 * @return bool|string
 */
function IpToLocation($ip='',$AK="YSkQHHHvh35YOfLMKGFQvwjDTDVya9TE"){
    //百度普通IP定位API
    $baiduAPI = "http://api.map.baidu.com/location/ip";
    //普通IP定位API查询参数
    $queryData = array(
        "ak" => $AK,
        "coor" => "bd09ll",
        "ip"   => $ip,
    );
    //连接查询参数
    $Dataencode = http_build_query($queryData);
    //构造查询url
    $url = $baiduAPI."?".$Dataencode;
    //返回json数据
    return $responseData = file_get_contents($url);
}