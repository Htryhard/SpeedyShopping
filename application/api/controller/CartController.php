<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/4/9 0009
 * Time: 上午 9:33
 */

namespace app\api\controller;


use app\common\model\CartSpecification;
use app\common\model\User;
use think\Controller;
use think\Request;

class CartController extends Controller
{

    public function editCart()
    {
        $data = array();
        $userId = Request::instance()->post("userId");
        $cartSpecififcationIds = Request::instance()->post("cartSpecififcationIds");
        $user = User::get(["id" => $userId]);
        if ($user != null && $cartSpecififcationIds != "") {
            $cartSpecififcationIdArray = explode(";", $cartSpecififcationIds);
            array_pop($cartSpecififcationIdArray);
            foreach ($cartSpecififcationIdArray as $value) {
                $cartSpecififcation = CartSpecification::get(["id" => $value]);
                if ($cartSpecififcation != "") {
                    $cartSpecififcation->delete();
                }
            }
            $data["statu"] = "Success";
            $data["data"] = "";
            return json($data);
        } else {
            $data["statu"] = "Fail";
            $data["data"] = "";
            return json($data);
        }
    }

}