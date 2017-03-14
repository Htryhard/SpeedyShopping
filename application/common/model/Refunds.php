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

    public function user()
    {
        return $this->belongsTo('user');
    }

    /**
     * 读取器
     * @param $value
     * @return mixed
     */
    public function getTypeAttr($value)
    {
        $type = [0=>'返修',1=>'换货',2=>'退货',3=>"申请取消",4=>'已处理'];
        return $type[$value];
    }

    /**
     * 返回所有的退换货单，如果没有就返回空
     * @return false|static[]
     */
    public static function getAllRefunds(){
        $refunds = Refunds::all();
        return $refunds;
    }
}