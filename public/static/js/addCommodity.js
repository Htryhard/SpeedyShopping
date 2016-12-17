/**
 * 添加商品所有的js都提取到了这里 on 2016/12/17.
 */
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
            $(InputsWrapper).append('<div>参数名：<input type="text" name="parameterName[]">；参数值：<input type="text" name="parameterValue[]" id="field_'+ FieldCount +'"/><a href="#" class="removeclass">×</a></div>');
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

//添加规格
$(document).ready(function() {
    var Maxcq = 5;
    var Inputscq = $("#InputsWrappercq"); //Input boxes wrapper ID
    var AddButtoncq = $("#AddMoreFileBoxcq"); //Add button ID

    var x = Inputscq.length; //initlal text box count
    var FieldCount=1; //to keep track of text box added

    $(AddButtoncq).click(function (e)  //on add input button click
    {
        if(x <= Maxcq) //max input box allowed
        {
            FieldCount++; //text box added increment
            //add input box
            $(Inputscq).append('<div>库存：<input type="text" name="repertory"><br/>价格：<input type="text" name="price"><br/><a href="#" id="AddMoreFileBoxattribute" class="btn btn-info">添加属性</a></div>');
            x++; //text box increment
        }
        return false;
    });

    $("body").on("click",".removeclass_cq", function(e){ //user click on remove text
        if( x > 1 ) {
            $(this).parent('div').remove(); //remove text box
            x--; //decrement textbox
        }
        return false;
    })
});

//添加属性    $(Inputscq).append('<div>库存：<input type="text" name="repertory"><br/>价格：<input type="text" name="price"><br/></div>');
$(document).ready(function() {
    var Maxcq = 5;
    var Inputscq = $("#InputsWrappercq_attribute"); //Input boxes wrapper ID
    var AddButtoncq = $("#AddMoreFileBoxattribute"); //Add button ID

    var x = Inputscq.length; //initlal text box count
    var FieldCount=1; //to keep track of text box added

    $(AddButtoncq).click(function (e)  //on add input button click
    {
        if(x <= Maxcq) //max input box allowed
        {
            FieldCount++; //text box added increment
            //add input box
            $(Inputscq).append('<div>属性名：<input type="text" name="cq_attribute_Name[]">；属性值：<input type="text" name="cq_attribute_Value[]" id="field_cq_1"/><a href="#" class="removeclass_cq_attribute">×</a></div>');
            x++; //text box increment
        }
        return false;
    });

    $("body").on("click",".removeclass_cq_attribute", function(e){ //user click on remove text
        if( x > 1 ) {
            $(this).parent('div').remove(); //remove text box
            x--; //decrement textbox
        }
        return false;
    })
});
