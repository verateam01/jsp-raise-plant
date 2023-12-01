<%@ page import="java.sql.*" %>
<%@ page import="db.util.DBConn" %>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>버츄얼플랜트</title>
    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.5.0/kakao.min.js"></script>
    <script>Kakao.init('baf124810d0cd543bcd9dba2e0cf58f6');</script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/main/main.css">
    <!-- Font-awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
</head>
<body>
<%
        User user = (User)session.getAttribute("user");
        String kakaoUserName = (String)session.getAttribute("kakao_name");
        String kakaoId = (String)session.getAttribute("kakao_id");
        String name;
        String id;
        if(user != null){
            name = user.getNick();
            id = user.getId();
        } else if(kakaoUserName != null){
            name = kakaoUserName;
            id = kakaoId;
        } else {
            response.sendRedirect("/login");
            return;
        }
    %>
    
    <div id="container">
        <div id="day_info">
            <div id="day_left"></div>
            <div id="day_text">
                <p style="text-align: center; font-size: 40px;">4 Day</p>
            </div>
            <div id="day_skip_button">
                <button id="next_day_button">다음날</button>
            </div>
        </div>
        <div id="heart_content">
            <div id="heart_gauge" style="margin: 0 auto;">
                <div id="gauge-fill" style="width: 55%;"></div>
            </div>
            <i class="fa-solid fa-heart fa-2xl" style="color: #ff7575; margin: auto;"></i>
        </div>
        <div id="plant_area">
            <div id="carouselExampleIndicators" class="carousel slide" data-bs-interval="false">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                </div>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="../../img/plant_img/Gardenia1.jpg" class="d-block" alt="..." data-plant-id="1">
                    </div>
                    <div class="carousel-item">
                        <img src="../../img/plant_img/Hyacinth1.jpg" class="d-block" alt="..." data-plant-id="2">
                    </div>
                    <div class="carousel-item">
                        <img src="../../img/plant_img/Cactus1.jpg" class="d-block" alt="..." data-plant-id="3">
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>
        <div id="action_area">
            <div class="buttons_container">
                <button class="water action_button">물주기</button>
                <button class="fertilized action_button">비료주기</button>
                <button class="action_button">말하기</button>
            </div>
            <div class="input_container">
                <div class="input-group mb-3">
                    <input type="text" class="form-control" placeholder="식물에게 말을 걸어봐요!" aria-label="Recipient's username" aria-describedby="button-addon2">
                    <button class="btn btn-outline-secondary" type="button" id="button-addon2">입력</button>
                </div>
            </div>
        </div>

        <div id="user_menu" class="dropdown">
            <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                <i id="user_icon" class="fa-solid fa-user"></i><%=name %>님
            </button>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                <li><a class="dropdown-item" href="#">계정 설정</a></li>
                <li><a class="dropdown-item" href="#">도움말</a></li>
                <li><a class="dropdown-item" href="#">관리자 메뉴</a></li>
                <li><a class="dropdown-item" href="#" onclick="logout()">로그아웃</a></li>
            </ul>
        </div>
    </div> 

    <script>
    /*로그아웃로직*/
        function kakaoLogout() {
            if (Kakao.Auth.getAccessToken()) {
                Kakao.Auth.logout(function(){
                    window.location.href="/login";
                    console.log('로그아웃완료');
                })
            }
        }
        function logout(){
            let kakaoUser = "<%=kakaoUserName%>"
            if(Kakao.Auth.getAccessToken() != null){
                kakaoLogout();
                console.log('로직실행');
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
    
    <script>
    /* 식물 정보가져오는 로직*/
    $(document).ready(function() {
    	let userId = "<%= id %>"
    	
    	const sendAjaxRequest = (url, type, data, successCallback) => {
    		$.ajax({
    			url: url,
    			type: type,
    			data: data,
    			success: successCallback,
    		})
    	}
    	
    	const fetchPlantData = (plantId) => {
    		sendAjaxRequest('/api/plant/info','GET',{userId:userId,plantId:plantId},(response)=>{
    			console.log(response);
    		})
    	}
    	/* 물주기 */
    	const waterPlant = (plantId) => {
    		let now = new Date();
    		now.setHours(now.getHours()+9);
    	    let formattedDateTime = now.toISOString().slice(0, 19).replace('T', ' ');
    	    
    		sendAjaxRequest('/api/plant/water','POST',{userId:userId, plantId:plantId,lastWaterd:formattedDateTime},(response)=>{
    			console.log('waterPlant',response);
    		})
    	}
    	/* 비료주기 */
    	const fertilizedPlant = (plantId) => {
    		sendAjaxRequest('/api/plant/fertilized','POST',{userId:userId, plantId:plantId},(response)=>{
    			console.log(response);
    		})
    	}
    	
        let	firstPlantId = $('#carouselExampleIndicators .carousel-item.active img').data('plant-id');
       	fetchPlantData(firstPlantId);        
        $('#carouselExampleIndicators').on('slid.bs.carousel',function(){
        	  let plantId = $(this).find('.carousel-item.active img').data('plant-id');
        	   fetchPlantData(plantId);
   	    });
     	   
    	$('.water').click(()=>{
    		let currentPlantId = $('#carouselExampleIndicators .carousel-item.active img').data('plant-id');
            waterPlant(currentPlantId);
    	})    
    	
    	$('.fertilized').click(()=>{
    		let currentPlantId = $('#carouselExampleIndicators .carousel-item.active img').data('plant-id');
            fertilizedPlant(currentPlantId);
    	})
	 });
    
    
    </script>
    
    <!-- jQuery and Bootstrap Bundle -->
    
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
