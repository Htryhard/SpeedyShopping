<?php
namespace app\admin\controller;

use app\common\Comm;
use app\common\controller\BaseController;
use app\common\model\Commodity;

/**
 * 专门用来测试的控制器
 * @package app\admin\controller
 */
class IndexController extends BaseController
{
    public function index()
    {
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
        echo 'laibaibao提交的';
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
