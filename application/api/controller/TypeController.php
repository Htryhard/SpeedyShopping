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

class TypeController extends Controller
{
    public function type()
    {
        header("Cache-control:max-age=5");
        $type = Type::all();
        return json($type);
    }

}