<?php 
namespace Home\Controller;
use Home\Controller\CommonController;

class ArticleController extends CommonController{
	public function writeArticle(){
		$classification = D("classification")->select();
		$this->assign("classification",$classification);
		$this->show();
	}
	/**
	 * 显示博客列表
	 * @return [type] [description]
	 */
	public function showArticle(){
		$article = D("ArticleView");
		$lists = $article->where("article.uid=".$_SESSION['uid'])->order('create_time desc')->page(I("get.p",1).',5')->select();
		$this->assign('lists',$lists);// 赋值数据集
		$count = $article->where("article.uid=".$_SESSION['uid'])->count("article.id");
		$page  = new \Think\Page($count,5);
		$show  = $page->show();
		$this->assign("page",$show);
		$this->show();
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

		$article = array(
			"title"             => $title,
			"content"           => $content,
			"create_time"       => date("Y-m-d H:m:s"),
			"last_edit_time"    => date("Y-m-d H:m:s"),
			"classification_id" => $classification,
			"uid"               => $_SESSION["uid"],
			);
		$ArticleM = M("article");
		//这里暂时不清楚如何使用同时插入多个标签数据 所以选择分开插入
		$article_id   = $ArticleM->add($article);
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
				);
			echo json_encode($response);
		}
	}
	/**
	 * 显示单个文章内容
	 * @param  int    $id 文章id
	 * @return [type]     [description]
	 */
	public function detailArticle($id){
		$article = D("ArticleView")->where("article.id=".$id)->find();
		$this -> assign("list",$article);
		$this -> show();
	}
	/**
	 * 处理添加分类的ajax 
	 * @return [type] [description]
	 */
	public function saveClassification(){
		$classM = M("classification");
		$result = $classM->where(array("classification"=>I("post.classification")))->find();
		if($result){
			echo json_encode(array("status"=>0,"message"=>"分类已存在"));
			return false;
		}
		$value = $classM -> add(array("classification"=>I("post.classification")));
		if($value){
			echo json_encode(array("status"=>1,"message"=>$value));
		}else{
			echo json_encode(array("status"=>0,"message"=>"添加失败"));
		}

	}
}
?>