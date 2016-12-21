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
        'repertory'  =>  'require|number|max:10',
        'price'  =>  'require|max:20',
    ];

    protected $message  =   [
        'title.require' => '请输入商品标题',
        'title.max'     => '商品标题最多不能超过250个字符',
        'parameter.require' => '请输入商品的参数',
        'repertory.max'     => '商品库存最多不能超过10个字符',
        'repertory.require' => '请输入商品库存',
        'repertory.number' => '商品库存必须为数字',
        'price.require' => '请输入商品价格',
        'price.max'     => '商品价格最多不能超过20个字符',
    ];

    protected $scene = [
        'title'  =>  ['title'],
        'parameter'  =>  ['parameter'],
        'repertory'  =>  ['repertory'],
        'price'  =>  ['price'],
        'addOrEdit'  =>  ['title','parameter','repertory','price'],
    ];

}