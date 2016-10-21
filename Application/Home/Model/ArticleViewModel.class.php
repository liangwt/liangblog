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
			"_on" => "article.classification_id=classification.id",
			"_type" => "LEFT",
			),
		"tag" => array(
			"name",
			"_on" => "tag.article_id=article.id"
			),
		);

}
?>