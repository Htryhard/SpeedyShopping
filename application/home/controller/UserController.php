<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/23
 * Time: 11:19
 */

namespace app\home\controller;

use app\common\Comm;
use app\common\controller\BaseController;
use app\common\model\Address;
use app\common\model\Cart;
use app\common\model\CartSpecification;
use app\common\model\Collect;
use app\common\model\Commodity;
use app\common\model\Order;
use app\common\model\OrderSpecification;
use app\common\model\Specification;
use app\common\model\User;
use think\Controller;
use think\Request;

class UserController extends BaseController
{

    //TODO:所有订单
    public function userOrders($type)
    {
        $user = User::getUserBySession();
        $this->assign("user", $user);
//        $orders = Order::all(["user_id"=>$user->getData('id')]);
//        $type = input('get.type');
        $orders = null;
        if ($type=="statu0"){
            $orders = Order::where(['user_id'=>$user->getData('id'),'status'=>0])->paginate(6);
        }elseif ($type=="statu1"){
            $orders = Order::where(['user_id'=>$user->getData('id'),'status'=>1])->paginate(6);
        }elseif ($type=="statu2"){
            $orders = Order::where(['user_id'=>$user->getData('id'),'status'=>2])->paginate(6);
        }elseif ($type=="statu3"){
            $orders = Order::where(['user_id'=>$user->getData('id'),'status'=>3])->paginate(6);
        }elseif ($type=="statu4"){
            $orders = Order::where(['user_id'=>$user->getData('id'),'status'=>4])->paginate(6);
        }elseif ($type=="statu5"){
            $orders = Order::where(['user_id'=>$user->getData('id'),'status'=>5])->paginate(6);
        }elseif ($type=="statu6"){
            $orders = Order::where(['user_id'=>$user->getData('id'),'status'=>6])->paginate(6);
        }else{
            //全部订单
            $orders = Order::where("user_id", $user->getData('id'))->order('order_time','desc')->paginate(6);
        }
        $this->assign("orders", $orders);

        $this->assign("status",$type);
        $iconRoot = "/SpeedyShopping/public//uploads/icon_images/";
        $imgRoot = '/SpeedyShopping/public//uploads/commodity_images/';
        $this->assign("imgRoot", $imgRoot);
        $this->assign("iconRoot", $iconRoot);


        //用户订单状态
        $order_0 = 0;//待付款
        $order_1 = 0;//待捡货
        $order_2 = 0;//待发货
        $order_3 = 0;//配送中
        $order_4 = 0;//货到付款
        foreach ($user['orders'] as $order) {
            if ($order->getData('status') == 0) {
                $order_0 = $order_0 + 1;
            } elseif ($order->getData('status') == 1) {
                $order_1 = $order_1 + 1;
            } elseif ($order->getData('status') == 2) {
                $order_2 = $order_2 + 1;
            } elseif ($order->getData('status') == 3) {
                $order_3 = $order_3 + 1;
            } elseif ($order->getData('status') == 4) {
                $order_4 = $order_4 + 1;
            }
        }
        $this->assign("order_0", $order_0);
        $this->assign("order_1", $order_1);
        $this->assign("order_2", $order_2);
        $this->assign("order_3", $order_3);
        $this->assign("order_4", $order_4);
        return $this->fetch();
    }
    //TODO: ...
    //TODO:用户的个人主页
    public function userHome()
    {
        $user = User::getUserBySession();
//        $userCollects = Collect::all(["user_id" => $user->getData("id")]);
        $userCollects = Collect::where(["user_id" => $user->getData("id")])->order("creation_time","desc")->paginate(10);
        $iconRoot = "/SpeedyShopping/public//uploads/icon_images/";
        $imgRoot = '/SpeedyShopping/public//uploads/commodity_images/';
        $this->assign("imgRoot", $imgRoot);
        $this->assign("userCollects", $userCollects);
        $this->assign("user", $user);
        $this->assign("iconRoot", $iconRoot);
        $orders = Order::where("user_id", $user->getData('id'))->paginate(15);
        $this->assign("orders", $orders);
        $cart = Cart::get(['user_id' => $user->getData("id")]);
        $this->assign("cart", $cart);

        //用户订单状态
        $order_0 = 0;//待付款
        $order_1 = 0;//待捡货
        $order_2 = 0;//待发货
        $order_3 = 0;//配送中
        $order_4 = 0;//货到付款
        foreach ($user['orders'] as $order) {
            if ($order->getData('status') == 0) {
                $order_0 = $order_0 + 1;
            } elseif ($order->getData('status') == 1) {
                $order_1 = $order_1 + 1;
            } elseif ($order->getData('status') == 2) {
                $order_2 = $order_2 + 1;
            } elseif ($order->getData('status') == 3) {
                $order_3 = $order_3 + 1;
            } elseif ($order->getData('status') == 4) {
                $order_4 = $order_4 + 1;
            }
        }
        $this->assign("order_0", $order_0);
        $this->assign("order_1", $order_1);
        $this->assign("order_2", $order_2);
        $this->assign("order_3", $order_3);
        $this->assign("order_4", $order_4);
        return $this->fetch();
    }

