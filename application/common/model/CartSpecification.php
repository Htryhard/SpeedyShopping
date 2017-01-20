<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/16
 * Time: 10:24
 */

namespace app\common\model;


use think\Model;

class CartSpecification extends Model
{
    public function Specification()
    {
        return $this->belongsTo('Specification');
    }

}