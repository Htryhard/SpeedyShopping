<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/16
 * Time: 11:19
 */

namespace app\admin\controller;


use app\common\controller\BaseController;

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
        // 临时关闭布局
        $this->view->engine->layout(false);
        return $this->fetch();
    }

}