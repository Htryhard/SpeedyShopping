<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/16
 * Time: 11:19
 */

namespace app\admin\controller;


use app\common\Comm;
use app\common\controller\BaseController;
use app\common\model\User;

class UserController extends BaseController
{
    public function login()
    {
        // 临时关闭布局
        $this->view->engine->layout(false);
        return $this->fetch();
    }

    public function register()
    {
        $data = $this->request->param();
        if (count($data) > 0) {
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

            if ($user->validate(true)->save($user->getData())) {
                $user->icon = Comm::uploadsIcon($userdata['base64Icon']);
                $user->save();
                //写入默认权限
//                Comm::defaltPermission($user->getData("id"));
                return json('succeed');
            } else {
                return json($user->getError());
            }
        } else {
            //渲染视图
            // 临时关闭布局
            $this->view->engine->layout(false);
            return $this->fetch();
        }
    }

}