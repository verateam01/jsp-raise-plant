<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/views/register/register.css">
<!-- jQuery -->
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js">
</script>
<style>
.button {
	width: 200px;
}
</style>
</head>
<body>
	<div class="container d-flex flex-column" style="height: 100vh;">
		<div style="margin: 50px;">
			<h1>회원가입</h1>
			<p class="m-0 p-2">이름</p>
			<input type="text" class="form-control" placeholder="이름" name="name" />
			<p class="m-0 p-2">닉네임</p>
			<input type="text" class="form-control" placeholder="닉네임" name="nick" />
			<p class="m-0 p-2">
				아이디
				<button id="duplicatedId" class="btn btn-primary" style="margin-left: 20px;background-color: #f97178; border:none;">중복확인</button>
			</p>
			<input type="text" class="form-control" placeholder="아이디" name="id" />
			<div id="idWarning" class="alert alert-danger mt-2" style="display: none;">아이디가 이미 존재합니다!</div>
			
			<p class="m-0 p-2">비밀번호</p>
			<input type="password" class="form-control" placeholder="비밀번호" name="pw" />
			<div class="d-flex justify-content-end mt-3">
				<button id="registerButton" class="btn btn-primary"
					style="width: 90px; background-color: #f97178; border:none;">회원가입</button>
			</div>
			<div class="d-flex justify-content-center">
				<p>회원이신가요? <a href="/login" style="text-decoration:none; color:#f97178;">로그인하러가기</a></p>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(()=>{
        let idValid = false;

	      $("#duplicatedId").click(() => {
           let id = $("input[name='id']").val().trim();

           if (id === "") {
               alert("아이디를 입력해주세요!");
               return; 
           }
           checkDuplicateId(id);
        });

        let checkDuplicateId=(id)=>{
          $.ajax({
              url: "/api/duplicate",
              type: "POST",
              data: { id: id },
              success: (response) => {
                  if (response.status === "success") {
                      alert("아이디가 중복됩니다!");
                      idValid = false;
                  } else {
                      alert("사용 가능한 아이디입니다.");
                      idValid = true;
                  }
              	}
          	});
     		 }
				$("#registerButton").click(()=>{
					let name = $("input[name ='name']").val();
					let nick = $("input[name ='nick']").val();
					let id = $("input[name ='id']").val();
					let pw = $("input[name ='pw']").val();
					
					
					if (id === "" || nick === "" || name === "" || pw === "") {
		        alert("빈칸이 존재합니다!");
		        return;
		 	    }
					if(idValid == false){
						alert('아이디 중복을 확인해주세요');
						return;
					}
					
					if(idValid == true && id!=""&& nick!="" && name!="" && pw!=""){
						$.ajax({
							url: "/api/register",
							type: "POST",
							data: {
								name:name,
								nick:nick,
								id:id,
								pw:pw
							},
							success:(response)=>{
									window.location.href="/login"
							}
						});
					}
				})
		})
	</script>
</body>
</html>
