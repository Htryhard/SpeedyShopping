<?php
namespace app\home\controller;


use app\common\model\Type;
use think\Controller;

class IndexController extends  Controller
{
    public function index()
    {
//        $this->assign("commodities",);
        $this->assign('types',Type::all());
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
