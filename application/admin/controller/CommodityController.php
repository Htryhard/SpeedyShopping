<?php
/**
 * 商品控制器
 * User: Huan
 * Date: 2016/12/17
 * Time: 8:06
 */

namespace app\admin\controller;


use app\common\Comm;
use app\common\controller\BaseController;
use app\common\model\Commodity;
use app\common\model\CommodityImages;
use app\common\model\Type;

class CommodityController extends BaseController
{
    /**
     * 商品首页
     * @return mixed
     */
    public function index()
    {
// 获取查询信息
        $title = input('get.title');
        $pageSize = 15; // 每页显示15条数据
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
//        $this->assign("user",User::getUserBySession());
        $this->assign('commodities', $commodities);
        return $this->fetch();
    }

    /**
     * 添加商品
     * @return mixed|string
     */
    public function addCommodity()
    {
        $data = $this->request->param();
        if (count($data) > 0) {
            $commodityData = $data['commodityData'];
            $commodityImages = Comm::getCommodityImagesNameByForm($commodityData);
            $commodityParameters = Comm::analysisParameter($commodityData);
            $commodityData = Comm::analysisCommodityForm($commodityData);

            echo "图片：";
            dump($commodityImages);
            echo "<br/>参数：";
            dump($commodityParameters);
            echo "<br/>商品：";
            dump($commodityData);

            if (count($commodityImages) > 0) {
                if (count($commodityParameters) > 0) {
                    if (count($commodityData) > 0) {
                        $commodity = new Commodity();
                        $commodity->id = Comm::getNewGuid();
                        $commodity->title = $commodityData["title"];
                        $commodity->describe = $commodityData["describe"];
                        $commodity->staistics = 0;
                        $commodity->parameter = Comm::toJson($commodityParameters);
                        $commodity->creation_time = time();
                        $commodity->out_time = strtotime($commodityData["wdate"]);
                        $commodity->type_id = $commodityData["type_id"];
                        $commodity->repertory = $commodityData["repertory"];
                        $commodity->price = $commodityData["price"];
                        $commodity->grade = 0;
                        if ($commodity->validate(true)->save($commodity->getData())) {
                            foreach ($commodityImages as $image) {
                                $commodityImage = new CommodityImages();
                                $commodityImage->id = Comm::getNewGuid();
                                $commodityImage->commodity_id = $commodity->getData("id");
                                $commodityImage->image = $image;
                                $commodityImage->save();
                                $oldUrl = ROOT_PATH . 'public' . DS . 'uploads' . DS . "cacheImages" . DS . $image;
                                $newUrl = ROOT_PATH . 'public' . DS . 'uploads' . DS . "commodity_images" . DS . $image;
                                Comm::moveFile($newUrl, $oldUrl);
                            }
                        } else {
                            return $commodity->getError();
                        }
                    } else {
                        return "商品不能为空";
                    }

                } else {
                    return "参数不能为空";
                }
            } else {
                return "至少选择一张图片";
            }
        } else {
            //渲染视图
            $this->assign("types", Type::all());
            return $this->fetch();
        }
    }

    /**
     * 上传商品的图片
     * @return string
     */
    public function uploadImage()
    {
        $imgSuffix = $_FILES['file']['name'];
        $imgSuffix = substr($imgSuffix, strpos($imgSuffix, ".") + 1);
        $imageName = Comm::getNewGuid() . "." . $imgSuffix;
        $uploaddir = ROOT_PATH . 'public' . DS . 'uploads' . DS . "cacheImages";
//        if (!is_dir($uploaddir)) {
//            mkdir($uploaddir);
//        }

        if (move_uploaded_file($_FILES['file']['tmp_name'], $uploaddir . "/" . $imageName)) {
//                print "文件上传成功！这是文件的一下信息:\n";
//                print_r($_FILES);
            return $imageName;
        } else {
            print "文件上传失败啦!这里有一些信息可以帮助你去调试:\n";
            print_r($_FILES);
        }
    }

    public function commodityDetailed()
    {
        $commodityId = $this->request->param("id");
        if ($commodityId != "") {
            $commodity = Commodity::get(['id' => $commodityId]);
            if ($commodity != null) {

//                $commodityData = Comm::analysisCommodityForm($commodityData);

                //构造商品的图片
                $commodityImages = array();
                $commodityImageObjects = $commodity['image'];
                foreach ($commodityImageObjects as $imageObject){
                    $imgUrl = '/speedyshopping/public//uploads/commodity_images/' . $imageObject->getData("image");
                    array_push($commodityImages,$imgUrl);
                }

                //构造商品的参数
                $commodityParameters = Comm::jsonToArr($commodity->getData("parameter"));


                $this->assign("commodity",$commodity);
                $this->assign("parameters",$commodityParameters);
                $this->assign("image",$commodityImages);
                return $this->fetch();
            } else {
                return "商品不存在";
            }
        } else {
            return "必须传入商品的ID";
        }
    }
}