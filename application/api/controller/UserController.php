<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/3/21 0021
 * Time: 下午 2:42
 */

namespace app\api\controller;


use app\common\model\Cart;
use app\common\model\User;
use think\Controller;
use think\Request;

class UserController extends Controller
{
    /**
     * 用户登录
     * @return \think\response\Json
     */
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

    /**
     * 根据用户的ID，检索出用户所有的地址
     * @return \think\response\Json
     */
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

    public function getCart()
    {
        $userId = Request::instance()->get("userId");
        $user = User::get(['id' => $userId]);
        if ($user != null) {
            $cart = Cart::get(['user_id' => $user->getData("id")]);
            $cartSpecifications = $cart["CartSpecifications"];
            $specifications = array();
            $commodities = array();
            foreach ($cartSpecifications as $cartSpecification) {
                array_push($specifications, $cartSpecification['Specification']);
                array_push($commodities, $cartSpecification['Specification']['commodity']);
            }



        } else {
            return json("usernull");
        }
    }

}