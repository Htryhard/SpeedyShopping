<?php
/**
 * 商品的规格.
 * User: Huan
 * Date: 2016/12/28
 * Time: 0:10
 */

namespace app\common\model;


use think\Model;

class Specification extends Model
{
    public function commodity()
    {
        return $this->belongsTo('commodity');
    }

}