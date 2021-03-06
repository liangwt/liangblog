﻿SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS  `blog_about`;
CREATE TABLE `blog_about` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` char(20) NOT NULL COMMENT '版本更新的大标题',
  `version` char(20) NOT NULL,
  `content` varchar(255) NOT NULL,
  `modify_time` char(20) NOT NULL,
  `creaet_by` char(20) NOT NULL COMMENT '此次版本的创建者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

insert into `blog_about`(`id`,`title`' at row 3
,`version`,`content`,`modify_time`,`creaet_by`) values
('2','返回顶部','2.0','&lt;p&gt;&lt;ul&gt;&lt;li&gt;修改了关于页&lt;br&gt;&lt;/li&gt;&lt;li&gt;修复了注册和登陆在关于页不弹出的bug&lt;br&gt;&lt;/li&gt;&lt;li&gt;加入了返回顶部的快捷按钮&lt;br&gt;&lt;/li&gt;&lt;li&gt;调整了导航栏位置，修复了个人中心弹出不与导航栏平齐的bug&lt;/li&gt;&lt;li&gt;修改了部分配色&lt;/li&gt;','2016/12/31','liang'),
('3','&lt;p&gt;&lt;ul&gt;&','3.0','&lt;p&gt;&lt;ul&gt;&lt;li&gt;增加了用户管理和文章管理&lt;/li&gt;&lt;li&gt;新增了角色创建和用户添加&lt;/li&gt;&lt;li&gt;todo：增加用户编辑，角色编辑，权限显示&lt;/li&gt;&lt;/ul&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','2017/02/16',''),
('4','&lt;p&gt;&lt;ul&gt;&','1.0','&lt;p&gt;&lt;ul&gt;&lt;li&gt;添加了关于页&amp;nbsp;&lt;/li&gt;&lt;li&gt;修改了分类的数据模型&lt;/li&gt;&lt;li&gt;分类只能自己看到&lt;br&gt;&lt;/li&gt;&lt;/ul&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','2016/12/06',''),
('5','&lt;p&gt;&lt;ul&gt;&','4.0','&lt;p&gt;&lt;ul&gt;&lt;li&gt;增加了用户管理&lt;/li&gt;&lt;li&gt;增加角色管理&lt;/li&gt;&lt;li&gt;增加权限管理&lt;/li&gt;&lt;/ul&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','2017/02/26',''),
('6','&lt;p&gt;&lt;ul&gt;&','4.5','&lt;p&gt;&lt;ul&gt;&lt;li&gt;首页加入了bing每日图片&lt;/li&gt;&lt;li&gt;首页侧边栏变为bing每日故事&lt;/li&gt;&lt;li&gt;其它调整&lt;/li&gt;&lt;/ul&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','2017/02/28','');
DROP TABLE IF EXISTS  `blog_article`;
CREATE TABLE `blog_article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `content` mediumtext,
  `create_time` datetime NOT NULL,
  `last_edit_time` datetime NOT NULL,
  `classification_id` int(11) unsigned DEFAULT NULL,
  `uid` int(11) NOT NULL,
  `public` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '是否公开，默认为否(0)',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `title` (`title`),
  KEY `fk_blog_user_article_uid` (`uid`) USING BTREE,
  CONSTRAINT `blog_article_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

insert into `blog_article`(`id`,`title`,`content`,`create_time`,`last_edit_time`,`classification_id`,`uid`,`public`) values
('6','使用拉链法解决冲突的简单hash表','&lt;p&gt;&amp;nbsp;Hash函数的作用是把任意长度的输入，通过hash算法变换成固定长度的输出，该输出就是hash值，hash表的复杂度为O(1)。&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;?php 
/**
 * 一个简单的hash表
 * 使用拉链法解决冲突
 */
class hashtable{
	private $buckets;   //存储数据数组
	private $size = 10;

	public function __construct(){
		$this -&amp;gt; buckets = new SplFixedArray($this-&amp;gt;size);
	}
	/**
	 * 通过把字符串相加取余得到hash值
	 * @param  string $key 关键字
	 * @return int         hash值
	 */
	private function hashfunc($key){
		$strlen  = strlen($key);
		$hashval = 0;
		for ($i=0; $i &amp;lt; $strlen; $i++) { 
			$hashval += ord($key[$i]);
		}
		return $hashval%$this-&amp;gt;size;
	}
	/**
	 * 1. 使用hsahfuc计算关键字的hash值，通过hash值定位到hash表的指定位置
	 * 2. 如果此位置已经被占用，把新节点的$NextNode指向此节点，否则把$NextNode设置为NULL
	 * 3. 把新节点保存到hash表中
	 * @param  string $key   关键字
	 * @param  string $value 值
	 * @return void        
	 */
	public function insert($key,$value){
		$index = $this-&amp;gt;hashfunc($key);
		if(isset($this-&amp;gt;buckets[$index])){
			$newNode = new HashNode($key,$value,$this-&amp;gt;buckets[$index]);
		}else{
			$newNode = new HashNode($key,$value,null);
		}
		$this-&amp;gt;buckets[$index] = $newNode;
	}
	public function find($key){
		$index   = $this -&amp;gt; hashfunc($key);
		$current = $this -&amp;gt; buckets[$index];
		while (isset($current)) {
			if($current-&amp;gt;key == $key){
				return $current-&amp;gt;value;
			}
			$current = $current-&amp;gt;nextNode;
		}
	}
}

class HashNode{
	public $key;            //节点关键字
	public $value;          //节点的值
	public $nextNode;       //具有相同hash值的节点的指针
	public function __construct($key,$value,$nextNode=null){
		$this -&amp;gt; key      = $key;
		$this -&amp;gt; value    = $value;
		$this -&amp;gt; nextNode = $nextNode;
	}
}

$test = new hashtable();
$test -&amp;gt; insert(\'key1\',\'value1\');
$test -&amp;gt; insert(\'key12\',\'value12\');
$test -&amp;gt; insert(\'key2\',\'value2\');
var_dump($test -&amp;gt; find(\'key1\'));
var_dump($test -&amp;gt; find(\'key12\'));
var_dump($test -&amp;gt; find(\'key2\'));

 ?&amp;gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;&lt;img src=&quot;data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==&quot;&gt;&lt;img src=&quot;data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','2016-10-13 00:00:00','2016-10-13 00:00:00','2','1','0'),
('16','Sample blog post','&lt;p&gt;This blog post shows a few different types of content that\'s supported and styled with Bootstrap. Basic typography, images, and code are all supported.&lt;/p&gt;&lt;p&gt;Cum sociis natoque penatibus et magnis&amp;nbsp;&lt;a href=&quot;http://127.0.0.1/liangblog/index.php/Home/Index/index.html#&quot;&gt;dis parturient montes&lt;/a&gt;, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet fermentum.&lt;/p&gt;&lt;blockquote&gt;Curabitur blandit tempus porttitor.&amp;nbsp;Nullam quis risus eget urna mollis&amp;nbsp;ornare vel eu leo. Nullam id dolor id nibh ultricies vehicula ut id elit.&lt;/blockquote&gt;&lt;p&gt;&lt;/p&gt;&lt;p&gt;Etiam porta&amp;nbsp;sem malesuada magna&amp;nbsp;mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','2016-10-15 00:00:00','2016-10-15 00:00:00','1','1','0'),
('18','NEW FEATURE','&lt;p&gt;Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Praesent commodo cursus magna, vel scelerisque nisl consectetur et.&lt;/li&gt;&lt;li&gt;Donec id elit non mi porta gravida at eget metus.&lt;/li&gt;&lt;li&gt;Nulla vitae elit libero, a pharetra augue.&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Etiam porta&amp;nbsp;sem malesuada magna&amp;nbsp;mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.&lt;/p&gt;&lt;p&gt;&lt;/p&gt;&lt;p&gt;Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','2016-10-16 21:10:28','2016-10-16 21:10:28','2','1','1'),
('68','IF标签','&lt;p&gt;用法示例：&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;if condition=&quot;($name eq 1) OR ($name gt 100) &quot;&amp;gt; value1
&amp;lt;elseif condition=&quot;$name eq 2&quot;/&amp;gt;value2
&amp;lt;else /&amp;gt; value3
&amp;lt;/if&amp;gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;在condition属性中可以支持eq等判断表达式，同上面的比较标签，但是不支持带有”&amp;gt;”、”&amp;lt;”等符号的用法，因为会混淆模板解析，所以下面的用法是错误的：&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;if condition=&quot;$id &amp;lt; 5 &quot;&amp;gt;value1
    &amp;lt;else /&amp;gt; value2
&amp;lt;/if&amp;gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;必须改成：&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;if condition=&quot;$id lt 5 &quot;&amp;gt;value1
&amp;lt;else /&amp;gt; value2
&amp;lt;/if&amp;gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;除此之外，我们可以在condition属性里面使用php代码，例如：&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;if condition=&quot;strtoupper($user[\'name\']) neq \'THINKPHP\'&quot;&amp;gt;ThinkPHP
&amp;lt;else /&amp;gt; other Framework
&amp;lt;/if&amp;gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;condition属性可以支持点语法和对象语法，例如： 自动判断user变量是数组还是对象&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;if condition=&quot;$user.name neq \'ThinkPHP\'&quot;&amp;gt;ThinkPHP
&amp;lt;else /&amp;gt; other Framework
&amp;lt;/if&amp;gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;或者知道user变量是对象&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;if condition=&quot;$user:name neq \'ThinkPHP\'&quot;&amp;gt;ThinkPHP
&amp;lt;else /&amp;gt; other Framework
&amp;lt;/if&amp;gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;&lt;/p&gt;&lt;p&gt;t由于if标签的condition属性里面基本上使用的是php语法，尽可能使用判断标签和Switch标签会更加简洁，原则上来说，能够用switch和比较标签解决的尽量不用if标签完成。因为switch和比较标签可以使用变量调节器和系统变量。如果某些特殊的要求下面，IF标签仍然无法满足要求的话，可以使用原生php代码或者PHP标签来直接书写代码。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','2016-10-25 21:10:35','2016-10-25 21:10:35','23','1','0'),
('69','jQuery.parseJSON(json)','&lt;h2&gt;&lt;span style=&quot;font-family: inherit; font-size: 34px; letter-spacing: 0.1px;&quot;&gt;概述&lt;/span&gt;&lt;br&gt;&lt;/h2&gt;&lt;p&gt;接受一个JSON字符串，返回解析后的对象。&lt;/p&gt;&lt;p&gt;传入一个畸形的JSON字符串会抛出一个异常。比如下面的都是畸形的JSON字符串：&lt;/p&gt;&lt;ul&gt;&lt;li&gt;{test: 1} （ test 没有包围双引号）&lt;/li&gt;&lt;li&gt;{\'test\': 1} （使用了单引号而不是双引号）&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;另外，如果你什么都不传入，或者一个空字符串、null或undefined，parseJSON都会返回 null 。&lt;/p&gt;&lt;h3&gt;参数&lt;/h3&gt;&lt;h4&gt;jsonStringV1.4.1&lt;/h4&gt;&lt;p&gt;要解析的JSON字符串&lt;/p&gt;&lt;h3&gt;示例&lt;/h3&gt;&lt;h4&gt;描述:&lt;/h4&gt;&lt;p&gt;解析一个JSON字符串&lt;/p&gt;&lt;h5&gt;jQuery 代码:&lt;/h5&gt;&lt;p&gt;&lt;/p&gt;&lt;pre&gt;&lt;code&gt;var obj = jQuery.parseJSON(\'{&quot;name&quot;:&quot;John&quot;}\');
alert( obj.name === &quot;John&quot; );&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','2016-10-28 21:10:01','2016-10-28 21:10:01','2','1','0'),
('70','下拉菜单','&lt;h1&gt;&lt;span style=&quot;color: rgb(102, 102, 102); font-size: 15px; letter-spacing: 0.1px;&quot;&gt;用于显示链接列表的可切换、有上下文的菜单。&lt;/span&gt;&lt;a href=&quot;http://v3.bootcss.com/javascript/#dropdowns&quot; style=&quot;background-color: rgb(255, 255, 255); font-size: 15px; letter-spacing: 0.1px;&quot;&gt;下拉菜单的 JavaScript 插件&lt;/a&gt;&lt;span style=&quot;color: rgb(102, 102, 102); font-size: 15px; letter-spacing: 0.1px;&quot;&gt;让它具有了交互性。&lt;/span&gt;&lt;br&gt;&lt;/h1&gt;&lt;h3&gt;实例&lt;/h3&gt;&lt;p&gt;将下拉菜单触发器和下拉菜单都包裹在&amp;nbsp;.dropdown&amp;nbsp;里，或者另一个声明了&amp;nbsp;position: relative;&amp;nbsp;的元素。然后加入组成菜单的 HTML 代码。&lt;/p&gt;&lt;p&gt;&lt;button&gt;Dropdown&amp;nbsp;&lt;/button&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Action&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Another action&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Something else here&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Separated link&lt;/a&gt;&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Copy&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;div class=&quot;dropdown&quot;&amp;gt;
  &amp;lt;button class=&quot;btn btn-default dropdown-toggle&quot; type=&quot;button&quot; id=&quot;dropdownMenu1&quot; data-toggle=&quot;dropdown&quot;&amp;gt;
    Dropdown
    &amp;lt;span class=&quot;caret&quot;&amp;gt;&amp;lt;/span&amp;gt;
  &amp;lt;/button&amp;gt;
  &amp;lt;ul class=&quot;dropdown-menu&quot; role=&quot;menu&quot; aria-labelledby=&quot;dropdownMenu1&quot;&amp;gt;
    &amp;lt;li role=&quot;presentation&quot;&amp;gt;&amp;lt;a role=&quot;menuitem&quot; tabindex=&quot;-1&quot; href=&quot;#&quot;&amp;gt;Action&amp;lt;/a&amp;gt;&amp;lt;/li&amp;gt;
    &amp;lt;li role=&quot;presentation&quot;&amp;gt;&amp;lt;a role=&quot;menuitem&quot; tabindex=&quot;-1&quot; href=&quot;#&quot;&amp;gt;Another action&amp;lt;/a&amp;gt;&amp;lt;/li&amp;gt;
    &amp;lt;li role=&quot;presentation&quot;&amp;gt;&amp;lt;a role=&quot;menuitem&quot; tabindex=&quot;-1&quot; href=&quot;#&quot;&amp;gt;Something else here&amp;lt;/a&amp;gt;&amp;lt;/li&amp;gt;
    &amp;lt;li role=&quot;presentation&quot;&amp;gt;&amp;lt;a role=&quot;menuitem&quot; tabindex=&quot;-1&quot; href=&quot;#&quot;&amp;gt;Separated link&amp;lt;/a&amp;gt;&amp;lt;/li&amp;gt;
  &amp;lt;/ul&amp;gt;
&amp;lt;/div&amp;gt;
&lt;/code&gt;&lt;/pre&gt;&lt;h3&gt;对齐&lt;/h3&gt;&lt;p&gt;B默认情况下，下拉菜单自动沿着父元素的上沿和左侧被定位为 100% 宽度。 为&amp;nbsp;.dropdown-menu&amp;nbsp;添加&amp;nbsp;.dropdown-menu-right&amp;nbsp;类可以让菜单右对齐。&lt;/p&gt;&lt;h4&gt;可能需要额外的定位May require additional positioning&lt;/h4&gt;&lt;p&gt;在正常的文档流中，通过 CSS 为下拉菜单进行定位。这就意味着下拉菜单可能会由于设置了&amp;nbsp;overflow&amp;nbsp;属性的父元素而被部分遮挡或超出视口（viewport）的显示范围。如果出现这种问题，请自行解决。&lt;/p&gt;&lt;h4&gt;不建议使用&amp;nbsp;.pull-right&lt;/h4&gt;&lt;p&gt;从 v3.1.0 版本开始，我们不再建议对下拉菜单使用&amp;nbsp;.pull-right&amp;nbsp;类。如需将菜单右对齐，请使用&amp;nbsp;.dropdown-menu-right&amp;nbsp;类。导航条中如需添加右对齐的导航（nav）组件，请使用&amp;nbsp;.pull-right&amp;nbsp;的 mixin 版本，可以自动对齐菜单。如需左对齐，请使用&amp;nbsp;.dropdown-menu-left&amp;nbsp;类。&lt;/p&gt;&lt;p&gt;Copy&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;ul class=&quot;dropdown-menu dropdown-menu-right&quot; role=&quot;menu&quot; aria-labelledby=&quot;dLabel&quot;&amp;gt;
  ...
&amp;lt;/ul&amp;gt;
&lt;/code&gt;&lt;/pre&gt;&lt;h3&gt;标题&lt;/h3&gt;&lt;p&gt;在任何下拉菜单中均可通过添加标题来标明一组动作。&lt;/p&gt;&lt;p&gt;&lt;button&gt;Dropdown&amp;nbsp;&lt;/button&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Dropdown header&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Action&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Another action&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Something else here&lt;/a&gt;&lt;/li&gt;&lt;li&gt;Dropdown header&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Separated link&lt;/a&gt;&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Copy&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;ul class=&quot;dropdown-menu&quot; role=&quot;menu&quot; aria-labelledby=&quot;dropdownMenu2&quot;&amp;gt;
  ...
  &amp;lt;li role=&quot;presentation&quot; class=&quot;dropdown-header&quot;&amp;gt;Dropdown header&amp;lt;/li&amp;gt;
  ...
&amp;lt;/ul&amp;gt;
&lt;/code&gt;&lt;/pre&gt;&lt;h3&gt;分割线&lt;/h3&gt;&lt;p&gt;为下拉菜单添加一条分割线，用于将多个链接分组。&lt;/p&gt;&lt;p&gt;&lt;button&gt;Dropdown&amp;nbsp;&lt;/button&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Action&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Another action&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Something else here&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Separated link&lt;/a&gt;&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Copy&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;ul class=&quot;dropdown-menu&quot; role=&quot;menu&quot; aria-labelledby=&quot;dropdownMenuDivider&quot;&amp;gt;
  ...
  &amp;lt;li role=&quot;presentation&quot; class=&quot;divider&quot;&amp;gt;&amp;lt;/li&amp;gt;
  ...
&amp;lt;/ul&amp;gt;
&lt;/code&gt;&lt;/pre&gt;&lt;h3&gt;禁用的菜单项&lt;/h3&gt;&lt;p&gt;为下拉菜单中的&amp;nbsp;&amp;lt;li&amp;gt;&amp;nbsp;元素添加&amp;nbsp;.disabled&amp;nbsp;类，从而禁用相应的菜单项。&lt;/p&gt;&lt;p&gt;&lt;button&gt;Dropdown&amp;nbsp;&lt;/button&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Regular link&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Disabled link&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Another link&lt;/a&gt;&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&lt;span&gt;&amp;lt;ul&lt;/span&gt; &lt;span&gt;class=&lt;/span&gt;&lt;span&gt;&quot;dropdown-menu&quot;&lt;/span&gt; &lt;span&gt;role=&lt;/span&gt;&lt;span&gt;&quot;menu&quot;&lt;/span&gt; &lt;span&gt;aria-labelledby=&lt;/span&gt;&lt;span&gt;&quot;dropdownMenu3&quot;&lt;/span&gt;&lt;span&gt;&amp;gt;&lt;/span&gt;
  &lt;span&gt;&amp;lt;li&lt;/span&gt; &lt;span&gt;role=&lt;/span&gt;&lt;span&gt;&quot;presentation&quot;&lt;/span&gt;&lt;span&gt;&amp;gt;&amp;lt;a&lt;/span&gt; &lt;span&gt;role=&lt;/span&gt;&lt;span&gt;&quot;menuitem&quot;&lt;/span&gt; &lt;span&gt;tabindex=&lt;/span&gt;&lt;span&gt;&quot;-1&quot;&lt;/span&gt; &lt;span&gt;href=&lt;/span&gt;&lt;span&gt;&quot;#&quot;&lt;/span&gt;&lt;span&gt;&amp;gt;&lt;/span&gt;Regular link&lt;span&gt;&amp;lt;/a&amp;gt;&amp;lt;/li&amp;gt;&lt;/span&gt;
  &lt;span&gt;&amp;lt;li&lt;/span&gt; &lt;span&gt;role=&lt;/span&gt;&lt;span&gt;&quot;presentation&quot;&lt;/span&gt; &lt;span&gt;class=&lt;/span&gt;&lt;span&gt;&quot;disabled&quot;&lt;/span&gt;&lt;span&gt;&amp;gt;&amp;lt;a&lt;/span&gt; &lt;span&gt;role=&lt;/span&gt;&lt;span&gt;&quot;menuitem&quot;&lt;/span&gt; &lt;span&gt;tabindex=&lt;/span&gt;&lt;span&gt;&quot;-1&quot;&lt;/span&gt; &lt;span&gt;href=&lt;/span&gt;&lt;span&gt;&quot;#&quot;&lt;/span&gt;&lt;span&gt;&amp;gt;&lt;/span&gt;Disabled link&lt;span&gt;&amp;lt;/a&amp;gt;&amp;lt;/li&amp;gt;&lt;/span&gt;
  &lt;span&gt;&amp;lt;li&lt;/span&gt; &lt;span&gt;role=&lt;/span&gt;&lt;span&gt;&quot;presentation&quot;&lt;/span&gt;&lt;span&gt;&amp;gt;&amp;lt;a&lt;/span&gt; &lt;span&gt;role=&lt;/span&gt;&lt;span&gt;&quot;menuitem&quot;&lt;/span&gt; &lt;span&gt;tabindex=&lt;/span&gt;&lt;span&gt;&quot;-1&quot;&lt;/span&gt; &lt;span&gt;href=&lt;/span&gt;&lt;span&gt;&quot;#&quot;&lt;/span&gt;&lt;span&gt;&amp;gt;&lt;/span&gt;Another link&lt;span&gt;&amp;lt;/a&amp;gt;&amp;lt;/li&amp;gt;&lt;/span&gt;
&lt;span&gt;&amp;lt;/ul&amp;gt;&lt;/span&gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','2016-10-25 21:10:37','2016-10-25 21:10:37','24','1','0'),
('79','test1','&lt;p&gt;test1&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','2016-11-29 21:11:20','2016-11-29 21:11:36','0','2','1'),
('80','下拉菜单','&lt;h4&gt;用于显示链接列表的可切换、有上下文的菜单。&lt;/h4&gt;&lt;h3&gt;&lt;a href=&quot;http://v3.bootcss.com/javascript/#dropdowns&quot; style=&quot;background-color: rgb(255, 255, 255); font-size: 15px; letter-spacing: 0.1px;&quot;&gt;下拉菜单的 JavaScript 插件&lt;/a&gt;&lt;span style=&quot;color: rgb(102, 102, 102); font-size: 15px; letter-spacing: 0.1px;&quot;&gt;让它具有了交互性。&lt;/span&gt;&lt;/h3&gt;&lt;h5&gt;实例&lt;/h5&gt;&lt;p&gt;将下拉菜单触发器和下拉菜单都包裹在&amp;nbsp;.dropdown&amp;nbsp;里，或者另一个声明了&amp;nbsp;position: relative;&amp;nbsp;的元素。然后加入组成菜单的 HTML 代码。&lt;/p&gt;&lt;p&gt;&lt;button&gt;Dropdown&amp;nbsp;&lt;/button&gt;&lt;/p&gt;&lt;p&gt;ActionAnother actionSomething else hereSeparated link&lt;/p&gt;&lt;p&gt;Copy&lt;/p&gt;&lt;pre&gt;&lt;code class=&quot;hljs xml&quot; codemark=&quot;1&quot;&gt;&lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;&lt;span class=&quot;hljs-name&quot;&gt;div&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;class&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;dropdown&quot;&lt;/span&gt;&amp;gt;&lt;/span&gt;
  &lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;&lt;span class=&quot;hljs-name&quot;&gt;button&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;class&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;btn btn-default dropdown-toggle&quot;&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;type&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;button&quot;&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;id&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;dropdownMenu1&quot;&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;data-toggle&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;dropdown&quot;&lt;/span&gt;&amp;gt;&lt;/span&gt;
    Dropdown
    &lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;&lt;span class=&quot;hljs-name&quot;&gt;span&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;class&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;caret&quot;&lt;/span&gt;&amp;gt;&lt;/span&gt;&lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;/&lt;span class=&quot;hljs-name&quot;&gt;span&lt;/span&gt;&amp;gt;&lt;/span&gt;
  &lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;/&lt;span class=&quot;hljs-name&quot;&gt;button&lt;/span&gt;&amp;gt;&lt;/span&gt;
  &lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;&lt;span class=&quot;hljs-name&quot;&gt;ul&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;class&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;dropdown-menu&quot;&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;role&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;menu&quot;&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;aria-labelledby&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;dropdownMenu1&quot;&lt;/span&gt;&amp;gt;&lt;/span&gt;
    &lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;&lt;span class=&quot;hljs-name&quot;&gt;li&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;role&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;presentation&quot;&lt;/span&gt;&amp;gt;&lt;/span&gt;&lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;&lt;span class=&quot;hljs-name&quot;&gt;a&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;role&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;menuitem&quot;&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;tabindex&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;-1&quot;&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;href&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;#&quot;&lt;/span&gt;&amp;gt;&lt;/span&gt;Action&lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;/&lt;span class=&quot;hljs-name&quot;&gt;a&lt;/span&gt;&amp;gt;&lt;/span&gt;&lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;/&lt;span class=&quot;hljs-name&quot;&gt;li&lt;/span&gt;&amp;gt;&lt;/span&gt;
    &lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;&lt;span class=&quot;hljs-name&quot;&gt;li&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;role&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;presentation&quot;&lt;/span&gt;&amp;gt;&lt;/span&gt;&lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;&lt;span class=&quot;hljs-name&quot;&gt;a&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;role&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;menuitem&quot;&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;tabindex&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;-1&quot;&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;href&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;#&quot;&lt;/span&gt;&amp;gt;&lt;/span&gt;Another action&lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;/&lt;span class=&quot;hljs-name&quot;&gt;a&lt;/span&gt;&amp;gt;&lt;/span&gt;&lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;/&lt;span class=&quot;hljs-name&quot;&gt;li&lt;/span&gt;&amp;gt;&lt;/span&gt;
    &lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;&lt;span class=&quot;hljs-name&quot;&gt;li&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;role&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;presentation&quot;&lt;/span&gt;&amp;gt;&lt;/span&gt;&lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;&lt;span class=&quot;hljs-name&quot;&gt;a&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;role&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;menuitem&quot;&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;tabindex&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;-1&quot;&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;href&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;#&quot;&lt;/span&gt;&amp;gt;&lt;/span&gt;Something else here&lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;/&lt;span class=&quot;hljs-name&quot;&gt;a&lt;/span&gt;&amp;gt;&lt;/span&gt;&lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;/&lt;span class=&quot;hljs-name&quot;&gt;li&lt;/span&gt;&amp;gt;&lt;/span&gt;
    &lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;&lt;span class=&quot;hljs-name&quot;&gt;li&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;role&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;presentation&quot;&lt;/span&gt;&amp;gt;&lt;/span&gt;&lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;&lt;span class=&quot;hljs-name&quot;&gt;a&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;role&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;menuitem&quot;&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;tabindex&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;-1&quot;&lt;/span&gt; &lt;span class=&quot;hljs-attr&quot;&gt;href&lt;/span&gt;=&lt;span class=&quot;hljs-string&quot;&gt;&quot;#&quot;&lt;/span&gt;&amp;gt;&lt;/span&gt;Separated link&lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;/&lt;span class=&quot;hljs-name&quot;&gt;a&lt;/span&gt;&amp;gt;&lt;/span&gt;&lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;/&lt;span class=&quot;hljs-name&quot;&gt;li&lt;/span&gt;&amp;gt;&lt;/span&gt;
  &lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;/&lt;span class=&quot;hljs-name&quot;&gt;ul&lt;/span&gt;&amp;gt;&lt;/span&gt;
&lt;span class=&quot;hljs-tag&quot;&gt;&amp;lt;/&lt;span class=&quot;hljs-name&quot;&gt;div&lt;/span&gt;&amp;gt;&lt;/span&gt;
&lt;/code&gt;&lt;/pre&gt;&lt;h4&gt;对齐&lt;/h4&gt;&lt;p&gt;B默认情况下，下拉菜单自动沿着父元素的上沿和左侧被定位为 100% 宽度。 为&amp;nbsp;.dropdown-menu&amp;nbsp;添加&amp;nbsp;.dropdown-menu-right&amp;nbsp;类可以让菜单右对齐。&lt;/p&gt;&lt;h5&gt;可能需要额外的定位May require additional positioning&lt;/h5&gt;&lt;p&gt;在正常的文档流中，通过 CSS 为下拉菜单进行定位。这就意味着下拉菜单可能会由于设置了&amp;nbsp;overflow&amp;nbsp;属性的父元素而被部分遮挡或超出视口（viewport）的显示范围。如果出现这种问题，请自行解决。&lt;/p&gt;&lt;h5&gt;不建议使用&amp;nbsp;.pull-right&lt;/h5&gt;&lt;p&gt;从 v3.1.0 版本开始，我们不再建议对下拉菜单使用&amp;nbsp;.pull-right&amp;nbsp;类。如需将菜单右对齐，请使用&amp;nbsp;.dropdown-menu-right&amp;nbsp;类。导航条中如需添加右对齐的导航（nav）组件，请使用&amp;nbsp;.pull-right&amp;nbsp;的 mixin 版本，可以自动对齐菜单。如需左对齐，请使用&amp;nbsp;.dropdown-menu-left&amp;nbsp;类。&lt;/p&gt;&lt;p&gt;&lt;/p&gt;&lt;pre&gt;&lt;code class=&quot;hljs cs&quot; codemark=&quot;1&quot;&gt;&lt;span&gt;&amp;lt;ul&lt;/span&gt; &lt;span&gt;&lt;span class=&quot;hljs-keyword&quot;&gt;class&lt;/span&gt;=&lt;/span&gt;&lt;span&gt;&lt;span class=&quot;hljs-string&quot;&gt;&quot;dropdown-menu dropdown-menu-right&quot;&lt;/span&gt;&lt;/span&gt; &lt;span&gt;role=&lt;/span&gt;&lt;span&gt;&lt;span class=&quot;hljs-string&quot;&gt;&quot;menu&quot;&lt;/span&gt;&lt;/span&gt; &lt;span&gt;aria-labelledby=&lt;/span&gt;&lt;span&gt;&lt;span class=&quot;hljs-string&quot;&gt;&quot;dLabel&quot;&lt;/span&gt;&lt;/span&gt;&lt;span&gt;&amp;gt;&lt;/span&gt;
  ...
&lt;span&gt;&amp;lt;/ul&amp;gt;&lt;/span&gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;','2016-11-30 18:11:18','2017-01-06 13:01:21','2','1','0');
DROP TABLE IF EXISTS  `blog_article_tag`;
CREATE TABLE `blog_article_tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int(11) unsigned NOT NULL,
  `tag_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

DROP TABLE IF EXISTS  `blog_article_view`;
CREATE TABLE `blog_article_view` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `view_ip` varchar(255) NOT NULL,
  `ip_province` varchar(255) NOT NULL,
  `ip_city` varchar(255) NOT NULL,
  `article_id` int(11) NOT NULL,
  `view_uid` int(11) DEFAULT NULL,
  `view_datetime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

