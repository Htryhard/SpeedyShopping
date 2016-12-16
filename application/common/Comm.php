<?php
/**
 * Created by PhpStorm.
 * Date: 2016/9/25
 * Time: 17:48
 * 功能：
 */
namespace app\common;
use app\common\model\User;

class Comm
{

    /**
     * 根据邮箱获取一个用户
     * @param $email
     * @return $user
     */
    public static function getUserByEmail($email)
    {
        $user = User::get(['email' => $email]);
        return $user;
    }

    /**
     * 获取一个sortid
     */
    public static function getSortId($model)
    {
        $m = D($model);
        $mdata = $m->select();
        $maxSortid = 0;
        if (count($mdata) > 0) {
            foreach ($mdata as $item) {
                if ($item['sortid'] > $maxSortid) {
                    $maxSortid = $item['sortid'];
                }
            }
            $maxSortid += 1;
            return $maxSortid;
        } else {
            return $maxSortid;
        }
    }

    /**
     * 生成一个GUID
     */
    public static function getNewGuid()
    {
        mt_srand((double)microtime() * 10000);
        $charid = strtoupper(md5(uniqid(mt_rand(), true)));
        $hyphen = chr(45);// "-"
        $uuid = chr(123)// "{"
            . substr($charid, 0, 8) . $hyphen
            . substr($charid, 8, 4) . $hyphen
            . substr($charid, 12, 4) . $hyphen
            . substr($charid, 16, 4) . $hyphen
            . substr($charid, 20, 12)
            . chr(125);// "}"
        return $uuid;

    }

    /**
     * 获取唯一编号
     */
    static function getNumber()
    {
        static $i = -1;
        $i++;
        $a = substr(date('YmdHis'), -12, 12);
        $b = sprintf("%02d", $i);
        if ($b >= 100) {
            $a += $b;
            $b = substr($b, -2, 2);
        }
        return $a . $b;
    }

    /**
     * 获取一个唯一的id
     * @return string
     */
    static function getNewId()
    {
        return uniqid('prefix_', true) . '-' . rand(10000, 99999);
    }

}