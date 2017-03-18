<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/3/15 0015
 * Time: 下午 2:07
 */

namespace app\api\controller;


use app\common\model\Commodity;
use app\common\model\CommodityImages;
use think\Controller;
use think\Request;

class CommodityController extends Controller
{
    public function getAllCommodity()
    {
        header("Cache-control:max-age=5");
        $commodities = Commodity::all();
        return json($commodities);
    }

    /**
     * 根据关键词进行搜索
     * @return \think\response\Json
     */
    public function getCommodities()
    {
        $commodity = new Commodity();
        $where = Request::instance()->get("where");
        if ($where != "") {
            $commodities = $commodity->where('title', 'like', '%' . $where . '%')->where('out_time', '>', time())->select();
        } else {
            $commodities = Commodity::all(function ($query) {
//            $query->where('out_time', '>', time())->order('id', 'desc');
                $query->where('out_time', '>', time());
            });
        }
        if (count($commodities) > 0) {
            return json($commodities);
        } else {
            return json(['error' => '还没有电影哦~'], 404);
        }

    }

    /**
     * 根据商品ID获取商品图片
     * @return \think\response\Json
     */
    public function getCommodityImages()
    {
        //商品ID
        $where = Request::instance()->get("where");
        if ($where!=""){
            $commoditiyImages = CommodityImages::all(['commodity_id'=>$where]);
            return json($commoditiyImages);
        }else{
            return json(["error"=>"参数错误！"]);
        }
    }

    public function getSpecificationForCommodity(){
        //商品ID
        $where = Request::instance()->get("where");
        if ($where!=""){
            $specificationes = Commodity::get(['id'=>$where])['specifications'];
            return json($specificationes);
        }else{
            return json(["error"=>"参数错误！"]);
        }
    }

}