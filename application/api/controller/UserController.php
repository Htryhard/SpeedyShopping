<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/3/21 0021
 * Time: 下午 2:42
 */

namespace app\api\controller;


use app\common\Comm;
use app\common\model\Cart;
use app\common\model\CartSpecification;
use app\common\model\Collect;
use app\common\model\Comment;
use app\common\model\Commodity;
use app\common\model\Order;
use app\common\model\OrderSpecification;
use app\common\model\Refunds;
use app\common\model\Specification;
use app\common\model\User;
use think\Controller;
use think\Request;

class UserController extends Controller
{
    /**
     * 用户登录
     * @return \think\response\Json
     */
    public function login()
    {
        $email = Request::instance()->post("email");
        $password = Request::instance()->post("password");
        $flag = User::login($email, $password, "home");
        if ($flag) {
            return json(User::getUserBySession("home"));
        } else {
            return json("notUser");
        }
    }

    /**
     * 根据用户的ID，检索出用户所有的地址
     * @return \think\response\Json
     */
    public function getUserAddress()
    {
        $userId = Request::instance()->post("userId");
//        if (User::isLogin("home")){
//
//        }else{
//
//        }
        $user = User::get(['id' => $userId]);
        if ($user != null) {
            $address = $user['address'];
            return json($address);
        } else {
            return json("usernull");
        }
    }

    /**
     * 根据用户ID，以json形式返回该用户的购物车列表
     * @return \think\response\Json
     */
    public function getCart()
    {
        $userId = Request::instance()->get("userId");
        $user = User::get(['id' => $userId]);
        if ($user != null) {
            $cart = Cart::get(['user_id' => $user->getData("id")]);
            $cartSpecifications = $cart["CartSpecifications"];
            $specifications = array();
            $commodities = array();
            $cartArray = array();
            foreach ($cartSpecifications as $cartSpecification) {
                array_push($specifications, $cartSpecification['Specification']);
                array_push($commodities, $cartSpecification['Specification']['commodity']);

                $cartItem = array();
                $cartItem += ['cartSpecificationId' => $cartSpecification['id']];
                $cartItem += ['specificationId' => $cartSpecification['Specification']['id']];
                $cartItem += ['cartId' => $cart['id']];
                $cartItem += ['commmodityId' => $cartSpecification['Specification']['commodity']['id']];
                $cartItem += ['commmodityTitle' => $cartSpecification['Specification']['commodity']['title']];
                $cartItem += ['commmodityIcon' => $cartSpecification['Specification']['commodity']['icon']];
                $cartItem += ['specificationContent' => $cartSpecification['Specification']['content']];
                $cartItem += ['cartSpecificationCount' => $cartSpecification['count']];
                $cartItem += ['specificationPrice' => $cartSpecification['Specification']['price']];

                array_push($cartArray, $cartItem);
            }
            return json($cartArray);
        } else {
            return json("usernull");
        }
    }

    /**
     * 编辑用户个人信息
     * @return \think\response\Json
     */
    public function editMessage()
    {
        $userId = Request::instance()->post("userId");
        $type = Request::instance()->post("type");
        $value = Request::instance()->post("value");
        $user = User::get(["id" => $userId]);
        if ($user != null && $value != "") {

            switch ($type) {
                case "NickName":
                    $user->nick_name = $value;
                    break;
                case "Sbasb":
                    $user->sbasb = $value;
                    break;
                case "UserName":
                    $user->user_name = $value;
                    break;
                case "EditUserIcon":
                    $oldUrl = ROOT_PATH . 'public' . DS . 'uploads' . DS . "icon_images" . DS . $user->getData('icon');
                    $user->icon = Comm::uploadsIconForAPI($value);
                    $user->save();
                    //删除旧的头像
                    unlink($oldUrl);
                    break;
                case "EditPassword":
                    $data = explode("-;-", $value);
                    $oldPassword = $data[0];
                    $newPassword = $data[1];
                    $flag = $user->checkPassword($oldPassword);
                    if ($flag) {
                        //密码正确，可以更改
                        $user->password = User::encryptPassword($newPassword);
                    } else {
                        //密码不正确
                        return json("");
                    }
                    break;
                default:
                    break;
            }
            $user->save();
            return json($user);
        } else {
            return json("用户不存在");
        }
    }

