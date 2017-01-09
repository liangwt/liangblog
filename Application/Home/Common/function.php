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
        $address = json_decode(IpToLocation($ip))->{"address"} || "other";
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


/*
测试程序
echo $str = encryption("127.0.0.1|1");
echo "\nMTI3LjAuMC4xfDE=\n";
echo encryption($str,0);*/
?>