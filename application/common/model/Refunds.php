<?php
/**
 * 退换货表的模型
 * User: 陈有欢
 * Date: 2017/3/13 0013
 * Time: 上午 10:16
 */

namespace app\common\model;


use think\Model;

class Refunds extends Model
{
    public function order()
    {
        return $this->belongsTo('order');
    }

    public function specification()
    {
        return $this->belongsTo('Specification');
    }

    /**
     * 读取器
     * @param $value
     * @return mixed
     */
    public function getTypeAttr($value)
    {
        $type = [0=>'返修',1=>'换货',2=>'退货'];
        return $type[$value];
    }
}