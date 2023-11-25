<%@page import="model.User"%>
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

</head>
<body>
	<%
		User user = (User)session.getAttribute("user");
		String kakaoUser = (String)session.getAttribute("kakao_user");
		String id;
		if(user != null){
		    id = user.getId();
		} else if(kakaoUser != null){
		    id = kakaoUser;
		} else {
		  response.sendRedirect("/login");
		  return;
		}
	%>

	<div class="container mt-5">
		<h3>환영합니다 <%= id %>님!</h3>
		<button type="button" class="btn btn-outline-info" onclick="logout()">로그아웃</button>
	</div>
	
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script>Kakao.init('baf124810d0cd543bcd9dba2e0cf58f6');</script>
	<script>
		function kakaoLogout() {
       if (Kakao.Auth.getAccessToken()) {
         Kakao.API.request({
           url: '/v1/user/unlink',
           success: (response)=>{
           		window.location.href="/login"
           },
           fail:(error) => {
             console.log(error)
           },
         })
         Kakao.Auth.setAccessToken(undefined)
       }
     }
		function logout(){
			let kakaoUser = "<%=kakaoUser%>"
			console.log(kakaoUser);
			if(kakaoUser != "null"){
				kakaoLogout();
			}
			else{
				$.ajax({
					url:"/api/logout",
					type:"POST",
					success:(res)=>{
						if(res.status == "success"){
							window.location.href="/login";
						}
					},
					error:(error)=>{
						console.log('에러발생',error);
					}
				})
			}
	 }
</script>
	
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
</body>
</html>