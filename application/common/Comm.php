<?php
/**
 * Created by PhpStorm.
 * Date: 2016/9/25
 * Time: 17:48
 * 功能：
 */
namespace app\common;

use app\common\model\Specification;
use app\common\model\User;

class Comm
{


    /**
     * 根据安卓端协商好协议，传上来的specificationIds格式为：
     * specificationId1,count1;specificationId2,count2;...
     * 检查库存量，如果库存少于用户购买的数量，则返回库存不足的商品，如果都满足用户购买的数量，则返回null
     * @param $specificationIds
     * @return null
     */
    public static function checkRepertory($specificationIds)
    {
        $commodity = null;
        $specificationIdAndCount = explode(';', $specificationIds);
        array_pop($specificationIdAndCount);
        $len = count($specificationIdAndCount);
        for ($i = 0; $i < $len; $i++) {
            $spIdAndCouns = $specificationIdAndCount[$i];
            $spIdAndCouns = explode(",", $spIdAndCouns);
            $specificationId = $spIdAndCouns[0];
            $specification = Specification::get(["id" => $specificationId]);
            //检查库存
            if ($specification->getData("repertory") < $spIdAndCouns[1]) {
                $commodity = $specification['commodity'];
                break;
            }
        }

        return $commodity;
    }

    /**
     * 与安卓端协商好协议，传上来的specificationIds格式为：
     * specificationId1,count1;specificationId2,count2;...
     * 其中specificationId为规格ID
     * count为用户购买的数量
     * 服务端要针对此进行解析
     *
     * 此解析函数返回的是一个一维数组，数组的键既是规格ID，
     * 数组的值是购买此商品规格的数量
     *
     * 如果解析出错则返回空数组
     * @param $specificationIds
     * @return array
     */
    public static function analysisApiOrder($specificationIds)
    {
        $spIdAndCountArray = array();
        $specificationIdAndCount = explode(';', $specificationIds);
        array_pop($specificationIdAndCount);
        $len = count($specificationIdAndCount);
        for ($i = 0; $i < $len; $i++) {
            $spIdAndCouns = $specificationIdAndCount[$i];
            $spIdAndCouns = explode(",", $spIdAndCouns);
            $spIdAndCountArray += [$spIdAndCouns[0] => $spIdAndCouns[1]];
        }
        return $spIdAndCountArray;
    }

    //获取访问IP
    public static function getClientIP()
    {
//        global $ip;
//        if (getenv("HTTP_CLIENT_IP"))
//            $ip = getenv("HTTP_CLIENT_IP");
//        else if(getenv("HTTP_X_FORWARDED_FOR"))
//            $ip = getenv("HTTP_X_FORWARDED_FOR");
//        else if(getenv("REMOTE_ADDR"))
//            $ip = getenv("REMOTE_ADDR");
//        else $ip = "Unknow";
//        return $ip;
        if (@$_SERVER["HTTP_X_FORWARDED_FOR"])
            $ip = $_SERVER["HTTP_X_FORWARDED_FOR"];
        else if (@$_SERVER["HTTP_CLIENT_IP"])
            $ip = $_SERVER["HTTP_CLIENT_IP"];
        else if (@$_SERVER["REMOTE_ADDR"])
            $ip = $_SERVER["REMOTE_ADDR"];
        else if (@getenv("HTTP_X_FORWARDED_FOR"))
            $ip = getenv("HTTP_X_FORWARDED_FOR");
        else if (@getenv("HTTP_CLIENT_IP"))
            $ip = getenv("HTTP_CLIENT_IP");
        else if (@getenv("REMOTE_ADDR"))
            $ip = getenv("REMOTE_ADDR");
        else
            $ip = "Unknown";
        return $ip;
    }

