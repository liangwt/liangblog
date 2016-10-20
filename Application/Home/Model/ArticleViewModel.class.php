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
			"uid",
			),
		"user_info"  => array(
			"username",
			"_on" => "article.uid=user_info.uid" 
			),
		);

}
?>