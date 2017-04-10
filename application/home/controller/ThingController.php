<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2017/1/8
 * Time: 9:01
 */

namespace app\home\controller;


use app\common\Comm;
use app\common\controller\BaseController;
use app\common\model\AuthGroup;
use app\common\model\Cart;
use app\common\model\Commodity;
use app\common\model\Count;
use app\common\model\User;
use think\Controller;
use think\Request;

class ThingController extends Controller
{

    public function showIP()
    {
        $counts = Count::where("id", ">", 0)->paginate(15);
        $this->assign("counts", $counts);
        return $this->fetch();
    }

    public function register()
    {
        $this->assign("user", User::getUserBySession("home"));
        return $this->fetch();
    }

    public function registerHandle()
    {

        if ($this->request->isAjax()) {
            $data = Request::instance()->param();
            $data = $data['userdata'];
            $userdata = array();
            foreach ($data as $item) {
                $userdata += [$item['name'] => $item['value']];
            }
            $email = $userdata['email'];
            $username = $userdata['name'];
            $password = $userdata['password'];
            $password2 = $userdata['password2'];
            $phone = $userdata['phone'];
            //验证邮箱是否唯一
            $flga = Comm::getUserByEmail($email);
            if ($flga != null) {
                //邮箱是否重复
                return json('repetition');
            }
            //验证密码
            if (!User::passwordFit($password, $password2)) {
                return json('passwordNoFit');
            }
            //验证必填信息
            $user = new User();

            $user->id = Comm::getNewGuid();
            $user->email = $email;
            $user->user_name = $username;
            $user->password = User::encryptPassword($password);
            $user->phone = $phone;
            $auth = AuthGroup::get(["rules" => "user"]);
            $user->role_id = $auth->getData("id");

            if ($user->validate(true)->save($user->getData())) {
                $user->icon = Comm::uploadsIcon($userdata['base64Icon']);
                $user->save();
                //为用户创建一个空的购物车待用
                $cart = new Cart();
                $cart->id = Comm::getNewGuid();
                $cart->user_id = $user->getData('id');
                $cart->save();
                //写入默认权限
//                Comm::defaltPermission($user->getData("id"));
                return json('succeed');
            } else {
                return json($user->getError());
            }
        } else {
            return json('error_notAjax');
        }
    }

    public function login()
    {
        $this->assign("user", User::getUserBySession("home"));
        return $this->fetch();
    }

    public function loginHandle()
    {
        // 接收post信息
        $data = Request::instance()->post();
        // 直接调用M层方法，进行登录。
        if (User::login($data['email'], $data['password'], "home")) {
            return json("succeed");
        } else {
            return json('TheUserNameOrPasswordError');
        }
    }

}