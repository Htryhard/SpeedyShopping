<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/16
 * Time: 10:28
 */

namespace app\common\model;


use think\Model;

class Type extends Model
{
    public function commodities()
    {
        return $this->hasMany('commodity','type_id','id');
    }

}