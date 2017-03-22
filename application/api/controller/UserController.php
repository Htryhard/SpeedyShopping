<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/3/21 0021
 * Time: 下午 2:42
 */

namespace app\api\controller;


use app\common\model\User;
use think\Controller;
use think\Request;

class UserController extends Controller
{
    public function login()
    {
        $email = Request::instance()->post("email");
        $password = Request::instance()->post("password");
        $flag = User::login($email, $password, "home");
        if ($flag) {
            return json(User::getUserBySession("home"));
        } else {
            return json("notUser");
        }
    }

    public function getUserAddress()
    {
        $userId = Request::instance()->post("userId");
//        if (User::isLogin("home")){
//
//        }else{
//
//        }
        $user = User::get(['id' => $userId]);
        if ($user != null) {
            $address = $user['address'];
            return json($address);
        } else {
            return json("usernull");
        }
    }

}