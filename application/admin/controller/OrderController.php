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
use app\common\model\OrderSpecification;
use app\common\model\Refunds;
use app\common\model\Specification;
use app\common\model\User;
use think\Request;

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
            case "statu9":
                $orders = Order::where("status!=0 AND status!=5 AND status!=7 AND status!=8")->order('order_time', 'desc')->paginate(15);
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

    /**
     * 保存编辑好的订单
     * @return string
     */
    public function editOrderHandle()
    {
        if ($this->request->isAjax()) {
            $commodities = $this->request->post("commodities");//二维数组，即多个规格组
            /**
             * 格式为：
             * array (size=3)
             * 0 =>
             * array (size=3)
             * 0 => string 'DA7CCCC7-2474-D9E5-EC31-4F41FDC62502' (length=36) //规格ID
             * 1 => string '100' (length=3)  //价格
             * 2 => string '1' (length=1)  //数量
             * 1 =>
             * array (size=3)
             * 0 => string '467E4794-E139-9D4C-A001-648467AE4B50' (length=36)
             * 1 => string '199' (length=3)
             * 2 => string '1' (length=1)
             * 2 =>
             * array (size=3)
             * 0 => string '718C679A-4D05-CC4A-6844-81B655A150D0' (length=36)
             * 1 => string '1699' (length=4)
             * 2 => string '1' (length=1)
             *
             *
             * */
            $commodities = json_decode($commodities);//json解析
            $orderId = $this->request->post("orderId");//订单ID
            $receiptName = $this->request->post("receiptName");//收货人姓名
            $new_xiangxi = $this->request->post("new_xiangxi");//收货人地址
            $mobile = $this->request->post("mobile");//收货人电话
            $status2_8 = $this->request->post("status2_8");//更新状态
            if (count($commodities) == 0 || $orderId == "" || $receiptName == "" || $new_xiangxi == "" || $mobile == "") {
                //参数不全
                return "ParameterError";
            }
            $order = Order::get(['id' => $orderId]);
            if ($order != null) {
                //TODO:目前这个地址修改方式存在不合理的地方，
                //TODO:一旦卖家修改收货地址，会把用户的地址改掉,需要在订单中新增收货人、收货地址、联系电话、邮编等属性
                $address = $order['address'];
                $address->phone = $mobile;
                $address->content = $new_xiangxi;
                $address->user_name = $receiptName;
                $address->save();

                //把数据更新上去
                $orderSpecifications = $order['orderSpecifications'];
                $osLen = count($orderSpecifications);
                for ($i = 0; $i < $osLen; $i++) {
                    $orspItem = $orderSpecifications[$i];
                    $orspItem->specification_id = $commodities[$i][0];
                    $orspItem->count = $commodities[$i][2];//数量
                    $orspItem->price = $commodities[$i][1];//价格
                    $orspItem->specificationcontent = Specification::get(['id' => $commodities[$i][0]])->getData('content');//规格内容
                    $orspItem->save();
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


    // 删除订单中的某件商品
    public function editOrderDeleteHandle()
    {
        if ($this->request->isAjax()) {
            $specificationId = $this->request->post("specificationId");
            $orderId = $this->request->post("orderId");
            $orderSpecification = OrderSpecification::get(['order_id' => $orderId,
                'specification_id' => $specificationId]);
            if ($orderSpecification != null) {
                $orderSpecification->delete();
                return "success";
            } else {
                $this->redirect(url("home/error/postError", ['code' => "410", 'msg' => "此商品已经不存在！"]));
            }
        } else {
            $this->redirect(url("home/error/postError", ['code' => "400", 'msg' => "请求方式错误！"]));
        }
    }

    public function refunds($type)
    {
        if ($type == "") {
            return $this->error("参数不全！");
        } else {
            $refunds = null;
            switch ($type) {
                case "all":
                    $refunds = Refunds::getAllRefunds();
                    break;
                case "":
                    break;
                default:
            }
            $this->assign("user", User::getUserBySession("admin"));
            $this->assign("refunds", $refunds);
            return $this->fetch();
        }
    }

    //发货单
    public function sendGoods()
    {
        $orders = Order::getOrdersForPayment();
        echo count($orders);
        $this->assign("orders", $orders);
        $this->assign("user", User::getUserBySession("admin"));
        return $this->fetch();
    }

    //更新订单的状态
    public function editOrderStatus()
    {
        if ($this->request->isAjax()) {
            $orderId = $this->request->post("orderId");
            $type = $this->request->post("type");
            $order = Order::get(['id' => $orderId]);
            if ($type == "" || $order == null) {
                $this->redirect(url("home/error/postError", ['code' => "404", 'msg' => "请求的参数不存在！"]));
            } else {
                $oldStatus = $order->getData('status');
                $order->status = $oldStatus + 1;
                $order->save();
                return "success";
            }
        } else {
            $this->redirect(url("home/error/postError", ['code' => "400", 'msg' => "请求方式错误！"]));
        }
    }


    public function customerService($refundId)
    {
        $refund = Refunds::get(["id" => $refundId]);
        if ($refund != null) {
            $this->assign("refund", $refund);
            $user = User::getUserBySession("admin");
            $this->assign("user", $user);
            $imgRoot = '/SpeedyShopping/public//uploads/commodity_images/';
            $this->assign("imgRoot", $imgRoot);
            return $this->fetch();
        } else {
            return $this->redirect(url("home/error/postError?code=404&msg=该退货单未找的到！！"));
        }
    }

    public function customerServiceHandle()
    {
        $refundId = Request::instance()->post("refundId");
        $type = Request::instance()->post("type");
        $refund = Refunds::get(["id" => $refundId]);
        if ($refund != null && $type != "") {
            if ($refund->getData("status") == 0) {
                if ($type == 1) {
                    //申请通过
                    $refund->status = 1;
                } else {
                    //拒绝申请
                    $refund->status = 2;
                }
                $refund->save();
                return "Success";
            } else {
                //退货订单已经被处理，不能再次处理
                return "Obsolete";
            }
        } else {
            return "ParameterError";
        }
    }


}