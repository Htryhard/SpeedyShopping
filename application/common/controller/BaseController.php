<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/16
 * Time: 10:30
 */

namespace app\common\controller;


use app\common\model\User;
use think\Controller;
use think\Request;

class BaseController extends Controller
{
    protected $request;
    public function __construct(Request $request)
    {
        parent::__construct();
        $this->request = $request;

        // 验证用户是否登陆
        if (!User::isLogin()) {
            $this->redirect(url('home/user/login'));
        }
    }

}