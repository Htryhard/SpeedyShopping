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
use app\common\model\User;
use think\Controller;
use think\Request;

class OrderController extends Controller
{
    public function addOrder()
    {
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
        if ($user != null && count($spIdAndCountArray) > 0 && $address != null)
        {

        }


    }

}