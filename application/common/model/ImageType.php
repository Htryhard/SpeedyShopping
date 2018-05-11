<?php
/**
 * Created by PhpStorm.
 * User: Huan
 * Date: 2016/12/16
 * Time: 10:23
 */

namespace app\common\model;


use think\Model;

class ImageType extends Model
{
    public function images()
    {
        return $this->hasMany('images','image_type_id','id');
    }

}