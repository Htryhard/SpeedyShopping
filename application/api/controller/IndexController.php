<?php
namespace app\api\controller;

use app\common\model\Commodity;
use app\common\model\Type;
use think\Controller;

class IndexController extends Controller
{

    public function initHome()
    {
        $data = array();
        //尽想购
        $SalesVolumeComs = array();
        $SalesVolumeCommodities = Commodity::where("states=0")->order('staistics', 'desc')->paginate(2);
        foreach ($SalesVolumeCommodities as $key => $commodity) {
            if ($key == 2) {
                break;
            }
            array_push($SalesVolumeComs, $commodity);
        }
        $data["SalesVolumeCommodities"] = $SalesVolumeComs;
        //有好货
        $NewsComs = array();
        $NewsCommodities = Commodity::where("states=0")->order('creation_time', 'desc')->paginate(2);
        foreach ($NewsCommodities as $key => $commodity) {
            if ($key == 2) {
                break;
            }
            array_push($NewsComs, $commodity);
        }
        $data["NewsCommodities"] = $NewsComs;
        //爱逛街
        //暂时写死
        $type = Type::get(['id' => "A2AF9D4A-D613-0A44-353C-F015BB16F24A"]);
        $comArr = array();
        if ($type != null) {
            $commodities = $type['commodities'];
            foreach ($commodities as $key => $commodity) {
                if ($key == 2) {
                    break;
                }
                array_push($comArr, $commodity);
            }
        }
        $data["LifeSupermarket"] = $comArr;
        //必买清单
        $RecommendComs = array();
        $RecommendCommodities = Commodity::where("states=0")->order('grade', 'desc')->paginate(2);
        foreach ($RecommendCommodities as $key => $commodity) {
            if ($key == 2) {
                break;
            }
            array_push($RecommendComs, $commodity);
        }
        $data["RecommendCommodities"] = $RecommendComs;

        return json($data);
    }

}
