<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/3/17 0017
 * Time: 下午 3:49
 */

namespace app\api\controller;


use app\common\model\Type;
use think\Controller;
use think\Request;

class TypeController extends Controller
{
    public function type()
    {
        header("Cache-control:max-age=5");
        $type = Type::all();
        return json($type);
    }

    public function getCommoditiesForType()
    {
        //分类ID
        $typeId = Request::instance()->get("typeId");
        $type = Type::get(['id' => $typeId]);
        if ($type != null) {
            $commodities = $type['commodities'];
            return json($commodities);
        } else {
            return json(['error' => '还没有电影哦~'], 404);
        }

    }

}