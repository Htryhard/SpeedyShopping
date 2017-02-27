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
use app\common\model\Count;
use app\common\model\Specification;
use app\common\model\Type;
use app\common\model\User;

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
            $commodities = $commodity->where('title', 'like', '%' . $title . '%')->order('creation_time','desc')->paginate($pageSize, false,
                [
                    'query' => [
                        'title' => $title,
                    ],
                ]);
        } else {
            $commodities = $commodity->order('creation_time','desc')->paginate($pageSize);
        }
        $this->assign("user",User::getUserBySession("admin"));
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
            $commoditySpecifications = Comm::getCommoditySpecificationsByForm($commodityData);
            $commodityImages = Comm::getCommodityImagesNameByForm($commodityData);
            $commodityParameters = Comm::analysisParameter($commodityData);
            $commodityData = Comm::analysisCommodityForm($commodityData);

//            echo "图片：";
//            dump($commodityImages);
//            echo "<br/>参数：";
//            dump($commodityParameters);
//            echo "<br/>规格：";
//            dump($commoditySpecifications);
//            echo "<br/>商品：";
//            dump($commodityData);

            if (count($commodityImages) > 0) {
                if (count($commodityParameters) > 0) {
                    if (count($commodityData) > 0) {
                        if (count($commoditySpecifications)>0) {
                            $commodity = new Commodity();
                            $commodity->id = Comm::getNewGuid();
                            $commodity->title = $commodityData["title"];
                            $commodity->describe = $commodityData["describe"];
                            $commodity->staistics = 0;
                            $commodity->parameter = Comm::toJson($commodityParameters);
                            $commodity->creation_time = time();
                            $commodity->out_time = strtotime($commodityData["wdate"]);
                            $commodity->type_id = $commodityData["type_id"];
                            $commodity->grade = 0;
                            $commodity->states = 0;//0代表没上架
                            if ($commodity->validate(true)->save($commodity->getData())) {
                                //此循环是保存商品的图片
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
                                //此循环是保存商品的规格
                                foreach ($commoditySpecifications as $specificationItem) {
                                    $specification = new Specification();
                                    $specification->id = Comm::getNewGuid();
                                    $specification->content = $specificationItem[0];
                                    $specification->repertory = $specificationItem[1];
                                    $specification->price = $specificationItem[2];
                                    $specification->commodity_id = $commodity->getData("id");
                                    if (!$specification->validate(true)->save($specification->getData())) {
                                        return $specification->getError();
                                    }
                                }
                            } else {
                                return $commodity->getError();
                            }
                        } else {
                            return "至少添加一组商品规格";
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
            $this->assign("user",User::getUserBySession("admin"));
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

    /**
     * 商品明细页面
     * @return mixed|string
     */
    public function commodityDetailed()
    {
        $commodityId = $this->request->param("id");
        if ($commodityId != "") {
            $commodity = Commodity::get(['id' => $commodityId]);
            if ($commodity != null) {

//                $commodityData = Comm::analysisCommodityForm($commodityData);

                //构造商品的图片
                $commodityImages = array();
                $commodityImageObjects = $commodity['images'];
                foreach ($commodityImageObjects as $imageObject) {
                    $imgUrl = '/SpeedyShopping/public//uploads/commodity_images/' . $imageObject->getData("image");
                    array_push($commodityImages, $imgUrl);
                }

                //构造商品的参数
                $commodityParameters = Comm::jsonToArr($commodity->getData("parameter"));
                $this->assign("user",User::getUserBySession("admin"));
                $this->assign("commodity", $commodity);
                $this->assign("parameters", $commodityParameters);
                $this->assign("images", $commodityImages);
                return $this->fetch();
            } else {
                return "商品不存在";
            }
        } else {
            return "必须传入商品的ID";
        }
    }

    public function editCommodity()
    {
        $commodityId = $this->request->param("id");
        if ($commodityId != "") {
            $commodity = Commodity::get(['id' => $commodityId]);
            if ($commodity != null) {
                //构造商品的图片
                $commodityImages = array();
                $commodityImageObjects = $commodity['images'];
                foreach ($commodityImageObjects as $imageObject) {
                    $imgUrl = '/SpeedyShopping/public//uploads/commodity_images/' . $imageObject->getData("image");
                    array_push($commodityImages, $imgUrl);
                }

                //构造商品的参数
                $commodityParameters = Comm::jsonToArr($commodity->getData("parameter"));
                $this->assign("user",User::getUserBySession("admin"));
                $this->assign("types", Type::all());
                $this->assign("commodity", $commodity);
                $this->assign("parameters", $commodityParameters);
                $this->assign("images", $commodityImages);
                return $this->fetch();
            } else {
                return "商品不存在";
            }
        } else {
            return "必须传入商品的ID";
        }
    }

    public function editCommodityHandle()
    {
        $commodityId = $this->request->param("id");
        $data = $this->request->param();
        if ($commodityId != "") {
            $commodity = Commodity::get(['id' => $commodityId]);
            if ($commodity != null) {
                //构造商品的图片
                $commodityData = $data['commodityData'];
                $commoditySpecifications = Comm::getCommoditySpecificationsByForm($commodityData);
                $commodityImages = Comm::getCommodityImagesNameByForm($commodityData);
                $commodityParameters = Comm::analysisParameter($commodityData);
                $commodityData = Comm::analysisCommodityForm($commodityData);

                echo "图片：";
                dump($commodityImages);
//                echo "<br/>参数：";
//                dump($commodityParameters);
//                echo "<br/>商品：";
//                dump($commodityData);

                $commodity->title = $commodityData["title"];
                $commodity->describe = $commodityData["describe"];
                $commodity->out_time = strtotime($commodityData["wdate"]);
                $commodity->type_id = $commodityData["type_id"];
                $commodity->parameter = Comm::toJson($commodityParameters);

                if ($commodity->validate(true)->save($commodity->getData())) {
                    if ($commodityImages[0] != ""){
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
                    }
                    foreach ($commodity['specifications'] as $item){
                        $item->delete();
                    }
                    //此循环是保存商品新的规格
                    foreach ($commoditySpecifications as $specificationItem) {
                        $specification = new Specification();
                        $specification->id = Comm::getNewGuid();
                        $specification->content = $specificationItem[0];
                        $specification->repertory = $specificationItem[1];
                        $specification->price = $specificationItem[2];
                        $specification->commodity_id = $commodity->getData("id");
                        if (!$specification->validate(true)->save($specification->getData())) {
                            return $specification->getError();
                        }
                    }
                } else {
                    return $commodity->getError();
                }

            } else {
                return "商品不存在";
            }
        } else {
            return "必须传入商品的ID";
        }
    }

    public function deleteImg()
    {
        $imgUrl = $this->request->post("imgUrl");
        if ($imgUrl != "") {
            $imgName = str_replace("/", "", strrchr($imgUrl, "/"));
            $img = ROOT_PATH . 'public' . DS . 'uploads' . DS . "commodity_images" . DS . $imgName;
            $commodityImg = CommodityImages::get(["image" => $imgName]);
            $commodityImg->delete();
            if (unlink($img)) {
                return json('Success');
            } else {
                return json('fail');
            }
        } else {
            return json("url null");
        }
    }

}
