<?php
namespace app\home\controller;

use app\common\controller\BaseController;
use app\common\model\Commodity;
use think\Request;

class IndexController extends  BaseController
{
    public function index()
    {
        $this->assign('email','你好');
        return $this->fetch();

    }


    public  function  loginHandle(){
        return $this->fetch();
    }
    public function read(){

    }
    public function  readHandle(){

    }
}
