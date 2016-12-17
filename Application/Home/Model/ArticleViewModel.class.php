<?php
namespace Home\Model;
use Think\Model\ViewModel;

class ArticleViewModel extends ViewModel{
	protected $viewFields = array(
		"article" => array(
			"id",
			"title",
			"content",
			"create_time",
			"last_edit_time",
			"classification_id",
			"uid",
			"_type" => "LEFT",
			),
		"user_info"  => array(
			"username",
			"_on"   => "article.uid=user_info.uid" ,
			"_type" => "LEFT",
			),
		"classification" => array(
			"classification",
			"uid" => "class_id",
			"_on"   => "article.classification_id=classification.id",
			"_type" => "LEFT",
			),
		"tag" => array(
			"name"  => "tag_name",
			"_on"   => "tag.article_id=article.id",
			"_type" => "LEFT",
			),
		"comment" => array(
			"id"  => "cid",
			"uid" => "comment_uid",
			"article_id",
			"content"=>"comment_content",
			"time",
			"comment_pid",
			"comment_rid",
			"_on" => "article.id = comment.article_id"),
		);

}
?>