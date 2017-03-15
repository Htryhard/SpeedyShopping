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
        return $this->hasMany('OrderSpecification', 'order_id', 'id');
    }

    public function user()
    {
        return $this->belongsTo('user');
    }

    public function address()
    {
        return $this->belongsTo('address');
    }

    /**
     * 读取器
     * @param $value
     * @return mixed
     */
    public function getStatusAttr($value)
    {
        $status = [0 => '待付款', 1 => '待捡货', 2 => '待发货', 3 => '配送中', 4 => '货到付款', 5 => '交易完成', 6 => '退换货中', 7 => '交易关闭', 8 => '删除订单'];
        return $status[$value];
    }

    //获取已付款但未发货的订单
    public static function getOrdersForPayment()
    {
        $orders = Order::where("status=1 OR status=4")->order('order_time', 'desc')->paginate(15);
        return $orders;
    }

}