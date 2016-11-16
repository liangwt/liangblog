/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : liangblog

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2016-11-03 21:19:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for blog_article
-- ----------------------------
DROP TABLE IF EXISTS `blog_article`;
CREATE TABLE `blog_article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `content` mediumtext,
  `create_time` datetime NOT NULL,
  `last_edit_time` datetime NOT NULL,
  `classification_id` int(11) unsigned DEFAULT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `title` (`title`),
  KEY `fk_blog_user_article_uid` (`uid`) USING BTREE,
  CONSTRAINT `blog_article_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `blog_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_article
-- ----------------------------
INSERT INTO `blog_article` VALUES ('6', '使用拉链法解决冲突的简单hash表', '&lt;p&gt;&amp;nbsp;Hash函数的作用是把任意长度的输入，通过hash算法变换成固定长度的输出，该输出就是hash值，hash表的复杂度为O(1)。&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;?php \n/**\n * 一个简单的hash表\n * 使用拉链法解决冲突\n */\nclass hashtable{\n	private $buckets;   //存储数据数组\n	private $size = 10;\n\n	public function __construct(){\n		$this -&amp;gt; buckets = new SplFixedArray($this-&amp;gt;size);\n	}\n	/**\n	 * 通过把字符串相加取余得到hash值\n	 * @param  string $key 关键字\n	 * @return int         hash值\n	 */\n	private function hashfunc($key){\n		$strlen  = strlen($key);\n		$hashval = 0;\n		for ($i=0; $i &amp;lt; $strlen; $i++) { \n			$hashval += ord($key[$i]);\n		}\n		return $hashval%$this-&amp;gt;size;\n	}\n	/**\n	 * 1. 使用hsahfuc计算关键字的hash值，通过hash值定位到hash表的指定位置\n	 * 2. 如果此位置已经被占用，把新节点的$NextNode指向此节点，否则把$NextNode设置为NULL\n	 * 3. 把新节点保存到hash表中\n	 * @param  string $key   关键字\n	 * @param  string $value 值\n	 * @return void        \n	 */\n	public function insert($key,$value){\n		$index = $this-&amp;gt;hashfunc($key);\n		if(isset($this-&amp;gt;buckets[$index])){\n			$newNode = new HashNode($key,$value,$this-&amp;gt;buckets[$index]);\n		}else{\n			$newNode = new HashNode($key,$value,null);\n		}\n		$this-&amp;gt;buckets[$index] = $newNode;\n	}\n	public function find($key){\n		$index   = $this -&amp;gt; hashfunc($key);\n		$current = $this -&amp;gt; buckets[$index];\n		while (isset($current)) {\n			if($current-&amp;gt;key == $key){\n				return $current-&amp;gt;value;\n			}\n			$current = $current-&amp;gt;nextNode;\n		}\n	}\n}\n\nclass HashNode{\n	public $key;            //节点关键字\n	public $value;          //节点的值\n	public $nextNode;       //具有相同hash值的节点的指针\n	public function __construct($key,$value,$nextNode=null){\n		$this -&amp;gt; key      = $key;\n		$this -&amp;gt; value    = $value;\n		$this -&amp;gt; nextNode = $nextNode;\n	}\n}\n\n$test = new hashtable();\n$test -&amp;gt; insert(\'key1\',\'value1\');\n$test -&amp;gt; insert(\'key12\',\'value12\');\n$test -&amp;gt; insert(\'key2\',\'value2\');\nvar_dump($test -&amp;gt; find(\'key1\'));\nvar_dump($test -&amp;gt; find(\'key12\'));\nvar_dump($test -&amp;gt; find(\'key2\'));\n\n ?&amp;gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;&lt;img src=&quot;data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==&quot;&gt;&lt;img src=&quot;data:image/gif;base64,R0lGODlhAQABAPABAP///wAAACH5BAEKAAAALAAAAAABAAEAAAICRAEAOw==&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;', '2016-10-13 00:00:00', '2016-10-13 00:00:00', '2', '1');
INSERT INTO `blog_article` VALUES ('16', 'Sample blog post', '&lt;p&gt;This blog post shows a few different types of content that\'s supported and styled with Bootstrap. Basic typography, images, and code are all supported.&lt;/p&gt;&lt;p&gt;Cum sociis natoque penatibus et magnis&amp;nbsp;&lt;a href=&quot;http://127.0.0.1/liangblog/index.php/Home/Index/index.html#&quot;&gt;dis parturient montes&lt;/a&gt;, nascetur ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet fermentum.&lt;/p&gt;&lt;blockquote&gt;Curabitur blandit tempus porttitor.&amp;nbsp;Nullam quis risus eget urna mollis&amp;nbsp;ornare vel eu leo. Nullam id dolor id nibh ultricies vehicula ut id elit.&lt;/blockquote&gt;&lt;p&gt;&lt;/p&gt;&lt;p&gt;Etiam porta&amp;nbsp;sem malesuada magna&amp;nbsp;mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;', '2016-10-15 00:00:00', '2016-10-15 00:00:00', '1', '1');
INSERT INTO `blog_article` VALUES ('18', 'NEW FEATURE', '&lt;p&gt;Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Praesent commodo cursus magna, vel scelerisque nisl consectetur et.&lt;/li&gt;&lt;li&gt;Donec id elit non mi porta gravida at eget metus.&lt;/li&gt;&lt;li&gt;Nulla vitae elit libero, a pharetra augue.&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Etiam porta&amp;nbsp;sem malesuada magna&amp;nbsp;mollis euismod. Cras mattis consectetur purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.&lt;/p&gt;&lt;p&gt;&lt;/p&gt;&lt;p&gt;Donec ullamcorper nulla non metus auctor fringilla. Nulla vitae elit libero, a pharetra augue.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;', '2016-10-16 21:10:28', '2016-10-16 21:10:28', '2', '1');
INSERT INTO `blog_article` VALUES ('68', 'IF标签', '&lt;p&gt;用法示例：&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;if condition=&quot;($name eq 1) OR ($name gt 100) &quot;&amp;gt; value1\n&amp;lt;elseif condition=&quot;$name eq 2&quot;/&amp;gt;value2\n&amp;lt;else /&amp;gt; value3\n&amp;lt;/if&amp;gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;在condition属性中可以支持eq等判断表达式，同上面的比较标签，但是不支持带有”&amp;gt;”、”&amp;lt;”等符号的用法，因为会混淆模板解析，所以下面的用法是错误的：&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;if condition=&quot;$id &amp;lt; 5 &quot;&amp;gt;value1\n    &amp;lt;else /&amp;gt; value2\n&amp;lt;/if&amp;gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;必须改成：&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;if condition=&quot;$id lt 5 &quot;&amp;gt;value1\n&amp;lt;else /&amp;gt; value2\n&amp;lt;/if&amp;gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;除此之外，我们可以在condition属性里面使用php代码，例如：&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;if condition=&quot;strtoupper($user[\'name\']) neq \'THINKPHP\'&quot;&amp;gt;ThinkPHP\n&amp;lt;else /&amp;gt; other Framework\n&amp;lt;/if&amp;gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;condition属性可以支持点语法和对象语法，例如： 自动判断user变量是数组还是对象&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;if condition=&quot;$user.name neq \'ThinkPHP\'&quot;&amp;gt;ThinkPHP\n&amp;lt;else /&amp;gt; other Framework\n&amp;lt;/if&amp;gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;或者知道user变量是对象&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;if condition=&quot;$user:name neq \'ThinkPHP\'&quot;&amp;gt;ThinkPHP\n&amp;lt;else /&amp;gt; other Framework\n&amp;lt;/if&amp;gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;&lt;/p&gt;&lt;p&gt;t由于if标签的condition属性里面基本上使用的是php语法，尽可能使用判断标签和Switch标签会更加简洁，原则上来说，能够用switch和比较标签解决的尽量不用if标签完成。因为switch和比较标签可以使用变量调节器和系统变量。如果某些特殊的要求下面，IF标签仍然无法满足要求的话，可以使用原生php代码或者PHP标签来直接书写代码。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;', '2016-10-25 21:10:35', '2016-10-25 21:10:35', '23', '1');
INSERT INTO `blog_article` VALUES ('69', 'jQuery.parseJSON(json)', '&lt;h2&gt;&lt;span style=&quot;font-family: inherit; font-size: 34px; letter-spacing: 0.1px;&quot;&gt;概述&lt;/span&gt;&lt;br&gt;&lt;/h2&gt;&lt;p&gt;接受一个JSON字符串，返回解析后的对象。&lt;/p&gt;&lt;p&gt;传入一个畸形的JSON字符串会抛出一个异常。比如下面的都是畸形的JSON字符串：&lt;/p&gt;&lt;ul&gt;&lt;li&gt;{test: 1} （ test 没有包围双引号）&lt;/li&gt;&lt;li&gt;{\'test\': 1} （使用了单引号而不是双引号）&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;另外，如果你什么都不传入，或者一个空字符串、null或undefined，parseJSON都会返回 null 。&lt;/p&gt;&lt;h3&gt;参数&lt;/h3&gt;&lt;h4&gt;jsonStringV1.4.1&lt;/h4&gt;&lt;p&gt;要解析的JSON字符串&lt;/p&gt;&lt;h3&gt;示例&lt;/h3&gt;&lt;h4&gt;描述:&lt;/h4&gt;&lt;p&gt;解析一个JSON字符串&lt;/p&gt;&lt;h5&gt;jQuery 代码:&lt;/h5&gt;&lt;p&gt;&lt;/p&gt;&lt;pre&gt;&lt;code&gt;var obj = jQuery.parseJSON(\'{&quot;name&quot;:&quot;John&quot;}\');\nalert( obj.name === &quot;John&quot; );&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;', '2016-10-28 21:10:01', '2016-10-28 21:10:01', '2', '1');
INSERT INTO `blog_article` VALUES ('70', '下拉菜单', '&lt;h1&gt;&lt;span style=&quot;color: rgb(102, 102, 102); font-size: 15px; letter-spacing: 0.1px;&quot;&gt;用于显示链接列表的可切换、有上下文的菜单。&lt;/span&gt;&lt;a href=&quot;http://v3.bootcss.com/javascript/#dropdowns&quot; style=&quot;background-color: rgb(255, 255, 255); font-size: 15px; letter-spacing: 0.1px;&quot;&gt;下拉菜单的 JavaScript 插件&lt;/a&gt;&lt;span style=&quot;color: rgb(102, 102, 102); font-size: 15px; letter-spacing: 0.1px;&quot;&gt;让它具有了交互性。&lt;/span&gt;&lt;br&gt;&lt;/h1&gt;&lt;h3&gt;实例&lt;/h3&gt;&lt;p&gt;将下拉菜单触发器和下拉菜单都包裹在&amp;nbsp;.dropdown&amp;nbsp;里，或者另一个声明了&amp;nbsp;position: relative;&amp;nbsp;的元素。然后加入组成菜单的 HTML 代码。&lt;/p&gt;&lt;p&gt;&lt;button&gt;Dropdown&amp;nbsp;&lt;/button&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Action&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Another action&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Something else here&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Separated link&lt;/a&gt;&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Copy&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;div class=&quot;dropdown&quot;&amp;gt;\n  &amp;lt;button class=&quot;btn btn-default dropdown-toggle&quot; type=&quot;button&quot; id=&quot;dropdownMenu1&quot; data-toggle=&quot;dropdown&quot;&amp;gt;\n    Dropdown\n    &amp;lt;span class=&quot;caret&quot;&amp;gt;&amp;lt;/span&amp;gt;\n  &amp;lt;/button&amp;gt;\n  &amp;lt;ul class=&quot;dropdown-menu&quot; role=&quot;menu&quot; aria-labelledby=&quot;dropdownMenu1&quot;&amp;gt;\n    &amp;lt;li role=&quot;presentation&quot;&amp;gt;&amp;lt;a role=&quot;menuitem&quot; tabindex=&quot;-1&quot; href=&quot;#&quot;&amp;gt;Action&amp;lt;/a&amp;gt;&amp;lt;/li&amp;gt;\n    &amp;lt;li role=&quot;presentation&quot;&amp;gt;&amp;lt;a role=&quot;menuitem&quot; tabindex=&quot;-1&quot; href=&quot;#&quot;&amp;gt;Another action&amp;lt;/a&amp;gt;&amp;lt;/li&amp;gt;\n    &amp;lt;li role=&quot;presentation&quot;&amp;gt;&amp;lt;a role=&quot;menuitem&quot; tabindex=&quot;-1&quot; href=&quot;#&quot;&amp;gt;Something else here&amp;lt;/a&amp;gt;&amp;lt;/li&amp;gt;\n    &amp;lt;li role=&quot;presentation&quot;&amp;gt;&amp;lt;a role=&quot;menuitem&quot; tabindex=&quot;-1&quot; href=&quot;#&quot;&amp;gt;Separated link&amp;lt;/a&amp;gt;&amp;lt;/li&amp;gt;\n  &amp;lt;/ul&amp;gt;\n&amp;lt;/div&amp;gt;\n&lt;/code&gt;&lt;/pre&gt;&lt;h3&gt;对齐&lt;/h3&gt;&lt;p&gt;B默认情况下，下拉菜单自动沿着父元素的上沿和左侧被定位为 100% 宽度。 为&amp;nbsp;.dropdown-menu&amp;nbsp;添加&amp;nbsp;.dropdown-menu-right&amp;nbsp;类可以让菜单右对齐。&lt;/p&gt;&lt;h4&gt;可能需要额外的定位May require additional positioning&lt;/h4&gt;&lt;p&gt;在正常的文档流中，通过 CSS 为下拉菜单进行定位。这就意味着下拉菜单可能会由于设置了&amp;nbsp;overflow&amp;nbsp;属性的父元素而被部分遮挡或超出视口（viewport）的显示范围。如果出现这种问题，请自行解决。&lt;/p&gt;&lt;h4&gt;不建议使用&amp;nbsp;.pull-right&lt;/h4&gt;&lt;p&gt;从 v3.1.0 版本开始，我们不再建议对下拉菜单使用&amp;nbsp;.pull-right&amp;nbsp;类。如需将菜单右对齐，请使用&amp;nbsp;.dropdown-menu-right&amp;nbsp;类。导航条中如需添加右对齐的导航（nav）组件，请使用&amp;nbsp;.pull-right&amp;nbsp;的 mixin 版本，可以自动对齐菜单。如需左对齐，请使用&amp;nbsp;.dropdown-menu-left&amp;nbsp;类。&lt;/p&gt;&lt;p&gt;Copy&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;ul class=&quot;dropdown-menu dropdown-menu-right&quot; role=&quot;menu&quot; aria-labelledby=&quot;dLabel&quot;&amp;gt;\n  ...\n&amp;lt;/ul&amp;gt;\n&lt;/code&gt;&lt;/pre&gt;&lt;h3&gt;标题&lt;/h3&gt;&lt;p&gt;在任何下拉菜单中均可通过添加标题来标明一组动作。&lt;/p&gt;&lt;p&gt;&lt;button&gt;Dropdown&amp;nbsp;&lt;/button&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;Dropdown header&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Action&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Another action&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Something else here&lt;/a&gt;&lt;/li&gt;&lt;li&gt;Dropdown header&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Separated link&lt;/a&gt;&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Copy&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;ul class=&quot;dropdown-menu&quot; role=&quot;menu&quot; aria-labelledby=&quot;dropdownMenu2&quot;&amp;gt;\n  ...\n  &amp;lt;li role=&quot;presentation&quot; class=&quot;dropdown-header&quot;&amp;gt;Dropdown header&amp;lt;/li&amp;gt;\n  ...\n&amp;lt;/ul&amp;gt;\n&lt;/code&gt;&lt;/pre&gt;&lt;h3&gt;分割线&lt;/h3&gt;&lt;p&gt;为下拉菜单添加一条分割线，用于将多个链接分组。&lt;/p&gt;&lt;p&gt;&lt;button&gt;Dropdown&amp;nbsp;&lt;/button&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Action&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Another action&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Something else here&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Separated link&lt;/a&gt;&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;Copy&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&amp;lt;ul class=&quot;dropdown-menu&quot; role=&quot;menu&quot; aria-labelledby=&quot;dropdownMenuDivider&quot;&amp;gt;\n  ...\n  &amp;lt;li role=&quot;presentation&quot; class=&quot;divider&quot;&amp;gt;&amp;lt;/li&amp;gt;\n  ...\n&amp;lt;/ul&amp;gt;\n&lt;/code&gt;&lt;/pre&gt;&lt;h3&gt;禁用的菜单项&lt;/h3&gt;&lt;p&gt;为下拉菜单中的&amp;nbsp;&amp;lt;li&amp;gt;&amp;nbsp;元素添加&amp;nbsp;.disabled&amp;nbsp;类，从而禁用相应的菜单项。&lt;/p&gt;&lt;p&gt;&lt;button&gt;Dropdown&amp;nbsp;&lt;/button&gt;&lt;/p&gt;&lt;ul&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Regular link&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Disabled link&lt;/a&gt;&lt;/li&gt;&lt;li&gt;&lt;a href=&quot;http://v3.bootcss.com/components/#&quot;&gt;Another link&lt;/a&gt;&lt;/li&gt;&lt;/ul&gt;&lt;p&gt;&lt;/p&gt;&lt;pre&gt;&lt;code&gt;&lt;span&gt;&amp;lt;ul&lt;/span&gt; &lt;span&gt;class=&lt;/span&gt;&lt;span&gt;&quot;dropdown-menu&quot;&lt;/span&gt; &lt;span&gt;role=&lt;/span&gt;&lt;span&gt;&quot;menu&quot;&lt;/span&gt; &lt;span&gt;aria-labelledby=&lt;/span&gt;&lt;span&gt;&quot;dropdownMenu3&quot;&lt;/span&gt;&lt;span&gt;&amp;gt;&lt;/span&gt;\n  &lt;span&gt;&amp;lt;li&lt;/span&gt; &lt;span&gt;role=&lt;/span&gt;&lt;span&gt;&quot;presentation&quot;&lt;/span&gt;&lt;span&gt;&amp;gt;&amp;lt;a&lt;/span&gt; &lt;span&gt;role=&lt;/span&gt;&lt;span&gt;&quot;menuitem&quot;&lt;/span&gt; &lt;span&gt;tabindex=&lt;/span&gt;&lt;span&gt;&quot;-1&quot;&lt;/span&gt; &lt;span&gt;href=&lt;/span&gt;&lt;span&gt;&quot;#&quot;&lt;/span&gt;&lt;span&gt;&amp;gt;&lt;/span&gt;Regular link&lt;span&gt;&amp;lt;/a&amp;gt;&amp;lt;/li&amp;gt;&lt;/span&gt;\n  &lt;span&gt;&amp;lt;li&lt;/span&gt; &lt;span&gt;role=&lt;/span&gt;&lt;span&gt;&quot;presentation&quot;&lt;/span&gt; &lt;span&gt;class=&lt;/span&gt;&lt;span&gt;&quot;disabled&quot;&lt;/span&gt;&lt;span&gt;&amp;gt;&amp;lt;a&lt;/span&gt; &lt;span&gt;role=&lt;/span&gt;&lt;span&gt;&quot;menuitem&quot;&lt;/span&gt; &lt;span&gt;tabindex=&lt;/span&gt;&lt;span&gt;&quot;-1&quot;&lt;/span&gt; &lt;span&gt;href=&lt;/span&gt;&lt;span&gt;&quot;#&quot;&lt;/span&gt;&lt;span&gt;&amp;gt;&lt;/span&gt;Disabled link&lt;span&gt;&amp;lt;/a&amp;gt;&amp;lt;/li&amp;gt;&lt;/span&gt;\n  &lt;span&gt;&amp;lt;li&lt;/span&gt; &lt;span&gt;role=&lt;/span&gt;&lt;span&gt;&quot;presentation&quot;&lt;/span&gt;&lt;span&gt;&amp;gt;&amp;lt;a&lt;/span&gt; &lt;span&gt;role=&lt;/span&gt;&lt;span&gt;&quot;menuitem&quot;&lt;/span&gt; &lt;span&gt;tabindex=&lt;/span&gt;&lt;span&gt;&quot;-1&quot;&lt;/span&gt; &lt;span&gt;href=&lt;/span&gt;&lt;span&gt;&quot;#&quot;&lt;/span&gt;&lt;span&gt;&amp;gt;&lt;/span&gt;Another link&lt;span&gt;&amp;lt;/a&amp;gt;&amp;lt;/li&amp;gt;&lt;/span&gt;\n&lt;span&gt;&amp;lt;/ul&amp;gt;&lt;/span&gt;&lt;/code&gt;&lt;/pre&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;', '2016-10-25 21:10:37', '2016-10-25 21:10:37', '24', '1');
INSERT INTO `blog_article` VALUES ('71', '表情测试', '&lt;p&gt;&lt;img src=&quot;http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/50/pcmoren_huaixiao_thumb.png&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;', '2016-10-28 22:10:47', '2016-10-28 22:10:47', '0', '1');

-- ----------------------------
-- Table structure for blog_article_tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_article_tag`;
CREATE TABLE `blog_article_tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int(11) unsigned NOT NULL,
  `tag_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of blog_article_tag
