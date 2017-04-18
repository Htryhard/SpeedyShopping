<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/3/21 0021
 * Time: 下午 2:42
 */

namespace app\api\controller;


use app\common\Comm;
use app\common\model\Address;
use app\common\model\AuthGroup;
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
use app\common\model\Type;
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

    public function postComment()
    {
        $date = array();
        $userId = Request::instance()->post("userId");
        $orderSpecificationId = Request::instance()->post("orderSpecificationId");
        $rating = Request::instance()->post("rating");
        $commentContnet = Request::instance()->post("commentContnet");
//        $imgBase64s = Request::instance()->post("imgBase64s");

        $user = User::get(["id" => $userId]);
        $orderSpecification = OrderSpecification::get(["id" => $orderSpecificationId]);

        if ($user != null && $orderSpecification != null && $rating != "" && $commentContnet != "") {
            //判断是否已经对这次购买的商品评论过
            $comment = Comment::get(['user_id' => $user->getData('id'), "order_specification_id" => $orderSpecification->getData('id')]);
            if ($comment != null) {
                $date["statu"] = "CommentRepeated";
                $date["data"] = "";
                return json($date);
            }
            $commodity = $orderSpecification["specification"]["commodity"];
            $grade = $commodity["grade"];
            $grade = (double)$grade + (double)$rating;
            $commodity->grade = $grade;
            $commodity->save();

            $comment = new Comment();
            $comment->id = Comm::getNewGuid();
            $comment->content = $commentContnet;
            $comment->grade = $rating;
            $comment->creation_time = time();
            $comment->user_id = $user->getData("id");
            $comment->commodity_id = $commodity["id"];
            $comment->order_id = $orderSpecification["order"]["id"];
            $comment->order_specification_id = $orderSpecification->getData('id');
            $comment->status = 1;//0正常显示，1管理员暂未开放
            $comment->save();

//            if ($imgBase64s != "") {
//                //以约定的5个#号来分割
//                $imgArray = explode("#####", $imgBase64s);
//                //分割会导致多出一个空元素，故移除最后一个空元素
//                array_pop($imgArray);
//                foreach ($imgArray as $item) {
//                    $commentImgPath = Comm::uploadsCommentImgsForAPI($item);
//                    $commentImageModle = new CommentImages();
//                    $commentImageModle->id = Comm::getNewGuid();
//                    $commentImageModle->image = $commentImgPath;
//                    $commentImageModle->comment_id = $comment->getData("id");
//                    $commentImageModle->save();
//                }
//            }
            $date["statu"] = "success";
            $date["data"] = $comment;
            return json($date);

        }
        $date["statu"] = "ParameterError";
        $date["data"] = "参数不全，可能是订单已经丢失";
        return json($date);

    }

    public function userAllComment()
    {
        $date = array();
        $commenDatas = array();
        $userId = Request::instance()->post("userId");
        $user = User::get(["id" => $userId]);
        if ($user != null) {
            $comments = Comment::all(["user_id" => $userId]);
            if (count($comments) > 0) {

                foreach ($comments as $comment) {
                    $commenArr = array();
                    $commenArr["id"] = $comment->getData("id");
                    $commenArr["count"] = $comment["OrderSpecification"]["count"];
                    $commenArr["price"] = $comment["OrderSpecification"]["price"];
                    $commenArr["specificationcontent"] = $comment["OrderSpecification"]["specificationcontent"];
                    $commenArr["ordeSpecificationId"] = $comment["OrderSpecification"]["id"];
                    $commenArr["order_date"] = $comment["OrderSpecification"]["order"]["order_time"];
                    $commenArr["commodityIcon"] = $comment["OrderSpecification"]["specification"]["commodity"]["icon"];
                    $commenArr["commodityTitle"] = $comment["OrderSpecification"]["specification"]["commodity"]["title"];
                    $commenArr["commodityId"] = $comment["OrderSpecification"]["specification"]["commodity"]["id"];
                    $commenArr["commentContent"] = $comment->getData("content");

                    $imgs = array();
                    foreach ($comment["commentImgs"] as $commentImg) {
                        array_push($imgs, $commentImg["image"]);
                    }
                    $commenArr["commentIcons"] = $imgs;

                    array_push($commenDatas, $commenArr);
                }

                $date["statu"] = "Success";
                $date["data"] = $commenDatas;
                return json($date);
            } else {
                $date["statu"] = "NullData";
                $date["data"] = "";
                return json($date);
            }
        } else {
            $date["statu"] = "NullUser";
            $date["data"] = "";
            return json($date);
        }

    }

    public function editAddress()
    {
        $data = array();
        $addressId = Request::instance()->post("addressId");
        $userId = Request::instance()->post("userId");
        $name = Request::instance()->post("name");
        $content = Request::instance()->post("content");
        $phone = Request::instance()->post("phone");

        $address = Address::get(['id' => $addressId]);
        $user = User::get(["id" => $userId]);

        if ($user != null && $name != "" && $content != "" && $phone != "") {
            if ($address != null) {
                $address->phone = $phone;
                $address->content = $content;
                $address->user_name = $name;
                $address->save();
            } else {
                $address = new Address();
                $address->id = Comm::getNewGuid();
                $address->phone = $phone;
                $address->content = $content;
                $address->user_name = $name;
                $address->user_id = $userId;
                $address->save();
            }
            $date["statu"] = "Success";
            $date["data"] = $address;
            return json($date);
        } else {
            $date["statu"] = "NullParameter";
            $date["data"] = "";
            return json($date);
        }

    }

    public function getRefund()
    {
        $orderSpecificationId = Request::instance()->post("orderSpecificationId");
        $orderSpecification = OrderSpecification::get(["id" => $orderSpecificationId]);
        $refund = Refunds::get(["order_specification_id" => $orderSpecificationId]);
        if ($refund != null) {
            $date["statu"] = "Success";
            $date["data"] = $this->getRefundArr($refund, $orderSpecification);
            return json($date);
        } else {
            $date["statu"] = "NullRefund";
            $date["data"] = "";
            return json($date);
        }
    }

    public function initHomeTyep()
    {
        $type = Request::instance()->get("type");
        $commodities = null;
        //states=0说明商品没有下架1或者删除2
        switch ($type) {
            case "Recommend":
                //推荐购
                $commodities = Commodity::where("states=0")->order('grade', 'desc')->paginate(30);
                break;
            case "LifeSupermarket":
                //生活超市
                //暂时写死
                $type = Type::get(['id' => "A2AF9D4A-D613-0A44-353C-F015BB16F24A"]);
                if ($type != null)
                    $commodities = $type['commodities'];
                break;
            case "CarRental":
                //租车
                //暂时写死
                $type = Type::get(['id' => "C2CFEB29-044B-1003-2BBA-F0EBF3F1CA3B"]);
                if ($type != null)
                    $commodities = $type['commodities'];
                break;
            case "TakeOutFood":
                //外卖
                //暂时写死
                $type = Type::get(['id' => "E310BC0C-CBB9-5D9B-B198-EE79D1D2A875"]);
                if ($type != null)
                    $commodities = $type['commodities'];
                break;
            case "DoorToDoorService":
                //上门维修
                //暂时写死
                $type = Type::get(['id' => "D85D8F1F-D978-E0E3-DEE5-6B6F1C93255A"]);
                if ($type != null)
                    $commodities = $type['commodities'];
                break;
            case "SalesVolume":
                //销量购
                $commodities = Commodity::where("states=0")->order('staistics', 'desc')->paginate(30);
                break;
            case "Score":
                //高分购
                $commodities = Commodity::where("states=0")->order('grade', 'desc')->paginate(30);
                break;
            case "SecondHand":
                //二手市场
                $type = Type::get(['id' => "7629D45C-386F-E1B0-F529-F268771CE43D"]);
                if ($type != null)
                    $commodities = $type['commodities'];
                break;
                break;
            default:
                break;
        }

        return json($commodities);

    }

    public function registerUser()
    {
        $email = Request::instance()->post("email");
        $password = Request::instance()->post("password");
        $userName = Request::instance()->post("userName");
        $phone = Request::instance()->post("phone");

        if ($email != "" && $password != "" && $userName != "" && $phone != "") {
            $user = User::get(["email" => $email]);
            if ($user != null) {
                $data["statu"] = "501";
                $data["data"] = "邮箱已经被注册！";
                return json($data);
            }

            $user = User::get(["phone" => $phone]);
            if ($user != null) {
                $data["statu"] = "502";
                $data["data"] = "手机号码已经被注册！";
                return json($data);
            }

            $user = new User();
            $user->id = Comm::getNewGuid();
            $user->email = $email;
            $user->user_name = $userName;
            $user->password = User::encryptPassword($password);
            $user->phone = $phone;
            $user->creation_time = time();
            $auth = AuthGroup::get(["rules" => "user"]);
            $user->role_id = $auth->getData("id");
            $user->icon = "201702181841206215.png";//默认头像

            if ($user->validate(true)->save($user->getData())) {
                //为用户创建一个空的购物车待用
                $cart = new Cart();
                $cart->id = Comm::getNewGuid();
                $cart->user_id = $user->getData('id');
                $cart->save();
                //写入默认权限
//                Comm::defaltPermission($user->getData("id"));
                $data["statu"] = "200";
                $data["data"] = $user;
                return json($data);
            } else {
                $data["statu"] = "505";
                $data["data"] = $user->getError();
                return json($data);
            }

        } else {
            $data["statu"] = "500";
            $data["data"] = "参数不全！";
            return json($data);
        }

    }

}