<?php
/**
 * Created by 观赏鱼.
 * Date: 2016/8/13
 * 功能：生成唯一的GUID标识
 */
namespace Home\Common;

//  三段
//  一段是微秒  一段是地址  一段是随机数
class  Guid
{
    var  $valueBeforeMD5;
    var  $valueAfterMD5;

    public function __construct()
    {
        //$this->getGuid();
    }

    function  getGuid()
    {
        $address  =  NetAddress::getLocalHost();
        $this->valueBeforeMD5  =  $address->toString().':'.System::currentTimeMillis().':'.Random::nextLong();
        $this->valueAfterMD5  =  md5($this->valueBeforeMD5);

        $raw  =  strtoupper($this->valueAfterMD5);
        return  substr($raw,0,8).'-'.substr($raw,8,4).'-'.substr($raw,12,4).'-'.substr($raw,16,4).'-'.substr($raw,20);
    }
}
?>