    /**
     * 购物车中加减商品数量
     * @return \think\response\Json
     */
    public function cartAddOrReduce()
    {
        $data = array();
        $userId = Request::instance()->post("userId");
        $type = Request::instance()->post("type");
        $cartSpecificationId = Request::instance()->post("cartSpecificationId");
        $position = Request::instance()->post("position");

        $user = User::get(["id" => $userId]);
        $cartSpecification = CartSpecification::get(["id" => $cartSpecificationId]);
        if ($user != null && $cartSpecification != null && $type != "" && $position != "") {
            $specification = $cartSpecification["Specification"];
            $repertory = $specification["repertory"];
            $oldCount = $cartSpecification["count"];
            if ($type == "Add") {
                if (($oldCount + 1) < $repertory) {
                    $cartSpecification->count = $oldCount + 1;
                    $cartSpecification->save();
                    $data["position"] = $position;
                    $data["code"] = 200;
                    $data["count"] = $cartSpecification->getData("count");
                    return json($data);
                }
            }
            if ($type == "Reduce") {
                if (($oldCount - 1) != 0) {
                    $cartSpecification->count = $oldCount - 1;
                    $cartSpecification->save();
                    $data["position"] = $position;
                    $data["code"] = 200;
                    $data["count"] = $cartSpecification->getData("count");
                    return json($data);
                }
            }
            $data["position"] = "";
            $data["code"] = 404;
            $data["count"] = "";
            return json($data);

        }
    }

    /**
     * 获取收藏列表
     * @return string|\think\response\Json
     */
    public function getCllects()
    {
        $data = array();
        $userId = Request::instance()->post("userId");
        $user = User::get(["id" => $userId]);
        if ($user != null) {
            $collects = Collect::all(["user_id" => $user->getData("id")]);
            foreach ($collects as $collect) {
                $commodity = $collect["commodity"];
                $item = array();
                $item["id"] = $collect->getData("id");
                $item["user_id"] = $collect->getData("user_id");
                $item["creation_time"] = $collect->getData("creation_time");
                $item["commodity"] = $commodity;
                $item["priceRange"] = $this->getMinPrice($collect["commodity_id"]);
                array_push($data, $item);
            }
            return json($data);
        } else {
            return "用户不存在！";
        }
    }

    /**
     * 获取一个商品中最低的价格
     * @param $commodityId
     * @return mixed
     */
    public function getMinPrice($commodityId)
    {
        $commodity = Commodity::get(["id" => $commodityId]);
        $spes = $commodity["specifications"];
        $min = $spes[0]["price"];
        foreach ($spes as $spe) {
            if ($spe["price"] < $min) {
                $min = $spe["price"];
            }
        }
        return $min;
    }

    public function isCollection()
    {
        $data = array();
        $userId = Request::instance()->post("userId");
        $commodityId = Request::instance()->post("commodityId");
        $user = User::get(["id" => $userId]);
        $commodity = Commodity::get(["id" => $commodityId]);
        if ($user != null && $commodity != null) {
            $collect = Collect::get(["user_id" => $user->getData("id"), "commodity_id" => $commodity->getData("id")]);
            if ($collect != null) {
                $data["code"] = 202;//已经收藏
                return json($data);
            } else {
                $data["code"] = 402;//没有收藏
                return json($data);
            }
        } else {
            $data["code"] = 402;//没有收藏
            return json($data);
        }
    }

    public function userCollection()
    {
        $data = array();
        $userId = Request::instance()->post("userId");
        $commodityId = Request::instance()->post("commodityId");
        $type = Request::instance()->post("type");
        $user = User::get(["id" => $userId]);
        $commodity = Commodity::get(["id" => $commodityId]);
        if ($user != null && $commodity != null && $type != "") {
            $collect = Collect::get(["user_id" => $user->getData("id"), "commodity_id" => $commodity->getData("id")]);
            if ($type == "add") {
                if ($collect == null) {
                    $collect = new Collect();
                    $collect->id = Comm::getNewGuid();
                    $collect->user_id = $user->getData('id');
                    $collect->commodity_id = $commodityId;
                    $collect->creation_time = time();
                    $collect->save();
                    $data["code"] = 203;//已经成功添加收藏
                    return json($data);
                }
            }
            if ($type == "remove") {
                if ($collect != null) {
                    $collect->delete();
                    $data["code"] = 204;//已经成功移除收藏
                    return json($data);
                }
            }
        } else {
            $data["code"] = 403;
            return json($data);
        }
    }

