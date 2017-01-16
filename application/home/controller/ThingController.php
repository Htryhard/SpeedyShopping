<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2017/1/8
 * Time: 9:01
 */

namespace app\home\controller;


use app\common\controller\BaseController;
use app\common\model\Commodity;

class ThingController extends BaseController
{

    public function addCart($commodityId,$type){
        $commodity = Commodity::get(['id'=>$commodityId]);
        if ($commodity != null){
            if ($type==""){

            }
        }else{
            return json(404);
        }
    }

}