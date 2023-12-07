<%@ page import="java.sql.*" %>
<%@ page import="db.util.DBConn" %>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>VirtualPlant</title>
    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.5.0/kakao.min.js"></script>
    <script>Kakao.init('baf124810d0cd543bcd9dba2e0cf58f6');</script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <!-- Main CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/main/main.css">
    <!-- Font-awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>
    <style>
#speech-bubble {
    position: relative;
	padding: 10px 10px 10px 10px;
	background: #FFFFFF;
	border-radius: 5px;
	border: 4px solid #00bfb6;
	position: absolute;
	font-size: 16px;
	text-align: left;
	width: 300px;
	height: 150px;
	top: 50px;
    right: 40px;
    z-index: 1;
}

#speech-bubble:after {
    content: "";
  width: 0px;
  height: 0px;
  position: absolute;
  border-left: 10px solid #fff;
  border-right: 10px solid transparent;
  border-top: 10px solid #fff;
  border-bottom: 10px solid transparent;
  left: 24px;
  bottom: -13px; 
}
#speech-bubble:before{
content: "";
  width: 0px;
  height: 0px;
  position: absolute;
  border-left: 10px solid #00bfb6;
  border-right: 10px solid transparent;
  border-top: 10px solid #00bfb6;
  border-bottom: 10px solid transparent;
  left: 20px;
  bottom: -23px;
}
    </style>
</head>
<body>
<%
        User user = (User)session.getAttribute("user");
        String kakaoUserName = (String)session.getAttribute("kakao_name");
        
        String kakaoId = (String)session.getAttribute("kakao_id");
        System.out.println("카카오유저"+kakaoUserName);
        System.out.println("카카오유저"+kakaoId);
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
                <p class="plant_day" style="text-align: center; font-size: 40px;"></p>
            </div>
            <div id="day_skip_button">
                <button id="next_day_button" class="next-day">다음날</button>
            </div>
        </div>
        <div id="heart_content">
            <div id="heart_gauge" style="margin: 0 auto;">
                <div id="gauge-fill"></div>
            </div>

            <i id="full_heart" class="fa-solid fa-heart fa-2xl" style="color: #ff7575; margin: auto;"></i>
            <i id="empty_heart" class="fa-regular fa-heart fa-2xl" style="color: #ff7575; margin: auto;"></i>
            <i id="skull" class="fa-solid fa-skull-crossbones fa-2xl" style="color: #463331; margin: auto;"></i>
            
        </div>
        <div id="plant_area" class="position-relative">
        	<div id="speech-bubble">
        		<span id="loading" style="display:none;">생각중...</span>
        		<span class="think-answer"></span>
        	</div>
        	
            <div id="carouselExampleIndicators" class="carousel slide" data-bs-interval="false">
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                </div>
                <div class="carousel-inner ">
                	
                    <div class="carousel-item active">
                        <img src="" class="img1 d-block" alt="..." data-plant-id="1">
                    </div>
                    <div class="carousel-item">
                        <img src="" class="img2 d-block" alt="..." data-plant-id="2">
                    </div>
                    <div class="carousel-item">
                        <img src="" class="img3 d-block" alt="..." data-plant-id="3">
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
                <button id="water-button" class="water-button action_button">물주기</button>
                <button id="fertilized-button" class="fertilized-button action_button">비료주기</button>
                <button class="refresh-button btn btn-outline-primary action_button">Refresh</button>
                <button id="next-stage" class="next-stage btn btn-outline-danger action_button">LevelUp!</button>
            </div>
            <div class="input_container">
                <div class="input-group mb-3">
                    <input type="text" id="chat" class="form-control" placeholder="식물에게 말을 걸어봐요!" aria-label="Recipient's username" aria-describedby="button-addon2">
                    <button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="sendGptRequest()">입력</button>
                </div>
            </div>
        </div>

        <div id="user_menu" class="dropdown">
            <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                <i id="user_icon" class="fa-solid fa-user"></i><%=name %>님
            </button>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                <li><a class="dropdown-item" href="#">계정 설정</a></li>
                <li><a class="dropdown-item" href="#">관리자 메뉴</a></li>
                <li><a class="dropdown-item logout-button" href="#">로그아웃</a></li>
            </ul>
        </div>
    </div> 
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script>
const sendAjaxRequest = (url, type, data, successCallback,errorCallback) => {
	$.ajax({
		url: url,
		type: type,
		data: data,
		success: successCallback,
		error:errorCallback
	})
}


