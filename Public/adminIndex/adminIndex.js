/**
 * Created by LiangWentao on 1/5/2017.
 */
$(function(){
    //表格颜色循环
    var color = ["info",'success',"danger","warning","active"];
    $("tr:has(td)").each(function(i){
        var choose = i%5;
        $(this).addClass(color[choose]);
    })

    $("#article_ser").focus(function(){
        $(this).attr("value","");
    }).blur(function(){
        $(this).attr("value","Search");
    });
})