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


    //TODO:加入购物车/编辑购物车
    //TODO:所有订单
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

    public function logout()
    {
        User::logOut();
    }


}