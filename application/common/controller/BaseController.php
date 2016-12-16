<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/16
 * Time: 10:30
 */

namespace app\common\controller;


use think\Controller;
use think\Request;

class BaseController extends Controller
{
    protected $request;
    public function __construct(Request $request)
    {
        parent::__construct();
        $this->request = $request;
    }

}