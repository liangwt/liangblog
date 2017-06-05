<?php
/**
 * Created by PhpStorm.
 * User: LiangWentao
 * Date: 1/5/2017
 * Time: 18:36
 */
namespace Admin\Controller;

use Think\Controller;
use Think\Crypt\Driver\Think;
use Home\Controller\CommonController;

class UserController extends CommonController
{
    /**
     * 用于后台显示出文章和用户
     */
    function index()
    {
        //用户管理
        $userL     = M("user")
            ->field("*,GROUP_CONCAT(rolename) as rolenames")
            ->join("__USER_INFO__ on __USER_INFO__.uid=__USER__.id")
            ->join("__USER_ROLE_RELATION__ on __USER__.id = __USER_ROLE_RELATION__.user_id")
            ->join("__ROLE__ on __ROLE__.id = __USER_ROLE_RELATION__.role_id")
            ->group("blog_user.id")
            ->order("reg_time")
            ->page(I("get.p", 1), 5)
            ->select();
        $userCount = M("user")->group("blog_user.id")->count();
        $userPage  = new \Think\Page($userCount, 5);
        $userShow  = $userPage->show();
        $this->assign(array(
            "userList" => $userL,
            "userShow" => $userShow,
        ));
        $this->display(T("Admin@User/index"));
    }

    /**
     * 添加用户
     */
    public function addUser()
    {
        $roleL = M("role")->select();
        $this->assign([
           "role" => $roleL,
        ]);
        $this->display(T("Admin@User/addUser"));
    }

    /**
     * 创建一个新的角色，需要为这个角色分配权限和添加用户
     */
    public function addRole()
    {
        $adminFileTree = $this->fileTree("./Application/Admin/View");
        /*        print_r($admin);
                exit();*/
        $homeFileTree = $this->fileTree("./Application/Home/View");
        $userL        = M("user")->join("LEFT JOIN __USER_INFO__ on __USER__.id = __USER_INFO__.uid")
                                 ->select();
        $this->assign(array(
            "userList" => $userL,
            "fileTree" => array_merge($adminFileTree, $homeFileTree),
        ));
        $this->display(T("Admin@/User/addRole"));
    }

    /**
     * @param $path 文件或者目录路径
     * @param array $result 已经存在的文件
     * @return array 路径下的文件树
     */
    private function fileTree($path, &$result = [])
    {
        //获取路径下的文件和目录
        $allFiles = scandir($path);
        /*        print_r($allFiles);*/
        foreach ($allFiles as $fileName) {
            if ($fileName == "." || $fileName == "..") {
                continue;
            }
            $newPath = $path . "/" . $fileName;
            /*            echo "**".$newPath."\n";*/
            //循环判断是否为文件，如果是文件添加进数组，如果不是文件递归循环直至文件，
            if (!is_dir($newPath) && is_readable($newPath)) {
                /*                echo "newPath".$newPath."\n";*/
                $result[] = $newPath;
                /*                print_r($result);*/
            } else {
                /*                echo "###".$newPath."\n";*/
                $this->fileTree($newPath, $result);

            }
        }
        return $result;
    }
    public function manageRole(){
        $roleL = M("role")->select();

        $this->assign([
           "roleList"=>$roleL,
        ]);
        $this->display(T("Admin@User/manageRole"));
    }
}