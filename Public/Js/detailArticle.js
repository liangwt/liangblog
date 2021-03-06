$(function(){

	//为标签附颜色
	var tagClass = ["label-default","label-primary","label-success","label-warning","label-danger","label-info"];
	
	$("div.blog-post-meta > span").each(function(i){
		var index = Math.floor(Math.random()*tagClass.length);
		$(this).addClass(tagClass[index]);
	})
    //删除文章弹出框
	$("#deleteArticle").click(function(){
        swal({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then(function () {
            $.ajax({
                url:deleteUrl,
                dataType : "json",
                success:function(msg){
                    if(msg.status){
                        swal({
                            title:'Deleted!',
                            text:'Your file has been deleted.',
                            type:'success'
                        }).then(function(){
                            //跳转到页面详情
                            window.location.href = showArticle;
                        })
                    }else{
                        swal({
                            title:'Failed!',
                            text:'Your file has not been deleted.',
                            type:'error'
                        }).then(function(){
                            //跳转到页面详情
                            window.location.href = showArticle;
                        })
                    }

                }
            });

        })
        return false;
    });
	//转换成公开的或者私密的确认
    $("#chgStu").click(function(){
        swal({
            title: 'Are you sure?',
            text: "Do you want to change the status?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, change it!'
        }).then(function () {
            $.ajax({
                url:chgstatusUrl,
                type:"POST",
                dataType:"json",
                success:function(msg){
                    swal({
                        title:'Success!',
                        text:msg.message,
                        type:'success'
                    }).then(function(){
                        //刷新页面
                        location.reload();
                    })
                },
                error:function(msg){
                    swal({
                        title:'error!',
                        text:'There is something wrong with server',
                        type:'error'
                    }).then(function(){
                        //刷新页面
                        location.reload();
                    })
                }

            })
        })
        return false;
    });
	//提交评论信息
	$("#sub_comment").click(function(){
        var flag = false;
        $.ajax({
            type:"POST",
            url:checkLoginURL,
            async:false,
            data:{},
            success:function(msg){
                var json_data = $.parseJSON(msg);
                if(!json_data.status){
                    toastr.error("请登录...");
                    $('#login').modal();
                    return false;
                }else{
                    if($("textarea[name=comment_text]").val() == ""){
                        $("textarea[name=comment_text]").focus();
                        toastr.info("输入不能为空");
                        return false;
                    }
                    $.ajax({
                        url:commentUrl,
                        type:"POST",
                        //serialize() 输入框中必须有name属性
                        data:$("#comment").serialize(),
                        dataType:"json",
                        success:function(msg){
                            //var json_data = $.parseJSON(msg);
                            if(msg.status){
                                location.reload();
                            }
                        }
                    })
                }
            }
        });
        return flag;
	})

    //顶评论ajax处理
    $("#up-comment").click(function(){
        $.ajax({
            url:upCommentUrl,
            type:"POST",
            
        })
    })
    //踩评论ajax处理

})