insert into `blog_article_view`(`id`,`view_ip`,`ip_province`,`ip_city`,`article_id`,`view_uid`,`view_datetime`) values
('1','180.110.223.97','河北','北京','1',null,'2017-01-06 13:45:43'),
('2','180.110.223.96','江苏','','1',null,'2017-01-05 13:46:10'),
('3','180.110.223.95','江苏','北京','1',null,'2017-01-03 13:46:32'),
('4','180.110.222.97','河北','江苏','1',null,'2017-01-01 13:46:37'),
('5','180.100.223.97','江苏','北京','1',null,'2017-01-07 13:46:40'),
('6','180.111.223.97','河北','江苏','1',null,'2017-01-07 13:47:01'),
('7','180.111.223.97','山东','北京','1',null,'2017-01-07 13:47:01'),
('8','180.111.223.97','河北','','1',null,'2017-01-07 13:47:01'),
('9','180.111.223.97','江苏','北京','1',null,'2017-01-07 13:47:01'),
('10','180.111.223.97','山东','江苏','1',null,'2017-01-07 13:47:01'),
('11','180.111.223.97','江苏','','1',null,'2017-01-07 13:47:01'),
('12','180.111.223.97','山东','北京','1',null,'2017-01-07 13:47:01'),
('13','180.111.223.97','江苏','江苏','1',null,'2017-01-07 13:47:01'),
('14','180.111.223.97','河北','北京','1',null,'2017-01-07 13:47:01'),
('15','180.111.223.97','江苏','','1',null,'2017-01-07 13:47:01'),
('16','','江苏','江苏','0',null,'2017-01-07 13:47:01'),
('17','180.111.223.97','山东','江苏','1',null,'2017-01-07 13:47:01'),
('18','180.111.223.97','河北','','1',null,'2017-01-07 13:47:01'),
('19','180.111.223.97','江苏','','1',null,'2017-01-07 13:47:01'),
('20','180.111.223.97','山东','','1',null,'2017-01-07 13:47:01'),
('21','180.111.223.97','江苏','','1',null,'2017-01-07 13:47:01'),
('22','180.111.223.97','河北','','1',null,'2017-01-07 13:47:01'),
('23','180.111.223.97','河南','','1',null,'2017-01-07 13:47:01'),
('24','180.111.223.97','福建','','1',null,'2017-01-07 13:47:01'),
('25','180.111.223.97','西藏','','1',null,'2017-01-07 13:47:01'),
('26','180.111.223.97','福建','','1',null,'2017-01-07 13:47:01'),
('27','180.111.223.97','福建','','1',null,'2017-01-07 13:47:01'),
('28','180.111.223.97','福建','','1',null,'2017-01-07 13:47:01'),
('29','180.111.223.97','西藏','','1',null,'2017-01-07 13:47:01'),
('30','180.111.223.97','河南','','1',null,'2017-01-07 13:47:01'),
('31','180.111.223.97','河南','','1',null,'2017-01-07 13:47:01'),
('32','180.111.223.97','西藏','','1',null,'2017-01-07 13:47:01'),
('33','180.111.223.97','内蒙古','','1',null,'2017-01-07 13:47:01'),
('34','180.111.223.97','河南','','1',null,'2017-01-07 13:47:01'),
('35','180.111.223.97','西藏','','1',null,'2017-01-07 13:47:01'),
('36','127.0.0.1','福建','{"status":1,"message":"Internal Service Error:ip[127.0.0.1] loc failed"}','0','1','2017-01-07 15:01:21'),
('37','127.0.0.1','西藏','','0','1','2017-01-07 15:01:43'),
('38','127.0.0.1','河南','','80','1','2017-01-07 15:01:37'),
('39','127.0.0.1','福建','other','80','1','2017-01-07 15:01:29'),
('40','127.0.0.1','河南','other','69','1','2017-01-07 23:01:55'),
('41','127.0.0.1','西藏','other','80','1','2017-01-08 21:01:06'),
('42','127.0.0.1','河南','other','80','1','2017-01-08 21:01:14'),
('43','127.0.0.1','福建','other','80','1','2017-01-08 21:01:22'),
('44','127.0.0.1','湖南','other','80','1','2017-01-08 21:01:28'),
('45','127.0.0.1','四川','other','69','1','2017-01-08 21:01:38'),
('46','127.0.0.1','other','other','80','1','2017-01-08 22:01:44'),
('47','127.0.0.1','other','other','80','1','2017-01-08 22:01:55'),
('48','127.0.0.1','other','other','80','1','2017-01-08 22:01:07'),
('49','127.0.0.1','other','other','80','1','2017-01-08 22:01:51'),
('50','127.0.0.1','other','other','80','1','2017-01-08 22:01:22'),
('51','127.0.0.1','other','other','80','1','2017-01-08 22:01:46'),
('52','127.0.0.1','other','other','80','1','2017-01-08 22:01:52'),
('53','127.0.0.1','other','other','80','1','2017-01-08 22:01:40'),
('54','127.0.0.1','other','other','80','1','2017-01-09 18:01:57'),
('55','127.0.0.1','other','other','69','1','2017-01-09 21:01:34'),
('56','127.0.0.1','other','other','69','1','2017-01-09 21:01:45'),
('57','127.0.0.1','other','other','68','1','2017-01-09 21:01:43'),
('58','127.0.0.1','other','other','80','1','2017-01-09 21:01:28'),
('59','127.0.0.1','other','other','69','1','2017-01-09 21:01:31'),
('60','127.0.0.1','other','other','70','1','2017-01-09 21:01:33'),
('61','127.0.0.1','other','other','18','1','2017-01-09 21:01:36'),
('62','127.0.0.1','other','other','6','1','2017-01-09 21:01:40'),
('63','127.0.0.1','other','other','16','1','2017-01-09 21:01:46'),
('64','127.0.0.1','other','other','68','1','2017-01-09 21:01:52'),
('105','127.0.0.1','other','other','80','1','2017-02-16 20:02:53'),
('106','127.0.0.1','other','other','69','1','2017-02-16 20:02:12'),
('107','127.0.0.1','other','other','69','1','2017-02-16 20:02:30'),
('108','127.0.0.1','other','other','80','1','2017-02-16 20:02:48'),
('109','127.0.0.1','other','other','80','1','2017-02-16 20:02:35'),
('110','127.0.0.1','other','other','80','1','2017-02-16 20:02:41'),
('111','127.0.0.1','other','other','111','1','2017-02-16 20:02:46'),
('112','127.0.0.1','other','other','69','1','2017-02-16 20:02:28'),
('113','127.0.0.1','other','other','70','1','2017-02-16 20:02:35'),
('114','127.0.0.1','other','other','69','1','2017-02-16 20:02:58'),
('115','127.0.0.1','other','other','70','1','2017-02-16 20:02:06'),
('116','121.237.72.8','other','other','80','1','2017-02-16 20:02:30'),
('117','121.237.72.8','other','other','80','1','2017-02-16 20:02:23'),
('118','121.237.72.8','other','other','6','1','2017-02-16 20:02:32'),
('119','121.237.72.8','other','other','16','1','2017-02-16 20:02:35'),
('120','121.237.72.8','other','other','18','1','2017-02-16 20:02:39'),
('121','121.237.72.8','other','other','68','1','2017-02-16 20:02:41'),
('122','121.237.72.8','other','other','69','1','2017-02-16 20:02:56'),
('123','121.237.72.8','other','other','6666','1','2017-02-16 20:02:00'),
('124','121.237.72.8','other','other','69','1','2017-02-16 20:02:09'),
('125','121.237.72.8','other','other','80','1','2017-02-16 20:02:12'),
('126','121.237.72.8','other','other','16','1','2017-02-16 20:02:42'),
('127','121.237.72.8','other','other','18','1','2017-02-16 20:02:45'),
('128','121.237.72.8','other','other','68','1','2017-02-16 20:02:47'),
('129','121.237.72.8','other','other','70','1','2017-02-16 20:02:51'),
('130','121.237.72.8','other','other','69','1','2017-02-16 20:02:53'),
('131','121.237.72.8','other','other','80','1','2017-02-16 20:02:55'),
('132','121.237.72.8','other','other','16','1','2017-02-16 20:02:05'),
('133','121.237.72.8','other','other','6','1','2017-02-16 20:02:07'),
('134','121.237.72.8','other','other','6','1','2017-02-16 20:02:20'),
('135','121.237.72.8','other','other','16','1','2017-02-16 20:02:22'),
('136','121.237.72.8','other','other','18','1','2017-02-16 20:02:26'),
('137','121.237.72.8','other','other','68','1','2017-02-16 20:02:28'),
('138','121.237.72.8','other','other','70','1','2017-02-16 20:02:31'),
('139','121.237.72.8','other','other','69','1','2017-02-16 20:02:33'),
('140','121.237.72.8','other','other','80','1','2017-02-16 20:02:34'),
('141','121.237.72.8','other','other','6','1','2017-02-16 20:02:19'),
('142','121.237.72.8','other','other','16','1','2017-02-16 20:02:22'),
('143','121.237.72.8','other','other','18','1','2017-02-16 20:02:26'),
('144','121.237.72.8','other','other','68','1','2017-02-16 20:02:28'),
('145','121.237.72.8','other','other','69','1','2017-02-16 20:02:31'),
('146','121.237.72.8','other','other','18','1','2017-02-16 20:02:33'),
('147','121.237.72.8','other','other','69','1','2017-02-16 20:02:09'),
('148','121.237.72.8','other','other','69','1','2017-02-16 20:02:11'),
('149','121.237.72.8','other','other','69','1','2017-02-16 21:02:12'),
('150','121.237.72.8','other','other','80','1','2017-02-16 21:02:31'),
('151','121.237.72.8','other','other','6','1','2017-02-16 21:02:36'),
('152','121.237.72.8','other','other','16','1','2017-02-16 21:02:02'),
('153','121.237.72.8','other','other','80','1','2017-02-16 21:02:41'),
('154','127.0.0.1','other','other','69','1','2017-02-16 21:02:24'),
('155','121.237.72.8','other','other','70','1','2017-02-16 21:02:02'),
('156','121.237.72.8','江苏','南京','70','1','2017-02-16 22:02:09'),
('157','121.237.72.8','江苏','南京','69','1','2017-02-16 22:02:47'),
('158','121.237.72.8','江苏','南京','80','1','2017-02-16 22:02:58'),
('159','121.237.72.8','江苏','南京','80','1','2017-02-17 21:02:57'),
('160','127.0.0.1','other','other','6','1','2017-02-17 23:02:31'),
('161','127.0.0.1','other','other','16','1','2017-02-17 23:02:34'),
('162','127.0.0.1','other','other','18','1','2017-02-17 23:02:37'),
('163','127.0.0.1','other','other','68','1','2017-02-17 23:02:41'),
('164','127.0.0.1','other','other','70','1','2017-02-17 23:02:44'),
('165','127.0.0.1','other','other','69','1','2017-02-17 23:02:47'),
('166','127.0.0.1','other','other','80','1','2017-02-17 23:02:49'),
('167','127.0.0.1','other','other','6','1','2017-02-17 23:02:54'),
('168','127.0.0.1','other','other','80','1','2017-02-22 21:02:32'),
('169','127.0.0.1','other','other','80','1','2017-02-22 22:02:03'),
('170','127.0.0.1','other','other','80','1','2017-02-22 22:02:16'),
('171','127.0.0.1','other','other','80','1','2017-02-22 22:02:20'),
('172','127.0.0.1','other','other','80','1','2017-02-28 20:02:51'),
('173','127.0.0.1','other','other','80','1','2017-02-28 20:02:03'),
('174','127.0.0.1','other','other','80','1','2017-02-28 20:02:30'),
('175','127.0.0.1','other','other','80','1','2017-02-28 20:02:02'),
('176','127.0.0.1','other','other','80','1','2017-02-28 20:02:11'),
('177','127.0.0.1','other','other','80','1','2017-02-28 20:02:14'),
('178','127.0.0.1','other','other','80','1','2017-02-28 20:02:17'),
('179','127.0.0.1','other','other','80','1','2017-02-28 20:02:03'),
('180','127.0.0.1','other','other','80','1','2017-02-28 20:02:38'),
('181','127.0.0.1','other','other','80','1','2017-02-28 20:02:46'),
('182','127.0.0.1','other','other','80','1','2017-02-28 20:02:59'),
('183','127.0.0.1','other','other','80','1','2017-02-28 20:02:07'),
('184','127.0.0.1','other','other','18','1','2017-02-28 21:02:42'),
('185','127.0.0.1','other','other','6','1','2017-02-28 21:02:49'),
('186','127.0.0.1','other','other','16','1','2017-02-28 21:02:53'),
('187','127.0.0.1','other','other','18','1','2017-02-28 21:02:00'),
('188','127.0.0.1','other','other','68','1','2017-02-28 21:02:03'),
('189','127.0.0.1','other','other','69','1','2017-02-28 21:02:06'),
('190','127.0.0.1','other','other','80','1','2017-02-28 21:02:11'),
('191','127.0.0.1','other','other','80','1','2017-03-19 14:03:15'),
('192','114.221.31.230','江苏','南京','69','1','2017-03-22 21:03:06'),
('193','114.221.31.230','江苏','南京','69','1','2017-03-22 21:03:33'),
('194','114.221.31.230','江苏','南京','69','1','2017-03-22 21:03:00'),
('195','114.221.31.230','江苏','南京','69','1','2017-03-22 21:03:09'),
('196','123.116.168.11','北京','北京','69','1','2017-03-22 22:03:11'),
('197','45.77.23.236','other','other','80','1','2017-04-29 16:04:12'),
('198','127.0.0.1','other','other','80','1','2017-04-29 17:04:52'),
('199','127.0.0.1','other','other','80','1','2017-04-30 00:04:35'),
('200','127.0.0.1','other','other','16','1','2017-04-30 00:04:50'),
('201','127.0.0.1','other','other','80','1','2017-04-30 11:04:59');
DROP TABLE IF EXISTS  `blog_classification`;
CREATE TABLE `blog_classification` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `classification` char(255) NOT NULL,
  `uid` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

