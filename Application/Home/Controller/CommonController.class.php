<?php
namespace Home\Controller;
use Think\Controller;

class CommonController extends Controller{

	public function _initialize(){
		$ip = get_client_ip();
		$cookieValue = explode("|",encryption($_COOKIE['auto'],0));
		if(isset($_COOKIE['auto']) && !isset($_SESSION['uid'])){
			if($ip == $cookieValue[0]){
				$user = M('user');
				$result = $user->where("id=".$cookieValue[1])->find();
				if(!$result){
					$this->redirect("index/index",'',3,"登录失败请重新登陆");
				}
				if($result['lock']){
					$this->error('账户已锁定');
				}
				$_SESSION['uid'] = $result['id'];
				$_SESSION['username'] = $account;
			}
		}
		if(!isset($_SESSION['uid'])){
			$this->redirect("Admin/login/index",'',3);
		}

		$article = D("Home/ArticleView");
		$classificationL = $article 
						 ->field("classification,count(distinct article.id) as classification_num") 
						 ->where(array("classification.uid"=>$_SESSION['uid']))
						 ->group("classification")
						 ->select();
		$this -> assign("classificationL",$classificationL);

	}
}


?>