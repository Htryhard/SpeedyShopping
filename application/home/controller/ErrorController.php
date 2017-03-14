<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/3/14 0014
 * Time: 上午 11:22
 */

namespace app\home\controller;


use think\Controller;

class ErrorController extends Controller
{
    /**
     * 请求方式错误！
     */
    public function postError($code,$msg)
    {
        $this->assign("code",$code);
        $this->assign("msg",$msg);
        return $this->fetch();
    }
}