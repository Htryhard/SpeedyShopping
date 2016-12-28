<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/23
 * Time: 11:19
 */

namespace app\home\controller;

use app\common\Comm;
use app\common\model\Address;
use app\common\model\Commodity;
use app\common\model\Order;
use app\common\model\OrderSpecification;
use app\common\model\Specification;
use app\common\model\User;
use think\Controller;
use think\Request;

class UserController extends Controller {
    public function register()
    {
        return $this->fetch();
    }

    public function login()
    {
        return $this->fetch();
    }

    public function loginHandle()
    {
        // 接收post信息
        $data = Request::instance()->param();
        // 直接调用M层方法，进行登录。
        if (User::login($data['email'], $data['password'])) {
            return json("succeed");
        } else {
            return json('TheUserNameOrPasswordError');
        }
    }

    /**
     * 添加一个地址
     */
    public function addAddress(){
        $user = User::getUserBySession();
        $address = new Address();
        $address->id = Comm::getNewGuid();
        $address->phone = "077128384858";
        $address->content = "广西壮族自治区 柳州市 柳州职业技术学院";
        $address->user_name = "爱丽丝";
        $address->user_id = $user['id'];
        $address->save();
    }

    public function buyOne(){
        $count = Request::instance()->param("count");
        $specificationId = Request::instance()->param("specificationId");
        $commodityId = Request::instance()->param("commodityId");
//        echo $specificationId."<br/>";
//        echo $commodityId;
        if ($specificationId != ""){
            if ($commodityId != ""){
                $commodity = Commodity::get(['id'=>$commodityId]);
                $specification = Specification::get(['id'=>$specificationId]);
                if ($commodity != null && $specification != null){
                    $this->assign("count",$count);
                    $this->assign("user",User::getUserBySession());
                    $this->assign("commodity",$commodity);
                    $this->assign("specification",$specification);
                    return $this->fetch();
                }else{
                    return "亲，你选择的商品或者规格已经从地球上消失了~~";
                }
            }else{
                return "亲，请选择商品";
            }
        }else{
            return "亲，请选择商品规格";
        }
    }

    public function buyOneHandle(){
        $count = Request::instance()->param("count");
        $addressId = Request::instance()->param("addressId");
        $specificationId = Request::instance()->param("specificationId");
        $commodityId = Request::instance()->param("commodityId");
//        echo $specificationId."<br/>";
//        echo $commodityId;
        if ($specificationId != ""){
            if ($commodityId != ""){
                $commodity = Commodity::get(['id'=>$commodityId]);
                $specification = Specification::get(['id'=>$specificationId]);
                if ($commodity != null && $specification != null){
                    $order = new Order();
                    $order->id = Comm::getNewGuid();
                    $order->status = 0;
                    $order->user_id = User::getUserBySession()['id'];
                    $order->address_id =$addressId;
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

                }else{
                    return "亲，你选择的商品或者规格已经从地球上消失了~~";
                }
            }else{
                return "亲，请选择商品";
            }
        }else{
            return "亲，请选择商品规格";
        }
    }


}