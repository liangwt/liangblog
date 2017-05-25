<?php
namespace Home\Controller;
use Home\Controller\CommonController;

class ArticleController extends CommonController
{

    private $articleL;

    public function writeArticle()
    {
        /*		print_r($article);
                print_r($tag);
                exit();*/
        //展示分类下拉列表
        $classification = D("classification")->where(array("uid" => $_SESSION['uid']))->select();
        $this->assign([
            "classification" => $classification,
        ]);
        $this->display(T("Home@Article/writeArticle"));
    }

    /**
     * 显示自己的博客列表
     * @return [type] [description]
     */
    public function showArticle()
    {
        $article = D("ArticleView");

        //分页之后的文章列表
        $this->articleL = $article->where("article.uid=" . $_SESSION['uid'])
            ->group("article.id")
            ->order('last_edit_time desc')
            ->page(I("get.p", 1) . ',5')
            ->select();
        $this->assign('lists', $this->articleL);// 赋值数据集
        //页码标签
        $count = $article->where("article.uid=" . $_SESSION['uid'])->count("distinct article.id");
        $page = new \Think\Page($count, 5);
        $show = $page->show();
        /*print_r($show);
        exit();*/

        $this->assign("page", $show);
        $this->display(T("Home@Article/showArticle"));
    }

    /**
     * 编辑文章
     * @return [type] [description]
     */
    public function editArticle()
    {
        $articleM = M("article");
        $article_id = I("get.id");

        if (!empty($article_id)) {
            $article = $articleM->where("id=" . $article_id)->find();
            $tag = M("tag")->field("name")->where("article_id=" . $article_id)->select();
            foreach ($tag as $name) {
                $p[] = $name["name"];
            }
            $tag = implode(",", $p);
        }
        $this->assign(array(
            "article_info" => $article,
            "tag"          => $tag,
        ));
        //展示分类下拉列表
        $classification = D("classification")->where(array("uid" => $_SESSION['uid']))->select();
        $this->assign([
            "classification" => $classification,
        ]);
        $this->display(T("Home@Article/editArticle"));
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
    public function saveArticle()
    {
        $content = I("post.content");
        $title = I("post.title");
        $classification = I("post.classification");
        $tag = I("post.tag");
        $article_id = I("get.id");
        $public = I("post.public", 0);
        $isOriginal = I("post.isOriginal", 1);

        $articleM = M("article");
        $tagM = M("tag");
        //处理没有id传入情况即新建一篇文章
        if (empty($article_id)) {
            $article = array(
                "title"             => $title,
                "content"           => $content,
                "create_time"       => date("Y-m-d H:m:s"),
                "last_edit_time"    => date("Y-m-d H:m:s"),
                "classification_id" => $classification,
                "uid"               => $_SESSION["uid"],
                "public"            => $public,
                "isOriginal"        => $isOriginal,
            );
            $article_id = $articleM->add($article);

        } else {
            //处理有id情况即更新一篇文章
            $article = array(
                "title"             => $title,
                "content"           => $content,
                "last_edit_time"    => date("Y-m-d H:m:s"),
                "classification_id" => $classification,
                "uid"               => $_SESSION["uid"],
                "public"            => $public,
                "isOriginal"        => $isOriginal,
            );
            $articleM->where(["id" => $article_id])->save($article);
            $tagM->where(["article_id" => $article_id])->delete();
        }

        //这里暂时不清楚如何使用同时插入多个标签数据 所以选择分开插入
        foreach ($tag as $key => $value) {
            $data = array(
                "name"       => $value,
                "article_id" => $article_id,
            );
            $result = M("tag")->add($data);
        }

        if ($result) {
            $response = array(
                'status'     => 1,
                'message'    => $title . "已保存",
                'article_id' => $article_id,
            );
            echo json_encode($response);
        }
    }

    /**
     * 删除文章
     * @return [json] [description]
     */
    public function deleteArticle()
    {
        $article_id = I("get.id");
        $articleM = M("Article");
        if (!empty($article_id)) {
            $articleM->where("id=" . $article_id)->delete();
            echo json_encode(["status" => 1, "message" => $article_id]);
        } else {
            echo json_encode(["status" => 0, "message" => "删除失败"]);
        }
    }

    /**
     * 改变文章的公开状态
     */
    public function chgstatus()
    {
        $id = I("get.id");
        $articleM = M("article");
        $status = $articleM->where("id=" . $id)->find();
        if ($status["public"] == 1) {
            $articleM->where("id=" . $id)->save(["public" => 0]);
            $response = array(
                "status"  => 1,
                "message" => "change to private"
            );
        } else {
            $articleM->where("id=" . $id)->save(["public" => 1]);
            $response = array(
                "status"  => 1,
                "message" => "change to public"
            );
        }
        echo json_encode($response);
    }

    /**
     * 处理添加分类的ajax
     * @return [json] [description]
     */
    public function saveClassification()
    {
        $classM = M("classification");
        $result = $classM->where(array(
            "classification" => I("post.classification"),
            "uid"            => $_SESSION['uid']))->find();
        if ($result) {
            echo json_encode(array("status" => 0, "message" => "分类已存在"));
            return false;
        }
        $value = $classM->add(array(
            "classification" => I("post.classification"),
            "uid"            => $_SESSION['uid'],
        ));
        if ($value) {
            echo json_encode(array("status" => 1, "message" => $value));
        } else {
            echo json_encode(array("status" => 0, "message" => "添加失败"));
        }
    }

    /**
     * 保存ajax提交过来的评论
     * @return [type] [description]
     */
    public function saveComment()
    {
        $comment_data = [
            "uid"        => $_SESSION["uid"],
            "article_id" => I("post.article_id"),
            "content"    => I("post.comment_text"),
            "time"       => date("Y-m-d H:m:s"),
            "comment_id" => 0,
        ];
        $commentM = M("comment");
        $result = $commentM->add($comment_data);
        if ($result) {
            echo json_encode(["status" => "1", "message" => $result]);
        } else {
            echo json_encode(["status" => "0", "message" => "error"]);
        }
    }

    /**
     * 处理编辑和写入文章时的图片插入
     * @return [string] [图片所在地址]
     */
    public function uploadPic()
    {
        $config = array(
            'maxSize'  => 0,
            'rootPath' => 'public/',
            'savePath' => 'uploads/ArticlePic/',
            'saveName' => array('uniqid', ''),
            'exts'     => array('jpg', 'gif', 'png', 'jpeg'),
            'autoSub'  => true,
            'subName'  => array('date', 'Ymd'),
        );
        $upload = new \Think\Upload($config);// 实例化上传类
        $info = $upload->upload();
        if (!$info) {
            // 上传错误提示错误信息
            echo "error|" . $upload->getError();
        } else {
            // 上传成功 获取上传文件信息
            foreach ($info as $file) {
                $path = __ROOT__ . "/Public/" . $file["savepath"] . $file['savename'];
                echo $path;
            }
        }
    }


}

?>
