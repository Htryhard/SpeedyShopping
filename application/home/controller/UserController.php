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
    public function userOrders(){
        $user = User::getUserBySession();
        $this->assign("user", $user);
//        $orders = Order::all(["user_id"=>$user->getData('id')]);
        $orders = Order::where("user_id",$user->getData('id'))->paginate(15);
        $this->assign("orders",$orders);
        return $this->fetch();
    }
    //TODO: ...
    //TODO:用户的个人主页
    public function userHome()
    {
        $user = User::getUserBySession();
        $userCollects = Collect::all(["user_id" => $user->getData("id")]);
        $iconRoot = "/speedyshopping/public//uploads/icon_images/";
        $imgRoot = '/speedyshopping/public//uploads/commodity_images/';
        $this->assign("imgRoot", $imgRoot);
        $this->assign("userCollects", $userCollects);
        $this->assign("user", $user);
        $this->assign("iconRoot", $iconRoot);
        $orders = Order::where("user_id",$user->getData('id'))->paginate(15);
        $this->assign("orders",$orders);
        $cart = Cart::get(['user_id'=>$user->getData("id")]);
        $this->assign("cart",$cart);
        return $this->fetch();
    }

    //TODO:关注/取消关注商品
    public function userCollect()
    {
        if ($this->request->isAjax()){
            if (User::isLogin()){
                $commodityId = $this->request->post("commodityId");
                $commodity = Commodity::get(['id'=>$commodityId]);
                if ($commodity==null){
                    return json("NotFindCommodity");//没有这件商品
                }
                $user = User::getUserBySession();
                $userCollect = Collect::get(['commodity_id'=>$commodityId,'user_id'=>$user->getData('id')]);
                if ($userCollect==null){
                    //用户未收藏，此次操作是收藏
                    $collect = new Collect();
                    $collect->id = Comm::getNewGuid();
                    $collect->user_id = $user->getData('id');
                    $collect->commodity_id = $commodityId;
                    $collect->creation_time = time();
                    $collect->save();
                    return json("AddCollectSuccess");//添加收藏成功
                }else{
                    //用户已经收藏过了，此次操作是取消收藏
                    $userCollect->delete();
                    return json("CancelCollectSuccess");//取消收藏成功
                }
            }else{
                return json("UserNotLogin");//用户未登录
            }
        }else{
            return json('IllegalRequest');//非法请求
        }
    }

    //TODO:加入购物车
    public function addToCart(){
        if ($this->request->isAjax()){
            if (User::isLogin()){
                $commodityId = $this->request->post("commodityId");
                $commodity = Commodity::get(['id'=>$commodityId]);
                if ($commodity==null){
                    return json("NotFindCommodity");//没有这件商品
                }
                $specificationId = $this->request->post("specificationId");
                $user = User::getUserBySession();
                $cart = Cart::get(['user_id'=>$user->getData("id")]);
                if ($specificationId==""){
                    $specification = $commodity["specifications"];
                    $specification = $specification[0];
                }else{
                    $specification = Specification::get(['id'=>$specificationId]);
                    if ($specification==null){
                        return json("NotFindSpecification");//没有这个规格
                    }
                }
                //验证库存
                if ($specification->getData("repertory")>0){

                    //验证是否有重复加入购物车的商品，有就在原来的基础上加一，没有就新建一条记录
                    $userSpecifications = $cart['CartSpecifications'];
                    $flag = false;
                    foreach ($userSpecifications as $item){
                        if ($item['specification_id']==$specification->getData('id')){
                            $flag = true;
                            $spcount = $item['count'];
                            $item->count = $spcount+1;
                            $item->save();
                            break;
                        }else{
                            $flag = false;
                        }
                    }
                    if (!$flag){
                        $newSpecification = new CartSpecification();
                        $newSpecification->id = Comm::getNewGuid();
                        $newSpecification->specification_id = $specification->getData('id');
                        $newSpecification->cart_id = $cart->getData("id");
                        $newSpecification->count = 1;
                        $newSpecification->save();
                    }
                    return json("AddCartSuccess");//添加进购物车成功
                }else{
                 return json("NotRepertory");//库存不足
                }
            }else{
                return json("UserNotLogin");//用户未登录
            }
        }else{
            return json('IllegalRequest');//非法请求
        }

    }
    //TODO:显示购物车
    public function showCart(){
        $user = User::getUserBySession();
        $cart = Cart::get(['user_id'=>$user->getData("id")]);
        $this->assign("user",$user);
        $this->assign("cart",$cart);
        return $this->fetch();
    }

    //TODO:购物车内单件商品的数量加减
    public function cartCommodityCount(){
        if ($this->request->isAjax()){
            $CartSpecificationId = $this->request->post("CartSpecificationId");
            $type = $this->request->post("type");
            $cartSpecification = CartSpecification::get(['id'=>$CartSpecificationId]);
            if ($cartSpecification!=null){
                $nowCount = $cartSpecification->getData("count");
                //减
                if ($type=="minus"){
                    if ($nowCount > 1){
                        $nowCount = $nowCount - 1;
                    }
                //加
                }else if ($type=="add"){
                    //库存
                    $specificationRepertory = $cartSpecification['Specification']['repertory'];
                    if ($specificationRepertory > $nowCount){
                        $nowCount = $nowCount + 1;
                    }

                }
                $cartSpecification->count = $nowCount;
                $cartSpecification->save();
                $nowCount = $cartSpecification->getData("count");
                $data = array(
                    "count"=>$nowCount,
                    "state"=>"Success"
                );
                return json($data);
            }else{
                return json("NotFindCartSpecification");//没有这项商品
            }
        }else{
            return json('IllegalRequest');//非法请求
        }
    }

    //TODO:商品从购物车从移除
    public function deleteCommodityFromCart(){
        if ($this->request->isAjax()){
            $CartSpecificationId = $this->request->post("CartSpecificationId");
            $cartSpecification = CartSpecification::get(['id'=>$CartSpecificationId]);
            if ($cartSpecification!=null){
                $cartSpecification->delete();
                return json('Success');//请求成功
            }else{
                return json("NotFindCartSpecification");//没有这项商品规格
            }
        }else{
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
        $address->content = "广西壮族自治区 柳州市 柳州职业技术学院";
        $address->user_name = "爱丽丝";
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
                    $order->pay_time = time();
                    $order->succeed_time = time();
                    $order->save();

                    //写入中间表
                    $orderSpecification = new OrderSpecification();
                    $orderSpecification->id = Comm::getNewGuid();
                    $orderSpecification->order_id = $order['id'];
                    $orderSpecification->count = $count;
                    $orderSpecification->specification_id = $specification['id'];
                    $orderSpecification->save();

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
    //TODO:用户个人资料
    public function userMessage()
    {
        $user = User::getUserBySession();
        $this->assign("user",$user);
        $iconRoot = "/speedyshopping/public//uploads/icon_images/";
        $this->assign("iconRoot", $iconRoot);
        return $this->fetch();
    }


}