    public function addToCart()
    {
        $data = array();
        $userId = Request::instance()->post("userId");
        $specificationId = Request::instance()->post("specificationId");
        $count = Request::instance()->post("count");
        $user = User::get(["id" => $userId]);
        $specification = Specification::get(["id" => $specificationId]);
        if ($user != null && $specification != null && $count != "") {
            $cart = Cart::get(["user_id" => $user->getData("id")]);
            $cartSpecification = CartSpecification::get(["specification_id" => $specification->getData("id")]);
            if ($cartSpecification != null) {
                $oldCount = $cartSpecification->getData("count");
                $cartSpecification->count = $oldCount + $count;
                $cartSpecification->save();
            } else {
                $cartSpecification = new CartSpecification();
                $cartSpecification->id = Comm::getNewGuid();
                $cartSpecification->specification_id = $specification->getData('id');
                $cartSpecification->cart_id = $cart->getData("id");
                $cartSpecification->count = $count;
                $cartSpecification->save();
            }
            $data["code"] = 200;
            return json($data);
        } else {
            $data["code"] = 404;
            return json($data);
        }
    }

    /**
     * 初始化用户的首页
     * @return \think\response\Json
     */
    public function initUser()
    {
        $data = array();
        $userId = Request::instance()->post("userId");
        $user = User::get(["id" => $userId]);
        if ($user != null) {
            $orders = $user["orders"];
            $comments = Comment::all(["user_id" => $user->getData("id")]);
            $refunds = Refunds::all(["user_id" => $user->getData("id")]);
            //待付款
            $obligation = 0;
            //待收货
            $receiv = 0;
            //待评价
            $assess = 0;
            //退换货
            $customer = count($refunds);

            //精确到订单商品规格
            $orderSpes = 0;
            foreach ($orders as $order) {
                if ($order->getData("status") != 8 && $order->getData("status") != 7) {
                    switch ($order->getData("status")) {
                        case 0:
                            $obligation = $obligation + 1;
                            break;
                        case 1:
                            $receiv = $receiv + 1;
                            break;
                        case 2:
                            $receiv = $receiv + 1;
                            break;
                        case 3:
                            $receiv = $receiv + 1;
                            break;
                        case 4:
                            $receiv = $receiv + 1;
                            break;
                        case 5:
                            break;
                        case 6:
//                        $customer = $customer + 1;
                            break;
                        default:
                            break;
                    }
                    $orderSpecifications = $order["orderSpecifications"];
                    $orderSpes = $orderSpes + count($orderSpecifications);
                }
            }

            $len = count($comments);
            if ($orderSpes == $len) {
                $assess = 0;
            } else if ($orderSpes > $len) {
                $assess = $orderSpes - $len;
            }

            $data["obligation"] = $obligation;
            $data["receiv"] = $receiv;
            $data["assess"] = $assess;
            $data["customer"] = $customer;
            return json($data);
        }
    }

