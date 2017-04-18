<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/4/18 0018
 * Time: 下午 5:29
 */

namespace app\home\controller;


use app\common\model\Collect;
use app\common\model\Type;
use app\common\model\User;
use think\Controller;

class TypeController extends Controller
{
    public function type($typeId)
    {
        $type = Type::get(["id" => $typeId]);
        if ($type != null) {
            $comies = $type["commodities"];
            $commodities = array();
            foreach ($comies as $comy) {
                if ($comy->getData("states") != 1) {
                    array_push($commodities, $comy);
                }
            }
            $user = User::getUserBySession("home");
            $userCollects = array();
            if ($user != null) {
                $userName = $user->getData("user_name");
                $userCollects = Collect::all(['user_id' => $user->getData('id')]);
            }
            $this->assign("userCollects", $userCollects);
            $this->assign("user", $user);
            $this->assign("type", $type);
            $imgRoot = '/SpeedyShopping/public//uploads/commodity_images/';
            $this->assign("imgRoot", $imgRoot);
            $this->assign("commodities", $commodities);
            return $this->fetch();
        }
    }

}