<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/16
 * Time: 10:23
 */

namespace app\common\model;


use think\Model;

class Address extends Model
{
    public function user()
    {
        return $this->belongsTo('user');
    }

}