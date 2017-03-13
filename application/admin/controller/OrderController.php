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
    public function orderIndex($type)
    {
        $orders = null;
        switch ($type) {
            case "all":
                $orders = Order::where("status", ">", -1)->order('order_time', 'desc')->paginate(15);
                break;
            case "statu0":
                $orders = Order::where("status", "=", 0)->order('order_time', 'desc')->paginate(15);
                break;
            case "statu1":
                $orders = Order::where("status", "=", 1)->order('order_time', 'desc')->paginate(15);
                break;
            case "statu2":
                $orders = Order::where("status", "=", 2)->order('order_time', 'desc')->paginate(15);
                break;
            case "statu3":
                $orders = Order::where("status", "=", 3)->order('order_time', 'desc')->paginate(15);
                break;
            case "statu4":
                $orders = Order::where("status", "=", 4)->order('order_time', 'desc')->paginate(15);
                break;
            case "statu5":
                $orders = Order::where("status", "=", 5)->order('order_time', 'desc')->paginate(15);
                break;
            case "statu6":
                $orders = Order::where("status", "=", 6)->order('order_time', 'desc')->paginate(15);
                break;
            case "statu7":
                $orders = Order::where("status", "=", 7)->order('order_time', 'desc')->paginate(15);
                break;
            case "statu8":
                $orders = Order::where("status", "=", 8)->order('order_time', 'desc')->paginate(15);
                break;
            default:
                break;
        }
        $this->assign("type", $type);
        $this->assign("user", User::getUserBySession("admin"));
        $this->assign("orders", $orders);
        return $this->fetch();
    }

    public function orderDetailed($id)
    {
        $order = Order::get($id);
        if ($order != null) {
            $this->assign("user", User::getUserBySession("admin"));
            $this->assign("users", User::all());
            $this->assign("order", $order);
            return $this->fetch();
        } else {
            return "没有这个订单";
        }
    }

    public function editOrder()
    {
        $orderId = $this->request->param("orderId");
        $user = User::getUserBySession("admin");
        $order = Order::get(['id' => $orderId]);
        if ($user != null && $order != null) {
            $this->assign("user", $user);
            $this->assign("order", $order);

            return $this->fetch();
        } else {
            return $this->error("订单不存在或者登陆已过期，请重新登陆！");
        }
    }

    public function editOrderHandle(){
        $commodities = $this->request->param("commodities");
        var_dump(json_decode($commodities));

    }


}