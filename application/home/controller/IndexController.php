<?php
namespace app\home\controller;

use app\common\controller\BaseController;

class IndexController extends  BaseController
{
    public function index()
    {

           $this->assign('content',"这是内容崖");
           return $this->fetch();
    }
    public  function  register(){

    }
    public  function  login(){

    }
    public function contact(){

    }
}
