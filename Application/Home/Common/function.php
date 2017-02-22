<?php
/**
 * 加密字符串
 * @param  string  $str  [字符串]
 * @param  integer $flag [1为加密 0为解密]
 * @return string        [加密或解密后的字符串]
 */
function encryption($str,$flag=1){
	$Salt = md5("LIANGBLOG");
	if($flag){
		$str = str_replace("=","",base64_encode($str^$Salt));
	}else{
		$str = base64_decode($str)^$Salt;
	}
	return $str;
}

/**
 * 记录访问历史记录，和访问者的ip地址
 * 当同一ip访问两次间隔不超过5分钟时只记录一次
 * @param int $article_id
 */
function recodeView($article_id=0){
    $ip = get_client_ip();
    //计算上一次和现在访问的时间差
    $viewData = M("article_view")
        ->where(["article_id"=>$article_id,"view_ip"=>$ip])
        ->order("view_datetime desc")
        ->find();
    //在5分钟之内访问，不记录
    if(strtotime("now")-strtotime($viewData["view_datetime"]) >= 5*60){
        //使用百度api获取地址，当获取失败时返回other
        //json_decode($json,[var]), 第二参数为true时返回数组，默认返回对象
        $address = json_decode(IpToLocation($ip))->{"address"} or "other";
        list($country,$province,$city,$none,$net,$other,$other2)=explode("|",$address);
        $data = array(
            "view_ip" => $ip,
            "ip_province" => empty(!$province)?$province:"other",
            "ip_city" => empty(!$city)?$city:"other",
            "article_id" => $article_id,
            "view_uid" => isset($_SESSION["uid"])?$_SESSION["uid"]:0,
            "view_datetime" => date("Y-m-d H:m:s"),
        );
        M("article_view")->add($data);
    }
}

/**
 * 从bing图片取图
 * @param int $idx 不同日期的图片
 * @param int $n   一次取多少张照片
 * @return array $wallerURL   索取照片的所有url
 *
 */
function getBingWaller($idx=0,$n=1){
    //必应图片API
    $url = "http://www.bing.com/HPImageArchive.aspx?format=js&idx=".$idx."&n=".$n."&mkt=zh-CN";
    $ch = curl_init($url);
    curl_setopt($ch,CURLOPT_HTTPHEADER,array(
        "User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36",
        "Accept-Language: en-US,en;q=0.8,zh-CN;q=0.6,zh;q=0.4,zh-TW;q=0.2",
        "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    ));
    //TRUE 将curl_exec()获取的信息以字符串返回，而不是直接输出。
    curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
    $response = curl_exec($ch);
    curl_close($ch);
    $data = json_decode($response,true);
//    var_dump($data);
    foreach ($data["images"] as $key => $value) {
        $wallerURL[] = "http://www.bing.com".$value["url"];
    }
    return $wallerURL;
}


/*
测试程序
echo $str = encryption("127.0.0.1|1");
echo "\nMTI3LjAuMC4xfDE=\n";
echo encryption($str,0);
echo getBingWaller(0,2);*/
?>