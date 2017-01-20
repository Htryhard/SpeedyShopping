<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/16
 * Time: 10:24
 */

namespace app\common\model;


use think\Model;

class Cart extends Model
{
    public function user()
    {
        return $this->belongsTo('user');
    }

    public function CartSpecifications()
    {
        return $this->hasMany('CartSpecification','cart_id','id');
    }

}