-- ----------------------------

-- ----------------------------
-- Table structure for blog_classification
-- ----------------------------
DROP TABLE IF EXISTS `blog_classification`;
CREATE TABLE `blog_classification` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `classification` char(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_classification
-- ----------------------------
INSERT INTO `blog_classification` VALUES ('1', 'php');
INSERT INTO `blog_classification` VALUES ('2', 'jquery');
INSERT INTO `blog_classification` VALUES ('6', 'log');
INSERT INTO `blog_classification` VALUES ('23', 'thinkPHP');
INSERT INTO `blog_classification` VALUES ('24', 'bootstarp');

-- ----------------------------
-- Table structure for blog_comment
-- ----------------------------
DROP TABLE IF EXISTS `blog_comment`;
CREATE TABLE `blog_comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `article_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '文章id',
  `content` char(225) NOT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评论父id',
  `up` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `down` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '反对数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_comment
-- ----------------------------
INSERT INTO `blog_comment` VALUES ('1', '1', '1', 'good', '2016-10-22 20:39:16', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('2', '1', '1', 'hello', '2016-10-22 20:39:52', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('3', '1', '2', 'world', '2016-10-22 20:40:20', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('4', '0', '18', 'liang', '2016-10-23 19:10:09', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('5', '0', '18', 'a', '2016-10-23 19:10:54', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('6', '0', '18', 'a', '2016-10-23 19:10:03', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('7', '0', '18', 'b', '2016-10-23 19:10:09', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('8', '0', '18', 'c', '2016-10-23 19:10:33', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('9', '0', '18', 'd', '2016-10-23 19:10:08', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('10', '0', '18', 'e', '2016-10-23 19:10:24', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('11', '0', '18', 'a', '2016-10-23 19:10:09', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('12', '0', '18', 'l', '2016-10-23 19:10:54', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('13', '0', '18', 'liang', '2016-10-23 19:10:14', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('14', '0', '18', 'l', '2016-10-23 19:10:17', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('15', '0', '18', 'aa', '2016-10-23 19:10:22', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('16', '0', '18', 'aaa', '2016-10-23 19:10:04', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('17', '0', '18', 'aaaaa', '2016-10-23 19:10:44', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('18', '0', '18', 'aa', '2016-10-23 19:10:25', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('19', '0', '69', '求解 如果现在有A控制器 a.thml和B控制器 b.html 怎么将A控制器获取的变量 输出到b,html?', '2016-10-25 21:10:52', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('20', '0', '69', '{$r:title}或者｛$r-&gt;title｝', '2016-10-25 21:10:07', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('21', '0', '69', '', '2016-10-25 22:10:19', '0', '0', '0');
INSERT INTO `blog_comment` VALUES ('22', '0', '71', '了', '2016-10-28 22:10:16', '0', '0', '0');

-- ----------------------------
-- Table structure for blog_follow
-- ----------------------------
DROP TABLE IF EXISTS `blog_follow`;
CREATE TABLE `blog_follow` (
  `follow` int(11) unsigned NOT NULL COMMENT '关注',
  `followed` int(11) unsigned NOT NULL COMMENT '被关注',
  PRIMARY KEY (`follow`,`followed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_follow
-- ----------------------------

-- ----------------------------
-- Table structure for blog_tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_tag`;
CREATE TABLE `blog_tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `article_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `article_id` (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_tag
-- ----------------------------
INSERT INTO `blog_tag` VALUES ('1', 'test1', '1');
INSERT INTO `blog_tag` VALUES ('2', 'test2', '1');
INSERT INTO `blog_tag` VALUES ('3', 'test3', '1');
INSERT INTO `blog_tag` VALUES ('9', 'a  ', '1');
INSERT INTO `blog_tag` VALUES ('10', 'v  ', '1');
INSERT INTO `blog_tag` VALUES ('11', 'b  ', '2');
INSERT INTO `blog_tag` VALUES ('12', 'a  ', '2');
INSERT INTO `blog_tag` VALUES ('13', 'v  ', '2');
INSERT INTO `blog_tag` VALUES ('14', 'b  ', '2');
INSERT INTO `blog_tag` VALUES ('15', 'a  ', '2');
INSERT INTO `blog_tag` VALUES ('16', 'v  ', '2');
INSERT INTO `blog_tag` VALUES ('17', 'b  ', '2');
INSERT INTO `blog_tag` VALUES ('18', 'l；  ', '64');
INSERT INTO `blog_tag` VALUES ('19', 'l  ', '65');
INSERT INTO `blog_tag` VALUES ('20', 'k  ', '66');
INSERT INTO `blog_tag` VALUES ('21', 'lll  ', '67');
INSERT INTO `blog_tag` VALUES ('22', 'php  ', '68');
INSERT INTO `blog_tag` VALUES ('23', 'thinkphp  ', '68');
INSERT INTO `blog_tag` VALUES ('24', 'if  ', '68');
INSERT INTO `blog_tag` VALUES ('27', 'bootatarp', '70');
INSERT INTO `blog_tag` VALUES ('28', 'dropdown', '70');
INSERT INTO `blog_tag` VALUES ('73', 'jquery  ', '69');
INSERT INTO `blog_tag` VALUES ('74', 'js  ', '69');
INSERT INTO `blog_tag` VALUES ('86', 'no.1  ', '71');
INSERT INTO `blog_tag` VALUES ('87', 'no.2  ', '71');
INSERT INTO `blog_tag` VALUES ('88', 'no.3  ', '71');
INSERT INTO `blog_tag` VALUES ('89', 'no.4  ', '71');

-- ----------------------------
-- Table structure for blog_user
-- ----------------------------
DROP TABLE IF EXISTS `blog_user`;
CREATE TABLE `blog_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `account` int(11) unsigned NOT NULL COMMENT '用户账户',
  `password` varchar(50) NOT NULL COMMENT '用户密码',
  `reg_time` datetime DEFAULT NULL,
  `lock` tinyint(1) DEFAULT '0' COMMENT '用户是否被锁定（1为被锁定 0为没有被锁定）',
  PRIMARY KEY (`id`),
  KEY `account` (`account`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_user
-- ----------------------------
INSERT INTO `blog_user` VALUES ('1', '183', 'cedebb6e872f539bef8c3f919874e9d7', '2016-10-10 23:01:21', '0');
INSERT INTO `blog_user` VALUES ('2', '620', 'b73dfe25b4b8714c029b37a6ad3006fa', '2016-10-14 15:13:13', '0');
INSERT INTO `blog_user` VALUES ('3', '110', '5f93f983524def3dca464469d2cf9f3e', '2016-10-17 20:41:15', '0');

-- ----------------------------
-- Table structure for blog_user_info
-- ----------------------------
DROP TABLE IF EXISTS `blog_user_info`;
CREATE TABLE `blog_user_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户信息id',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `truename` varchar(50) DEFAULT NULL COMMENT '用户真实姓名',
  `age` datetime DEFAULT NULL COMMENT '用户年龄',
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_user_info
-- ----------------------------
INSERT INTO `blog_user_info` VALUES ('1', 'liang', 'lwt', '2016-10-04 00:00:00', 'm', 'ada', 'adsa', 'asdad', 'asdad', 'asdasd', '1');
INSERT INTO `blog_user_info` VALUES ('2', '620', null, null, null, null, null, null, null, null, '2');
INSERT INTO `blog_user_info` VALUES ('3', '', '', '0000-00-00 00:00:00', 'f', null, '', '', '', '', '0');
INSERT INTO `blog_user_info` VALUES ('4', '', '', '0000-00-00 00:00:00', 'f', null, '', '', '', '', '0');
INSERT INTO `blog_user_info` VALUES ('5', '110', null, null, null, null, null, null, null, null, '3');
INSERT INTO `blog_user_info` VALUES ('6', '', '', '2016-10-24 00:00:00', 'f', null, '', '', '湖北', '宜昌', '0');
