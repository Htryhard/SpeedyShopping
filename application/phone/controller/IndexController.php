<?php

namespace app\phone\controller;


use app\common\Comm;
use app\common\model\Commodity;
use app\common\model\Count;
use app\common\model\Images;
use think\Controller;

/**
 * 专门用来测试的控制器
 * @package app\admin\controller
 */
class IndexController extends Controller
{
    /**
     * 测试页面
     * @return mixed
     */
    public function test()
    {
        return $this->fetch();
    }

    /**
     * 首页
     * @return mixed
     * @throws \think\Exception\DbException
     */
    public function index()
    {
        //记录访问IP
        $requestIP = Comm::getClientIP();
        $requestDate = time();
        $count = new Count();
        $count->ipcontent = $requestIP;
        $count->time = date('Y-m-d h:i:s', $requestDate);
        $count->user = "手机端";
        $count->modle = $this->request->module();
        $count->save();

        // 使用闭包查询
        $bannerCommodities = Commodity::all(function ($query) {
            $query->where('states', 0)->limit(3)->order('creation_time', 'desc');
        });

        // 使用闭包查询
        $commodities = Commodity::all(function ($query) {
            $query->where('states', 0)->limit(10)->order('creation_time', 'desc');
        });
        $imgRoot = '/SpeedyShopping/public//uploads/commodity_images/';
        $this->assign("imgRoot", $imgRoot);
        $this->assign('commodities', $commodities);
        $this->assign('bannerCommodities', $bannerCommodities);
        return $this->fetch();
    }

    /**
     * 搜索页面
     * @param string $keyword
     * @return mixed
     * @throws \think\exception\DbException
     */
    public function searchPage($keyword = "")
    {
        $pageSize = 100; // 每页显示30条数据
        $commodity = new Commodity();
        // 定制查询信息
        if ($keyword != "") {
            $commodities = $commodity->where('title', 'like', '%' . $keyword . '%')->paginate($pageSize, false,
                [
                    'query' => [
                        'title' => $keyword,
                    ],
                ]);
        } else {
            $commodities = [];
        }
        $imgRoot = '/SpeedyShopping/public//uploads/commodity_images/';
        $this->assign("imgRoot", $imgRoot);
        $this->assign("keyword", $keyword);
        $this->assign('commodities', $commodities);
        return $this->fetch();
    }

    /**
     * 商品列表页面
     * @return mixed
     * @throws \think\Exception\DbException
     */
    public function commodityList()
    {
        // 使用闭包查询
        $commodities = Commodity::all(function ($query) {
            $query->where('states', 0)->limit(100)->order('creation_time', 'desc');
        });
        $imgRoot = '/SpeedyShopping/public//uploads/commodity_images/';
        $this->assign("imgRoot", $imgRoot);
        $this->assign('commodities', $commodities);
        return $this->fetch();
    }

    /**
     * 关于我的页面
     * @return mixed
     */
    public function aboutMe()
    {
        return $this->fetch();
    }

    /**
     * 商品明细页面
     * @param string $id
     * @return mixed|string
     * @throws \think\Exception\DbException
     */
    public function commodityDetailed($id = "")
    {
        if ($id != "") {
            $commodity = Commodity::get(['id' => $id]);
            if ($commodity != null) {
                //构造商品的图片
                $commodityImages = array();
                $commodityImageObjects = $commodity['images'];
                foreach ($commodityImageObjects as $imageObject) {
                    $imgUrl = $imageObject->getData("image");
                    array_push($commodityImages, $imgUrl);
                }
                //构造商品的参数
                $commodityParameters = Comm::jsonToArr($commodity->getData("parameter"));
                $iconRoot = "/SpeedyShopping/public//uploads/icon_images/";
                $this->assign("iconRoot", $iconRoot);
                $this->assign("commodity", $commodity);
                $this->assign("parameters", $commodityParameters);
                $this->assign("images", $commodityImages);
                return $this->fetch();
            } else {
                return "商品不存在";
            }
        } else {
            return "没有转入指定参数";
        }
    }


    public function imagesList()
    {
        $images = Images::all();
        $imgRoot = '/SpeedyShopping/public//uploads/commodity_images/';
        $this->assign("imgRoot", $imgRoot);
        $this->assign("Images", $images);
        return $this->fetch();
    }

}