$(document).ready(function() {
    	let userId = "<%= id %>"
    	
   		const kakaoLogout = () => {
   		    if (Kakao.Auth.getAccessToken()) {
   		        Kakao.Auth.logout(function(){
   		            window.location.href="/login";
   		            console.log('로그아웃완료');
   		        })
   		    }
   		}
		/*로그아웃*/
   		const logout = () => {
   		    let kakaoUser = "<%=kakaoId%>"
   		    console.log(kakaoUser);
   		    if(Kakao.Auth.getAccessToken() != null){
   		        kakaoLogout();
   		        console.log('로직실행');
   		    }
   		    else{
   		        sendAjaxRequest('/api/logout','POST',{},(response)=>{
   		            if(response.status == "success")
   		                window.location.href='/login';
   		        },(error)=>{
   		            console.log(error)
   		        })
   		    }
   		}
		$('.logout-button').click(logout);
		
    	let	firstPlantId = $('#carouselExampleIndicators .carousel-item.active img').data('plant-id');
    	/*
    	* @count: 주기 횟수
    	* @type: water, fertilized 
    	*/
    	const answerSpeech = (count,type) => {
    		let message = "";
    		if(count > 3 && type=="water")
    			message = "너무 물이 많아요 ㅠㅠ 다음날주세요! 오늘 횟수:" + count;
    		else if(count <= 3 && type=="water")
    			message = "물을 주셔서 감사합니다! 하루3번인거 잊지않으셨죠?";
    		else if(count > 2 && type=="fertilizer")
    			message = "영양분 과다 섭취 입니다 ㅠㅠ";
    		else if(count <=2 && type=="fertilizer")
    			message = "쑥쑥 크겠습니다! 감사합니다";
    		
    		$('.think-answer').html(message);
    		
    		setTimeout(()=>{
    			$('.think-answer').html('');
    		},5000)
    	}
    	
    	/*애정도에 따른 애정도바, 아이콘, 버튼 함수*/
    	const affectionBarUpdate = (affection) => {
		    // 버튼 요소들을 가져옵니다
		    const waterButton = document.getElementById("water-button");
		    const fertilizedButton = document.getElementById("fertilized-button");
		    const nextStageButton = document.getElementById("next-stage");
		    const nextdayButton = document.getElementById("next_day_button");
		
		    if (affection > 100){
		        affection = 100;
		        document.getElementById("empty_heart").style.display = 'none';
		        document.getElementById("skull").style.display = 'none';
		        document.getElementById("full_heart").style.display = 'block';
		    }
		    else if (affection < 0) {
		        document.getElementById("full_heart").style.display = 'none';               
		        document.getElementById("empty_heart").style.display = 'none';
		        document.getElementById("skull").style.display = 'block';
		
		        // 애정도가 음수일 때 버튼들을 숨깁니다.
		        waterButton.style.display = 'none';
		        fertilizedButton.style.display = 'none';
		        nextStageButton.style.display = 'none';
		        nextdayButton.style.display = 'none';
		    }
		    else {
		        affection = affection;
		        document.getElementById("full_heart").style.display = 'none';
		        document.getElementById("skull").style.display = 'none';
		        document.getElementById("empty_heart").style.display = 'block';
		
		        // 애정도가 음수가 아닐 때 버튼들을 보이게 합니다.
		        waterButton.style.display = 'block';
		        fertilizedButton.style.display = 'block';
		        nextStageButton.style.display = 'block';
		        nextdayButton.style.display = 'block';
		    }
		    $('#gauge-fill').css('width', affection + '%');
		}
    	
		/*호감도,단계에따른 버튼보여주는 로직*/    	
    	const displayLevelUp = (affection,stage) => {
    		if(stage == 4){
    			$('.refresh-button').show();
    			$('.next-stage').hide();
    		}
    		else if(affection >= 100 && stage < 4){
    			$('.refresh-button').hide();
    			$('.next-stage').show();
    		}
    		else{
    			$('.refresh-button').show();
    			$('.next-stage').hide();
    		}
    			
    	}
    	
    	/*사진변경코드*/
    	/*
    	*@todo 캐러셀변경시 사진없음 이미지 삭제, currStage4단계까지 확장 , 사진잘림문제해결필요
    	*/
    	const changeImg = (plantId,currStage) => {
    		if(plantId == 1){
    			let imgSrc = '../../img/plant_img/Gardenia' + currStage + '.jpg';
    	        $('#carouselExampleIndicators .carousel-item.active img').attr('src', imgSrc);
    		}
    		if(plantId == 2){
    			let imgSrc = '../../img/plant_img/Hyacinth' + currStage + '.jpg';
    	        $('#carouselExampleIndicators .carousel-item.active img').attr('src', imgSrc);
    		}
    		if(plantId == 3){
    			let imgSrc = '../../img/plant_img/Cactus' + currStage + '.jpg';
    	        $('#carouselExampleIndicators .carousel-item.active img').attr('src', imgSrc);
    		}
    	}

        
        /* 식물 죽는 로직 */
        const witherPlant = (plantId) => {
    				sendAjaxRequest('/api/plant/wither','POST',{userId:userId,plantId:plantId},(response)=>{  	    	
    	    			changeImg(response.plantId,response.currStage);
    				},(error)=>{console.log(error)})
    				
    				$('#gauge-fill').css({
    				    'width': '100%',
    				    'background-color': '#463331'
    				});
    				$('empty_heart').css({
    					'color': '#463331'
    				});

        }			
                
    	/*식물데이터 얻어오는 함수*/
    	const fetchPlantData = (plantId) => {
    		sendAjaxRequest('/api/plant/info','GET',{userId:userId,plantId:plantId},(response)=>{    			
    			console.log(response)
    			affectionBarUpdate(response.affection);    			
    			changeImg(response.plantId,response.currStage);
    			displayLevelUp(response.affection,response.currStage);
    			
    			// 날짜 변경 로직
    			let datData = response.plantDay;
    			document.querySelector('.plant_day').innerText = datData + ' Day';
    			
    			if (response.affection < 0){
    				witherPlant(plantId);
    			}
    		},(error)=>{console.log(error)})

    	}
    	
       	fetchPlantData(firstPlantId);
       	
    	/*슬라이드 넘길시 로직*/
        $('#carouselExampleIndicators').on('slid.bs.carousel',function(){
        	  let plantId = $(this).find('.carousel-item.active img').data('plant-id');
        	   fetchPlantData(plantId);
        	   $('.think-answer').html('');
   	    });
    	
        /* 물주기로직 */   
    	$('.water-button').click(()=>{
    		let currentPlantId = $('#carouselExampleIndicators .carousel-item.active img').data('plant-id');
            let now = new Date();
    		now.setHours(now.getHours()+9);
    	    let formattedDateTime = now.toISOString().slice(0, 19).replace('T', ' '); //한국시간변
    	    
    		sendAjaxRequest('/api/plant/water','POST',{userId:userId, plantId:currentPlantId,lastWaterd:formattedDateTime},(response)=>{
    			console.log('waterPlant',response);
    			affectionBarUpdate(response.affection);
				answerSpeech(response.waterCount,"water");  
				displayLevelUp(response.affection,response.currStage);
				if (response.affection < 0){
    				witherPlant(currentPlantId);
    			}
    		})
    	})    
    	
    	/* 비료주기 로직*/
    	$('.fertilized-button').click(()=>{
    		let currentPlantId = $('#carouselExampleIndicators .carousel-item.active img').data('plant-id');
    		let now = new Date();
    		now.setHours(now.getHours()+9);
    	    let formattedDateTime = now.toISOString().slice(0, 19).replace('T', ' '); //한국시간변
    	    
            sendAjaxRequest('/api/plant/fertilizer','POST',{userId:userId, plantId:currentPlantId,lastFertilizedTime:formattedDateTime},(response)=>{
    			console.log(response);
    			affectionBarUpdate(response.affection);
    			answerSpeech(response.fertilizerCount,"fertilizer");
    			displayLevelUp(response.affection,response.currStage);
    			if (response.affection < 0){
    				witherPlant(currentPlantId);
    			}
    		})
    	})
    	
    	/*리프레시 버튼 로직*/
    	$('.refresh-button').click(()=>{
    		
    		let currentPlantId = $('#carouselExampleIndicators .carousel-item.active img').data('plant-id');
    		
    		sendAjaxRequest('/api/plant/refresh','POST',{userId:userId,plantId:currentPlantId},(response)=>{
    			console.log(response);
    			affectionBarUpdate(response.affection);
    			changeImg(response.plantId,response.currStage);
    			fetchPlantData(currentPlantId);
    			// witherPlant(plantId);
    		})
    		$('#gauge-fill').css({
			    'background-color': '#f97178'
			});
    	})
    	
    
    	
    	/*단계업그레이드 로직*/
    	$('.next-stage').click(()=>{
    		let currentPlantId = $('#carouselExampleIndicators .carousel-item.active img').data('plant-id');
            sendAjaxRequest('api/plant/levelup','POST',{userId:userId,plantId:currentPlantId},(response)=>{
            	console.log(response.plantId,response.currStage);
            	affectionBarUpdate(response.affection);
            	changeImg(response.plantId,response.currStage);
            	displayLevelUp(response.affection,response.currStage);
            })
    	})
    	
    	/* 다음날 버튼 로직 */
    	$('.next-day').click(() => {
    	    let currentPlantId = $('#carouselExampleIndicators .carousel-item.active img').data('plant-id');
    	    sendAjaxRequest('/api/plant/day', 'POST', {userId: userId, plantId: currentPlantId}, (response) => {
    	        console.log(response.plantId, response.plantDay);
    	        affectionBarUpdate(response.affection);
    	        fetchPlantData(currentPlantId);
    	        displayLevelUp(response.affection,response.currStage);
                
    	    });

    	});
    	
	 });
     	
     	
    </script>
    <script>
    const sendGptRequest = () => {
        let chatInput = $('#chat').val();
        let prompt = "간단하고 순수한 어휘 사용, 궁금한 것에 대한 무한한 호기심, 그리고 어린아이와 같은 단순하고 직관적인 사고 방식, 귀엽고 긍정적인 어휘를 사용해서 대답해줘. 너의 이름은 [식물이]이야. 이제 이 다음에 질문한것에대한 대답을해줘 " + chatInput;
        
        $('.think-answer').html('');
		$('#loading').show();
        sendAjaxRequest('/api/gpt','GET',{prompt:prompt},(response)=>{
        	console.log(response);
            $('.think-answer').html(response.answer);
            $('#loading').hide();
        },(error)=>console.log(error))
    }
    </script>
    <script>
    	
    </script>
    
    <!-- jQuery and Bootstrap Bundle -->
    
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
