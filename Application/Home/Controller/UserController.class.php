<?php 
namespace Home\Controller;
use Home\Controller\CommonController;

class UserController extends CommonController{

	public function editBasic(){
		$this -> show();
	}
	/**
	 * 用来处理ajax文件上传的函数，即uploader
	 * @return [type] [description]
	 */
	public function uploadify(){
		$config = array(
	    'maxSize'    =>    0,
	    'rootPath'   =>    'Public/',
	    'savePath'   =>    'uploads/face/',
	    'saveName'   =>    array('uniqid',''),
	    'exts'       =>    array('jpg', 'gif', 'png', 'jpeg'),
	    'autoSub'    =>    true,
	    'subName'    =>    array('date','Ymd'),
		);
		$upload = new \Think\Upload($config);// 实例化上传类
		$info   =   $upload->upload();
		if(!$info) {// 上传错误提示错误信息
    		$response = array(
    			"status" => 0,
    			"message" => $upload->getError(),
    		);
		}else{// 上传成功 获取上传文件信息
			foreach ($info as $file) {
				$path = "Public/".$file["savepath"].$file['savename'];
				$newPath = str_replace("face", "littleface", $file["savepath"]);
				//构造一个新的路径存放缩略图
				$newPath = "Public/".$newPath;
				if(!is_dir($newPath)){
					mkdir($newPath);
				}
				$newPath .= $file['savename'];

				$image = new \Think\Image(); 
				$image->open($path);
				// 按照原图的比例生成一个最大为150*150的缩略图并保存为thumb.jpg
				$image->thumb(150, 150,\Think\Image::IMAGE_THUMB_FIXED)->save($newPath);
				$response = array(
					'status' => 1,
					"message" => $newPath,
					"old" => $path,
					"newPath1" => $newPath1
				);
			}
    	}
    	echo json_encode($response);
	}

	public function basicForm(){
		$basicPost = I("post.");

		$user = M("user_info");
		$result = $user->where("uid=".$_SESSION['uid'])->add($basicPost);
		if($result){
			echo 1;
			return false;
		}
		echo 0;
	}


}


?>