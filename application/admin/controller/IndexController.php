<?php
namespace app\admin\controller;

use app\common\Comm;
use app\common\controller\BaseController;

/**
 * 专门用来测试的控制器
 * @package app\admin\controller
 */
class IndexController extends BaseController
{
    public function index()
    {
        echo "nihao ";
    }

    public function test()
    {
        echo "陈炳坤提交的";
    }

    public function testUUID()
    {
        echo "GUID:" . Comm::getNewGuid() . "<br/>";
    }
    public  function add(){
        echo 'laibaibao提交的';
    }

    public function test1(){
        echo "dddddd";
        echo "aaaa";
    }

    //测试后台布局界面
    public function testWei(){
        return $this->fetch();
    }


}
