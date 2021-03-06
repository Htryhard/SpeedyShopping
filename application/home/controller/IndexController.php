<?php
namespace app\home\controller;


use app\common\Comm;
use app\common\model\Collect;
use app\common\model\Count;
use app\common\model\Type;
use app\common\model\User;
use think\Controller;

class IndexController extends Controller
{

    public function home()
    {

        $userName = "";
        $user = User::getUserBySession("home");
        $userCollects = array();
        if ($user != null) {
            $userName = $user->getData("user_name");
            $userCollects = Collect::all(['user_id' => $user->getData('id')]);
        }

        //记录访问IP
        $requestIP = Comm::getClientIP();
        $requestDate = time();
        $count = new Count();
        $count->ipcontent = $requestIP;
        $count->time = $requestDate;
        $count->user = $userName;
        $count->modle = $this->request->module();
        $count->save();


//        $this->assign("commodities",);

        $this->assign("userCollects", $userCollects);
        $this->assign("user", $user);
        $imgRoot = '/SpeedyShopping/public//uploads/commodity_images/';
        $this->assign("imgRoot", $imgRoot);
        $this->assign('types', Type::all());
        return $this->fetch();
    }

    public function index()
    {

        $userName = "";
        $user = User::getUserBySession("home");
        $userCollects = array();
        if ($user != null) {
            $userName = $user->getData("user_name");
            $userCollects = Collect::all(['user_id' => $user->getData('id')]);
        }

        //记录访问IP
        $requestIP = Comm::getClientIP();
        $requestDate = time();
        $count = new Count();
        $count->ipcontent = $requestIP;
        $count->time = $requestDate;
        $count->user = $userName;
        $count->modle = $this->request->module();
        $count->save();


//        $this->assign("commodities",);

        $this->assign("userCollects", $userCollects);
        $this->assign("user", $user);
        $imgRoot = '/SpeedyShopping/public//uploads/commodity_images/';
        $this->assign("imgRoot", $imgRoot);
        $this->assign('types', Type::all());
        return $this->fetch();
    }


    public function loginHandle()
    {
        return $this->fetch();
    }

    public function read()
    {

    }

    public function readHandle()
    {

    }

}
