<?php
namespace app\admin\controller;

use app\common\Comm;
use app\common\controller\BaseController;
use app\common\model\Commodity;
use app\common\model\User;

/**
 * 专门用来测试的控制器
 * @package app\admin\controller
 */
class IndexController extends BaseController
{
    public function index()
    {
        $user = User::getUserBySession("admin");
        $this->assign("user", $user);
        //服务器操作系统

        //服务器域名/IP
        //服务器环境
        //PHP 版本
        //Mysql 版本

        return $this->fetch();
    }

    public function test()
    {
        $objs = Commodity::all();
        return json($objs);
    }

    public function testUUID()
    {
        echo "GUID:" . Comm::getNewGuid() . "<br/>";
    }

    public function add()
    {
        echo time();
    }

    public function test1()
    {
        echo "dddddd";
        echo "aaaa";
    }

    //测试后台布局界面
    public function testWei()
    {
        return $this->fetch();
    }


}