    /**
     * 图片上传,返回保存的文件名
     * @param $file
     * @return string
     */
    public static function uploads($file)
    {

        $info = $file->rule('uniqid')->move(ROOT_PATH . 'public' . DS . 'uploads' . DS . 'film');
        if ($info) {
//            $this->success('文件上传成功：' . $info->getRealPath());
            return $info->getSaveName();
        } else {
            // 上传失败获取错误信息
//            $this->error($file->getError());
            return 'no';
        }
    }

    /**
     * 上传头像
     * @param $base64Icon
     * @return bool|string
     */
    public static function uploadsIcon($base64Icon)
    {
        //获取扩展名和文件名
        if (preg_match('/(?<=\/)[^\/]+(?=\;)/', $base64Icon, $pregR))
            $streamFileType = '.' . $pregR[0];
        //读取扩展名，如果你的程序仅限于画板上来的，那一定是png，这句可以直接streamFileType 赋值png
        //产生一个随机文件名（因为你base64上来肯定没有文件名，这里你可以自己设置一个也行）
        $streamFileRand = date('YmdHis') . rand(1000, 9999);
        $streamFilename = ROOT_PATH . "/public/uploads/icon_images/" . $streamFileRand . $streamFileType;
        //存入数据库的位置
        $path = $streamFileRand . $streamFileType;
        //处理base64文本，用正则把第一个base64,之前的部分砍掉
        preg_match('/(?<=base64,)[\S|\s]+/', $base64Icon, $streamForW);
        if (file_put_contents($streamFilename, base64_decode($streamForW[0])) === false) {
//                //这是我自己的一个静态类，输出错误信息的，你可以换成你的程序
//                Common::exitWithError("文件写入失败!","");
            return false;
        } else {
            return $path;
        }

    }

    /**
     * api上传头像的方式
     * @param $base64Icon
     * @return bool|string
     */
    public static function uploadsIconForAPI($base64Icon)
    {
        $streamFileType = ".png";
        //产生一个随机文件名（因为你base64上来肯定没有文件名，这里你可以自己设置一个也行）
        $streamFileRand = date('YmdHis') . rand(1000, 9999);
        $streamFilename = ROOT_PATH . "/public/uploads/icon_images/" . $streamFileRand . $streamFileType;
        //存入数据库的位置
        $path = $streamFileRand . $streamFileType;

        //处理base64文本
        if (file_put_contents($streamFilename, base64_decode($base64Icon)) === false) {
//                //这是我自己的一个静态类，输出错误信息的，你可以换成你的程序
//                Common::exitWithError("文件写入失败!","");
            return false;
        } else {
            return $path;
        }

    }


    /**
     * @author 陈有欢
     * @param $base64Img
     * @param $uppath 指定上传到的位置 例：uploads/icon_images/
     * @return bool|string
     */
    public static function uploadsCommentImg($base64Img, $uppath)
    {
        //获取扩展名和文件名
//        if (preg_match('/(?<=\/)[^\/]+(?=\;)/', $base64Img, $pregR))
//            $streamFileType = '.' . $pregR[0];
        $streamFileType = substr($base64Img, 0, stripos($base64Img, ";"));
        $streamFileType = "." . substr($streamFileType, 11);
        //读取扩展名，如果于画板上来的，那一定是png，这句可以直接streamFileType 赋值png
        //产生一个随机文件名（因为你base64上来肯定没有文件名，这里你可以自己设置一个也行）
//        $streamFileRand = date('YmdHis') . rand(1000, 9999);
        $streamFileRand = Comm::getNewGuid();
        $streamFilename = ROOT_PATH . "/public/" . $uppath . $streamFileRand . $streamFileType;
        //存入数据库的位置
        $path = $streamFileRand . $streamFileType;
        //处理base64文本，用正则把第一个base64,之前的部分砍掉
//        preg_match('/(?<=base64,)[\S|\s]+/', $base64Img, $streamForW);
        $streamForW = substr($base64Img, stripos($base64Img, ",") + 1);
        if (file_put_contents($streamFilename, base64_decode($streamForW)) === false) {
//                //输出错误信息的
//                Common::exitWithError("文件写入失败!","");
            return false;
        } else {
            return $path;
        }

    }

