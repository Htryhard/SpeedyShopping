<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/16
 * Time: 15:36
 */

namespace app\admin\controller;


use app\common\Comm;
use app\common\controller\BaseController;
use app\common\model\Type;
use think\Request;

/**
 * 类别控制器
 * @package app\admin\controller
 */
class TypeController extends BaseController
{
    //显示所有的类别
    public function index()
    {
        $types = Type::all();
        $this->assign("types", $types);
        return $this->fetch();
    }

    //添加一个分类
    public function add()
    {
        $data = $this->request->param("content");
        if ($data != "") {
            $type = new Type();
            $type->id = Comm::getNewGuid();
            $type->content = $data;
            $type->save($type->getData());
        }

    }


}