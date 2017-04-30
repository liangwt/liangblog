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
        $versionM = M('about');
        $postData = array(
            "title" => I("POST.content"),
            "version" => I("POST.version"),
            "content" => I("POST.content"),
            "modify_time" => I("POST.PubDate"),
            "create_by" => "liangwt",

        );
        $versionM -> add($postData);
    }

}