  $(function(){
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
		'swf'      : PUBLIC+'/uploadify/uploadify.swf',
        'uploader' : uploader,
        'fileTypeDesc' : "*.jpeg,*.png,*.gif",
        'multi'    : false,
        'onUploadSuccess' : function(file, data, response) {
        	var json_data = $.parseJSON( data );
        	if (json_data.status){
        		$("#afterFace").attr("src",ROOT+json_data.message).parent().show("slow");
        		$("#faceAdress").val(ROOT+json_data.message);
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
			url:basicForm,
			type:"post",
			data:$("#basic-post-form").serialize(),
			success:function(msg){
				alert(msg);
			}

		})
	})
})