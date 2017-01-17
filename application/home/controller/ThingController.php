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
use app\common\model\User;
use think\Controller;
use think\Request;

class ThingController extends Controller
{

    public function register()
    {
        $this->assign("user",User::getUserBySession());
        return $this->fetch();
    }

    public function login()
    {
        $this->assign("user",User::getUserBySession());
        return $this->fetch();
    }

    public function loginHandle()
    {
        // 接收post信息
        $data = Request::instance()->post();
        // 直接调用M层方法，进行登录。
        if (User::login($data['email'], $data['password'])) {
            return json("succeed");
        } else {
            return json('TheUserNameOrPasswordError');
        }
    }

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