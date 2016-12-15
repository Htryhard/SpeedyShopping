<?php
/**
 * Created by PhpStorm.
 * Date: 2016/9/25
 * Time: 17:48
 * 功能：
 */
namespace Home\Common;
class Comm{

    /**
    获取一个sortid
     */
    public static function getSortId($model){
        $m = D($model);
        $mdata = $m->select();
        $maxSortid = 0;
        if (count($mdata)>0){
            foreach ($mdata as $item){
                if ($item['sortid'] > $maxSortid){
                    $maxSortid = $item['sortid'];
                }
            }
            $maxSortid+=1;
            return $maxSortid;
        }else{
            return $maxSortid;
        }
    }

    /**
    生成一个GUID
     */
    public static function getNewGuid(){
        $guid = new Guid();
        return $guid->getGuid();
    }


}