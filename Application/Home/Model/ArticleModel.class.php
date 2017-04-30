<?php
namespace Home\Model;
use Think\Model\RelationModel;

class ArticleModel extends RelationModel{
	protected $_link = array(
		"classification" => array(
			"mapping_type" => self::BELONGS_TO,
			"class_name" => "classification",
			"parent_key" => "classification_id",
			),
		"tag" => array(
			"mapping_type" => self::HAS_MANY,
			"class_name"  => "Tag",
			"foreign_key" => "article_id",
			),
		);
}

?>