insert into `blog_classification`(`id`,`classification`,`uid`) values
('1','php','2'),
('2','jquery','1'),
('6','log','1'),
('23','thinkPHP','1'),
('24','bootstarp','1'),
('25','test1','1'),
('26','test2','0'),
('27','test3','2'),
('28','test4','2'),
('29','test1','2'),
('30','test1','4');
DROP TABLE IF EXISTS  `blog_comment`;
CREATE TABLE `blog_comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `article_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '文章id',
  `content` char(225) NOT NULL,
  `time` datetime NOT NULL DEFAULT '2017-01-01 00:00:00',
  `comment_pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评论父id',
  `comment_rid` int(11) unsigned NOT NULL COMMENT '评论根id',
  `up` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `down` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '反对数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

insert into `blog_comment`(`id`,`uid`,`article_id`,`content`,`time`,`comment_pid`,`comment_rid`,`up`,`down`) values
('1','1','1','good','2016-10-22 20:39:16','0','0','0','0'),
('2','1','1','hello','2016-10-22 20:39:52','0','0','0','0'),
('3','1','2','world','2016-10-22 20:40:20','0','0','0','0'),
('4','0','18','liang','2016-10-23 19:10:09','0','0','0','0'),
('5','0','18','a','2016-10-23 19:10:54','0','0','0','0'),
('6','0','18','a','2016-10-23 19:10:03','0','0','0','0'),
('7','0','18','b','2016-10-23 19:10:09','0','0','0','0'),
('8','0','18','c','2016-10-23 19:10:33','0','0','0','0'),
('9','0','18','d','2016-10-23 19:10:08','0','0','0','0'),
('10','0','18','e','2016-10-23 19:10:24','0','0','0','0'),
('11','0','18','a','2016-10-23 19:10:09','0','0','0','0'),
('12','0','18','l','2016-10-23 19:10:54','0','0','0','0'),
('13','0','18','liang','2016-10-23 19:10:14','0','0','0','0'),
('14','0','18','l','2016-10-23 19:10:17','0','0','0','0'),
('15','0','18','aa','2016-10-23 19:10:22','0','0','0','0'),
('16','0','18','aaa','2016-10-23 19:10:04','0','0','0','0'),
('17','0','18','aaaaa','2016-10-23 19:10:44','0','0','0','0'),
('18','0','18','aa','2016-10-23 19:10:25','0','0','0','0'),
('19','0','69','求解 如果现在有A控制器 a.thml和B控制器 b.html 怎么将A控制器获取的变量 输出到b,html?','2016-10-25 21:10:52','0','0','0','0'),
('20','0','69','{$r:title}或者｛$r-&gt;title｝','2016-10-25 21:10:07','0','0','0','0'),
('21','0','69','','2016-10-25 22:10:19','0','0','0','0'),
('22','0','71','了','2016-10-28 22:10:16','0','0','0','0'),
('23','0','69','good','2016-11-30 18:11:12','0','0','0','0'),
('24','0','80','1','2016-11-30 18:11:36','0','0','0','0');
DROP TABLE IF EXISTS  `blog_follow`;
CREATE TABLE `blog_follow` (
  `follow` int(11) unsigned NOT NULL COMMENT '关注',
  `followed` int(11) unsigned NOT NULL COMMENT '被关注',
  PRIMARY KEY (`follow`,`followed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS  `blog_index`;
