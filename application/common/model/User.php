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
        return $this->hasMany('order','user_id','id');
    }

    /**
     * 用户关联地址
     * @return \think\model\Relation
     */
    public function address()
    {
        return $this->hasMany('address','user_id','id');
    }

    /**
     * 判断用户是否已登录
     * @return boolean 已登录true
     * @author  Huan
     */
    static public function isLogin()
    {
        $userid= session('email');
        // isset()和is_null()是一对反义词
        if (isset($userid)) {
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
    static public function logOut()
    {
        // 销毁session中数据
        session('email', null);
        return true;
    }

    /**
     * 用户登录
     * @param  string $email 邮箱
     * @param  string $password 密码
     * @return bool    成功返回true，失败返回false。
     */
    static public function login($email, $password)
    {
        // 验证用户是否存在
        $map = array('email' => $email);
        $user = self::get($map);

        if (!is_null($user)) {
            // 验证密码是否正确
            if ($user->checkPassword($password)) {
                // 登录
                session('email',$user->getData('email'));
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
        return $this->getData('password')==$this::encryptPassword($password) ? true : false;
    }

    /**
     * 密码加密算法
     * @param    string  $password 加密前密码
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
    static public function passwordFit($pw1,$pw2){
        return $pw1===$pw2 ? true:false;
    }
    /**
     * 从session中获取一个用户
     * @return null|static
     */
    public static function getUserBySession(){
        if (self::isLogin()){
            $userEmail = session("email");
            $user = Comm::getUserByEmail($userEmail);
            return $user;
        }else{
            return null;
        }
    }

}