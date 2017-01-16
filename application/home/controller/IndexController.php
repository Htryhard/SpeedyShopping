<?php
namespace app\home\controller;


use app\common\Comm;
use app\common\model\Type;
use app\common\model\User;
use think\Controller;

class IndexController extends  Controller
{
    public function index()
    {
//        $this->assign("commodities",);
        $user = User::getUserBySession();
        $this->assign("user",$user);
        $imgRoot = '/speedyshopping/public//uploads/commodity_images/';
        $this->assign("imgRoot", $imgRoot);
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
