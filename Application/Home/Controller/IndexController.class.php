<?php
namespace Home\Controller;
use Think\Controller;
class IndexController extends Controller {
    public function index(){
        //打开首页进行自动登录判断,除了成功建立session其他情况不做操作
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
/*    	print_r($_SESSION);
    	exit;*/
        getBingWaller(0,1);
        $carouselPic =  M("index")->order("id desc")->limit(3)->select();
        $story =  M("index")->order("id desc")->find();
        $this->assign([
            "carouselPic" => $carouselPic,
            "story"=>$story,
        ]);
    	$this -> show();
    }

    /**
     * 显示首页上的文章列表
     * 文章的权限为公开
     * 右侧分为热门文章与热门评论热门分类
     */
    public function showArticle(){
        $article = D("ArticleView");
        //分页之后的文章列表
        $this->articleL = $article->where(["public"=>1])
            ->group("article.id")
            ->order('last_edit_time desc')
            ->page(I("get.p",1).',5')
            ->select();
        /*print_r($this->articleL);
        exit();*/
        $this->assign('lists',$this->articleL);// 赋值数据集
        //页码标签
        $count = $article->where(["public"=>1])->count("distinct article.id");
        $page  = new \Think\Page($count,5);
        $show  = $page->show();
        /*print_r($show);
        exit();*/

        $this->assign("page",$show);
        $this->display(T("Home@Index/showArticle"));
    }

    /**
     * 显示单个文章内容
     * @param  int    $id 文章id
     * @return [type]     [description]
     */
    public function detailArticle($id){
        if(!empty($id)){
            //记录访问信息，5分钟之外访问记录
            recodeView($id);
            //展示文章信息
            $article = D("ArticleView")->where("article.id=".$id)->find();//文章信息
            $comment = $this->showComment($id);
            $tags    = M("tag") -> where("article_id=".$id) -> select();//标签信息
            $this -> assign([
                "list"            => $article,
                "classificationL" => $this->classificationL,
                "comment"         => $comment,
                "tags"            => $tags,
            ]);
            //检测是否有读取这篇文章的权限
            //当作者为文章作者时，可以编辑
            if($article["uid"]==$_SESSION["uid"]){
                $this -> display(T("Home@Article/detailArticle_private"));
            }elseif ($article["uid"]!=$_SESSION["uid"] && $article["public"]==1){
                //当不是作者但是文章为公开的时候，可读但是不可写
                $this -> display(T("Home@Article/detailArticle_public"));
            }else{
                //当既不是作者文章又不是公开的时候，报错
                E("error");
            }
        }else{
            E("error");
        }

        /*		print_r($tags);
                exit();*/

    }
    /**
     * 读取评论，通过读取根评论来获得跟评论下面的所有评论
     * @param  integer $articleId   文章id
     * @return array   $rootComment 评论数组
     */
    private function showComment($articleId=0){
        $commentWhere = array(
            "article_id" => $articleId,
            "comment_pid" => 0,
        );
        $rootComment = M("comment")->where($commentWhere)->order("time")->select();//根评论信息
        foreach ($rootComment as $key => $value) {
            $commentWhere = array(
                "article_id" => $articleId,
                "comment_rid" => $value["id"],
            );
            //获得二级评论，键值为根评论
            $rootComment[$key]["secondComment"] = M("comment")->where($commentWhere)->order("time")->select();
        }
        return $rootComment;
        /*		print_r($rootComment);
                print_r($secondComment);*/
    }
}