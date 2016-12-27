<?php
/**
 * 商品验证器.
 * User: Huan
 * Date: 2016/12/20
 * Time: 15:49
 */

namespace app\common\validate;


use think\Validate;

class Commodity extends Validate
{
    protected $rule = [
        'title'  =>  'require|max:250',
        'parameter'  =>  'require',
    ];

    protected $message  =   [
        'title.require' => '请输入商品标题',
        'title.max'     => '商品标题最多不能超过250个字符',
        'parameter.require' => '请输入商品的参数',
    ];

    protected $scene = [
        'title'  =>  ['title'],
        'parameter'  =>  ['parameter'],
        'repertory'  =>  ['repertory'],
        'price'  =>  ['price'],
        'addOrEdit'  =>  ['title','parameter','repertory','price'],
    ];

}