<?php
/**
 * Created by PhpStorm.
 * User: LiangWentao
 * Date: 1/5/2017
 * Time: 22:49
 */
namespace Admin\Controller;

use Think\Controller;

class ArticleController extends Controller
{
    function index()
    {
        //文章管理
        $articleL     = M("article")
            ->field("*,blog_article.id as article_id")
            ->join("left join __USER_INFO__ on __USER_INFO__.id=__ARTICLE__.uid")
            ->order("last_edit_time")
            ->page(I("get.p", 1), 5)
            ->select();
        $articleCount = M("article")->count();
        $articlePage  = new \Think\Page($articleCount, 5);
        $articleShow  = $articlePage->show();
        $this->assign(array(
            "articleList" => $articleL,
            "articleShow" => $articleShow,
        ));
        $this->display();
    }

    function showArticle()
    {
        $articleL = M("article")->where("id=" . I("get.id"))->find();
        if ($articleL) {
            $this->display();
        } else {
            $this->show("文章不存在");
        }

    }

    function viewData()
    {
        $viewDataL = M("article_view")
            ->field("count(*) as num,Date(view_datetime) as date")
            ->group("Date(view_datetime)")
            ->order("view_datetime")
            ->where("article_id=" . I("get.id"))
            ->select();
        $response  = array();
        foreach ($viewDataL as $n => $t) {
            $response["num"][]  = $t["num"];
            $response["date"][] = $t["date"];
        }
        echo json_encode($response);
        /*        print_r(json_encode($response));*/
    }

    function locationData()
    {
        $viewDataL = M("article_view")
            ->where("article_id=" . I("get.id"))
            ->select();
        foreach ($viewDataL as $viewData) {
            $locationData[] = $viewData["ip_province"];
        }
        $locationCount = array_count_values($locationData);
        foreach ($locationCount as $name => $value) {
            $response[] = array(
                "name"  => $name,
                "value" => $value,
            );
        }
        echo json_encode($response);
    }
}