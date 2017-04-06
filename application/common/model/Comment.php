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
    public function OrderSpecification()
    {
        return $this->belongsTo('OrderSpecification');
    }

    public function user()
    {
        return $this->belongsTo('user');
    }

    public function commentImgs()
    {
        return $this->hasMany('CommentImages', 'comment_id', 'id');
    }

}