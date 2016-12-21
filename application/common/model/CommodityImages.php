<?php
/**
 * 商品的图片
 * User: Huan
 * Date: 2016/12/16
 * Time: 10:26
 */

namespace app\common\model;


use think\Model;

class CommodityImages extends Model
{
    public function commodity(){
        return $this->belongsTo('commodity');
    }
}