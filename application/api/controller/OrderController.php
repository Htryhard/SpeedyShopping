<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/3/23 0023
 * Time: 上午 10:57
 */

namespace app\api\controller;

use app\common\Comm;
use app\common\model\Address;
use app\common\model\CartSpecification;
use app\common\model\Order;
use app\common\model\OrderSpecification;
use app\common\model\Specification;
use app\common\model\User;
use think\Controller;
use think\Request;

class OrderController extends Controller
{
    /**
     * 下单
     * @return \think\response\Json
     */
    public function addOrder()
    {
        $returnDate = array();

        $userId = Request::instance()->post("userId");
        /**
         * 与安卓端协商好协议，传上来的specificationIds格式为：
         * specificationId1,count1;specificationId2,count2;...
         * 其中specificationId为规格ID
         * count为用户购买的数量
         * 服务端要针对此进行解析
         */
        $specificationIds = Request::instance()->post("specificationIds");
        $addressId = Request::instance()->post("addressId");
        $user = User::get(['id' => $userId]);
        $spIdAndCountArray = Comm::analysisApiOrder($specificationIds);
        $address = Address::get(['id' => $addressId]);
        $len = count($spIdAndCountArray);
        if ($user != null && $len > 0 && $address != null) {
            $commodity = Comm::checkRepertory($specificationIds);
            //检查库存
            if ($commodity != null) {
                $returnDate["commodity"] = $commodity;
                $returnDate["order"] = "";
                return json($returnDate);
            } else {
                $order = new Order();
                $order->id = Comm::getNewGuid();
                $order->status = 0;
                $order->user_id = $user->getData("id");
                $order->address_id = $address->getData("id");
                $order->order_number = time();
                $order->order_time = time();
                $order->pay_time = "";
                $order->succeed_time = "";
                $order->save();

                foreach ($spIdAndCountArray as $key => $value) {
                    $specification = Specification::get(["id" => $key]);
                    //写入中间表
                    $orderSpecification = new OrderSpecification();
                    $orderSpecification->id = Comm::getNewGuid();
                    $orderSpecification->order_id = $order->getData("id");
                    $orderSpecification->count = $value;
                    $orderSpecification->price = $specification->getData("price");
                    $orderSpecification->specificationcontent = $specification->getData('content');
                    $orderSpecification->specification_id = $specification->getData('id');
                    $orderSpecification->save();

                    //此商品规格的库存减少
                    $repertory = $specification->getData('repertory');
                    $specification->repertory = $repertory - $value;
                    $specification->save();
                    //从购物车提交的订单,需要删除购物车中间表
                    $cartSpecification = CartSpecification::get(["specification_id" => $specification->getData('id')]);
                    if ($cartSpecification != null) {
                        $cartSpecification->delete();
                    }
                }
                $returnDate["commodity"] = "";
                $returnDate["order"] = $order;
                return json($returnDate);
            }
        }

    }


    /**
     * 支付验证
     * @return string|\think\response\Json
     */
    public function payOrder()
    {
        $userId = Request::instance()->post("userId");
        $orderId = Request::instance()->post("orderId");
        $password = Request::instance()->post("password");
        $user = User::get(["id" => $userId]);
        $order = Order::get(['id' => $orderId]);
        if ($user != null && $order != null && $password != "") {
            //判断密码是否正确
            if ($user->getData("password") == User::encryptPassword($password)) {
                $order->status = 1;
                $order->pay_time = time();
                $order->save();
                return json($order);
            } else {
                return "PasswordError";
            }
        } else {
            return json("参数不全");
        }
    }

    /**
     * 获取订单中的地址
     * @return \think\response\Json
     */
    public function getOrderAddress()
    {
        $addressId = Request::instance()->get("addressId");
        $address = Address::get(["id" => $addressId]);
        if ($address != null) {
            return json($address);
        } else {
            return json("没有这个地址");
        }
    }

    public function orderDetailed()
    {
        $data = array();
        $orderId = Request::instance()->post("orderId");
        $order = Order::get(['id' => $orderId]);
        if ($order != null) {
            $orderSpecifications = $order["orderSpecifications"];
            foreach ($orderSpecifications as $orderSpecification) {
                $commodity = $orderSpecification["specification"]["commodity"];
                $specification = $orderSpecification["specification"];
                $returnData = array();
                $returnData["id"] = $orderSpecification["id"];
                $returnData["order_id"] = $order->getData("id");
                $returnData["specification_id"] = $specification["id"];
                $returnData["commodityId"] = $commodity["id"];
                $returnData["count"] = $orderSpecification['count'];
                $returnData["price"] = $orderSpecification["price"];
                $returnData["specificationcontent"] = $orderSpecification["specificationcontent"];
                $returnData["commodityIcon"] = $commodity["icon"];
                $returnData["commodityTitle"] = $commodity["title"];
                array_push($data, $returnData);
            }
            return json($data);
        } else {
            return json("参数不全");
        }

    }

}