CREATE TABLE `blog_index` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL COMMENT '获取图片的日期',
  `url` char(255) NOT NULL COMMENT '每日一图url',
  `comment` varchar(255) DEFAULT NULL COMMENT '每日一图评论',
  `copyright` varchar(255) DEFAULT NULL,
  `attribute` varchar(255) DEFAULT NULL,
  `para1` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `Country` varchar(255) DEFAULT NULL,
  `City` varchar(255) DEFAULT NULL,
  `Continent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

insert into `blog_index`(`id`,`date`,`url`,`comment`,`copyright`,`attribute`,`para1`,`title`,`provider`,`Country`,`City`,`Continent`) values
('1','2017-02-22','/az/hprichbg/rb/VenetianFortifications_ZH-CN11140565989_1920x1080.jpg','',null,null,null,null,null,null,null,null),
('2','2017-02-22','http://www.bing.com/az/hprichbg/rb/VenetianFortifications_ZH-CN11140565989_1920x1080.jpg','',null,null,null,null,null,null,null,null),
('3','2017-02-22','http://www.bing.com/az/hprichbg/rb/MartianCrater_ZH-CN9867068013_1920x1080.jpg','',null,null,null,null,null,null,null,null),
('4','2017-02-22','http://www.bing.com/az/hprichbg/rb/YorkshireWinter_ZH-CN9258658675_1920x1080.jpg','',null,null,null,null,null,null,null,null),
('14','2017-02-23','http://www.bing.com/az/hprichbg/rb/ViennaOperaBall_ZH-CN10790748867_1920x1080.jpg','维也纳国家歌剧院内的舞会，奥地利 ','© APA-PictureDesk GmbH/REX/Shutterstock',null,null,null,null,null,null,null),
('15','2017-02-23','http://www.bing.com/az/hprichbg/rb/VenetianFortifications_ZH-CN11140565989_1920x1080.jpg','科托尔的防御工事，黑山 ','© Slavica Stajić/500px',null,null,null,null,null,null,null),
('16','2017-02-23','http://www.bing.com/az/hprichbg/rb/MartianCrater_ZH-CN9867068013_1920x1080.jpg','北方大平原的火星陨石坑内结的冰 ','© VUZE/NASA/Alamy',null,null,null,null,null,null,null),
('17','2017-02-26','http://www.bing.com/az/hprichbg/rb/GriffithPark_ZH-CN9871772537_1920x1080.jpg','加利福尼亚州洛杉矶格里菲斯天文台，美国 ','© Walter Bibikow/Getty Images',null,null,null,null,null,null,null),
('18','2017-02-26','http://www.bing.com/az/hprichbg/rb/Hoatzin_ZH-CN6642664963_1920x1080.jpg','两只麝雉栖息枝头，巴西 ','© Morten Ross/500px',null,null,null,null,null,null,null),
('19','2017-02-26','http://www.bing.com/az/hprichbg/rb/ShengshanIsland_ZH-CN14229927013_1920x1080.jpg','浙江嵊山岛被遗弃的渔村 ','© VCG/Getty Images',null,null,null,null,null,null,null),
('26','2017-02-27','http://www.bing.com/az/hprichbg/rb/RiverOtters_ZH-CN9287285757_1920x1080.jpg','黄石国家公园内的北美水獭，美国怀俄明州 ','© mlharing/istock/Getty Images','美国，黄石国家公园','北美水獭可以以每小时15英里的速度在陆地上奔跑，并且当需要快速逃生时，甚至可以滑过雪和冰。它们是天生的游泳家，厚厚的皮毛和长锥形身体帮助它们滑过水，推动它们的短腿和网状的脚。冬天会在结冰的湖面下看到它们的身影，不远处的冰洞也可以看到它们探出小脑袋大口的呼吸。','悠然闲适 水陆皆栖','© mlharing/istock/Getty Images','美国','黄石国家公园','北美洲'),
('27','2017-02-28','http://www.bing.com/az/hprichbg/rb/BrassBandTrumpet_ZH-CN8703910231_1920x1080.jpg','一位铜管乐队成员正在为国王嘉年华活动吹奏小号，新奥尔良 ','© Gerald Herbert/AP Photo','美国，新奥尔良','今天，对于当地人来说是一个尽情狂欢的日子。新奥尔良的街道响起了响亮的声音，铜管乐队的声音响彻城市的每个角落。在这个发明爵士乐的地方，新奥尔良狂欢节成为载歌载舞的欢乐盛宴。狂欢节完全免费，人人都可以来参与，还不赶快行动？','跟着乐队燥起来','© Gerald Herbert/AP Photo','美国','新奥尔良','北美洲'),
('28','2017-03-04','http://www.bing.com/az/hprichbg/rb/Aoraki_ZH-CN7776353328_1920x1080.jpg','新西兰南岛的塔斯曼湖 ','© UpdogDesigns/iStock/Getty Images Plus','新西兰，库克山国家公园','塔斯曼冰川位于库克山的东边，从1990年开始，随着塔斯曼冰川开始慢慢融化，冰川小水池开始凝聚成大量的水才形成了塔斯曼湖。随着冰川每年平均退缩590英尺，塔斯曼湖的生长范围越来越广。科学家估计，供给塔斯曼湖的冰川将在未来几十年内完全消失。','积小流，成江海','©UpdogDesigns/iStock/Getty Images Plus','新西兰','库克山国家公园','亚洲'),
('29','2017-03-19','http://www.bing.com/az/hprichbg/rb/MatunuskaGlacier_ZH-CN11670641539_1920x1080.jpg','马他奴思卡冰川里的冰隧道，阿拉斯加州 ','© Lynn Wegener/Offset','美国，马他奴思卡冰川','如果你喜欢公路旅行，开车到阿拉斯加的马他奴思卡冰川是个不错的选择。当你看到这个27英里长，4英里宽的冰隧道，那么你的徒步旅行就要开始了！跟着导游乘船沿着隧道划行，晶莹泛蓝的冰川透着丝丝寒气，把一路上的炎热感直接驱走。徜徉在这个美如仙境的冰川世界，满足惬意感油然而生！','真实的冰雪童话','© Lynn Wegener/Offset','美国','马他奴思卡冰川','北美洲'),
('30','2017-03-20','http://www.bing.com/az/hprichbg/rb/TingSakura_ZH-CN14945610051_1920x1080.jpg','一只在樱花树上嬉戏的绿绣眼（© Reece Cheng/500px）','','枝头嬉戏的绿绣眼','古代的春分分为三候：“一候玄鸟至，二候雷乃发声，三候始电。”便是说春分日后，燕子便从南方飞来了，下雨时天空便要打雷并发出闪电。春分后，中国南方大部分地区越冬作物进入春季生长阶段，气温也继续回升，真正的春天来了，你也开始一个全新的自己吧！','碧玉妆 绿丝绦','© Reece Cheng/500px','','','亚洲'),
('31','2017-03-22','http://www.bing.com/az/hprichbg/rb/GuizhouWaterfall_ZH-CN10955906714_1920x1080.jpg','安顺附近的银链坠潭瀑布，中国贵州省 ','© Top Photo Group/Getty Images','中国，安顺','几个世纪以来，贵州省的瀑布吸引着陆陆续续的游客。在黄果树国家森林，可以看到壮丽的银链坠潭瀑布，在陡峭的岩石上瀑布细腻流淌，被称为“中国最温柔的瀑布”。如果你喜欢刺激的冒险，你可以步行到黄果树瀑布，远远的你便能听见银链坠潭瀑布那如银铃般的巨大落地声！','千丝万缕 如泣如诉','© Top Photo Group/Getty Images','中国','安顺','亚洲'),
('32','2017-03-25','http://www.bing.com/az/hprichbg/rb/SpainSpring_ZH-CN9613370360_1920x1080.jpg','沐浴在春光中的AÃnsa-Sobrarbe村庄，西班牙 ','© Hans Kruse/500px','西班牙，比利牛斯山脉','比利牛斯山是欧洲西南部的最大山脉，也是西班牙和法国之间的天然国界，将伊比利亚半岛与欧洲大陆其它地区分隔开。与阿尔卑斯地区一样，比利牛斯山地区的许多村庄都是农业地区，绵羊和牛群在春天进入山区，蓝天碧野与成群白花花的牛儿羊儿们构成一幅美丽的油画。','蓝天碧野 湖光山色','© Hans Kruse/500px','西班牙','比利牛斯山脉','欧洲'),
('33','2017-03-26','http://www.bing.com/az/hprichbg/rb/WildfireSapling_ZH-CN10766255059_1920x1080.jpg','被烧焦的石南花中一颗刚萌芽的松树苗，Strabrechtse Heide，荷兰 ','© Heike Odermatt/Minden Pictures','萌芽中的松树苗','2010年，在荷兰南部的自然保护区发生了一场火灾。数百名消防员和荷兰军队工作了一个星期，才得以完全扑灭大火。两年后，一棵微小的松树苗从被烧焦的石南花中长出来。最终，这里的土地生态系统维持了自我平衡，更多的植物和动物被自愈。我们不得不被自然的力量折服。','生命的坚韧华丽','© Heike Odermatt/Minden Pictures','','','亚洲'),
('34','2017-03-30','http://www.bing.com/az/hprichbg/rb/CMLSCNP_ZH-CN12089840072_1920x1080.jpg','摇篮山-圣克莱尔湖国家公园中的林间步道，澳大利亚塔斯马尼亚州 ','© Sean Crane/Minden Pictures','澳大利亚，摇篮山-圣克莱尔湖国家公园','我们即将飞往澳大利亚大陆南部海岸的塔斯马尼亚，那里的摇篮山 - 圣克莱尔湖国家公园是全球各地的徒步旅行者都向往的地方。公园里有众多的徒步小径，其中Overland Track是最有名的。有些小径穿梭在原始森林里，给人一种神秘感，如果你也喜欢徒步探险，这里是个不错的选择。','悬崖与湖泊的混搭','© Sean Crane/Minden Pictures','澳大利亚','摇篮山-圣克莱尔湖国家公园','大洋洲'),
('35','2017-04-02','http://www.bing.com/az/hprichbg/rb/LavaTubeIce_ZH-CN12266785340_1920x1080.jpg','熔岩床国家纪念碑中熔岩管里的冰，加利福尼亚州 ','© Floris van Breugel/Minden Pictures','美国，熔岩床国家纪念碑','在加利福尼亚州的北部，当天气足够冷的时候，这个火山景观冻结了流过洞穴和熔岩的水，创造出一种具有超凡脱俗视觉效果的冰。人类要想探索这个洞穴极具挑战性，但是想想你进入到洞穴中拍出的极具视觉冲击的照片，也算是件酷酷的事情！','神秘的探索之地','© Floris van Breugel/Minden Pictures','美国','熔岩床国家纪念碑','北美洲'),
('36','2017-04-05','http://www.bing.com/az/hprichbg/rb/JulianAlps_ZH-CN11764181030_1920x1080.jpg','在斯洛文尼亚侧面的朱利安阿尔卑斯山 ','© Nino Marcutti/Alamy','斯洛文尼亚，朱利安阿尔卑斯山','朱利安阿尔卑斯山跨越意大利与斯洛文尼亚两个国家。作为壁纸的这张照片是在斯洛文尼亚那一侧拍摄的。作为阿尔卑斯山的一部分，朱利安阿尔卑斯山成了两国之间的自然边界。朱利安阿尔卑斯山的很大一部分属于斯洛文尼亚的特里格拉夫国家公园。','冰雪交融 风景如画','© Nino Marcutti/Alam','斯洛文尼亚','朱利安阿尔卑斯山','欧洲'),
('37','2017-04-08','http://www.bing.com/az/hprichbg/rb/KalsoyIsland_ZH-CN11586790825_1920x1080.jpg','卡尔斯岛上的Kallur灯塔，法罗群岛 ','© Janne Kahila/500px','丹麦，卡尔斯岛','卡尔斯岛是法罗群岛东北部的岛屿。岛的西岸是高而陡峭的悬崖，一条高速公路连接着东部山谷的四个小村庄。卡鲁尔灯塔在狭窄的小岛的北端，岛的南端也有一个对应的灯塔。大约有数百人居住在岛上，这里还栖息着数量庞大种类繁多的海鸟，得天独厚的地理条件让这里成为游客的聚集地。','黑夜如漆 明亮如你','© Janne Kahila/500px','丹麦','卡尔斯岛','欧洲'),
('38','2017-04-10','http://www.bing.com/az/hprichbg/rb/ArcticFoxSibs_ZH-CN7417451993_1920x1080.jpg','弗兰格尔岛上的北极狐，俄罗斯 ','© Owen Newman/Getty Images','俄罗斯，弗兰格尔岛','几只北极狐正在悠闲的庆祝今天的兄弟姐妹日。这些北极狐住在阿拉斯加附近的俄罗斯北部岛屿弗兰格尔岛上。北极狐幼崽在9周龄时就断奶，但它们享受着来自爸爸和妈妈以及家中其它成年狐狸的保护。当幼崽准备好自己搜寻小的啮齿动物时，成年北极狐会训练它们如何独立生活和保护自己及家人。','北极冰原的精灵','© Owen Newman/Getty Images','俄罗斯','弗兰格尔岛','欧洲'),
('39','2017-04-12','http://www.bing.com/az/hprichbg/rb/SpacewalkSelfie_ZH-CN10118363891_1920x1080.jpg','宇航员Terry Virts的太空自拍照 ','© NASA','宇航员Terry Virts的太空自拍照','2015年3月，美国宇航员特里·维尔茨在绕轨道运行的国际空间站。他和同事布奇·威尔玛在轨道上对空间站做一些修理。这时宇航员特里·维尔茨来了一次史无前例的“太空自拍”，并在太空中做翻滚的动作。当走出空间站进行工作的同时，维尔茨在社交媒体上发送了这张自拍。 谁能抵挡住在太空的自拍呢！','严肃又俏皮的NASA','© NASA','','','亚洲'),
('40','2017-04-14','http://www.bing.com/az/hprichbg/rb/TitanicBelfast_ZH-CN7528306628_1920x1080.jpg','贝尔法斯特的泰坦尼克博物馆，爱尔兰 ','© Allan Baxter/Gallery Stock','爱尔兰，贝尔法斯特','在贝尔法斯特的港口，泰坦尼克博物馆回到了著名的“泰坦尼克”的诞生地。105年前的今天，泰坦尼克号撞上冰山并在大西洋沉没。从19世纪中叶到20世纪初期，造船业带动了贝尔法斯特地区的大部分经济，在这里建造了许多类似于“泰坦尼克”的大型船，博物馆利用著名的“泰坦尼克”故事讲述了贝尔法斯特造船业的更多故事。','怀旧经典 永恒难忘','© Allan Baxter/Gallery Stock','爱尔兰','贝尔法斯特','欧洲'),
('41','2017-04-16','http://www.bing.com/az/hprichbg/rb/GroundNest_ZH-CN8953105132_1920x1080.jpg','北极国家野生动物保护区内地面上的巢穴，美国阿拉斯加州 ','© Mint Images/Offset','美国，北极国家野生动物保护区','也许当你想到春天的鸟巢时，你会想到许多鸟蛋在温暖的巢中等待孵化、这个巢在高大且足够安全的枝头的情景。但是在阿拉斯加，许多鸟儿喜欢把巢建在地面，搭巢、产卵、孵蛋都是在地面上进行的。如果你在阿拉斯加的北极国家野生动物保护区内徒步旅行，记得放轻脚步。','天然纯净 自然馈赠','© Mint Images/Offset','美国','北极国家野生动物保护区','北美洲'),
('42','2017-04-21','http://www.bing.com/az/hprichbg/rb/SolarFarm_ZH-CN4853771923_1920x1080.jpg','托诺帕附近的新月沙丘太阳能项目，美国内华达州 ','© Jassen Todorov/Solent News/REX/Shutterstock','美国，托诺帕','2015年开始运行的新月沙丘太阳能项目，不像其它大多数用合成油作为中介液体的聚光太阳能电站一样，它使用具有更有利的热性能的熔盐。当需要用电时，熔盐可以泵入到将水转换成水蒸气的热交换器中，带动涡轮旋转来发电，冷却盐回流到储蓄槽中，周期循环重复。','源源不断 永不停歇','© Jassen Todorov/Solent News/REX/Shutterstock','美国','托诺帕','北美洲'),
('43','2017-04-25','http://www.bing.com/az/hprichbg/rb/AfricaWeaverbirds_ZH-CN9479498858_1920x1080.jpg','伊丽莎白女王国家公园内的织巢鸟，乌干达 ','© Joel Sartore/Getty Images','乌干达，伊丽莎白女王国家公园','在乌干达伊丽莎白女王国家公园，你可能会看到壁纸中这样的织巢鸟巢穴。几乎所有的织巢鸟都以其精心制作的巢穴而闻名。通常情况下，雄鸟会认真仔细的编织一个非常美丽的巢穴来吸引一个伴侣，而且巢足够坚固，可以撑住孵化出来的幼鸟。织巢鸟的巢穴被认为是最精致的巢穴之一。','织出最精致的巢','© Joel Sartore/Getty Images','乌干达','伊丽莎白女王国家公园','亚洲'),
('44','2017-04-27','http://www.bing.com/az/hprichbg/rb/SaronicGulf_ZH-CN8379891695_1920x1080.jpg','萨罗尼克湾上方的云隙光，希腊 ','© Stian Rekdal/Nimia','希腊，萨罗尼克湾','这束在云层中闪过的阳光被拍摄于希腊海岸的萨罗尼克湾。你不需要专程去爱琴海看这束光，因为它发生在世界各地。它被称为云隙光，在西方国家被称为耶稣光或上帝之梯，一般在黎明或黄昏时候出现。一抹神奇的光线透过云层洒落大地，这情景真的美极了！','生命之光','© Stian Rekdal/Nimia','希腊','萨罗尼克湾','欧洲'),
('45','2017-04-29','http://www.bing.com/az/hprichbg/rb/SoundSuits_ZH-CN11561095548_1920x1080.jpg','2016年于悉尼火车制造厂展出的艺术家尼克·凯夫的系列作品“Soundsuits”，澳大利亚 ','© Don Arnold/WireImage/Getty Images','澳大利亚，悉尼','艺术家兼表演家尼克·凯夫创造了许多他称之为“Soundsuits”的服装，这些服装采用各种不同的材料，有时包括一些捡到的物品。尼克·凯夫不仅在服装材质上有足够敏感的视觉艺术感，服装的夸张感更成为“Soundsuits”的突出特点，也成为尼克·凯夫的标志。','没有想象哪来艺术','© Don Arnold/WireImage/Getty Images','澳大利亚','悉尼','大洋洲'),
('46','2017-04-30','http://www.bing.com/az/hprichbg/rb/SouthMoravian_ZH-CN13384331455_1920x1080.jpg','基约夫附近的南摩拉维亚风景，捷克共和国  ','© Tomas Vocelka/500px','捷克，基约夫','如果提到《不能承受的生命之轻》的作者米兰·昆德拉，则会引起很多人的共鸣，没错，他的故乡就在南摩拉维亚。当你想到捷克共和国时，你可能会想到比尔森啤酒，因为这里是葡萄酒之乡，捷克总占地17000公顷的葡萄园中95%都在南摩拉维亚州。','迷人而神秘','© Tomas Vocelka/500px','捷克','基约夫','欧洲');
DROP TABLE IF EXISTS  `blog_permission`;
CREATE TABLE `blog_permission` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pername` varchar(20) NOT NULL COMMENT '权限标识，读、写、执行等',
  `path` varchar(20) NOT NULL COMMENT '角色可以访问的路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

