<?php
namespace Home\Controller;
use Think\Controller;

class AboutController extends Controller{
	function about(){
		$aboutM = D("about");
		$versionL = $aboutM -> select();
		$this->assign(array(
			"versionL" => $versionL,
			));
/*		print_r($versionL);
		exit();*/
		$this->show();
	}


}

?>