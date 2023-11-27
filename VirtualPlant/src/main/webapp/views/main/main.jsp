<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- main.css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/main/main.css">
<!-- bootstrap -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<!-- Font-awesome -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>

</head>
<body>
<body>
	<div id="container">
		<div id="side_left"></div>
		<div id="mid_content">
			<div id="day_info">
				<p style="font-size: 40px;">4 Day</p>
				<button id="next_day_button">다음날</button>

			</div>
			<div id="heart_content">
				<div id="heart_gauge" style="margin: 0 auto;">
					<div id="gauge-fill" style="width: 55%;"></div>
				</div>
				<i class="fa-solid fa-heart fa-2xl"
					style="color: #ff7575; margin: auto;"></i>
			</div>
			<div id="plant_area">
				<div id="move_left_plant">
					<i class="fa-solid fa-chevron-left fa-xl"></i>
				</div>
				<div id="plant">
					<img src="img/plant.png" />
				</div>
				<div id="move_right_plant">
					<i class="fa-solid fa-chevron-right  fa-xl"></i>
				</div>
			</div>
			<div id="action_area">
				<div class="buttons_container">
					<button class="action_button">물주기</button>
					<button class="action_button">비료주기</button>
					<button class="action_button">말하기</button>

				</div>
				<div class="input_container">
					<div class="input-group mb-3">
						<input type="text" class="form-control"
							placeholder="식물에게 말을 걸어봐요!" aria-label="Recipient's username"
							aria-describedby="button-addon2">
						<button class="btn btn-outline-secondary" type="button"
							id="button-addon2">입력</button>
					</div>

				</div>
			</div>

		</div>

		<div id="side_right">
			<div id="side_right_box">

				<div class="dropdown">

					<button class="btn dropdown-toggle" type="button"
						id="dropdownMenuButton1" data-bs-toggle="dropdown"
						aria-expanded="false">
						<i id="user_icon" class="fa-solid fa-user"></i>이채원님
					</button>
					<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
						<li><a class="dropdown-item" href="#">계정 설정</a></li>
						<li><a class="dropdown-item" href="#">도움말</a></li>
						<li><a class="dropdown-item" href="#">관리자 메뉴</a></li>
						<li><a class="dropdown-item" href="#" onclick="logout()">로그아웃</a></li>
					</ul>
				</div>

			</div>
		</div>
	</div>
	<%-- <%
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
	%> --%>

	<%-- <h3>환영합니다 <%= id %>님!</h3> --%>
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
			<%-- let kakaoUser = "<%=kakaoUser%>" --%>
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
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
</body>
</html>