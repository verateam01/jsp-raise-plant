<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<!-- jQuery -->
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<style>
.button {
	width: 200px;
}

</style>
</head>
<body>
	<div class="container d-flex flex-column" style="height: 100vh;">
		<h1>회원가입</h1>
		<p class="m-0 p-2">이름</p>
		<input type="text" class="form-control" placeholder="이름" name="name"/>
		<p class="m-0 p-2">닉네임</p>
		<input type="text" class="form-control" placeholder="닉네임" name="nick"/>
		<p class="m-0 p-2">아이디</p>
		<input type="text" class="form-control" placeholder="아이디" name="id"/>
		<p class="m-0 p-2">비밀번호</p>
		<input type="text" class="form-control" placeholder="비밀번호" name="pw"/>
		<div class="d-flex justify-content-end mt-3">
			<button id="registerButton" class="btn btn-primary" style="width:90px;">회원가입</button>
		</div>
	</div>
	
	<script>
		$(document).ready(()=>{
			$("#registerButton").click(()=>{
				let name = $("input[name ='name']").val();
				let nick = $("input[name ='nick']").val();
				let id = $("input[name ='id']").val();
				let pw = $("input[name ='pw']").val();
				
				$.ajax({
					url: "${pageContext.request.contextPath}/api/register",
					type: "POST",
					data: {
						name:name,
						nick:nick,
						id:id,
						pw:pw
					}
				})
			})
		})
	</script>
</body>
</html>
