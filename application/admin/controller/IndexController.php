<?php
namespace app\admin\controller;

use app\common\Comm;
use think\Controller;

class IndexController extends Controller
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
    }


}