insert into `blog_permission`(`id`,`pername`,`path`) values
('1','read',''),
('2','edit','');
DROP TABLE IF EXISTS  `blog_role`;
CREATE TABLE `blog_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `rolename` varchar(20) NOT NULL,
  `status` tinyint(2) DEFAULT '1' COMMENT '角色状态，1为激活，0为注销',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

insert into `blog_role`(`id`,`rolename`,`status`) values
('1','admin','1'),
('2','author','1'),
('3','other','0');
DROP TABLE IF EXISTS  `blog_role_permission_relation`;
CREATE TABLE `blog_role_permission_relation` (
  `role_permisssion_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`role_permisssion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

insert into `blog_role_permission_relation`(`role_permisssion_id`,`role_id`,`permission_id`) values
('1','1','1'),
('2','1','2'),
('3','2','1'),
('4','2','2'),
('5','3','1');
DROP TABLE IF EXISTS  `blog_tag`;
CREATE TABLE `blog_tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `article_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `article_id` (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;

insert into `blog_tag`(`id`,`name`,`article_id`) values
('1','test1','1'),
('2','test2','1'),
('3','test3','1'),
('9','a  ','1'),
('10','v  ','1'),
('11','b  ','2'),
('12','a  ','2'),
('13','v  ','2'),
('14','b  ','2'),
('15','a  ','2'),
('16','v  ','2'),
('17','b  ','2'),
('18','l；  ','64'),
('19','l  ','65'),
('20','k  ','66'),
('21','lll  ','67'),
('22','php  ','68'),
('23','thinkphp  ','68'),
('24','if  ','68'),
('27','bootatarp','70'),
('28','dropdown','70'),
('86','no.1  ','71'),
('87','no.2  ','71'),
('88','no.3  ','71'),
('89','no.4  ','71'),
('90','1；  ','72'),
('91','2  ','73'),
('92','3  ','74'),
('96','7  ','78'),
('97','7  ','77'),
('98','7  ','76'),
('100','test1  ','79'),
('101','5  ','75'),
('105','1  ','81'),
('107','1  ','82'),
('109','test  ','80');
DROP TABLE IF EXISTS  `blog_user`;
CREATE TABLE `blog_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `account` int(11) unsigned NOT NULL COMMENT '用户账户',
  `password` varchar(50) NOT NULL COMMENT '用户密码',
  `reg_time` datetime DEFAULT NULL,
  `lock` tinyint(1) DEFAULT '0' COMMENT '用户是否被锁定（1为被锁定 0为没有被锁定）',
  PRIMARY KEY (`id`),
  KEY `account` (`account`),
  KEY `id` (`id`),
  CONSTRAINT ` ` FOREIGN KEY (`id`) REFERENCES `blog_user_info` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

