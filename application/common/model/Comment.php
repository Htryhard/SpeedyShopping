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

    /**
     * 读取器
     * @param $value
     * @return mixed
     */
    public function getStatusAttr($value)
    {
        $status = [0 => '正常显示', 1 => '已被管理员关闭!'];
        return $status[$value];
    }

}