<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/4/11 0011
 * Time: 下午 4:37
 */

namespace app\home\controller;


use app\common\model\User;
use think\Controller;

class MessageController extends Controller
{
    public function index()
    {
        $user = User::getUserBySession("home");
        $this->assign("user", $user);
        return $this->fetch();
    }

}