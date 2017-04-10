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
use app\common\model\User;


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
        $user = User::getUserBySession("admin");
        $this->assign("user", $user);
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

    public function editType()
    {
        if ($this->request->isAjax()) {
            //
            $content = $this->request->post("content");
            $typeId = $this->request->post("typeId");
            $type = Type::get(["id" => $typeId]);
            if ($type != null && $content != "") {
                $type->content = $content;
                $type->save();
                return "Success";
            }else{
                //提交方式出错
                return "ParameterError";
            }
        } else {
            //提交方式出错
            return "PostError";
        }
    }


}