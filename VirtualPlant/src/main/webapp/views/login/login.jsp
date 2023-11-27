<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<!-- jQuery -->
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js">
</script>
<style>
	.kakaoButton{
		cursor:pointer
	}
</style>
</head>
<body>
<div class="container d-flex flex-column mt-4">
	<h1 class="mb-4">로그인</h1>
	<p>아이디</p>
	<input type="text" class="form-control mb-4 p-3" placeholder="아이디" name="id"/>
	<p>비밀번호</p>
	<input type="password" class="form-control mb-4 p-3" placeholder="비밀번호" name="pw"/>
	<div class="d-flex justify-content-end mt-3">
			<button id="loginButton" class="btn btn-primary"
				style="width: 90px;">로그인</button>
		</div>
	<div class="d-flex flex-column align-middle">
		<p>소셜로그인</p>
		<span onclick="kakaoLogin();">
      <a href="javascript:void(0)">
					<img class="kakaoButton" style="width:185px; hegiht:45px;" src="../../img/kakao_loginButton.png" alt="카카오로그인버튼"/>
      </a>
		</span>
	</div>
</div>
<!--카카오로그인-->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
	  Kakao.init('baf124810d0cd543bcd9dba2e0cf58f6');
  console.log(Kakao.isInitialized());
</script>
<script>
    function kakaoLogin() {
        Kakao.Auth.login({
          success: function (response) {
            Kakao.API.request({
              url: '/v2/user/me',
              
              success: function (response) {
            	  console.log(response)
            	  
            	  $.ajax({
            		  url:"/api/login/kakao",
            		  method:"POST",
            		  data:{
            			  id:response.id,
            				email:response.kakao_account.email,
            				name:response.properties.nickname
            		  },
            		  success:(res)=>{
            			  if(res.status == "success"){
	            			  window.location.href="/main";	  
            			  } 
            		  }
            	  }) 
              },
              
              fail: function (error) {
                console.log(error)
              },
            })
          },
          fail: function (error) {
            console.log(error)
          },
        })
      }
     
    
  
</script>

<!-- 소셜로그인 -->
<script>
	$(document).ready(()=>{
		$("#loginButton").click(()=>{
			let id = $("input[name = 'id']").val();
			let pw = $("input[name = 'pw']").val();
			
			if(id!="" && pw != ""){
				$.ajax({
					url:"/api/login",
					method:"POST",
					data:{
						id:id,
						pw:pw
					},
					success:(response)=>{
						if(response.status == "success")
							window.location.href="/main";
						else
							alert("아이디 비밀번호를 확인해주세요");
					}
				})
			}
			else{
				alert("빈칸이 존재합니다.");
			}
		})
		
		//카카오로그인버튼 로직
		
		
	})
</script>
</body>
</html>