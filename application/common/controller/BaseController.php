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

        $modle = $request->module();
        $modle = strtolower($modle);
        // 验证用户是否登陆
        if (!$this->request->isAjax()){
            if (!User::isLogin($modle)) {
                if ($modle=="admin"){
                    $this->redirect(url('admin/user/login'));
                }elseif($modle=="home"){
                    $this->redirect(url('home/thing/login'));
                }else{
                    return $this->error("请求的页面不存在！");
                }
            }
        }
    }

}