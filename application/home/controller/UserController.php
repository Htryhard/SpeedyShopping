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
use app\common\model\Comment;
use app\common\model\CommentImages;
use app\common\model\Commodity;
use app\common\model\Order;
use app\common\model\OrderSpecification;
use app\common\model\Refunds;
use app\common\model\Specification;
use app\common\model\User;
use think\Controller;
use think\Request;

class UserController extends BaseController
{

    //所有订单
    public function userOrders($type)
    {
        $user = User::getUserBySession("home");
        $this->assign("user", $user);
//        $orders = Order::all(["user_id"=>$user->getData('id')]);
//        $type = input('get.type');
        $orders = null;
        if ($type == "statu0") {
            $orders = Order::where("status", "<>", 8)->where(['user_id' => $user->getData('id'), 'status' => 0])->order('order_time', 'desc')->paginate(6);
        } elseif ($type == "statu1") {
            $orders = Order::where("status", "<>", 8)->where(['user_id' => $user->getData('id'), 'status' => 1])->order('order_time', 'desc')->paginate(6);
        } elseif ($type == "statu2") {
            $orders = Order::where("status", "<>", 8)->where(['user_id' => $user->getData('id'), 'status' => 2])->order('order_time', 'desc')->paginate(6);
        } elseif ($type == "statu3") {
            $orders = Order::where("status", "<>", 8)->where(['user_id' => $user->getData('id'), 'status' => 3])->order('order_time', 'desc')->paginate(6);
        } elseif ($type == "statu4") {
            $orders = Order::where("status", "<>", 8)->where(['user_id' => $user->getData('id'), 'status' => 4])->order('order_time', 'desc')->paginate(6);
        } elseif ($type == "statu5") {
            $orders = Order::where("status", "<>", 8)->where(['user_id' => $user->getData('id'), 'status' => 5])->order('order_time', 'desc')->paginate(6);
        } elseif ($type == "statu6") {
            $orders = Order::where("status", "<>", 8)->where(['user_id' => $user->getData('id'), 'status' => 6])->order('order_time', 'desc')->paginate(6);
        } else {
            //全部订单
            $orders = Order::where("user_id", $user->getData('id'))->where("status", "<>", 8)->order('order_time', 'desc')->paginate(6);
        }
        $this->assign("orders", $orders);

        $this->assign("status", $type);
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
        $order_5 = 0;//交易已经完成（待评价）
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
            } elseif ($order->getData('status') == 5) {
                $order_5 = $order_5 + 1;
            }
        }
        $this->assign("order_0", $order_0);
        $this->assign("order_1", $order_1);
        $this->assign("order_2", $order_2);
        $this->assign("order_3", $order_3);
        $this->assign("order_4", $order_4);
        $this->assign("order_5", $order_5);
        return $this->fetch();
    }

    //删除订单
    public function deleteOrder()
    {
        if ($this->request->isAjax()) {
            $orderId = $this->request->post("orderId");
            $orderType = $this->request->post("type");
            if ($orderId != "" && $orderType != "") {
                $order = Order::get(["id" => $orderId]);
                if ($order != null) {
                    $statu = null;
                    if ($orderType == "delete") {
                        $statu = 8;
                    } elseif ($orderType == "cancel") {
                        $statu = 7;
                    } else {
                        //类型错误！
                        return "TypeError";
                    }
                    $order->status = $statu;
                    $order->save();
                    return "success";
                } else {
                    //订单不存在
                    return "OrderNull";
                }
            } else {
                //参数不正确
                return "ParameterError";
            }
        } else {
            //请求方式错误
            return "PostError";
        }
    }

    //用户的个人主页
    public function userHome()
    {
        $user = User::getUserBySession("home");
//        $userCollects = Collect::all(["user_id" => $user->getData("id")]);
        $userCollects = Collect::where(["user_id" => $user->getData("id")])->order("creation_time", "desc")->paginate(10);
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

    //关注/取消关注商品
    public function userCollect()
    {
        if ($this->request->isAjax()) {
            if (User::isLogin("home")) {
                $commodityId = $this->request->post("commodityId");
                $commodity = Commodity::get(['id' => $commodityId]);
                if ($commodity == null) {
                    return json("NotFindCommodity");//没有这件商品
                }
                $user = User::getUserBySession("home");
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

    //加入购物车
    public function addToCart()
    {
        if ($this->request->isAjax()) {
            if (User::isLogin("home")) {
                $commodityId = $this->request->post("commodityId");
                $commodity = Commodity::get(['id' => $commodityId]);
                if ($commodity == null) {
                    return json("NotFindCommodity");//没有这件商品
                }
                $specificationId = $this->request->post("specificationId");
                $user = User::getUserBySession("home");
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

    //显示购物车
    public function showCart()
    {
        $user = User::getUserBySession("home");
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

    //购物车内单件商品的数量加减
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

    //商品从购物车从移除
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
        if ($this->request->isAjax()) {
            $addressNameStr = $this->request->post("addressNameStr");
            $addressContent = $this->request->post("addressContent");
            $new_phoneStr = $this->request->post("new_phoneStr");
            if ($new_phoneStr != "" && $addressContent != "" && $addressNameStr != "") {
                $user = User::getUserBySession("home");
                $address = new Address();
                $address->id = Comm::getNewGuid();
                $address->phone = $new_phoneStr;
                $address->content = $addressContent;
                $address->user_name = $addressNameStr;
                $address->user_id = $user['id'];
                $address->save();
                return "ReceiptSuccess";
            } else {
                //参数不正确
                return "ParameterError";
            }
        } else {
            //请求方式错误
            return "PostError";
        }

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
                    $this->assign("user", User::getUserBySession("home"));
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

    //处理下单(单个商品)
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
                    $order->user_id = User::getUserBySession("home")['id'];
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
                    $orderSpecification->price = $specification->getData("price");
                    $orderSpecification->specificationcontent = $specification->getData("content");
                    $orderSpecification->specification_id = $specification->getData("id");
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

    //下单（多个商品的情况）
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
                $user = User::getUserBySession("home");
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

    //提交订单（多个商品情况下）
    public function placeOrdersHandle()
    {
        if (User::isLogin("home")) {
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
                    $order->user_id = User::getUserBySession("home")['id'];
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
                        $orderSpecification->price = $item['Specification']['price'];
                        $orderSpecification->specificationcontent = $item['Specification']['content'];
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

    //用户个人资料
    public function userMessage()
    {
        $user = User::getUserBySession("home");
        $this->assign("user", $user);
        $iconRoot = "/SpeedyShopping/public//uploads/icon_images/";
        $this->assign("iconRoot", $iconRoot);
        return $this->fetch();
    }

    //注销
    public function logOut()
    {
        User::logOut("home");
        $this->redirect(url('home/index/index'));
    }

    //支付
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
                $this->assign("user", User::getUserBySession("home"));
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

    //支付处理
    public function doPayHandle()
    {
        if ($this->request->isAjax()) {
            $password = $this->request->post("password");
            $orderId = $this->request->post("orderId");
            $order = Order::get(["id" => $orderId]);
            $user = User::getUserBySession("home");
            if ($user->getData("password") == User::encryptPassword($password)) {
                if ($order != null) {
                    $flag = true;
                    foreach ($order['orderSpecifications'] as $item) {
                        $repertory = $item['specification']['repertory'];
                        if ($item['count'] > $repertory) {
                            $flag = false;
                            //库存不足
                            return "UnderStock/【" . $item['specification']['commodity']['title'] . "】库存不足，当前仅有 " . $repertory . " 件";
                        }
                    }
                    if ($flag) {
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

    //订单详细
    public function orderDetailed($orderId)
    {
        if ($orderId != "") {
            $order = Order::get(['id' => $orderId]);
            if ($order != null) {
                $this->assign("order", $order);
                $this->assign("user", User::getUserBySession("home"));
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

    //确认收货
    public function confirmReceipt()
    {
        if ($this->request->isAjax()) {
            $orderId = $this->request->post("orderId");
            if ($orderId != "") {
                $order = Order::get(['id' => $orderId]);
                if ($order != null) {
                    $order->status = 5;//交易完成
                    $order->succeed_time = time();
                    $order->save();

                    foreach ($order["orderSpecifications"] as $item) {
                        $comm_count = $item['specification']['commodity']['staistics'];
                        $item['specification']['commodity']->staistics = $comm_count + $item['count'];
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
        } else {
            //请求方式错误
            return "PostError";
        }
    }

    //修改个人信息
    public function editMessage()
    {
        if ($this->request->isAjax()) {
            $postType = $this->request->post("postType");
            $postValue = $this->request->post("postValue");
            if ($postType != "" && $postValue != "") {
                $user = User::getUserBySession("home");
                $user->$postType = $postValue;
                $result = $user->save();
                if ($result !== false) {
                    return 'success';
                } else {
                    return 'false';
                }
            } else {
                //参数不正确
                return "ParameterError";
            }
        } else {
            //请求方式错误
            return "PostError";
        }
    }

    //修改头像
    public function editIcon()
    {
        if ($this->request->isAjax()) {
            $imgBase64 = $this->request->post("imgBase64");
            if ($imgBase64 != "") {
                $user = User::getUserBySession("home");
                $userNewIconName = Comm::uploadsIcon($imgBase64);
                if ($userNewIconName == false) {
                    //上传失败
                    return "UploadsError";
                } else {
                    $oldUrl = ROOT_PATH . 'public' . DS . 'uploads' . DS . "icon_images" . DS . $user->getData('icon');
                    $user->icon = $userNewIconName;
                    $user->save();
                    //删除旧的头像
                    unlink($oldUrl);
                    return "success";
                }
            } else {
                //参数不正确
                return "ParameterError";
            }
        } else {
            //请求方式错误
            return "PostError";
        }
    }

    //用户评论商品
    public function comment($orderId, $specificationId)
    {
        if ($orderId != null && $specificationId != null) {
            $order = Order::get(['id' => $orderId]);
            $specification = Specification::get(["id" => $specificationId]);
            if ($order == null && $specification != null) {
                return $this->error('订单或者商品不存在！');
            }
            $user = User::getUserBySession("home");
            $this->assign('order', $order);
            $this->assign("user", $user);
            $this->assign("specification", $specification);
            $imgRoot = "/SpeedyShopping/public//uploads/commodity_images/";
            $this->assign("imgRoot", $imgRoot);
            return $this->fetch();
        } else {
            return $this->error("参数不全！");
        }
    }

    /**
     * 处理商品的评论
     * @author 陈有欢
     * @return string
     */
    public function commentHandle()
    {
        if ($this->request->isAjax()) {
            $commentImgs = $this->request->post("commentImages");
            $orderId = $this->request->post("orderId");
            $specificationId = $this->request->post("specificationId");
            $fenshu = $this->request->post("fenshu");
            $commentContent = $this->request->post("content");
            if ($orderId != "" && $specificationId != "" && $fenshu != "" && $commentContent != "") {
                $user = User::getUserBySession("home");
                $specification = Specification::get(['id' => $specificationId]);
                if ($specification == null) {
                    return "SpecificationNull";
                }
                $commodityId = $specification['commodity']['id'];
                //判断是否已经对这次购买的商品评论过
                $comment = Comment::get(['order_id' => $orderId, 'user_id' => $user->getData('id'), "specification_id" => $specification->getData('id')]);
                if ($comment != null) {
                    return "CommentRepeated";
                }
                $commodity = Commodity::get(['id'=>$commodityId]);
                $grade = $commodity->getData("grade");
                $grade = $grade+$fenshu;
                $commodity->grade = $grade;
                $commodity->save();

                $comment = new Comment();
                $comment->id = Comm::getNewGuid();
                $comment->content = $commentContent;
                $comment->grade = $fenshu;
                $comment->creation_time = time();
                $comment->user_id = $user->getData("id");
                $comment->commodity_id = $commodityId;
                $comment->order_id = $orderId;
                $comment->specification_id = $specification->getData('id');
                $comment->status = 0;//0待审核，1通过并显示，2删除不显示
                $comment->save();
                if ($commentImgs != "") {
                    //以约定的5个#号来分割
                    $imgArray = explode("#####", $commentImgs);
                    //分割会导致多出一个空元素，故移除最后一个空元素
                    array_pop($imgArray);
                    foreach ($imgArray as $item) {
                        $commentImgPath = Comm::uploadsCommentImg($item, "uploads/comment_images/");
                        $commentImageModle = new CommentImages();
                        $commentImageModle->id = Comm::getNewGuid();
                        $commentImageModle->image = $commentImgPath;
                        $commentImageModle->comment_id = $comment->getData("id");
                        $commentImageModle->save();
                    }
                }
                return "success";
            } else {
                //参数不正确
                return "ParameterError";
            }
        } else {
            return "PostError";
        }
    }

    /**
     * 退换货
     * @param $orderId
     * @param $orderSpecificationId
     * @return mixed|void
     */
    public function refunds($orderId, $orderSpecificationId)
    {
        if ($orderId != null && $orderSpecificationId != null) {
            $order = Order::get(['id' => $orderId]);
            $orderSpecification = OrderSpecification::get(["id" => $orderSpecificationId]);
            if ($order == null && $orderSpecification != null) {
                return $this->error('订单或者商品不存在！');
            }
            $user = User::getUserBySession("home");
            $this->assign('order', $order);
            $this->assign("user", $user);
            $this->assign("orderSpecification", $orderSpecification);
            $imgRoot = "/SpeedyShopping/public//uploads/commodity_images/";
            $this->assign("imgRoot", $imgRoot);
            return $this->fetch();
        } else {
            return $this->error("参数不全！");
        }
    }

    /**
     * 退换货处理
     * @return string
     */
    public function refundsHandle()
    {
        if ($this->request->isAjax()) {
            $select_type = $this->request->post("select_type");
            $orderId = $this->request->post("orderId");
            $orderSpecificationId = $this->request->post("orderSpecificationId");
            $refunds_content = $this->request->post("refunds_content");
            if ($orderId != "" && $orderSpecificationId != "" && $select_type != "" && $refunds_content != "") {
                $user = User::getUserBySession("home");
                $orderSpecification = OrderSpecification::get(['id' => $orderSpecificationId]);
                if ($orderSpecification == null) {
                    return "SpecificationNull";
                }
                $commodityId = $orderSpecification['specification']['commodity']['id'];
                //判断是否已经对这次购买的商品进行退换货操作过
                $refund = Refunds::get(['order_id' => $orderId, 'user_id' => $user->getData('id'), "order_specification_id" => $orderSpecification->getData('id')]);
                if ($refund != null) {
                    return "RefundsRepeated";
                }
                $refund = new Refunds();
                $refund->id = Comm::getNewGuid();
                $refund->type = $select_type;
                $refund->content = $refunds_content;
                $refund->creation_time = time();
                $refund->user_id = $user->getData("id");
                $refund->order_id = $orderId;
                $refund->order_specification_id = $orderSpecification->getData('id');
                $refund->status = 0;//0待审核，1，2
                $refund->save();
                return "success";
            } else {
                //参数不正确
                return "ParameterError";
            }
        } else {
            return "PostError";
        }

    }

}