<?php
/**
 * Created by 观赏鱼.
 * Date: 2016/8/13
 * 功能：
 */
namespace Home\Common;

class  Random
{
    function  nextLong()
    {
        $tmp  =  rand(0,1)?'-':'';
        return  $tmp.rand(1000,  9999).rand(1000,  9999).rand(1000,  9999).rand(100,  999).rand(100,  999);
    }
}