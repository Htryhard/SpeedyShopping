<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/16
 * Time: 10:27
 */

namespace app\common\model;


use think\Model;

class Order extends Model
{
    public function orderSpecifications()
    {
        return $this->hasMany('OrderSpecification','order_id','id');
    }
    public function user(){
        return $this->belongsTo('user');
    }

    public function address(){
        return $this->belongsTo('address');
    }

    /**
     * 读取器
     * @param $value
     * @return mixed
     */
    public function getStatusAttr($value)
    {
        $status = [0=>'待付款',1=>'待捡货',2=>'待发货',3=>'配送中',4=>'货到付款'];
        return $status[$value];
    }

}