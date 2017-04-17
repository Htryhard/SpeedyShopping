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
use app\common\model\Specification;
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
            $commodities = $commodity->where('title', 'like', '%' . $where . '%')->where('out_time', '>', time())->where('states', '=', 0)->select();
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

    public function getNewsCommodities()
    {
        $commodity = new Commodity();
        // 使用闭包查询
        $commodities = Commodity::all(function ($query) {
            $query->where('states', '0')->order('creation_time', 'desc');
        });
        return json($commodities);
    }

    /**
     * 根据商品ID获取商品图片
     * @return \think\response\Json
     */
    public function getCommodityImages()
    {
        //商品ID
        $where = Request::instance()->get("where");
        if ($where != "") {
            $commoditiyImages = CommodityImages::all(['commodity_id' => $where]);
            return json($commoditiyImages);
        } else {
            return json(["error" => "参数错误！"]);
        }
    }

    /**
     * 根据商品ID获取商品所有的规格
     * @return \think\response\Json
     */
    public function getSpecificationForCommodity()
    {
        //商品ID
        $where = Request::instance()->get("where");
        if ($where != "") {
            $specificationes = Commodity::get(['id' => $where])['specifications'];
            return json($specificationes);
        } else {
            return json(["error" => "参数错误！"]);
        }
    }

    /**
     * 根据安卓端上传的规格ID列表（格式：规格ID1;规格ID2;...）
     * 返回对应的商品列表（不需处理重复值）
     * @return \think\response\Json
     */
    public function getCommodityBySpecification()
    {
        $speIDs = Request::instance()->get("speIds");
        $commodities = array();
        $speArray = explode(";", $speIDs);
        array_pop($speArray);
        foreach ($speArray as $spid) {
            $specification = Specification::get(['id' => $spid]);
            $commodity = $specification['commodity'];
            $commodities[] = $commodity;
        }
        return json($commodities);
    }

    public function getComments()
    {
        $data = array();
        $commodityId = Request::instance()->post("commodityId");
        $commodity = Commodity::get(["id" => $commodityId]);
        if ($commodity != null) {
            $comments = $commodity["comments"];
            foreach ($comments as $comment) {
                if ($comment->getData("status") != 1) {
                    $comData = array();
                    $comData["id"] = $comment["id"];
                    $comData["content"] = $comment["content"];
                    $comData["grade"] = $comment["grade"];
                    $comData["creation_time"] = $comment["creation_time"];

                    $user = $comment["user"];
                    $comData["user_name"] = $user["nick_name"];
                    $comData["user_icon"] = $user["icon"];

                    $orderSpecification = $comment['OrderSpecification'];
                    if ($orderSpecification == null) {
                        $comData["specification_content"] = "";
                    } else {
                        $comData["specification_content"] = $orderSpecification["specificationcontent"];
                    }

                    $comData["status"] = $comment["status"];
                    $comData["order_id"] = $comment["order_id"];
                    $comData["commodity_id"] = $comment["commodity_id"];

                    $Images = array();
                    foreach ($comment["commentImgs"] as $img) {
                        array_push($Images, $img["image"]);
                    }
                    $comData["commentIcons"] = $Images;

                    array_push($data, $comData);
                }

            }

            return json($data);
        }
    }

}