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
	<div class="d-flex flex-column">
		<p>소셜로그인</p>
	</div>
</div>
<script>
	$(document).ready(()=>{
		$("#loginButton").click(()=>{
			let id = $("input[name = 'id']").val();
			let pw = $("input[name = 'pw']").val();
			
			if(id!="" && pw != ""){
				$.ajax({
					url:"${pageContext.request.contextPath}/api/login",
					method:"POST",
					data:{
						id:id,
						pw:pw
					},
					success:(response)=>{
						if(response.status == "success")
							window.location.href="${pageContext.request.contextPath}/views/main/main.jsp";
						else
							alert("아이디 비밀번호를 확인해주세요");
					}
				})
			}
			else{
				alert("빈칸이 존재합니다.");
			}
		})
	})
</script>
</body>
</html>