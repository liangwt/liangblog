<?php
namespace Home\Controller;
use Think\Controller;
class IndexController extends Controller {
    public function index(){
        //打开首页进行自动登录判断,除了成功建立session其他情况不做操作
        $ip = get_client_ip();
        //读取cookie里的自动登录保存下的信息
        $cookieValue = explode("|",encryption($_COOKIE['auto'],0));
        //有auto的信息并且没有建立session 说明是头一次登录的情况
        if(isset($_COOKIE['auto']) && !isset($_SESSION['uid'])){
            if($ip == $cookieValue[0]){
                $user = M('user');
                $result = $user->where("id=".$cookieValue[1])->find();
                if(!$result['lock']){
                    $_SESSION['uid'] = $result['id'];
                }
            }
        }
/*    	print_r($_SESSION);
    	exit;*/
        getBingWaller(0,1);
        $carouselPic =  M("index")->order("id desc")->limit(3)->select();
        $story =  M("index")->order("id desc")->find();
        $this->assign([
            "carouselPic" => $carouselPic,
            "story"=>$story,
        ]);
    	$this -> show();
    }
}