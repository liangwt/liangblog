$(function () {
    //城市联动
    var province = '';
    $.each(city, function (i, k) {
        province += '<option value="' + k.name + '" index="' + i + '">' + k.name + '</option>';
    });
    $('select[name=province]').append(province).change(function () {
        var option = '';
        if ($(this).val() == '') {
            option += '<option value="">请选择</option>';
        } else {
            var index = $(':selected', this).attr('index');
            var data = city[index].child;
            for (var i = 0; i < data.length; i++) {
                option += '<option value="' + data[i] + '">' + data[i] + '</option>';
            }
        }

        $('select[name=city]').html(option);
    });

    //头像文件上传
    $("#face").uploadify({
        'swf': PUBLIC + '/uploadify/uploadify.swf',
        'uploader': uploader,
        'fileTypeDesc': "*.jpeg,*.png,*.gif",
        'multi': false,
        'onUploadSuccess': function (file, data, response) {
            var json_data = $.parseJSON(data);
            if (json_data.status) {
                $("#afterFace").attr("src", ROOT + json_data.message).parent().show("slow");
                $("#faceAdress").val(ROOT + json_data.message);
            }
        }
    });

    //出生日期日历控件
    $('#datetimepicker').datetimepicker({
        format: 'YYYY-MM-DD',//日期格式化，只显示日期
        locale: 'zh-CN' //中文化
    });
    //基本信息表单提交
    $("#basic-info-btn").click(function(event){
        event.preventDefault();
        $.ajax({
            url: basicForm,
            type: "post",
            data: $("#basic-post-form").serialize(),
            success: function (msg) {
                var json_data = $.parseJSON(msg);
                if (json_data.status) {
                    toastr.success(json_data.message);
                    location.reload();
                } else {
                    toastr.error(json_data.message);
                }

            }
        })
    });
    //修改密码表单提交
    $("#chgpass-btn").click(function (event) {
        var flag=true;
        event.preventDefault();
        //判断文本框不能为空
        $("#chgpass-post-form input").each(function(){
            if($(this).val()==""){
                $(this).focus();
                toastr.warning("密码不能为空");
                flag = false;
                return false;
            }
        });
        //判断两次密码是否一致
        if($("input[name=newpassword]").val()!= $("input[name=rnewpassword]").val()){
            toastr.warning("两次密码不一致");
            return false;
        }
        if(flag){
            $.ajax({
                url: chgpassForm,
                type: "post",
                data: $("#chgpass-post-form").serialize(),
                success: function (msg) {
                    var json_data = $.parseJSON(msg);
                    if (json_data.status) {
                        toastr.success(json_data.message);
                        location.reload();
                    } else {
                        toastr.error(json_data.message);
                    }
                }
            })
        }
    })
})