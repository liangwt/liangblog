<?php
/**
 * Created by PhpStorm.
 * User: LiangWentao
 * Date: 1/5/2017
 * Time: 22:49
 */
namespace Admin\Controller;
use Think\Controller;
class ArticleController extends Controller{
    function showArticle(){
        $this->display();
    }
    function viewData(){
        $viewDataL = M("article_view")
            ->field("count(*) as num,Date(view_datetime) as date")
            ->group("Date(view_datetime)")
            ->order("view_datetime")
            ->where("article_id=".I("get.id"))
            ->select();
        $response = array();
        foreach ($viewDataL as $n => $t){
            $response["num"][] = $t["num"];
            $response["date"][] = $t["date"];
        }
        echo json_encode($response);
/*        print_r(json_encode($response));*/
    }
    function locationData(){
        $viewDataL = M("article_view")
            ->where("article_id=".I("get.id"))
            ->select();
        foreach ($viewDataL as $viewData ){
            $locationData[]=$viewData["ip_province"];
        }
        $locationCount = array_count_values($locationData);
        foreach ($locationCount as $name=>$value){
            $response[]=array(
                "name"=>$name,
                "value"=>$value,
            );
        }
        echo json_encode($response);
    }
}