    //TODO:关注/取消关注商品
    public function userCollect()
    {
        if ($this->request->isAjax()) {
            if (User::isLogin()) {
                $commodityId = $this->request->post("commodityId");
                $commodity = Commodity::get(['id' => $commodityId]);
                if ($commodity == null) {
                    return json("NotFindCommodity");//没有这件商品
                }
                $user = User::getUserBySession();
                $userCollect = Collect::get(['commodity_id' => $commodityId, 'user_id' => $user->getData('id')]);
                if ($userCollect == null) {
                    //用户未收藏，此次操作是收藏
                    $collect = new Collect();
                    $collect->id = Comm::getNewGuid();
                    $collect->user_id = $user->getData('id');
                    $collect->commodity_id = $commodityId;
                    $collect->creation_time = time();
                    $collect->save();
                    return json("AddCollectSuccess");//添加收藏成功
                } else {
                    //用户已经收藏过了，此次操作是取消收藏
                    $userCollect->delete();
                    return json("CancelCollectSuccess");//取消收藏成功
                }
            } else {
                return json("UserNotLogin");//用户未登录
            }
        } else {
            return json('IllegalRequest');//非法请求
        }
    }

    //TODO:加入购物车
    public function addToCart()
    {
        if ($this->request->isAjax()) {
            if (User::isLogin()) {
                $commodityId = $this->request->post("commodityId");
                $commodity = Commodity::get(['id' => $commodityId]);
                if ($commodity == null) {
                    return json("NotFindCommodity");//没有这件商品
                }
                $specificationId = $this->request->post("specificationId");
                $user = User::getUserBySession();
                $cart = Cart::get(['user_id' => $user->getData("id")]);
                if ($specificationId == "") {
                    $specification = $commodity["specifications"];
                    $specification = $specification[0];
                } else {
                    $specification = Specification::get(['id' => $specificationId]);
                    if ($specification == null) {
                        return json("NotFindSpecification");//没有这个规格
                    }
                }
                //验证库存
                if ($specification->getData("repertory") > 0) {

                    //验证是否有重复加入购物车的商品，有就在原来的基础上加一，没有就新建一条记录
                    $userSpecifications = $cart['CartSpecifications'];
                    $flag = false;
                    foreach ($userSpecifications as $item) {
                        if ($item['specification_id'] == $specification->getData('id')) {
                            $flag = true;
                            $spcount = $item['count'];
                            $item->count = $spcount + 1;
                            $item->save();
                            break;
                        } else {
                            $flag = false;
                        }
                    }
                    if (!$flag) {
                        $newSpecification = new CartSpecification();
                        $newSpecification->id = Comm::getNewGuid();
                        $newSpecification->specification_id = $specification->getData('id');
                        $newSpecification->cart_id = $cart->getData("id");
                        $newSpecification->count = 1;
                        $newSpecification->save();
                    }
                    return json("AddCartSuccess");//添加进购物车成功
                } else {
                    return json("NotRepertory");//库存不足
                }
            } else {
                return json("UserNotLogin");//用户未登录
            }
        } else {
            return json('IllegalRequest');//非法请求
        }

    }

