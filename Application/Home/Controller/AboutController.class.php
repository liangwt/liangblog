<?php
namespace Home\Controller;
use Think\Controller;

class AboutController extends Controller{
	function about(){
		$aboutM = D("about");
		$versionL = $aboutM -> order("modify_time desc") -> select();
		$this->assign(array(
			"versionL" => $versionL,
			));
/*		print_r($versionL);
		exit();*/
		$this->show();
	}


}

?>