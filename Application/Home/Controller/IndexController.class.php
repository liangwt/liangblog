<?php
namespace Home\Controller;
use Think\Controller;
class IndexController extends Controller {
    public function index(){
/*    	print_r($_SESSION);
    	exit;*/
    	$this -> show();
    }
}