insert into `blog_user`(`id`,`account`,`password`,`reg_time`,`lock`) values
('1','183','cedebb6e872f539bef8c3f919874e9d7','2016-10-10 23:01:21','0'),
('2','620','b73dfe25b4b8714c029b37a6ad3006fa','2016-10-14 15:13:13','0'),
('3','110','5f93f983524def3dca464469d2cf9f3e','2016-10-17 20:41:15','0'),
('4','111','698d51a19d8a121ce581499d7b701668','2016-11-29 21:54:35','0');
DROP TABLE IF EXISTS  `blog_user_info`;
CREATE TABLE `blog_user_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户信息id',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `truename` varchar(50) DEFAULT NULL COMMENT '用户真实姓名',
  `age` date DEFAULT NULL COMMENT '用户年龄',
  `sex` enum('m','f') DEFAULT NULL COMMENT '用户性别m为男性，f为女性',
  `intrdocue` varchar(50) DEFAULT NULL,
  `faceAdress` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `province` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `uid` int(11) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `username` (`username`),
  KEY `fk_blog_user_info_uid` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

insert into `blog_user_info`(`id`,`username`,`truename`,`age`,`sex`,`intrdocue`,`faceAdress`,`email`,`province`,`city`,`uid`) values
('1','liang','lwt','2016-10-04 00:00:00','m','ada','adsa','asdad','asdad','asdasd','1'),
('2','620',null,null,null,null,null,null,null,null,'2'),
('5','110',null,null,null,null,null,null,null,null,'3'),
('6','','','2016-10-24 00:00:00','f',null,'','','湖北','宜昌','0'),
('7','','','2016-10-04 00:00:00','f',null,'','','','','0'),
('8','111',null,null,null,null,null,null,null,null,'4'),
('9','','','2016-10-04 00:00:00','f',null,'/liangblog/Public/uploads/littleface/20161129/583d','','','','0');
DROP TABLE IF EXISTS  `blog_user_role_relation`;
CREATE TABLE `blog_user_role_relation` (
  `role_user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`role_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

insert into `blog_user_role_relation`(`role_user_id`,`user_id`,`role_id`) values
('1','1','1'),
('2','1','2'),
('3','2','1');
SET FOREIGN_KEY_CHECKS = 1;