    /**
     * api上传评论图片的方式
     * @param $base64Icon
     * @return bool|string
     */
    public static function uploadsCommentImgsForAPI($base64Icon)
    {
        $streamFileType = ".png";
        //产生一个随机文件名（因为你base64上来肯定没有文件名，这里你可以自己设置一个也行）
        $streamFileRand = Comm::getNewGuid();
        $streamFilename = ROOT_PATH . "/public/uploads/comment_images/" . $streamFileRand . $streamFileType;
        //存入数据库的位置
        $path = $streamFileRand . $streamFileType;

        //处理base64文本
        if (file_put_contents($streamFilename, base64_decode($base64Icon)) === false) {
//                //这是我自己的一个静态类，输出错误信息的，你可以换成你的程序
//                Common::exitWithError("文件写入失败!","");
            return false;
        } else {
            return $path;
        }

    }

    /**
     * 获取一个用户的base64头像
     * @return string
     */
    public static function getUserIcon($model)
    {
        $user = User::getUserBySession($model);
        $type = getimagesize(ROOT_PATH . $user->getData("icon"));//取得图片的大小，类型等
//        dump($type);
        $fp = fopen(ROOT_PATH . $user->getData("icon"), "r") or die("Can't open file");
        $file_content = chunk_split(base64_encode(fread($fp, filesize(ROOT_PATH . $user->getData("icon")))));//base64编码
        switch ($type[2]) {//判读图片类型
            case 1:
                $img_type = "gif";
                break;
            case 2:
                $img_type = "jpg";
                break;
            case 3:
                $img_type = "png";
                break;
        }
        $img = 'data:image/' . $img_type . ';base64,' . $file_content;//合成图片的base64编码
        fclose($fp);
        return $img;
    }

    /**
     * 把表单里的二维数字转换为一维数组
     * @param $arr
     * @return array|null
     */
    public static function arrayConvert($arr)
    {
        if (count($arr) > 0) {
            $result = array();
            foreach ($arr as $item) {
                $result += [$item['name'] => $item['value']];
            }
            return $result;
        } else {
            return null;
        }
    }

    /**
     * 根据邮箱获取一个用户
     * @param $email
     * @return $user
     */
    public static function getUserByEmail($email)
    {
        if ($email == "") {
            return null;
        }
        $user = User::get(['email' => $email]);
        return $user;
    }

    /**
     * 获取一个sortid
     */
    public static function getSortId($model)
    {
        $m = D($model);
        $mdata = $m->select();
        $maxSortid = 0;
        if (count($mdata) > 0) {
            foreach ($mdata as $item) {
                if ($item['sortid'] > $maxSortid) {
                    $maxSortid = $item['sortid'];
                }
            }
            $maxSortid += 1;
            return $maxSortid;
        } else {
            return $maxSortid;
        }
    }

    /**
     * 生成一个GUID
     */
    public static function getNewGuid()
    {
        mt_srand((double)microtime() * 10000);
        $charid = strtoupper(md5(uniqid(mt_rand(), true)));
        $hyphen = chr(45);// "-"
//        $uuid = chr(123)// "{"
//            . substr($charid, 0, 8) . $hyphen
//            . substr($charid, 8, 4) . $hyphen
//            . substr($charid, 12, 4) . $hyphen
//            . substr($charid, 16, 4) . $hyphen
//            . substr($charid, 20, 12)
//            . chr(125);// "}"
        $uuid =
            substr($charid, 0, 8) . $hyphen
            . substr($charid, 8, 4) . $hyphen
            . substr($charid, 12, 4) . $hyphen
            . substr($charid, 16, 4) . $hyphen
            . substr($charid, 20, 12);
        return $uuid;

    }

    /**
     * 获取唯一编号
     */
    static function getNumber()
    {
        static $i = -1;
        $i++;
        $a = substr(date('YmdHis'), -12, 12);
        $b = sprintf("%02d", $i);
        if ($b >= 100) {
            $a += $b;
            $b = substr($b, -2, 2);
        }
        return $a . $b;
    }

