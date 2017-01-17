<?php
/**
 * 商品评论模型
 * User: Huan
 * Date: 2016/12/16
 * Time: 10:25
 */

namespace app\common\model;


use think\Model;

class Comment extends Model
{
    public function commodity()
    {
        return $this->belongsTo('commodity');
    }

}