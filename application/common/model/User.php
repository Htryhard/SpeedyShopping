<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/16
 * Time: 10:22
 */

namespace app\common\model;

use app\common\Comm;
use think\Model;

class User extends Model
{
    public function orders()
    {
        return $this->hasMany('order', 'user_id', 'id');
    }

    public function cart()
    {
        return $this->belongsTo('cart');
    }

    /**
     * 用户关联地址
     * @return \think\model\Relation
     */
    public function address()
    {
        return $this->hasMany('address', 'user_id', 'id');
    }

    /**
     * 判断用户是否已登录
     * @param  string $model
     * @return boolean 已登录true
     * @author  Huan
     */
    static public function isLogin($model)
    {
        $userEmail = null;
        // 销毁session中数据
        if ($model == "home") {
            $userEmail = session("HomeEmail201612161528083417", '', $model);
        } elseif ($model == "admin") {
            $userEmail = session("AdminEmail201612161528083417", '', $model);
        }

        // isset()和is_null()是一对反义词
        if ($userEmail != null) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 注销
     * @return bool  成功true，失败false。
     * @author huan
     */
    static public function logOut($model)
    {
        // 销毁session中数据
        if ($model == "home") {
            session('HomeEmail201612161528083417', null, $model);
        } elseif ($model == "admin") {
            session('AdminEmail201612161528083417', null, $model);
        }
        return true;
    }

    /**
     * 用户登录
     * @param  string $email 邮箱
     * @param  string $password 密码
     * @param  string $modle 生效模块
     * @return bool    成功返回true，失败返回false。
     */
    static public function login($email, $password, $modle)
    {
        // 验证用户是否存在
        $map = array('email' => $email);
        $user = self::get($map);

        if (!is_null($user)) {
            // 验证密码是否正确
            if ($user->checkPassword($password)) {
                if ($modle == "home") {
                    // 前台登录
                    session('HomeEmail201612161528083417', $user->getData('email'), $modle);
                } elseif ($modle == "admin") {
                    // 后台登录
                    session('AdminEmail201612161528083417', $user->getData('email'), $modle);
                }
                return true;
            }
        }
        return false;
    }

    /**
     * 验证密码是否正确
     * @param  string $password 密码
     * @return bool
     */
    public function checkPassword($password)
    {
        return $this->getData('password') == $this::encryptPassword($password) ? true : false;
    }

    /**
     * 密码加密算法
     * @param    string $password 加密前密码
     * @return   string  加密后密码
     * @author Huan
     * @DateTime 2016-10-21T09:26:18+0800
     */
    static public function encryptPassword($password)
    {
        // 实际的过程中，我还还可以借助其它字符串算法，来实现不同的加密。
        return sha1(md5($password) . 'chenyouhuan');
    }

    /**
     * 验证两次密码是否相同
     * @param $pw1
     * @param $pw2
     * @return bool
     */
    static public function passwordFit($pw1, $pw2)
    {
        return $pw1 === $pw2 ? true : false;
    }

    /**
     * @param $model 生效模块
     * 从session中获取一个用户
     * @return null|static
     */
    public static function getUserBySession($model)
    {
        if (self::isLogin($model)) {
            $userEmail = "";
            if ($model == "home") {
                $userEmail = session("HomeEmail201612161528083417", '', $model);
            } elseif ($model == "admin") {
                $userEmail = session("AdminEmail201612161528083417", '', $model);
            }
            $user = Comm::getUserByEmail($userEmail);
            return $user;
        } else {
            return null;
        }
    }

}