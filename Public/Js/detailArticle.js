$(function(){
	//提交评论信息
	$("#sub_comment").click(function(){
		if($("textarea[name=comment_text]").val() == ""){
			$("textarea[name=comment_text]").focus();
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
	})

})