<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>

</head>
<body>
<%
        User user = (User)session.getAttribute("user");
		
        String kakaoUserName = (String)session.getAttribute("kakao_name");
        
        String kakaoId = (String)session.getAttribute("kakao_id");
        System.out.println("카카오유저"+kakaoUserName);
        System.out.println("카카오유저"+kakaoId);
        String userType = null;
        String name;
        String id;
        if(user != null){
            name = user.getNick();
            id = user.getId();
            userType=user.getUserType();
        } else if(kakaoUserName != null){
            name = kakaoUserName;
            id = kakaoId;
            userType = "kakao";
        } else {
            response.sendRedirect("/login");
            return;
        }

    %>            
	
</body>
</html>