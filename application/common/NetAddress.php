<?php
/**
 * Created by 观赏鱼.
 * Date: 2016/8/13
 * 功能：
 */
namespace Home\Common;

class  NetAddress
{
    var  $Name  =  'localhost';
    var  $IP  =  '127.0.0.1';
    function  getLocalHost()  //  static
    {
        $address  =  new  NetAddress();
        $address->Name  =  $_ENV["COMPUTERNAME"];
        $address->IP  =  $_SERVER["SERVER_ADDR"];
        return  $address;
    }

    function  toString()
    {
        return  strtolower($this->Name.'/'.$this->IP);
    }
}