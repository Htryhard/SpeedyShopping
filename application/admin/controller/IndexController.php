<?php
namespace app\admin\controller;

use app\common\Comm;
use app\common\controller\BaseController;
use app\common\model\Commodity;
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

    public function seting()
    {
        $user = User::getUserBySession("admin");
        $this->assign("user", $user);
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


}
