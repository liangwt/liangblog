<?php
namespace Home\Controller;
use Think\Controller;
class IndexController extends Controller {
    public function index(){
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