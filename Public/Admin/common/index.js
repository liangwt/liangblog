/**
 * Created by LiangWentao on 1/5/2017.
 */
$(function(){
    //表格颜色循环
    var color = ["info",'success',"danger","warning","active"];
    $("tr:has(td)").each(function(i){
        var choose = i%5;
        $(this).addClass(color[choose]);
    });

    $("#article_ser").focus(function(){
        $(this).attr("value","");
    }).blur(function(){
        $(this).attr("value","Search");
    });

    //点击check全选,取消checkbox全不选
    $(".selectAll").click(function(){
        if($(this).prop("checked") == true){
            $(this).parents("table").find("input").not(".selectAll").prop("checked",true);
        }else{
            $(this).parents("table").find("input").not(".selectAll").prop("checked",false);
        }
    });
    //任意checkbox不选中，更改.selectAll的状态
    $("input").not(".selectAll").click(function(){
        $(this).parents("table").find(".selectAll").prop("checked",false);
    });

    //多选框全选
    $("#allUser1").click(function(){
        $("#allUser>option").prop("selected",true);
        return false;
    });
    $("#roleUser1").click(function(){
        $("#roleUser>option").prop("selected",true);
        return false;
    });
    //多选框反选
    $("#allUser2").click(function(){
        $("#allUser>option").each(function(){
            $(this).prop("selected",!$(this).prop("selected"));
        });
        return false;
    });
    $("#roleUser2").click(function(){
        $("#roleUser>option").each(function(){
            $(this).prop("selected",!$(this).prop("selected"));
        });
        return false;
    });
    //添加的另一侧
    $("#allUser3").click(function(){
        $("#allUser>option:selected").each(function(){
            $(this).remove();
            var option="<option value='"+$(this).val()+"'>"+$(this).html()+"</option>";
            $("#roleUser").append(option);
        });
        return false;
    });
    $("#roleUser3").click(function(){
        $("#roleUser>option:selected").each(function(){
            $(this).remove();
            var option="<option value='"+$(this).val()+"'>"+$(this).html()+"</option>";
            $("#allUser").append(option);
        });
        return false;
    });
    //双击加入用户组
    $("#allUser option").dblclick(function(){
        $(this).remove();
        var option="<option value='"+$(this).val()+"'>"+$(this).html()+"</option>";
        $("#roleUser").append(option);
        return false;
    })
    $("#roleUser option").dblclick(function(){
        $(this).remove();
        var option="<option value='"+$(this).val()+"'>"+$(this).html()+"</option>";
        alert(option);
        $("#allUser").append(option);
    })


});