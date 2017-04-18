<?php
namespace app\api\controller;

use app\common\aliyun\top\request\AlibabaAliqinFcSmsNumSendRequest;
use app\common\aliyun\top\TopClient;
use app\common\Comm;
use app\common\model\AuthGroup;
use app\common\model\Code;
use app\common\model\Comment;
use app\common\model\CommentImages;
use app\common\model\Commodity;
use app\common\model\Type;
use app\common\model\User;
use com\Auth;
use think\Controller;
use think\Request;

class IndexController extends Controller
{

    public function initHome()
    {
        $data = array();
        //尽想购
        $SalesVolumeComs = array();
        $SalesVolumeCommodities = Commodity::where("states=0")->order('staistics', 'desc')->paginate(2);
        foreach ($SalesVolumeCommodities as $key => $commodity) {
            if ($key == 2) {
                break;
            }
            array_push($SalesVolumeComs, $commodity);
        }
        $data["SalesVolumeCommodities"] = $SalesVolumeComs;
        //有好货
        $NewsComs = array();
        $NewsCommodities = Commodity::where("states=0")->order('creation_time', 'desc')->paginate(2);
        foreach ($NewsCommodities as $key => $commodity) {
            if ($key == 2) {
                break;
            }
            array_push($NewsComs, $commodity);
        }
        $data["NewsCommodities"] = $NewsComs;
        //爱逛街
        //暂时写死
        $type = Type::get(['id' => "A2AF9D4A-D613-0A44-353C-F015BB16F24A"]);
        $comArr = array();
        if ($type != null) {
            $commodities = $type['commodities'];
            foreach ($commodities as $key => $commodity) {
                if ($key == 2) {
                    break;
                }
                array_push($comArr, $commodity);
            }
        }
        $data["LifeSupermarket"] = $comArr;
        //必买清单
        $RecommendComs = array();
        $RecommendCommodities = Commodity::where("states=0")->order('grade', 'desc')->paginate(2);
        foreach ($RecommendCommodities as $key => $commodity) {
            if ($key == 2) {
                break;
            }
            array_push($RecommendComs, $commodity);
        }
        $data["RecommendCommodities"] = $RecommendComs;

        return json($data);
    }

    public function getCode()
    {
        $phone = $this->request->post("phone");

        if ($phone != "") {
            $user = User::get(['phone' => $phone]);
            if ($user != null) {
                $code = rand(10000, 99999);//随机生成5位数为验证码

                //保存验证码
                $codeModel = Code::get(["phone" => $phone]);
                if ($codeModel == null) {
                    $codeModel = new Code();
                    $codeModel->id = Comm::getNewGuid();
                }
                $codeModel->code = $code;
                $codeModel->create_time = time();
                $codeModel->type = "login";
                $codeModel->key = $phone . $code;
                $codeModel->phone = $phone;
                $codeModel->save();


                $c = new TopClient();
                $c->appkey = "23577534";//填写自己的appke
                $c->secretKey = "dc76e12032ae3b8ba71e94cb8d9074ff";//真写自己的seretKEY
                $req = new AlibabaAliqinFcSmsNumSendRequest();
                $req->setSmsType("normal");
                $req->setSmsFreeSignName("周边送购物助手");
                $req->setSmsParam("{\"code\":\"$code\"}");
                $req->setRecNum($phone);
                $req->setSmsTemplateCode("SMS_34830149");
                $resp = $c->execute($req);
                return json("Success");
            } else {
                return json("NoUser");//没有这个用户
            }
        }
    }

    public function loginCode()
    {
        $phone = Request::instance()->post("phone");
        $userCode = Request::instance()->post("code");
        $code = Code::get(["phone" => $phone]);
        if ($code != null) {
            //判断是否过期
            $createTime = $code->getData("create_time");
            $createTime = $createTime + 1800;//三十分钟有效期
            $currentTime = time();

            //有效
            if ($createTime > $currentTime && $code->getData("code") == $userCode) {
                $user = User::get(['phone' => $phone]);
                //判断用户的权限
                $rule = $user->getData("role_id");
                $auth = AuthGroup::get(["id" => $rule]);
                $flag = false;
                if ($auth->getData("rules") == "user") {
                    $flag = true;
                }
                if ($flag) {
                    $data["state"] = "Success";
                    $data["data"] = $user;
                    return json($data);
                } else {
                    $data["state"] = "Power";//无权访问
                    $data["data"] = "";
                    return json($data);
                }
            } else {
                $data["state"] = "Fail";
                $data["data"] = "";
                return json($data);
            }
        } else {
            $data["state"] = "Fail";
            $data["data"] = "";
            return json($data);
        }
    }

    public function postCommentImgs()
    {
        $commentId = Request::instance()->post("commentId");
        $imgBase64 = Request::instance()->post("imgBase64");
        $comment = Comment::get(["id" => $commentId]);
        if ($comment != null && $imgBase64 != "") {
            $commentImgPath = Comm::uploadsCommentImgsForAPI($imgBase64);
            $commentImageModle = new CommentImages();
            $commentImageModle->id = Comm::getNewGuid();
            $commentImageModle->image = $commentImgPath;
            $commentImageModle->comment_id = $comment->getData("id");
            $commentImageModle->save();

            $date["statu"] = "success";
            $date["data"] = $comment;
            return json($date);
        } else {
            $date["statu"] = "error";
            $date["data"] = "";
            return json($date);
        }


    }

}
