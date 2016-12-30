<?php
/**
 * 订单和商品规格表的中间表
 * User: Huan
 * Date: 2016/12/28
 * Time: 4:15
 */

namespace app\common\model;


use think\Model;

class OrderSpecification extends Model
{
    public function order()
    {
        return $this->belongsTo('order');
    }
    public function specification()
    {
        return $this->belongsTo('specification');
    }

}