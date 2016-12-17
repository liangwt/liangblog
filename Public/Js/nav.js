$(function(){
	$("#login").click(function () {

	});
	//轮询消息推送
	var timestamp = 0;
	var error = false;

	function connect(){
		$.ajax({
			data:{"timestamp":timestamp},
			url:MsgUrl,
			type:"get",
			timeout:0,
			success:function(response){
				var data = eval();
				error = false;
				timeout = data.timestamp;
				$().append("")
			}
		})
	}

	//点击图片切换验证码
	$("#verifyCode").click(function(){
		var codeSrc = $(this).attr("src");
		var picURL = codeSrc.split("?")[0];
		$(this).attr("src",picURL+"?"+Math.random());
	})

	//点击模态框中的注册按钮触发ajax事件
	$("#btn_register").click(function(event){
		var account   = $("#register_account").val();
		var password  = $("#register_password").val();
		var rpassword = $("#register_rpassword").val();
		
		toastr.options = {
			"closeButton": false,
			"debug": false,
			"newestOnTop": true,
			"progressBar": false,
			"positionClass": "toast-top-right",
			"preventDuplicates": false,
			"onclick": null,
			"showDuration": "300",
			"hideDuration": "1000",
			"timeOut": "5000",
			"extendedTimeOut": "1000",
			"showEasing": "swing",
			"hideEasing": "linear",
			"showMethod": "fadeIn",
			"hideMethod": "fadeOut"
		}
		
		$.ajax({
			type: "POST",
			url: registerurl,
			data: {"account":account,"password":password,"rpassword":rpassword},
			datatype:"json",
			success: function(msg){
				var json_data = $.parseJSON( msg );
				if(!json_data.status){
					$('#register').modal();
					toastr.error(json_data.message);
				}else{
					setTimeout(function(){
						location.reload();
					},1000);
					toastr.success(json_data.message);
				}
   			}	
		});
	});

	//点击模态框中的登陆按钮触发ajax事件
   	$("#btn_login").click(function(){
   		var account   = $("#login_account").val();
		var password  = $("#login_password").val();
		var auto = $("input[name='auto']:checked").val();
		var verify_code = $("#login_code").val();

		$.ajax({
			type: "POST",
			url: loginurl, 
			data: {"account":account,"password":password,"auto":auto,"varify_code":verify_code},
			datatype:"json",
			success: function(msg){
				var json_data = $.parseJSON( msg );
				if(!json_data.status){
					toastr.error(json_data.message);
					$('#login').modal();
				}else{
					setTimeout(function(){
						location.reload();
					},1000);
					toastr.success(json_data.message);
				}
   			}	
		})
   	})
   	//点击导航栏中的退出按钮触发退出登陆事件
   	$("#logout").click(function(){
		$.ajax({
			type: "POST",
			url: logouturl,
			data: {},
			datatype:"json",
			success: function(msg){
				var json_data = $.parseJSON( msg );
				if(!json_data.status){
					toastr.error(json_data.message);
					$('#login').modal();
				}else{
					setTimeout(function(){
						location.reload();
					},1000);
					toastr.success(json_data.message);
				}
   			}	
		})   		
   	})
})