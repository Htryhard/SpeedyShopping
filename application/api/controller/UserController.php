<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/3/21 0021
 * Time: 下午 2:42
 */

namespace app\api\controller;


use app\common\Comm;
use app\common\model\Cart;
use app\common\model\CartSpecification;
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

    /**
     * 根据用户ID，以json形式返回该用户的购物车列表
     * @return \think\response\Json
     */
    public function getCart()
    {
        $userId = Request::instance()->get("userId");
        $user = User::get(['id' => $userId]);
        if ($user != null) {
            $cart = Cart::get(['user_id' => $user->getData("id")]);
            $cartSpecifications = $cart["CartSpecifications"];
            $specifications = array();
            $commodities = array();
            $cartArray = array();
            foreach ($cartSpecifications as $cartSpecification) {
                array_push($specifications, $cartSpecification['Specification']);
                array_push($commodities, $cartSpecification['Specification']['commodity']);

                $cartItem = array();
                $cartItem += ['cartSpecificationId' => $cartSpecification['id']];
                $cartItem += ['specificationId' => $cartSpecification['Specification']['id']];
                $cartItem += ['cartId' => $cart['id']];
                $cartItem += ['commmodityId' => $cartSpecification['Specification']['commodity']['id']];
                $cartItem += ['commmodityTitle' => $cartSpecification['Specification']['commodity']['title']];
                $cartItem += ['commmodityIcon' => $cartSpecification['Specification']['commodity']['icon']];
                $cartItem += ['specificationContent' => $cartSpecification['Specification']['content']];
                $cartItem += ['cartSpecificationCount' => $cartSpecification['count']];
                $cartItem += ['specificationPrice' => $cartSpecification['Specification']['price']];

                array_push($cartArray, $cartItem);
            }
            return json($cartArray);
        } else {
            return json("usernull");
        }
    }

    /**
     * 编辑用户个人信息
     * @return \think\response\Json
     */
    public function editMessage()
    {
        $userId = Request::instance()->post("userId");
        $type = Request::instance()->post("type");
        $value = Request::instance()->post("value");
        $user = User::get(["id" => $userId]);
        if ($user != null && $value != "") {

            switch ($type) {
                case "NickName":
                    $user->nick_name = $value;
                    break;
                case "Sbasb":
                    $user->sbasb = $value;
                    break;
                case "UserName":
                    $user->user_name = $value;
                    break;
                case "EditUserIcon":
                    $oldUrl = ROOT_PATH . 'public' . DS . 'uploads' . DS . "icon_images" . DS . $user->getData('icon');
                    $user->icon = Comm::uploadsIconForAPI($value);
                    $user->save();
                    //删除旧的头像
                    unlink($oldUrl);
                    break;
                case "EditPassword":
                    $data = explode("-;-", $value);
                    $oldPassword = $data[0];
                    $newPassword = $data[1];
                    $flag = $user->checkPassword($oldPassword);
                    if ($flag) {
                        //密码正确，可以更改
                        $user->password = User::encryptPassword($newPassword);
                    } else {
                        //密码不正确
                        return json("");
                    }
                    break;
                default:
                    break;
            }
            $user->save();
            return json($user);
        } else {
            return json("用户不存在");
        }
    }

    public function cartAddOrReduce()
    {
        $data = array();
        $userId = Request::instance()->post("userId");
        $type = Request::instance()->post("type");
        $cartSpecificationId = Request::instance()->post("cartSpecificationId");
        $position = Request::instance()->post("position");

        $user = User::get(["id" => $userId]);
        $cartSpecification = CartSpecification::get(["id" => $cartSpecificationId]);
        if ($user != null && $cartSpecification != null && $type != "" && $position != "") {
            $specification = $cartSpecification["Specification"];
            $repertory = $specification["repertory"];
            $oldCount = $cartSpecification["count"];
            if ($type == "Add") {
                if (($oldCount + 1) < $repertory) {
                    $cartSpecification->count = $oldCount + 1;
                    $cartSpecification->save();
                    $data["position"] = $position;
                    $data["code"] = 200;
                    $data["count"] = $cartSpecification->getData("count");
                    return json($data);
                }
            }
            if ($type == "Reduce") {
                if (($oldCount - 1) != 0) {
                    $cartSpecification->count = $oldCount - 1;
                    $cartSpecification->save();
                    $data["position"] = $position;
                    $data["code"] = 200;
                    $data["count"] = $cartSpecification->getData("count");
                    return json($data);
                }
            }
            $data["position"] = "";
            $data["code"] = 404;
            $data["count"] = "";
            return json($data);

        }
    }

}