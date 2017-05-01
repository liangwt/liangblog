<?php 
namespace Home\Controller;
use Home\Controller\CommonController;

class ArticleController extends CommonController{

	private $articleL;

	public function writeArticle(){	
/*		print_r($article);
		print_r($tag);
		exit();*/
		//展示分类下拉列表
		$classification = D("classification")->where(array("uid"=>$_SESSION['uid']))->select();
		$this->assign([
			"classification"=>$classification,
			]);
		$this->show();
	}
	/**
	 * 显示博客列表
	 * @return [type] [description]
	 */
	public function showArticle(){	
		$article = D("ArticleView");

		//分页之后的文章列表
		$this->articleL = $article->where("article.uid=".$_SESSION['uid'])
                                  ->group("article.id")
                                  ->order('last_edit_time desc')
                                  ->page(I("get.p",1).',5')
                                  ->select();
		$this->assign('lists',$this->articleL);// 赋值数据集
		//页码标签
		$count = $article->where("article.uid=".$_SESSION['uid'])->count("distinct article.id");
		$page  = new \Think\Page($count,5);
		$show  = $page->show();
		/*print_r($show);
		exit();*/

		$this->assign("page",$show);
		$this->display(T("Home@Article/showArticle"));
	}

    /**
     * 编辑文章
     * @return [type] [description]
     */
    public function editArticle(){
        $articleM = M("article");   
        $article_id = I("get.id");

        if(!empty($article_id)){
            $article = $articleM->where("id=".$article_id)->find();
            $tag = M("tag") -> where("article_id=".$article_id)->select();
        }
        $this->assign(array(
            "article_info" => $article,
            "tag" => json_encode($tag),
            "edit" => $edit,
            "article_id"=>$id,
            ));
        $this->writeArticle();
/*        
        $articleM = M("article");
        $tagM = M("tag");

        $articleM -> where("id=".$article_id)-> save($article);
        $tagM -> where("article_id=".$article_id)-> delete();*/
    }

	/**
	 * 保存博客内容
	 * @return [type] [description]
	 */
	public function saveArticle(){
		$content        = I("post.content");
		$title          = I("post.title");
		$classification = I("post.classification");
		$tag            = I("post.tag");
        $article_id     = I("get.id");
        $public         = I("post.public",0);

        $articleM = M("article");
        $tagM = M("tag");
        //处理没有id传入情况即新建一篇文章
        if(empty($article_id)){
            $article = array(
                "title"             => $title,
                "content"           => $content,
                "create_time"       => date("Y-m-d H:m:s"),
                "last_edit_time"    => date("Y-m-d H:m:s"),
                "classification_id" => $classification,
                "uid"               => $_SESSION["uid"],
                "public"            => $public,
                );     
            $article_id = $articleM -> add($article);   

        }else{
            //处理有id情况即更新一篇文章
            $article = array(
                "title"             => $title,
                "content"           => $content,
                "last_edit_time"    => date("Y-m-d H:m:s"),
                "classification_id" => $classification,
                "uid"               => $_SESSION["uid"],
                );  
            $articleM -> where(["id"=>$article_id])->save($article);
            $tagM -> where(["article_id"=>$article_id]) -> delete();
        }
	
		//这里暂时不清楚如何使用同时插入多个标签数据 所以选择分开插入
		foreach ($tag as $key => $value) {
			$data = array(
				"name" => $value,
				"article_id" => $article_id,
				);
			$result = M("tag") -> add($data);
		}

		if($result){
			$response = array(
				'status'  => 1,
				'message' => $title ."已保存",
                'article_id' => $article_id,
				);
			echo json_encode($response);
		}
	}

    /**
     * 删除文章
     * @return [json] [description]
     */
	public function deleteArticle(){
		$article_id = I("get.id");
        $articleM = M("Article");
        if(!empty($article_id)){
            $articleM ->where("id=".$article_id)-> delete();
            echo json_encode(["status"=>1,"message"=>$article_id]);
        }else{
            echo json_encode(["status"=>0,"message"=>"删除失败"]);
        }	
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
     * 改变文章的公开状态
     */
	public function chgstatus(){
	    $id = I("get.id");
	    $articleM = M("article");
	    $status = $articleM -> where("id=".$id) -> find();
	    if($status["public"]==1){
	        $articleM ->where("id=".$id) -> save(["public"=>0]);
	        $response = array(
	            "status" => 1,
                "message" => "change to private"
            );
        }else{
            $articleM ->where("id=".$id) -> save(["public"=>1]);
            $response = array(
                "status" => 1,
                "message" => "change to public"
            );
        }
        echo json_encode($response);
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
	/**
	 * 处理添加分类的ajax 
	 * @return [json] [description]
	 */
	public function saveClassification(){
		$classM = M("classification");
		$result = $classM->where(array(
				"classification"=>I("post.classification"),
				"uid"=>$_SESSION['uid']))->find();
		if($result){
			echo json_encode(array("status"=>0,"message"=>"分类已存在"));
			return false;
		}
		$value = $classM -> add(array(
				"classification"=>I("post.classification"),
				"uid"=>$_SESSION['uid'],
				));
		if($value){
			echo json_encode(array("status"=>1,"message"=>$value));
		}else{
			echo json_encode(array("status"=>0,"message"=>"添加失败"));
		}

	}
	/**
	 * 保存ajax提交过来的评论
	 * @return [type] [description]
	 */
	public function saveComment(){
		$comment_data = [
			"uid" => 0,
			"article_id" => I("post.article_id"),
			"content" => I("post.comment_text"),
			"time" => date("Y-m-d H:m:s"),
			"comment_id" => 0,
			];
		$commentM = M("comment");
		$result = $commentM -> add($comment_data);
		if($result){
			echo json_encode(["status"=>"1","message"=>$result]);
		}else{
			echo json_encode(["status"=>"0","message"=>"error"]);
		}
	}
    /**
     * 处理编辑和写入文章时的图片插入
     * @return [string] [图片所在地址]
     */
    public function uploadPic(){
        $config = array(
            'maxSize'    =>    0,
            'rootPath'   =>    'public/',
            'savePath'   =>    'uploads/ArticlePic/',
            'saveName'   =>    array('uniqid',''),
            'exts'       =>    array('jpg', 'gif', 'png', 'jpeg'),
            'autoSub'    =>    true,
            'subName'    =>    array('date','Ymd'),
        );
        $upload = new \Think\Upload($config);// 实例化上传类
        $info   =   $upload->upload();
        if(!$info) {
            // 上传错误提示错误信息
            echo "error|".$upload->getError();
        }else{
            // 上传成功 获取上传文件信息
            foreach ($info as $file) {
                $path = __ROOT__."/Public/".$file["savepath"].$file['savename'];
                echo $path;
            }
        }
    }


}
?>
