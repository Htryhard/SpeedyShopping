<?php

namespace app\admin\controller;

use app\common\Comm;
use app\common\controller\BaseController;
use app\common\model\Comment;
use app\common\model\Commodity;
use app\common\model\Count;
use app\common\model\Images;
use app\common\model\Order;
use app\common\model\OrderSpecification;
use app\common\model\User;

/**
 * 专门用来测试的控制器
 * @package app\admin\controller
 */
class IndexController extends BaseController
{
    public function index()
    {
        $user = User::getUserBySession("admin");
        $this->assign("user", $user);
        //待处理订单   状态不为0(待付款)、5(已完成)、7、(交易关闭)、8(用户已经删除订单)
        $orders = Order::where("status!=0 AND status!=5 AND status!=7 AND status!=8")->select();
        $this->assign("countOrder", count($orders));
        //商品数量
        $this->assign("countCommodity", count(Commodity::all()));
        //用户总数
        $this->assign("countUser", count(User::all()));

        //今日订单
        $todayOrder = array();
        $beginToday = mktime(0, 0, 0, date('m'), date('d'), date('Y'));
        $endToday = mktime(0, 0, 0, date('m'), date('d') + 1, date('Y')) - 1;
        $allOrders = Order::all();
        foreach ($allOrders as $order) {
            $orderTime = $order["order_time"];
            if ($orderTime > $beginToday && $orderTime < $endToday) {
                array_push($todayOrder, $order);
            }
        }
        $this->assign("countTodayOrders", count($todayOrder));
        //今日访问量
        $todayComent = array();
        $allCount = Count::all();
        foreach ($allCount as $count) {
            $countTime = $count["time"];
            if ($countTime > $beginToday && $countTime < $endToday) {
                array_push($todayComent, $count);
            }
        }
        $this->assign("countTodayComent", count($todayComent));
        //今日新增会员
        $todayUser = array();
        $allUser = User::all();
        foreach ($allUser as $user) {
            $reTime = $user["creation_time"];
            if ($reTime > $beginToday && $reTime < $endToday) {
                array_push($todayUser, $user);
            }
        }
        $this->assign("countTodayUser", count($todayUser));
        //待审核的评论
        $comments = Comment::where("status=1")->select();
        $this->assign("comments", count($comments));

        //服务器操作系统

        //服务器域名/IP
        //服务器环境
        //PHP 版本
        //Mysql 版本

        return $this->fetch();
    }

    public function test()
    {
        $objs = Commodity::all();
        return json($objs);
    }

    public function tableUser()
    {
        // 获取查询信息
        $phone = input('get.where');
        $pageSize = 10; // 每页显示10条数据
        $user = new User();
        // 定制查询信息
        if (!empty($phone)) {
            $users = $user->where('phone', 'like', '%' . $phone . '%')->paginate($pageSize, false,
                [
                    'query' => [
                        'phone' => $phone,
                    ],
                ]);
        } else {
            $users = $user->paginate($pageSize);
        }
        $this->assign("DataType", "userDataShow");
        $this->assign("user", User::getUserBySession("admin"));
        $this->assign('users', $users);
        return $this->fetch();

    }

    public function tableOrder()
    {
        // 获取查询信息
        $ordernmber = input('get.ordernmber');
        $ord = Order::get(['order_number' => $ordernmber]);
        $pageSize = 10; // 每页显示10条数据
        $order = new Order();
        // 定制查询信息
        if (!empty($ord['id'])) {
            $orders = $order->where('id', 'like', '%' . $ord['id'] . '%')->paginate($pageSize, false,
                [
                    'query' => [
                        'id' => $ord['id'],
                    ],
                ]);
        } else {
            $orders = $order->paginate($pageSize);
        }

        $this->assign("DataType", "orderDataShow");
        $this->assign("allOrders", Order::all());
        $this->assign("countOrder", count(Order::all()));
        $this->assign("user", User::getUserBySession("admin"));
        $this->assign('orders', $orders);
        return $this->fetch();

    }

    public function tableCommodity()
    {
        // 获取查询信息
        $title = input('get.title');
        $pageSize = 10; // 每页显示10条数据
        $commodity = new Commodity();
        // 定制查询信息
        if (!empty($title)) {
            $commoditys = $commodity->where('title', 'like', '%' . $title . '%')->paginate($pageSize, false,
                [
                    'query' => [
                        'title' => $title,
                    ],
                ]);
        } else {
            $commoditys = $commodity->paginate($pageSize);
        }

        $showCount = 0;
        foreach (Commodity::all() as $commodity) {
            if ($commodity['states'] != 1) {
                $showCount++;
            }
        }
        $this->assign("DataType", "commodityDataShow");
        $this->assign("mOut", count(Commodity::all()) - $showCount);
        $this->assign("mHot", $showCount);
        $this->assign("mCommodityCount", count(Commodity::all()));
        $this->assign("user", User::getUserBySession("admin"));
        $this->assign("orderSpecification", OrderSpecification::all());
        $this->assign('commoditys', $commoditys);
        return $this->fetch();

    }


    public function testUUID()
    {
        echo "GUID:" . Comm::getNewGuid() . "<br/>";
    }

    public function add()
    {
        echo time();
    }

    public function test1()
    {
        echo "dddddd";
        echo "aaaa";
    }

    //测试后台布局界面
    public function testWei()
    {
        return $this->fetch();
    }


    public function seting()
    {
        $user = User::getUserBySession("admin");
        $this->assign("user", $user);
        return $this->fetch();
    }

    public function saveImages()
    {
        $commodityImages = $this->request->param("commodityImages");
        if ($commodityImages != "") {
            $commodityImages = substr($commodityImages, 1);
        }
        $imagesArr = explode(";", $commodityImages);
        //此循环是保存商品的图片
        foreach ($imagesArr as $image) {
            $commodityImage = new Images();
            $commodityImage->id = Comm::getNewGuid();
            $commodityImage->path = $image;
            $commodityImage->image_type_id = "";
            $commodityImage->save();
            $oldUrl = ROOT_PATH . 'public' . DS . 'uploads' . DS . "cacheImages" . DS . $image;
            $newUrl = ROOT_PATH . 'public' . DS . 'uploads' . DS . "commodity_images" . DS . $image;
            Comm::moveFile($newUrl, $oldUrl);
        }
    }

    /**
     * 上传商品的图片
     * @return string
     */
    public function uploadImage()
    {
        $imgSuffix = $_FILES['file']['name'];
        $imgSuffix = substr($imgSuffix, strpos($imgSuffix, ".") + 1);
        $imageName = Comm::getNewGuid() . "." . $imgSuffix;
        $uploaddir = ROOT_PATH . 'public' . DS . 'uploads' . DS . "cacheImages";
//        if (!is_dir($uploaddir)) {
//            mkdir($uploaddir);
//        }

        if (move_uploaded_file($_FILES['file']['tmp_name'], $uploaddir . "/" . $imageName)) {
//                print "文件上传成功！这是文件的一下信息:\n";
//                print_r($_FILES);
            return $imageName;
        } else {
            print "文件上传失败啦!这里有一些信息可以帮助你去调试:\n";
            print_r($_FILES);
        }
    }


}
