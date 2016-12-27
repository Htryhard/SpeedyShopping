<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/28
 * Time: 0:11
 */

namespace app\common\validate;


use think\Validate;

class Specification extends Validate
{
    protected $rule = [
        'content'  =>  'require|max:250',
        'repertory'  =>  'require|number|max:10',
        'price'  =>  'require|max:20',
    ];

    protected $message  =   [
        'content.require' => '请输入规格内容',
        'content.max'     => '规格内容最多不能超过250个字符',
        'repertory.max'     => '商品库存最多不能超过10个字符',
        'repertory.require' => '请输入商品库存',
        'repertory.number' => '商品库存必须为数字',
        'price.require' => '请输入商品价格',
        'price.max'     => '商品价格最多不能超过20个字符',
    ];

}