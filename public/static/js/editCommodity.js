/**
 * Created by Huan on 2016/12/22.
 */

//添加参数
$(document).ready(function() {

    var MaxInputs       = 20; //maximum input boxes allowed
    var InputsWrapper   = $("#InputsWrapper"); //Input boxes wrapper ID
    var AddButton       = $("#AddMoreFileBox"); //Add button ID

    // var x = InputsWrapper.length; //initlal text box count
    var x = $("#InputsWrapper div").length;
    var FieldCount=1; //to keep track of text box added

    $(AddButton).click(function (e)  //on add input button click
    {
        if(x <= MaxInputs) //max input box allowed
        {
            FieldCount++; //text box added increment
            //add input box
            $(InputsWrapper).append('<div>' +
                '参数名：<input type="text" name="parameterName" class="form-control"/>；' +
                '参数值：<input type="text" class="form-control" name="parameterValue" id="field_'+ FieldCount +'"/>' +
                ' <a href="#" class="removeclass" >' + '<img src="/SpeedyShopping/public/static/images/delete.png" width="10px;"height="10px"></a>' +
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

