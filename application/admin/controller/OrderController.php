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

    public function editOrderHandle()
    {
        if ($this->request->isAjax()) {
            $commodities = $this->request->post("commodities");//二维数组，即多个规格组
            /**
             * 格式为：
            array (size=3)
            0 =>
            array (size=3)
            0 => string 'DA7CCCC7-2474-D9E5-EC31-4F41FDC62502' (length=36) //规格ID
            1 => string '100' (length=3)  //价格
            2 => string '1' (length=1)  //数量
            1 =>
            array (size=3)
            0 => string '467E4794-E139-9D4C-A001-648467AE4B50' (length=36)
            1 => string '199' (length=3)
            2 => string '1' (length=1)
            2 =>
            array (size=3)
            0 => string '718C679A-4D05-CC4A-6844-81B655A150D0' (length=36)
            1 => string '1699' (length=4)
            2 => string '1' (length=1)
             *
             *
             * */
            $commodities = json_decode($commodities);//json解析
            $orderId = $this->request->post("orderId");//订单ID
            $receiptName = $this->request->post("receiptName");//收货人姓名
            $new_xiangxi = $this->request->post("new_xiangxi");//收货人地址
            $mobile = $this->request->post("mobile");//收货人电话
            if (count($commodities) == 0 || $orderId == "" || $receiptName == "" || $new_xiangxi == "" || $mobile == "") {
                //参数不全
                return "ParameterError";
            }
            $order = Order::get(['id' => $orderId]);
            if ($order != null) {
                $address = $order['address'];
                $address->phone = $mobile;
                $address->content = $new_xiangxi;
                $address->user_name = $receiptName;
                $address->save();

                $orderSpecifications = $order['orderSpecifications'];
                $osLen = count($orderSpecifications);
                for ($i = 0; $i < $osLen; $i++) {
                    $orspItem = $orderSpecifications[$i];
                    $comLen = count($commodities);
                    for ($j = 0; $j < $comLen; $j++) {
                        if ($orspItem['specification_id'] == $commodities[$j][0]) {
                            $orspItem->price=$commodities[$j][1];//价格
                            $orspItem->count=$commodities[$j][2];//数量
                            $orspItem->save();
                        }
                    }
                }
                return "success";
            } else {
                //订单不存在
                return "OrderError";
            }
        } else {
            //请求方式错误！
            return "PostError";
        }

    }


}