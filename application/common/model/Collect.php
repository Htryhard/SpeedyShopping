<?php
/**
 * 收藏表模型.
 * User: Huan
 * Date: 2017/1/18
 * Time: 2:57
 */

namespace app\common\model;


use think\Model;

class Collect extends Model
{
    public function user()
    {
        return $this->belongsTo('user');
    }
    public function commodity()
    {
        return $this->belongsTo('commodity');
    }

}