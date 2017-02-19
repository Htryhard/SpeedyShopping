<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/16
 * Time: 10:30
 */

namespace app\common\controller;


use app\common\Comm;
use app\common\model\Count;
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
        if (!$this->request->isAjax()) {
            if (!User::isLogin($modle)) {
                if ($modle == "admin") {
                    $this->redirect(url('admin/user/login'));
                } elseif ($modle == "home") {
                    $this->redirect(url('home/thing/login'));
                } else {
                    return $this->error("请求的页面不存在！");
                }
            } else {
                //记录访问IP
                $requestIP = Comm::getClientIP();
                $requestDate = time();
                $count = new Count();
                $count->ipcontent = $requestIP;
                $count->time = $requestDate;
                if ($modle == "admin") {
                    $count->user = User::getUserBySession("admin")->getData("user_name");
                } elseif ($modle == "home") {
                    $count->user = User::getUserBySession("home")->getData("user_name");
                } else {
                    $count->user = "";
                }
                $count->modle = $this->request->module()."/".$this->request->controller()."/".$this->request->action();
                $count->save();
            }
        }
    }

}