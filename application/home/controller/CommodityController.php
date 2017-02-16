<?php
/**
 * 前端商品控制器
 * User: Huan
 * Date: 2016/12/25
 * Time: 23:49
 */

namespace app\home\controller;


use app\common\Comm;
use app\common\model\Collect;
use app\common\model\Commodity;
use app\common\model\User;
use think\Controller;

class CommodityController extends Controller
{

    public function search()
    {
        $user = User::getUserBySession();
        $userCollects = array();
        if ($user!=null){
            $userCollects = Collect::all(['user_id'=>$user->getData('id')]);
        }
        $this->assign("userCollects",$userCollects);
        $this->assign("user",$user);
        // 获取查询信息
        $title = input('get.title');
        $pageSize = 30; // 每页显示30条数据
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
        $imgRoot = '/SpeedyShopping/public//uploads/commodity_images/';
        $this->assign("imgRoot", $imgRoot);
        $this->assign('commodities', $commodities);
        return $this->fetch();
    }

    /**
     * 前端商品明细页面
     * @param string $id
     * @return mixed|string
     */
    public function commodityDetailed($id = "")
    {
        if ($id != "") {
            $commodity = Commodity::get(['id' => $id]);
            if ($commodity != null) {
//                $commodityData = Comm::analysisCommodityForm($commodityData);
                //构造商品的图片
                $commodityImages = array();
                $commodityImageObjects = $commodity['images'];
                foreach ($commodityImageObjects as $imageObject){
                    $imgUrl = $imageObject->getData("image");
                    array_push($commodityImages,$imgUrl);
                }
                //构造商品的参数
                $commodityParameters = Comm::jsonToArr($commodity->getData("parameter"));
                $user = User::getUserBySession();
                $this->assign("user",$user);
                $this->assign("commodity",$commodity);
                $this->assign("parameters",$commodityParameters);
                $this->assign("images",$commodityImages);
                return $this->fetch();
            } else {
                return "商品不存在";
            }
        } else {
            return "没有转入指定参数";
        }
    }

}