    //TODO:显示购物车
    public function showCart()
    {
        $user = User::getUserBySession();
        $cart = Cart::get(['user_id' => $user->getData("id")]);
        $this->assign("user", $user);
        $this->assign("cart", $cart);

        $iconRoot = "/SpeedyShopping/public//uploads/icon_images/";
        $imgRoot = '/SpeedyShopping/public//uploads/commodity_images/';
        $this->assign("imgRoot", $imgRoot);
        $this->assign("iconRoot", $iconRoot);

        //用户订单状态
        $order_0 = 0;//待付款
        $order_1 = 0;//待捡货
        $order_2 = 0;//待发货
        $order_3 = 0;//配送中
        $order_4 = 0;//货到付款
        foreach ($user['orders'] as $order) {
            if ($order->getData('status') == 0) {
                $order_0 = $order_0 + 1;
            } elseif ($order->getData('status') == 1) {
                $order_1 = $order_1 + 1;
            } elseif ($order->getData('status') == 2) {
                $order_2 = $order_2 + 1;
            } elseif ($order->getData('status') == 3) {
                $order_3 = $order_3 + 1;
            } elseif ($order->getData('status') == 4) {
                $order_4 = $order_4 + 1;
            }
        }
        $this->assign("order_0", $order_0);
        $this->assign("order_1", $order_1);
        $this->assign("order_2", $order_2);
        $this->assign("order_3", $order_3);
        $this->assign("order_4", $order_4);
        return $this->fetch();
    }

    //TODO:购物车内单件商品的数量加减
    public function cartCommodityCount()
    {
        if ($this->request->isAjax()) {
            $CartSpecificationId = $this->request->post("CartSpecificationId");
            $type = $this->request->post("type");
            $cartSpecification = CartSpecification::get(['id' => $CartSpecificationId]);
            if ($cartSpecification != null) {
                $nowCount = $cartSpecification->getData("count");
                //减
                if ($type == "minus") {
                    if ($nowCount > 1) {
                        $nowCount = $nowCount - 1;
                    }
                    //加
                } else if ($type == "add") {
                    //库存
                    $specificationRepertory = $cartSpecification['Specification']['repertory'];
                    if ($specificationRepertory > $nowCount) {
                        $nowCount = $nowCount + 1;
                    }

                }
                $cartSpecification->count = $nowCount;
                $cartSpecification->save();
                $nowCount = $cartSpecification->getData("count");
                $data = array(
                    "count" => $nowCount,
                    "state" => "Success"
                );
                return json($data);
            } else {
                return json("NotFindCartSpecification");//没有这项商品
            }
        } else {
            return json('IllegalRequest');//非法请求
        }
    }

    //TODO:商品从购物车从移除
    public function deleteCommodityFromCart()
    {
        if ($this->request->isAjax()) {
            $CartSpecificationId = $this->request->post("CartSpecificationId");
            $cartSpecification = CartSpecification::get(['id' => $CartSpecificationId]);
            if ($cartSpecification != null) {
                $cartSpecification->delete();
                return json('Success');//请求成功
            } else {
                return json("NotFindCartSpecification");//没有这项商品规格
            }
        } else {
            return json('IllegalRequest');//非法请求
        }
    }

    /**
     * 添加一个地址
     */
    public function addAddress()
    {
        $user = User::getUserBySession();
        $address = new Address();
        $address->id = Comm::getNewGuid();
        $address->phone = "077128384858";
        $address->content = "广东广州天河区";
        $address->user_name = "筑梦草根";
        $address->user_id = $user['id'];
        $address->save();
    }

    /**
     * 直接购买一件商品
     * @return mixed|string
     */
    public function buyOne()
    {
        $count = Request::instance()->param("count");
        $specificationId = Request::instance()->param("specificationId");
        $commodityId = Request::instance()->param("commodityId");
//        echo $specificationId."<br/>";
//        echo $commodityId;
        if ($specificationId != "") {
            if ($commodityId != "") {
                $commodity = Commodity::get(['id' => $commodityId]);
                $specification = Specification::get(['id' => $specificationId]);
                if ($commodity != null && $specification != null) {
                    $this->assign("count", $count);
                    $this->assign("user", User::getUserBySession());
                    $this->assign("commodity", $commodity);
                    $this->assign("specification", $specification);
                    return $this->fetch();
                } else {
                    return "亲，你选择的商品或者规格已经从地球上消失了~~";
                }
            } else {
                return "亲，请选择商品";
            }
        } else {
            return "亲，请选择商品规格";
        }
    }

