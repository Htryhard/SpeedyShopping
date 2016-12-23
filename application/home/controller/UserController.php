<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/23
 * Time: 11:19
 */

namespace app\home\controller;

use app\common\model\User;
use think\Controller;
use think\Request;

class UserController extends Controller
{
    public function register()
    {
        return $this->fetch();
    }

    public function login()
    {
        return $this->fetch();
    }

    public function loginHandle()
    {
        // 接收post信息
        $data = Request::instance()->param();
        // 直接调用M层方法，进行登录。
        if (User::login($data['email'], $data['password'])) {
            return json("succeed");
        } else {
            return json('TheUserNameOrPasswordError');
        }
    }

}