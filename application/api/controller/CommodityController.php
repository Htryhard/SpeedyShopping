<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/3/15 0015
 * Time: 下午 2:07
 */

namespace app\api\controller;


use app\common\model\Commodity;
use think\Controller;

class CommodityController extends Controller
{
    public function getAllCommodity(){
        header("Cache-control:max-age=5");
        $commodities = Commodity::all();
        return json($commodities);
    }

    public function getCommodities(){}

}