    //TODO:处理下单(单个商品)
    public function buyOneHandle()
    {
        $count = Request::instance()->param("count");
        $addressId = Request::instance()->param("addressId");
        $specificationId = Request::instance()->param("specificationId");
        $commodityId = Request::instance()->param("commodityId");
//        echo $specificationId."<br/>";
//        echo $commodityId;
        if ($specificationId != "") {
            if ($commodityId != "") {
                $commodity = Commodity::get(['id' => $commodityId]);
                $specification = Specification::get(['id' => $specificationId]);
                if ($commodity != null && $specification != null) {
                    $order = new Order();
                    $order->id = Comm::getNewGuid();
                    $order->status = 0;
                    $order->user_id = User::getUserBySession()['id'];
                    $order->address_id = $addressId;
                    $order->order_number = time();
                    $order->order_time = time();
                    $order->pay_time = "";
                    $order->succeed_time = "";
                    $order->save();

                    //写入中间表
                    $orderSpecification = new OrderSpecification();
                    $orderSpecification->id = Comm::getNewGuid();
                    $orderSpecification->order_id = $order['id'];
                    $orderSpecification->count = $count;
                    $orderSpecification->specification_id = $specification['id'];
                    $orderSpecification->save();

                    $this->redirect("home/user/doPay", ['orderId' => $order->getData("id")]);
                } else {
                    return "亲，你选择的商品或者规格已经从地球上消失了~~";
                }
            } else {
                return "亲，请选择商品";
            }
        } else {
            return "亲，请选择商品规格";
        }
    }

    //TODO:下单（多个商品的情况）
    public function placeOrder()
    {
        $idStr = $this->request->post("CartSpecificationsId");
        $cartspeId = "";
        if ($idStr != "") {
            $idStr = str_replace("x_", "", $idStr);
            $idStr = substr($idStr, 0, strlen($idStr) - 1);
            $cartspeId = $idStr;
            $idStr = explode(";", $idStr);
            $CartSpecifications = array();
            foreach ($idStr as $CartSpecificationId) {
                $CartSpecification = CartSpecification::get(["id" => $CartSpecificationId]);
                if ($CartSpecification == null) {
                    continue;
                } else {
                    array_push($CartSpecifications, $CartSpecification);
                }
            }
            if (count($CartSpecifications) != 0) {
                $user = User::getUserBySession();
                $this->assign("user", $user);
                $this->assign("CartSpecifications", $CartSpecifications);
                $this->assign("cartspeId", $cartspeId);
                return $this->fetch();
            } else {
                return $this->error("请求参数错误，没有找到指定商品规格");
            }
        } else {
            return $this->error("参数不全");
        }
    }

    //TODO:提交订单（多个商品情况下）
    public function placeOrdersHandle()
    {
        if (User::isLogin()) {
            //1购物车中间表的id（因为下单完成之后我们需要把它删除了）
            //1）数量
            //3）规格id
            $idStr = $this->request->post("cartspeId");
            //2地址id
            $addressId = $this->request->post("addressId");
            if ($idStr != "" && $addressId != "") {
                $idStr = explode(";", $idStr);
                $CartSpecifications = array();
                foreach ($idStr as $CartSpecificationId) {
                    $CartSpecification = CartSpecification::get(["id" => $CartSpecificationId]);
                    if ($CartSpecification == null) {
                        continue;
                    } else {
                        array_push($CartSpecifications, $CartSpecification);
                    }
                }
                if (count($CartSpecifications) != 0) {

                    $order = new Order();
                    $order->id = Comm::getNewGuid();
                    $order->status = 0;
                    $order->user_id = User::getUserBySession()['id'];
                    $order->address_id = $addressId;
                    $order->order_number = time();
                    $order->order_time = time();
                    $order->pay_time = "";
                    $order->succeed_time = "";
                    $order->save();

                    foreach ($CartSpecifications as $item) {
                        //写入中间表
                        $orderSpecification = new OrderSpecification();
                        $orderSpecification->id = Comm::getNewGuid();
                        $orderSpecification->order_id = $order['id'];
                        $orderSpecification->count = $item['count'];
                        $orderSpecification->specification_id = $item['Specification']['id'];
                        $orderSpecification->save();

                        //删除购物车和规格的中间表
                        $item->delete();
                    }

                    $this->redirect("home/user/doPay", ['orderId' => $order->getData("id")]);
                } else {
                    return $this->error("请求参数错误，没有找到指定商品规格");
                }
            } else {
                return $this->error("参数错误，缺少商品或者地址");
            }

        } else {
            return $this->error("请先登陆");
        }
    }

