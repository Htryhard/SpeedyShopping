/**
 * Created by Huan on 2016/12/22.
 */

$(function () {
    // 初始化插件
    $("#zyupload").zyUpload({
        width: "700px",                 // 宽度
        height: "400px",                 // 宽度
        itemWidth: "140px",                 // 文件项的宽度
        itemHeight: "115px",                 // 文件项的高度
        url: "uploadImage",              // 上传文件的路径
        fileType: ["jpg", "png"],// 上传文件的类型
        fileSize: 51200000,                // 上传文件的大小
        multiple: true,                    // 是否可以多个文件上传
        dragDrop: true,                    // 是否可以拖动上传文件
        tailor: true,                    // 是否可以裁剪图片
        del: true,                    // 是否可以删除文件
        finishDel: true,  				  // 是否在上传文件完成后删除预览
        /* 外部获得的回调接口 */
        onSelect: function (selectFiles, allFiles) {    // 选择文件的回调方法  selectFile:当前选中的文件  allFiles:还没上传的全部文件
            console.info("当前选择了以下文件：");
            console.info(selectFiles);
        },
        onDelete: function (file, files) {              // 删除一个文件的回调方法 file:当前删除的文件  files:删除之后的文件
            console.info("当前删除了此文件：");
            console.info(file.name);
        },
        onSuccess: function (file, response) {          // 文件上传成功的回调方法
//                console.info("此文件上传成功：");
//                console.info(file.name);
//                console.info("此文件上传到服务器地址：");
//                console.info(response);
//                $("#uploadInf").append("<p>上传成功，文件地址是：" + response + "</p>");

            var imageName = document.getElementById("dirname").value;
            imageName += ";" + response.substr(0,40);
            $("#dirname").val(imageName);
            // alert(response.substr(0,40));
        },
        onFailure: function (file, response) {          // 文件上传失败的回调方法
            console.info("此文件上传失败：");
            console.info(file.name);
            $("#dirname").val("");
        },
        onComplete: function (response) {           	  // 上传完成的回调方法
//                console.info("文件上传完成");
//                console.info(response);
//                alert(response);
            $.ajax({
                type: "POST",
                url: "editCommodityHandle",
                dataType: "json",
                data: {
                    commodityData: $('#commodityData').serializeArray()
                },
                success: function (msg) {

                },
            });
            $("#dirname").val("");

        }
    });

});

//添加参数
$(document).ready(function() {

    var MaxInputs       = 10; //maximum input boxes allowed
    var InputsWrapper   = $("#InputsWrapper"); //Input boxes wrapper ID
    var AddButton       = $("#AddMoreFileBox"); //Add button ID

    var x = InputsWrapper.length; //initlal text box count
    var FieldCount=1; //to keep track of text box added

    $(AddButton).click(function (e)  //on add input button click
    {
        if(x <= MaxInputs) //max input box allowed
        {
            FieldCount++; //text box added increment
            //add input box
            $(InputsWrapper).append('<div>' +
                '参数名：<input type="text" name="parameterName" style=" height:30px;width: 150px ">；' +
                '参数值：<input type="text" style=" height:30px;width:150px  " name="parameterValue" id="field_'+ FieldCount +'"/>' +
                '<a href="#" class="removeclass" >' + '<img src="/SpeedyShopping/public/static/images/delete.png" width="15px;"height="15px"></a>' +
                '</div>');

            x++; //text box increment

        }
        return false;
    });

    $("body").on("click",".removeclass", function(e){ //user click on remove text
        if( x > 1 ) {
            $(this).parent('div').remove(); //remove text box
            x--; //decrement textbox
        }
        return false;
    })

});