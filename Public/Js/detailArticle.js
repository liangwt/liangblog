$(function(){
	$("#sub_comment").click(function(){
		var comment_text = $("#comment_text").val();
		var username = $("#username").val();

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