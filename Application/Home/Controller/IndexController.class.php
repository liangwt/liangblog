<?php
namespace Home\Controller;
use Think\Controller;
class IndexController extends Controller {
    public function index(){
/*    	print_r($_SESSION);
    	exit;*/
        $carouselPic = getBingWaller(0,3);
        $this->assign([
            "carouselPic" => $carouselPic,
        ]);
    	$this -> show();
    }
}