    /**
     * 解析商品表单从而获取商品的参数
     * @param $arr
     * @return array
     */
    public static function analysisParameter($arr)
    {
        $parameterName = array();
        $parameterValue = array();
        $paramet = array();
        foreach ($arr as $item) {
            if ($item["name"] == "parameterName") {
//                $parameterName += [$item['value']];
                array_push($parameterName, $item['value']);
            }

            if ($item["name"] == "parameterValue") {
//                $parameterValue += [$item['value']];
                array_push($parameterValue, $item['value']);
            }
        }
        $parametLen = count($parameterName);
        for ($i = 0; $i < $parametLen; $i++) {
            $paramet += [$parameterName[$i] => $parameterValue[$i]];
//            $paramet[$parameterName[$i]] = [$parameterValue[$i]];
        }
        return $paramet;
    }

    /**
     * 根据商品表单  从中解析出商品的规格
     * @param $arr
     * @return array
     */
    public static function getCommoditySpecificationsByForm($arr)
    {
        $specificationContent = array();
        $specificationRepertory = array();
        $specificationPrice = array();
        $specifications = array();
        foreach ($arr as $item) {
            if ($item["name"] == "specificationContent") {
                array_push($specificationContent, $item['value']);
            }

            if ($item["name"] == "specificationRepertory") {
                array_push($specificationRepertory, $item['value']);
            }

            if ($item["name"] == "specificationPrice") {
                array_push($specificationPrice, $item['value']);
            }
        }
        $specificationLen = count($specificationContent);
        for ($i = 0; $i < $specificationLen; $i++) {
            $cachearr = array();
            array_push($cachearr, $specificationContent[$i]);
            array_push($cachearr, $specificationRepertory[$i]);
            array_push($cachearr, $specificationPrice[$i]);
            $specifications += [$i => $cachearr];
        }
        return $specifications;
    }

    /**
     * 解析商品表单，商品表单数据格式不规则，需要单独解析
     * @param $arr
     * @return array|null
     */
    public static function analysisCommodityForm($arr)
    {
        if (count($arr) > 0) {
            $result = array();
            foreach ($arr as $item) {
                if ($item["name"] == "parameterValue" || $item["name"] == "parameterName"
                    || $item["name"] == "dirname" || $item["name"] == "specificationContent"
                    || $item["name"] == "specificationRepertory" || $item["name"] == "specificationPrice"
                ) {
                    continue;
                }
                $result += [$item['name'] => $item['value']];
            }
            return $result;
        } else {
            return null;
        }
    }

    /**从商品表单中解析出图片的名称
     * @param $arr
     * @return array|null
     */
    public static function getCommodityImagesNameByForm($arr)
    {
        if (count($arr) > 0) {
            $result = array();
            $imgStr = "";
            foreach ($arr as $item) {
                if ($item["name"] == "dirname" && $item['value'] != "") {
                    $imgStr = $item['value'];
                    $imgStr = substr($imgStr, 1);
//                    array_push($result,$item['value']);
                    break;
                }
            }
            $result = explode(";", $imgStr);
            return $result;
        } else {
            return null;
        }
    }

    /**把一个数组进行json编码
     * @param $arr
     * @return string
     */
    public static function toJson($arr)
    {
        return json_encode($arr);
    }

    /**把一个json字符串转换成数组
     * @param $json
     * @return mixed
     */
    public static function jsonToArr($json)
    {
        return json_decode($json, true);
    }

    /**
     * @param $newUrl 新路径（全路径）
     * @param $oldUrl 旧路径（全路径）
     * @return bool 成功返回真，失败返回假
     */
    public static function moveFile($newUrl, $oldUrl)
    {
        copy($oldUrl, $newUrl); //拷贝到新目录
        return unlink($oldUrl); //删除旧目录下的文件
    }

}