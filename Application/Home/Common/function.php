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

/*
测试程序
echo $str = encryption("127.0.0.1|1");
echo "\nMTI3LjAuMC4xfDE=\n";
echo encryption($str,0);*/
?>