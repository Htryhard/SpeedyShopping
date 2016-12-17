<?php
/**
 * 商品控制器
 * User: Huan
 * Date: 2016/12/17
 * Time: 8:06
 */

namespace app\admin\controller;


use app\common\controller\BaseController;
use app\common\model\Type;

class CommodityController extends BaseController
{
    public function addCommodity(){
        $data = $this->request->param();
        if (count($data)>0){
            dump($data['commodityData']);
//            $commodityTitle = $data['title'];
//            $commodityDescribe = $data['describe'];

        }else{
            //渲染视图

            $this->assign("types",Type::all());
            return $this->fetch();
        }
    }
}