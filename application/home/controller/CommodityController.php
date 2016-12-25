<?php
/**
 * 前端商品控制器
 * User: Huan
 * Date: 2016/12/25
 * Time: 23:49
 */

namespace app\home\controller;


use app\common\controller\BaseController;
use app\common\model\Commodity;

class CommodityController extends BaseController
{

    public function search(){
        $title = $this->request->param();
        // 获取查询信息
        $title = input('get.title');
        $pageSize = 30; // 每页显示15条数据
        $commodity = new Commodity();
        // 定制查询信息
        if (!empty($title)) {
            $commodities = $commodity->where('title', 'like', '%' . $title . '%')->paginate($pageSize, false,
                [
                    'query' => [
                        'title' => $title,
                    ],
                ]);
        } else {
            $commodities = $commodity->paginate($pageSize);
        }
        $imgRoot = '/speedyshopping/public//uploads/commodity_images/';
        $this->assign("imgRoot",$imgRoot);
        $this->assign('commodities', $commodities);
        return $this->fetch();
    }

}