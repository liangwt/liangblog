<?php
/**
 * Created by PhpStorm.
 * User: LiangWentao
 * Date: 1/5/2017
 * Time: 18:36
 */
namespace Admin\Controller;
use Think\Controller;
use Think\Crypt\Driver\Think;

class IndexController extends Controller{
    /**
     * 用于后台显示出文章和用户
     */
    function index(){
        //用户管理
        $userL = M("user")
            ->field("*,GROUP_CONCAT(rolename) as rolenames")
            ->join("__USER_INFO__ on __USER_INFO__.uid=__USER__.id")
            ->join("__USER_ROLE_RELATION__ on __USER__.id = __USER_ROLE_RELATION__.user_id")
            ->join("__ROLE__ on __ROLE__.id = __USER_ROLE_RELATION__.role_id")
            ->group("blog_user.id")
            ->order("reg_time")
            ->select();
        $this->assign(array(
            "userList" => $userL,
        ));
        //文章管理
        $articleL = M("article")
            ->field("*,blog_article.id as article_id")
                    ->join("left join __USER_INFO__ on __USER_INFO__.id=__ARTICLE__.uid")
                    ->order("last_edit_time")
                    ->page(I("get.p",1),5)
                    ->select();
        $articleCount = M("article")->count();
        $articlePage = new \Think\Page($articleCount,5);
        $articleShow = $articlePage->show();
        $this->assign(array(
           "articleList" =>  $articleL,
            "articleShow" => $articleShow,
        ));
        $this->display();
    }
}