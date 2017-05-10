$(function(){

	var editor = new wangEditor('writearticle');
   //无论是哪种方式上传，你都想通过myFileName获取
    editor.config.uploadImgFileName = 'ArticlePic'
    // 上传图片（举例）
    editor.config.uploadImgUrl = uploadImgUrl;
	//配置表情
	editor.config.emotions = {
    	// 支持多组表情

	    // 第二组，id叫做'weibo'
	    'weibo': {
	        title: '微博表情',  // 组名称
	        data: emotions,
	    }
	    // 下面还可以继续，第三组、第四组、、、
	};
	//配置吸顶距离
	editor.config.menuFixed = 0;
	// 插入代码时的默认语言
	editor.config.codeDefaultLang = 'php'
	editor.config.jsFilter = false;
    editor.create();


    //文章标题不能为空
    $("input[name=title]").blur(function(){
    	if($(this).val().length==0){
            $(this).parent("div").addClass("has-error");
            toastr.warning("标题不能为空");
    	}		       
    }).focus(function(){
    	$(this).parent("div").removeClass("has-error");
    })

    //添加分类模态框
    $("select[name=classification]").change(function(){
    	if($("select option:selected").val() == "add"){
    		$("#addClassification").modal();
    	}
    })
    //关闭模态框时select恢复
    $("#close_btn").click(function(){
    	$("#choose").prop("selected","selected");
    })
    //ajax提交添加的分类信息到服务器
    $("#add_class").click(function(){
    	var classification = $("#classification").val();
    	$.ajax({
    		url:classUrl,
    		type:"POST",
    		datatype:"json",
    		data:{"classification":classification},
    		success:function(msg){
    			var json_data = $.parseJSON(msg);
    			if(json_data.status){
    				$("#add").before("<option selected='selected' value="+json_data.message+">"+classification+"</option>");
    				$("#addClassification").modal("hide");
    				toastr.success(classification+"已添加");
    			}else{
    				$("#classification").after("<span class='glyphicon glyphicon-remove form-control-feedback'></span>")
    				toastr.error(classification+json_data.message);
    			}
    		}
    	})
    	
    })

/*  本地多标签输入框
	已放弃使用faltui默认
    $("input[name=tag]").tagsInput({
    	'defaultText':'添加标签',
    	'height':'100px',
   		'width':'100%',
   		'delimiter': [',',';'],
    });*/

/*  switch
	已放弃使用faltui默认
    $("[name='my-checkbox']").bootstrapSwitch({
        onColor: "warning",
        offColor: "danger",
        onText: "公开",
        offText: "私密"
	});*/

    //通过ajax提交博客信息到服务器
    $("#publish_btn").click(function(){
		var html  = editor.$txt.html();
		var title = $("input[name=title]").val();
		var classification = $("select option:selected").val();
		var public = $("input[name=public]").prop("checked")?0:1;
		alert(public);
		var tag = new Array();
        //把标签添加到数组
		$("span.tag").each(function(i,n){
			tag[i] = $(this).text();	
		});
		if(title == ''){
			toastr.warning("标题不能为空");
            $("input[name=title]").focus();
			return false;
		}
    	$.ajax({
			url:saveArticleUrl,
			type:"POST",
			datatype:"json",
			data:{
				"content":html,
				"title":title,
				"tag":tag,
				"classification":classification,
                "public":public
			},
    		success:function(msg){                     
                var json_data = $.parseJSON(msg);
                toastr.success(json_data.message);
                
                setTimeout(function(){
                    //跳转到页面详情
                    window.location.href = detailArticle+"?id="+json_data.article_id;
                },1000);
    		}
    	})
    }) 
})