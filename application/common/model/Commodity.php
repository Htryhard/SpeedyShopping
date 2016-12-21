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

    public function images(){
        return $this->hasMany('CommodityImages','commodity_id','id');
    }

}