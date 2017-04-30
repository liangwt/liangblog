<?php
namespace Home\Model;
use Think\Model\RelationModel;
class UserRelationModel extends RelationModel{
	protected $tableName = "user";
	protected $_link = array(
		"user_info" => array(
			"mapping_type" => self::HAS_ONE,
			"class_name" => "user_info",
			"foreign_key" => "uid",
			), 
		);
}

?>