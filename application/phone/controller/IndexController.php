<?php

namespace app\phone\controller;


use app\common\Comm;
use app\common\model\Commodity;
use think\Controller;

/**
 * 专门用来测试的控制器
 * @package app\admin\controller
 */
class IndexController extends Controller
{
    public function index()
    {
        // 使用闭包查询
        $bannerCommodities = Commodity::all(function ($query) {
            $query->where('staistics', 0)->limit(3)->order('creation_time', 'desc');
        });

        // 使用闭包查询
        $commodities = Commodity::all(function ($query) {
            $query->where('staistics', 0)->limit(10)->order('creation_time', 'desc');
        });
        $imgRoot = '/SpeedyShopping/public//uploads/commodity_images/';
        $this->assign("imgRoot", $imgRoot);
        $this->assign('commodities', $commodities);
        $this->assign('bannerCommodities', $bannerCommodities);
        return $this->fetch();
    }

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

    public function commodityList()
    {
        // 使用闭包查询
        $commodities = Commodity::all(function ($query) {
            $query->where('staistics', 0)->limit(100)->order('creation_time', 'desc');
        });
        $imgRoot = '/SpeedyShopping/public//uploads/commodity_images/';
        $this->assign("imgRoot", $imgRoot);
        $this->assign('commodities', $commodities);
        return $this->fetch();
    }

    public function aboutMe()
    {
        return $this->fetch();
    }

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


}
