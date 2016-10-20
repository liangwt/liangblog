
DROP TABLE if exists `blog_user`;
DROP TABLE if exists `blog_user_info`;
DROP TABLE if exists `blog_article`;

CREATE TABLE if not exists `blog_user`  (
`id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
`account` int(11) UNSIGNED NOT NULL COMMENT '用户账户',
`password` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '用户密码',
`reg_time` datetime NULL,
`lock` tinyint(1) NULL DEFAULT 0 COMMENT '用户是否被锁定（1为被锁定 0为没有被锁定）',
PRIMARY KEY (`id`) ,
INDEX `account` (`account` ASC),
INDEX (`id` ASC)
)engine=myisam default charset=utf8;

CREATE TABLE if not exists `blog_user_info` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户信息id',
`username` varchar(50) NOT NULL COMMENT '用户名',
`truename` varchar(50) NULL COMMENT '用户真实姓名',
`age` datetime NULL COMMENT '用户年龄',
`sex` enum('m','f') NULL COMMENT '用户性别m为男性，f为女性',
`intrdocue` varchar(50) NULL,
`faceAdress` varchar(50) NULL,
`email` varchar(50) NULL,
`province` varchar(50) NULL,
`city` varchar(50) NULL,
`uid` int(11) NOT NULL COMMENT '用户id',
PRIMARY KEY (`id`) ,
INDEX (`id` ASC),
INDEX (`username` ASC)
)engine=myisam default charset=utf8;

CREATE TABLE if not exists `blog_article` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`title` varchar(50) NOT NULL,
`content` char(255) NULL,
`create_time` datetime NOT NULL,
`last_edit_time` datetime NOT NULL,
`uid` int(11) NOT NULL,
PRIMARY KEY (`id`) ,
INDEX (`id` ASC),
INDEX (`title` ASC)
)engine=myisam default charset=utf8;


ALTER TABLE `blog_user_info` ADD CONSTRAINT `fk_blog_user_info_uid` FOREIGN KEY (`uid`) REFERENCES `blog_user` (`id`);
ALTER TABLE `blog_article` ADD CONSTRAINT `fk_blog_user_article_uid` FOREIGN KEY (`uid`) REFERENCES `blog_user` (`id`);

