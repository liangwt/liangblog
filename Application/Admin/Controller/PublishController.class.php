<?php
/**
 * Created by PhpStorm.
 * User: LiangWentao
 * Date: 12/28/2016
 * Time: 22:18
 */
namespace Admin\Controller;
use Think\Controller;

/**
 * Class PublishController
 * @package Admin\Controller
 * 负责后台版本发布信息
 */
class PublishController extends Controller{
    public function index(){
        $this->show();
    }
    public function post(){
        $versionM = M('version');
        $postData = array(
            $version = I("post.version"),

        );
    }

}