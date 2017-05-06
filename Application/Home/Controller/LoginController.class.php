<?php
namespace Home\Controller;
use Think\Controller;

class LoginController extends Controller{
    //ajax判断是否登录并且没有被锁定
    public function LoginAndHasAccess(){
        if(!IS_AJAX){
            E('页面不存在');
        }
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
        if(isset($_SESSION['uid'])){
            $responseArray = [
                "status" => 1,
                "message" => "success"
            ];
        }else {
            $responseArray = [
                "status" => 0,
                "message" => "error"
            ];
        }
        echo json_encode($responseArray);
    }
	function register(){
/*		if(!IS_AJAX){
			E('页面不存在');
		}*/
		$account   = I("post.account");
		$password  = I("post.password");
		$rpassword = I("post.rpassword");
		if(empty($account) || empty($password) || empty($rpassword) ){
			$responseJsData['status'] = 0;
			$responseJsData['message'] = '不能为空';
			echo json_encode($responseJsData);
			return false;
		}
		//验证密码是否一致
		if($rpassword!=$password){
			$responseJsData['status']  = 0;
			$responseJsData['message'] = '密码不一致';
			echo json_encode($responseJsData);
			return false;
		}
		//验证账号是否存在
		$existAccount = array('account'=>$account);
		$result = D('user')->where($existAccount)->find();
		if(!empty($result)){
			$responseJsData['status']  = 0;
			$responseJsData['message'] = '账号已存在';
			echo json_encode($responseJsData);
			return false;
		}
		//创建账号
		$registerAccount = array(
			'account'  => $account,
			'password' => md5($password),
			'reg_time' => date("Y-m-d H:i:s"),
			'user_info' => array(
				'username' => "User_".$account,
				),
			);
		$uid = D('Home/UserRelation') -> relation(true)-> add($registerAccount);
		if($uid){
			$_SESSION['uid']      = $uid;
			$_SESSION['username'] = $account;
			//加入cookie
			$ip = get_client_ip();
			setcookie('auto',encryption($ip."|".$uid),time()+3600*24*7,'/');
			//返回json数据
			$responseJsData['status']  = 1;
			$responseJsData['message'] = '账号创建成功';
			echo json_encode($responseJsData);
		}else{
			$responseJsData['status']  = 0;
			$responseJsData['message'] = '账号创建失败';
			echo json_encode($responseJsData);
		}
	}

	function login(){
		$account   = I("post.account");
		$password  = I("post.password");
		$auto = I("post.auto");
		$varify_code = I("post.varify_code");

		//验证账号是否存在
		$existAccount = array('account'=>$account);
		$result = D('user')->where($existAccount)->find();
		if($result == null){
			$responseJsData['status'] = 0;
			$responseJsData['message'] = '账号不存在';
			echo json_encode($responseJsData);
			return false;
		}
		if($result['password'] != md5($password)){
			$responseJsData['status'] = 0;
			$responseJsData['message'] = '密码错误';
			echo json_encode($responseJsData);
			return false;
		}
		if($result['lock']){
			$responseJsData['status'] = 0;
			$responseJsData['message'] = '账号已锁定';
			echo json_encode($responseJsData);
			return false;
		}
        //验证验证码
        $verify = new \Think\Verify();
    	$result['varify_code'] = $verify->check($varify_code);
		if(!$result['varify_code']){
            $responseJsData['status'] = 0;
            $responseJsData['message'] = '验证码错误';
            echo json_encode($responseJsData);
            return false;            
        }
		//
		$_SESSION['uid'] = $result['id'];
		$_SESSION['username'] = $account;
		if($auto){
			//加入cookie
			$ip = get_client_ip();
			setcookie('auto',encryption($ip."|".$result['id']),time()+3600*24*7,'/');
		}

		//返回json数据
		$responseJsData['status'] = 1;
		$responseJsData['message'] = '登陆成功';
		echo json_encode($responseJsData);
	}

	function logout(){
		unset($_SESSION['uid']);
		unset($_SESSION['username']);
		setcookie('auto','',time()-3600,'/');
		$responseJsData['status']  = 1;
		$responseJsData['message'] = '退出登录';
		echo json_encode($responseJsData);
	}
	//生成验证码的地址
	function verifyCode(){
		$Verify = new \Think\Verify();
		$Verify->entry();
	}

}



?>