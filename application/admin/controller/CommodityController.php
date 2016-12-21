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
use app\common\model\Type;

class CommodityController extends BaseController
{
    public function addCommodity(){
        $data = $this->request->param();
        if (count($data)>0){
            $commodityData = $data['commodityData'];
            $commodityImages = Comm::getCommodityImagesNameByForm($commodityData);
            $commodityParameters = Comm::analysisParameter($commodityData);
            $commodityData = Comm::analysisCommodityForm($commodityData);

//            echo "图片：";
//            dump($commodityImages);
//            echo "<br/>参数：";
//            dump($commodityParameters);
//            echo "<br/>商品：";
//            dump($commodityData);

//            $commodityTitle = $data['title'];
//            $commodityDescribe = $data['describe'];

        }else{
            //渲染视图
            $this->assign("types",Type::all());
            return $this->fetch();
        }
    }

    public function uploadImage(){
         $imgSuffix = $_FILES['file']['name'];
        $imgSuffix = substr($imgSuffix,strpos($imgSuffix,".")+1);
        $imageName = Comm::getNewGuid().".".$imgSuffix;
        $uploaddir = ROOT_PATH . 'public' . DS . 'uploads'.DS."cacheImages";
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
}