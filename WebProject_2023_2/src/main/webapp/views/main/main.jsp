<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		    // 둘 다 null인 경우
		    response.sendRedirect("http://localhost:8080/WebProject_2023_2/views/login/login.jsp");
		    return;
		}
	%>

	<div>
		로그인아이디 <%= id %><br/>
		Main Page입니다
	</div>
	
	
</body>
</html>