    //TODO:用户个人资料
    public function userMessage()
    {
        $user = User::getUserBySession();
        $this->assign("user", $user);
        $iconRoot = "/SpeedyShopping/public//uploads/icon_images/";
        $this->assign("iconRoot", $iconRoot);
        return $this->fetch();
    }

    //TODO:注销
    public function logOut()
    {
        User::logOut();
        $this->redirect(url('home/index/index'));
    }

    //TODO:支付
    public function doPay($orderId)
    {
        if ($orderId != "") {
            $order = Order::get(['id' => $orderId]);
            if ($order != null) {
//                $orderStatu = $order->getData("status");
//                if ($orderStatu == 0) {
//
//                } elseif ($orderStatu == 4) {
//                    //这个订单是货到付款
//                    return "CashOnDelivery";
//                } else {
//                    //这个订单已经付款了
//                    return "AlreadyPaid";
//                }
                $this->assign("order", $order);
                $this->assign("user", User::getUserBySession());
                return $this->fetch();
            } else {
                //无法找到这个订单
//                return "OrderNull";
                return $this->error("无法找到这个订单");
            }
        } else {
            //参数不正确
//            return "ParameterError";
            return $this->error("参数不正确");
        }
    }

    //TODO:支付处理
    public function doPayHandle()
    {
        if ($this->request->isAjax()) {
            $password = $this->request->post("password");
            $orderId = $this->request->post("orderId");
            $order = Order::get(["id" => $orderId]);
            $user = User::getUserBySession();
            if ($user->getData("password") == User::encryptPassword($password)) {
                if ($order != null) {
                    $flag = true;
                    foreach ($order['orderSpecifications'] as $item) {
                        $repertory = $item['specification']['repertory'];
                        if ($item['count']>$repertory){
                            $flag = false;
                            //库存不足
                            return "UnderStock/【".$item['specification']['commodity']['title']."】库存不足，当前仅有 ".$repertory." 件";
                        }
                    }
                    if ($flag){
                        foreach ($order['orderSpecifications'] as $item) {
                            $repertory = $item['specification']['repertory'];
                            $item['specification']['repertory'] = $repertory - $item['count'];
                            $item['specification']->save();
                        }
                        $order->status = 1;
                        $order->pay_time = time();
                        $order->save();
                        return "PaySuccess";
                    }
                } else {
                    return "OrderNull";
                }
            } else {
                return "PasswordError";
            }
        } else {
            return "PostError";
        }
    }

    //TODO:订单详细
    public function orderDetailed($orderId)
    {
        if ($orderId != "") {
            $order = Order::get(['id' => $orderId]);
            if ($order != null) {
                $this->assign("order", $order);
                $this->assign("user", User::getUserBySession());
                return $this->fetch();
            } else {
                //无法找到这个订单
//                return "OrderNull";
                return $this->error("无法找到这个订单");
            }
        } else {
            //参数不正确
//            return "ParameterError";
            return $this->error("参数不正确");
        }
    }

    //TODO:确认收货
    public function confirmReceipt()
    {
       if ($this->request->isAjax()){
           $orderId = $this->request->post("orderId");
           if ($orderId != "") {
               $order = Order::get(['id' => $orderId]);
               if ($order != null) {
                   $order->status = 5;//交易完成
                   $order->succeed_time = time();
                   $order->save();

                   foreach ($order["orderSpecifications"] as $item){
                       $comm_count = $item['specification']['commodity']['staistics'];
                       $item['specification']['commodity']->staistics = $comm_count+$item['count'];
                       $item['specification']['commodity']->save();
                   }
                   //确认成功！
                   return "ReceiptSuccess";
               } else {
                   //无法找到这个订单
                return "OrderNull";
               }
           } else {
               //参数不正确
            return "ParameterError";
           }
       }else{
           //请求方式错误
           return "PostError";
       }
    }



}