<?php
/**
 * 订单管理控制器.
 * User: Huan
 * Date: 2016/12/29
 * Time: 17:09
 */

namespace app\admin\controller;


use app\common\controller\BaseController;
use app\common\model\Order;
use app\common\model\User;

class OrderController extends BaseController
{
    public function orderIndex()
    {
        $this->assign("orders", Order::all());
        return $this->fetch();
    }

    public function orderDetailed($id){
        $order = Order::get($id);
        if ($order!=null){
            $this->assign("users",User::all());
            $this->assign("order",$order);
            return $this->fetch();
        }else{
            return "没有这个订单";
        }
    }


}