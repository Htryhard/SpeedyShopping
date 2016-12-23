<?php
namespace app\home\controller;

use app\common\controller\BaseController;
use app\common\model\Commodity;
use think\Request;

class IndexController extends  BaseController
{
    public function index()
    {
        $this->assign('email','你好');
        return $this->fetch();

    }

    public function search(){
        $title = $this->request->param();
        // 获取查询信息
        $title = input('get.title');
        $pageSize = 30; // 每页显示15条数据
        $commodity = new Commodity();
        // 定制查询信息
        if (!empty($title)) {
            $commodities = $commodity->where('title', 'like', '%' . $title . '%')->paginate($pageSize, false,
                [
                    'query' => [
                        'title' => $title,
                    ],
                ]);
        } else {
            $commodities = $commodity->paginate($pageSize);
        }
        $imgRoot = '/speedyshopping/public//uploads/commodity_images/';
        $this->assign("imgRoot",$imgRoot);
        $this->assign('commodities', $commodities);
        return $this->fetch();
    }


    public  function  loginHandle(){
        return $this->fetch();
    }
    public function read(){

    }
    public function  readHandle(){

    }
}
