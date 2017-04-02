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
use app\common\model\Comment;
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

    public function getAllOrder()
    {
        $data = array();
        $orderSpeArr = array();
        $userId = Request::instance()->post("userId");
        $type = Request::instance()->post("type");
        $user = User::get(['id' => $userId]);
        if ($user != null) {
            $orderArr = array();
            $orders = $user["orders"];
            if ($type == "All" || $type == "") {
                //全部订单
                foreach ($orders as $item) {
                    if ($item->getData("status") != 8) {
                        array_push($orderArr, $item);
                    }
                }
            } else if ($type == "Obligation") {
                //待付款
                foreach ($orders as $item) {
                    if ($item->getData("status") == 0) {
                        array_push($orderArr, $item);
                    }
                }
            } else if ($type == "Receiv") {
                //待收货
                foreach ($orders as $item) {
                    if ($item->getData("status") >= 1 && $item->getData("status") <= 4) {
                        array_push($orderArr, $item);
                    }
                }
            } else if ($type == "Assess") {
                //待评价
                foreach ($orders as $val) {
                    if ($val->getData("status") != 8) {
                        $orderSpes = $val["orderSpecifications"];
                        foreach ($orderSpes as $orderSpe) {
                            $comment = Comment::get(["order_id" => $val["id"], "specification_id" => $orderSpe["specification_id"]]);
                            if ($comment == null) {
                                array_push($orderArr, $val);
                                break;
                            }
                        }
                    }
                }
            }

            if (count($orderArr) > 0) {
                foreach ($orderArr as $order) {
                    $orderSpecifications = $order["orderSpecifications"];
                    foreach ($orderSpecifications as $orderSpecification) {
                        $commodity = $orderSpecification["specification"]["commodity"];
                        $specification = $orderSpecification["specification"];
                        $returnData = array();
                        $returnData["id"] = $orderSpecification["id"];
                        $returnData["order_id"] = $order["id"];
                        $returnData["specification_id"] = $specification["id"];
                        $returnData["commodityId"] = $commodity["id"];
                        $returnData["count"] = $orderSpecification['count'];
                        $returnData["price"] = $orderSpecification["price"];
                        $returnData["specificationcontent"] = $orderSpecification["specificationcontent"];
                        $returnData["commodityIcon"] = $commodity["icon"];
                        $returnData["commodityTitle"] = $commodity["title"];
                        array_push($orderSpeArr, $returnData);
                    }
                }
            }
            $data["orders"] = $this->getOrders($userId, $type);
            $data["orderSpecifications"] = $orderSpeArr;
            return json($data);
        } else {
            return json("用户不存在！");
        }
    }

    public function getOrders($userId, $type)
    {
        $user = User::get(['id' => $userId]);

        $orderArr = array();
        $orders = $user["orders"];
        if ($type == "All" || $type == "") {
            //全部订单
            foreach ($orders as $item) {
                if ($item->getData("status") != 8) {
                    array_push($orderArr, $item);
                }
            }
        } else if ($type == "Obligation") {
            //待付款
            foreach ($orders as $item) {
                if ($item->getData("status") == 0) {
                    array_push($orderArr, $item);
                }
            }
        } else if ($type == "Receiv") {
            //待收货
            foreach ($orders as $item) {
                if ($item->getData("status") >= 1 && $item->getData("status") <= 4) {
                    array_push($orderArr, $item);
                }
            }
        } else if ($type == "Assess") {
            //待评价
            foreach ($orders as $val) {
                if ($val->getData("status") != 8) {
                    $orderSpes = $val["orderSpecifications"];
                    foreach ($orderSpes as $orderSpe) {
                        $comment = Comment::get(["order_id" => $val["id"], "specification_id" => $orderSpe["specification_id"]]);
                        if ($comment == null) {
                            array_push($orderArr, $val);
                            break;
                        }
                    }
                }
            }
        }

        return $orderArr;
    }

    public function handleOrder()
    {
        $userId = Request::instance()->post("userId");
        $orderId = Request::instance()->post("orderId");
        $type = Request::instance()->post("type");
        $user = User::get(["id" => $userId]);
        $order = Order::get(["id" => $orderId]);
        if ($user != null && $order != null && $type != "") {
            if ($type == "confirm") {
                $order->status = 5;
            } else if ($type == "cancel") {
                $order->status = 7;
            } else if ($type == "detele") {
                $order->status = 8;
            }
            $order->save();
            return json($order);
        }
    }

}