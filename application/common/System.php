<?php
/**
 * Created by 观赏鱼.
 * Date: 2016/8/13
 * 功能：
 */
namespace Home\Common;

class  System
{
    function  currentTimeMillis()
    {
        list($usec,  $sec)  =  explode("  ",microtime());
        return  $sec.substr($usec,  2,  3);
    }
}