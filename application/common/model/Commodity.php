<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/16
 * Time: 10:25
 */

namespace app\common\model;


use think\Model;

class Commodity extends Model
{
    public function type()
    {
        return $this->belongsTo('type');
    }

    public function images()
    {
        return $this->hasMany('CommodityImages', 'commodity_id', 'id');
    }

    public function specifications()
    {
        return $this->hasMany('specification', 'commodity_id', 'id');
    }

    public function comments()
    {
        return $this->hasMany('comment', 'commodity_id', 'id');
    }

    /**
     * 读取器
     * @param $value
     * @return mixed
     */
    public function getStatesAttr($value)
    {
        $status = [0 => '正常', 1 => '已下架', 2 => '促销'];
        return $status[$value];
    }

}