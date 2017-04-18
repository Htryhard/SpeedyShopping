<?php
/**
 * 用户管理控制器
 * User: Huan
 * Date: 2016/12/16
 * Time: 11:19
 */

namespace app\admin\controller;


use app\common\Comm;
use app\common\controller\BaseController;
use app\common\model\AuthGroup;
use app\common\model\Cart;
use app\common\model\User;
use think\Controller;
use think\Request;

class UserController extends Controller
{
    public function logOut()
    {
        if (User::isLogin("admin")) {
//            $user = User::getUserBySession("admin");
            User::logOut("admin");
            $this->redirect("admin/user/login");
        } else {
            return $this->error("用户未登录！");
        }
    }

    public function index()
    {
        // 获取查询信息
        $email = input('get.email');
        $pageSize = 15; // 每页显示15条数据
        $user = new User();
        // 定制查询信息
        if (!empty($email)) {
            $users = $user->where('email', 'like', '%' . $email . '%')->paginate($pageSize, false,
                [
                    'query' => [
                        'email' => $email,
                    ],
                ]);
        } else {
            $users = $user->paginate($pageSize);
        }
        $this->assign("user", User::getUserBySession("admin"));
        $this->assign("users", $users);
        return $this->fetch();
    }

    public function login()
    {
        // 临时关闭布局
        $this->view->engine->layout(false);
        return $this->fetch();
    }

    public function loginHandle()
    {
        // 接收post信息
        $data = Request::instance()->post();
        // 直接调用M层方法，进行登录。
        if (User::login($data['email'], $data['password'], "admin")) {
            return json("succeed");
        } else {
            return json('TheUserNameOrPasswordError');
        }
    }

    public function register()
    {
        $data = Request::instance()->param();
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
            $user->creation_time = time();
            $auth = AuthGroup::get(["rules" => "administrator"]);
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
            //渲染视图
            // 临时关闭布局
            $this->view->engine->layout(false);
            //只有管理员才能添加管理员，所以，必须传一个管理员过去
            $this->assign("user", User::getUserBySession("admin"));
            return $this->fetch();
        }
    }

    public function userMesg($userId)
    {
        $editUser = User::get(["id" => $userId]);
        if ($editUser != null) {
            $user = User::getUserBySession("admin");
            $this->assign("user", $user);
            $this->assign("editUser", $editUser);
            $iconRoot = "/SpeedyShopping/public//uploads/icon_images/";
            $this->assign("iconRoot", $iconRoot);
            return $this->fetch();
        } else {
            return $this->redirect(url("home/error/postError?code=404&msg=用户未找的到！！"));
        }
    }

    //修改个人信息
    public function userMesgHandle()
    {
        if ($this->request->isAjax()) {
            $data = $this->request->param();
            $imgBase64 = $data["imgBase64"];
            $data = $data["userdata"];
            if ($imgBase64 != "") {
//                $user = User::getUserBySession("admin");
                $userdata = array();
                foreach ($data as $item) {
                    $userdata += [$item['name'] => $item['value']];
                }
//                var_dump($userdata);

//                $email = $userdata['email'];
                $username = $userdata['name'];
                $password = $userdata['password'];
                $phone = $userdata['phone'];

                $nickName = $userdata['nick_name'];
                $sbasb = $userdata['sbasb'];
                $userId = $userdata['userId'];
                $user = User::get(["id" => $userId]);
                if ($user == null) {
                    //上传失败
                    return "UploadsError";
                }
//                $user->email = $email;
                $user->user_name = $username;
                if ($password != "") {
                    $user->password = User::encryptPassword($password);
                }
                $user->phone = $phone;
                $user->nick_name = $nickName;
                $user->sbasb = $sbasb;
                $user->save();

                $userNewIconName = Comm::uploadsIcon($imgBase64);
                if ($userNewIconName == false) {
                    //上传失败
                    return "UploadsError";
                } else {
                    $oldUrl = ROOT_PATH . 'public' . DS . 'uploads' . DS . "icon_images" . DS . $user->getData('icon');
                    $user->icon = $userNewIconName;
                    $user->save();
                    //删除旧的头像
                    unlink($oldUrl);
                    return "success";
                }
            } else {
                //参数不正确
                return "ParameterError";
            }
        } else {
            //请求方式错误
            return "PostError";
        }
    }

}