    public function customerService()
    {
        $data = array();
        $userId = Request::instance()->post("userId");
        $orderSpecificationId = Request::instance()->post("orderSpecificationId");
        $orderId = Request::instance()->post("orderId");
        $content = Request::instance()->post("content");
        $type = Request::instance()->post("type");

        $user = User::get(["id" => $userId]);
        $order = Order::get(["id" => $orderId]);
        $orderSpecification = OrderSpecification::get(["id" => $orderSpecificationId]);
        if ($user != null && $order != null && $orderSpecification != null) {
            $refund = Refunds::get(['order_id' => $orderId, 'user_id' => $user->getData('id'), "order_specification_id" => $orderSpecification->getData('id')]);
            if ($refund != null) {
                $data["statu"] = "RefundsRepeated";
                $data["data"] = $this->getRefundArr($refund, $orderSpecification);
                return json($data);
            } else {
                $refund = new Refunds();
                $refund->id = Comm::getNewGuid();
                switch ($type) {
                    case "repair"://返修
                        $refund->type = 0;
                        break;
                    case "goods_rejected"://退货
                        $refund->type = 2;
                        break;
                    case "exchange_goods"://换货
                        $refund->type = 1;
                        break;
                    default:
                        break;
                }
                $refund->content = $content;
                $refund->creation_time = time();
                $refund->user_id = $user->getData("id");
                $refund->order_id = $orderId;
                $refund->order_specification_id = $orderSpecification->getData('id');
                $refund->status = 0;//0待审核，1，2
                $refund->save();

//                $refundForApi = array();
//                $refundForApi["id"] = $refund->getData("id");
//                $refundForApi["type"] = $refund->getData("type");
//                $refundForApi["content"] = $refund->getData("content");
//                $refundForApi["order_id"] = $refund->getData("order_id");
//                $refundForApi["creation_time"] = $refund->getData("creation_time");
//                $refundForApi["status"] = $refund->getData("status");
//
//                $refundForApi["commmodityTitle"] = $orderSpecification['specification']['commodity']['title'];
//                $refundForApi["commmodityIcon"] = $orderSpecification['specification']['commodity']['icon'];
//                $refundForApi["specificationContent"] = $orderSpecification->getData('specificationcontent');
//                $refundForApi["cartSpecificationCount"] = $orderSpecification->getData('count');
//                $refundForApi["specificationPrice"] = $orderSpecification->getData('price');
//                $refundForApi["order_date"] = $refund['order']['order_time'];

                $data["statu"] = "success";
                $data["data"] = $this->getRefundArr($refund, $orderSpecification);
                return json($data);
            }
        } else {
            $data["statu"] = "fail";
            $data["data"] = "";
            return json($data);
        }
    }

    public function getRefundArr($refund, $orderSpecification)
    {
        $refundForApi = array();
        $refundForApi["id"] = $refund->getData("id");
        $refundForApi["type"] = $refund->getData("type");
        $refundForApi["content"] = $refund->getData("content");
        $refundForApi["order_id"] = $refund->getData("order_id");
        $refundForApi["creation_time"] = $refund->getData("creation_time");
        $refundForApi["status"] = $refund->getData("status");

        $refundForApi["commmodityTitle"] = $orderSpecification['specification']['commodity']['title'];
        $refundForApi["commmodityIcon"] = $orderSpecification['specification']['commodity']['icon'];
        $refundForApi["specificationContent"] = $orderSpecification->getData('specificationcontent');
        $refundForApi["cartSpecificationCount"] = $orderSpecification->getData('count');
        $refundForApi["specificationPrice"] = $orderSpecification->getData('price');
        $refundForApi["order_date"] = $refund['order']['order_time'];
        return $refundForApi;

    }

    public function getAllRefunds()
    {
        $data = array();
        $userId = Request::instance()->post("userId");
        $user = User::get(["id" => $userId]);
        if ($user != null) {
            $refunds = Refunds::all(["user_id" => $user->getData("id")]);
            foreach ($refunds as $refund) {
                $refundForApi = array();
                $refundForApi["id"] = $refund->getData("id");
                $refundForApi["type"] = $refund->getData("type");
                $refundForApi["content"] = $refund->getData("content");
                $refundForApi["order_id"] = $refund->getData("order_id");
                $refundForApi["creation_time"] = $refund->getData("creation_time");
                $refundForApi["status"] = $refund->getData("status");

                $refundForApi["commmodityTitle"] = $refund['OrderSpecification']['specification']['commodity']['title'];
                $refundForApi["commmodityIcon"] = $refund['OrderSpecification']['specification']['commodity']['icon'];
                $refundForApi["specificationContent"] = $refund['OrderSpecification']['specificationcontent'];
                $refundForApi["cartSpecificationCount"] = $refund['OrderSpecification']['count'];
                $refundForApi["specificationPrice"] = $refund['OrderSpecification']['price'];
                $refundForApi["order_date"] = $refund['order']['order_time'];

                array_push($data, $refundForApi);
            }
            return json($data);
        }
    }

}