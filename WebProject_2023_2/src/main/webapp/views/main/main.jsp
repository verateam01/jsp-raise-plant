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
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.min.js">
</script>
</head>
<body>
	<%
		User user = (User)session.getAttribute("user");
		String kakao_user = (String)session.getAttribute("kakao_user");
		String id;
		if(user != null){
		    id = user.getId();
		} else if(kakao_user != null){
		    id = kakao_user;
		} else {
		  response.sendRedirect("http://localhost:8080/WebProject_2023_2/views/login/login.jsp");
		  return;
		}
	%>

	<div class="container mt-5">
		<h3>환영합니다 <%= id %>님!</h3>
		<button type="button" class="btn btn-outline-info">로그아웃</button>
	</div>
	
	
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<%if (id == kakao_user)%>
	<script>
	function kakaoLogout() {
        if (Kakao.Auth.getAccessToken()) {
          Kakao.API.request({
            url: '/v1/user/unlink',
            success: function (response) {
            	console.log(response)
            },
            fail: function (error) {
              console.log(error)
            },
          })
          Kakao.Auth.setAccessToken(undefined)
        }
      }
	</script>
	<%-- <%else if(id == user.getId()) %> --%>
</body>
</html>