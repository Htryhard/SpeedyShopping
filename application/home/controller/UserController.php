<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/23
 * Time: 11:19
 */

namespace app\home\controller;


use app\common\controller\BaseController;

class UserController extends BaseController
{
    public function register()
    {
        return $this->fetch();
    }

    public function login()
    {
        return $this->fetch();
    }

}