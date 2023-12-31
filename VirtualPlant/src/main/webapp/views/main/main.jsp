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
</head>
<body>
<%
        User user = (User)session.getAttribute("user");
        String kakaoUserName = (String)session.getAttribute("kakao_name");
        String kakaoId = (String)session.getAttribute("kakao_id");
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
        	
        	<div id="guide_modal">
        	
        	<!-- Button trigger modal -->
		<button type="button" id="modal_button" class="btn btn-secondary" data-bs-toggle="modal"
			data-bs-target="#exampleModal" style="border-radius: 20px;">
			<i class="fa-solid fa-question fa-xl"></i>
		</button>

		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-scrollable modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title help-flower-title fs-1" id="exampleModalLabel"></h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body help-flower">
						도움말
					</div>
					<p>
				</div>
			</div>
		</div>
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
            <!--식물이름 -->
            <div class="plant-div">
			    <span class="plant-name" style="font-size:2rem;">식물 이름</span>
			    <i class="fa-solid fa-pen open-pen" style="padding-bottom:4px;"></i>
			    <div class="edit-plant-container d-none align-items-center">
			        <div class="input-group">
			            <input type="text" class="form-control edit-plant-name" value="" name="edit-plant-name"/>
			            <span class="input-group-text">
			                <i class="fa-solid fa-pen save-plant-name close-pen"></i>
			            </span>
			        </div>
			    </div>
			</div>
        </div>
        
        
        <div id="action_area">
            <div class="buttons_container">
                <button id="water-button" class="water-button action_button">물주기</button>
                <button id="fertilized-button" class="fertilized-button action_button">비료주기</button>
				<button type="button" class="refresh-button btn btn-outline-primary action_button" data-bs-toggle="modal" data-bs-target="#reset-modal">Refresh</button>
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
                <%if("admin".equals(userType)) {%>
                <li><a class="manager-menu dropdown-item" href="#">관리자 메뉴</a></li>
                <%} %>
                <li><a class="dropdown-item logout-button" href="#">로그아웃</a></li>
            </ul>
        </div>
    </div> 
    
	    <!-- Modal -->
	<div class="modal fade" id="reset-modal" tabindex="-1" aria-labelledby="refreshModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">식물 초기화</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        정말 식물을 초기화 하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	        <button type="button" class="reset-btn btn btn-primary"  data-bs-dismiss="modal">초기화</button>
	      </div>
	    </div>
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
let userId = null;

$(document).ready(function() {
    	userId = "<%= id %>";
    	let userType = "<%=userType%>";
    	console.log('userType',userType)
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
    	
    	let timeoutHandle; //시간담을 변수 
    	const answerSpeech = (count,type,affection) => {
    		let message = "";
    		if(count > 3 && type=="water" && affection >= 0)
    			message = "너무 물이 많아요 ㅠㅠ<br> 다음날 주세요!!<br> 오늘 횟수:" + count;
    		else if(count <= 3 && type=="water" && affection >= 0)
    			message = "물을 주셔서 감사합니다!<br> 하루3번인거 잊지 않으셨죠?";
    		else if(count > 2 && type=="fertilizer" && affection >= 0)
    			message = "영양분 과다 섭취 입니다 ㅠㅠ <br> 오늘 횟수:" + count;
    		else if(count <=2 && type=="fertilizer" && affection >= 0)
    			message = "쑥쑥 크겠습니다! 감사합니다 ㅎㅎ";
    		else if(affection < 0){
    			message = "ㅠㅠ 시들시들 Refresh버튼으로 초기화해주세요!";
    		}
    		clearTimeout(timeoutHandle);
    		
    		$('.think-answer').html(message);
    		timeoutHandle = setTimeout(()=>{
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
		
		    if (affection >= 100){
		        affection = 100;
		        document.getElementById("empty_heart").style.display = 'none';
		        document.getElementById("skull").style.display = 'none';
		        document.getElementById("full_heart").style.display = 'block';
		        $('#gauge-fill').css('background-color', '#f97178');
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
		        $('#gauge-fill').css('background-color', '#463331');
		    }
		    else {
		        affection = affection;
		        document.getElementById("full_heart").style.display = 'none';
		        document.getElementById("skull").style.display = 'none';
		        document.getElementById("empty_heart").style.display = 'block';
		        $('#gauge-fill').css('background-color', '#f97178');
		
		        // 애정도가 음수가 아닐 때 버튼들을 보이게 합니다.
		        waterButton.style.display = 'block';
		        fertilizedButton.style.display = 'block';
		        nextStageButton.style.display = 'block';
		        nextdayButton.style.display = 'block';
		    }
		    $('#gauge-fill').css('width', affection + '%')
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
		
    	$('.manager-menu').click(()=>{
    		sendAjaxRequest('/api/admin/user','POST',{userType:userType},(response)=>{
    			console.log(response);
    			if('<%=userType%>' == 'admin'){    				
		                window.location.href='/manager';
		                console.log(<%=userType%>);
		                }
    			
    		
    			else {
    				alert("관리자만 접근할 수 있습니다.");
    				console.log('<%=userType%>');
    			}
    		},(err)=>{console.log(err)})
    	})
    	
    	/*사진변경코드*/    	
    	const changeImg = (plantId, currStage) => {
    	    let imgSrc, jspFile;

    	    if (plantId == 1) {
    	        imgSrc = '../../img/plant_img/Gardenia' + currStage + '.jpg';
    	        $('.help-flower-title').text('치자나무는 어떻게 키워요?');
    	        jspFile = '/views/modal/GardeniaGuide.html';
    	        
    	    } else if (plantId == 2) {
    	        imgSrc = '../../img/plant_img/Hyacinth' + currStage + '.jpg';
    	        $('.help-flower-title').text('히아신스는 어떻게 키워요?');
    	        jspFile = '/views/modal/HyacinthGuide.html'; 
    	    } else if (plantId == 3) {
    	        imgSrc = '../../img/plant_img/Cactus' + currStage + '.jpg';
    	        $('.help-flower-title').text('선인장은 어떻게 키워요?');
    	        jspFile = '/views/modal/CactusGuide.html';
    	    }

    	    // 이미지 소스 변경
    	    $('#carouselExampleIndicators .carousel-item.active img').attr('src', imgSrc);

    	    // JSP 파일 불러오기
    	    if (jspFile) {
    	        $.get(jspFile, function(data) {
    	            $('.help-flower').html(data);
    	        });
    	    }
    	};
        
        /* 식물 죽는 로직 */
        const witherPlant = (plantId) => {
    				sendAjaxRequest('/api/plant/wither','POST',{userId:userId,plantId:plantId},(response)=>{  	    	
    	    			changeImg(response.plantId,response.currStage);
    	    			$('#gauge-fill').css({
        				    'width': '100%',
        				    'background-color': '#463331'
        				});
        				$('empty_heart').css({
        					'color': '#463331'
        				});
    				},(error)=>{console.log(error)})
        }			
                               
    	/*식물데이터 얻어오는 함수*/
    	const fetchPlantData = (plantId) => {
    		sendAjaxRequest('/api/plant/info','GET',{userId:userId,plantId:plantId},(response)=>{    			
    			console.log(response)
    			affectionBarUpdate(response.affection);    			
    			changeImg(response.plantId,response.currStage);
    			displayLevelUp(response.affection,response.currStage);
    			$('.plant-name').html(response.plantName);
    			
    			// 날짜 변경 로직
    			let datData = response.plantDay;
    			document.querySelector('.plant_day').innerText = datData + ' Day';
    			
    			if (response.affection < 0){
    				witherPlant(plantId);
    			}
    		},(error)=>{console.log(error)})

    	}
    	
       	fetchPlantData(firstPlantId);
       	
       	/*식물이름 수정*/
       	const showEditElements= () =>{
		    let currentName = $('.plant-name').text();
		    $('.edit-plant-name').val(currentName);
		    $('.edit-plant-container').removeClass('d-none').addClass('d-flex');
		    $('.plant-name').hide();
		    $('.open-pen').hide();
		    $('.edit-plant-name').focus();
		}
       	
       	const hideEditElements = ()=> {
       	    $('.edit-plant-container').addClass('d-none').removeClass('d-flex');
       	    $('.open-pen').show();
       	    $('.plant-name').show();
       	}
       	
       	$(document).on('click', '.plant-div', function(e) {
       		e.stopPropagation();
            if ($(e.target).is('.plant-name, .open-pen')) {
                showEditElements();
            }
       	})
       	
       	$('.save-plant-name').click(function() {
        	let newName = $('.edit-plant-name').val();
        	let plantId = $('#carouselExampleIndicators .carousel-item.active img').data('plant-id');
        	sendAjaxRequest('/api/plant/name/edit','POST',{
        		newName,
        		userId,
        		plantId
        	},(res)=>{
        		if(res.plantName)
		        		$('.plant-name').text(res.plantName)
        		hideEditElements();
        	});
    	});
       	
       	
       	$('.edit-plant-name').keypress(function(e) {
	        if(e.which == 13) { // 엔터 키 코드는 13
	            let newName = $(this).val();
	            let plantId = $('#carouselExampleIndicators .carousel-item.active img').data('plant-id');
	            console.log(newName);
	            sendAjaxRequest('/api/plant/name/edit','POST',{
	        		newName,
	        		userId,
	        		plantId
	        	},(res)=>{
        		if(res.plantName)
		        		$('.plant-name').text(res.plantName)
        		hideEditElements();
        	});
	        }
    	});
       	
       	$(document).click(function(e) {
            if (!$(e.target).closest('.edit-plant-container').length && !$(e.target).is('.open-pen')) {
                $('.edit-plant-container').removeClass('d-flex').addClass('d-none');
                $('.plant-name').show();
                $('.open-pen').show();
            }
        });
       	
       	
       	
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
				answerSpeech(response.waterCount,"water",response.affection);  
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
    			answerSpeech(response.fertilizerCount,"fertilizer",response.affection);
    			displayLevelUp(response.affection,response.currStage);
    			if (response.affection < 0){
    				witherPlant(currentPlantId);
    			}
    		})
    	})
    	
    	/*리프레시 버튼 로직*/
    	$('.reset-btn').click(()=>{
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

const sendGptRequest = () => {
    let currentPlantId = $('#carouselExampleIndicators .carousel-item.active img').data('plant-id');

    sendAjaxRequest('/api/plant/info', 'GET', { userId: userId, plantId: currentPlantId }, (response) => {
        console.log(response);
        let plant_name = response.plantName;
        let plant_affection = response.affection;
        let plant_feel;
        let chatInput = $('#chat').val();
        if (plant_affection >= 50) {
        	plant_feel = "기분 좋은 상태야.";
        }
        else if (plant_affection >= 0) {
        	plant_feel = "기분이 그저 그런 상태야.";
        }
        else {
        	plant_feel = "시들어서 잎이 다 말랐어.";
        }
        
        let prompt = "너는 식물이야. 그리고 너의 이름은 " + plant_name + "야. 질문을 하는 사람인 나의 이름은 " + " <%= name %> " +  "이야. 먼저 나에게 인사를 하고, 그 다음 자신을 소개하고 , 그 다음에 이 질문에 대답해줘: " + chatInput + ". 너의 대답은 간단하고 순수한 어휘를 사용해야 해. 어린아이처럼 궁금한 것에 대한 호기심을 가지고, 단순하고 직관적인 사고 방식으로 답해줘." + plant_feel;


        $('.think-answer').html('');
        $('#loading').show();
        sendAjaxRequest('/api/gpt', 'GET', { prompt: prompt }, (response) => {
            console.log(response);
            $('.think-answer').html(response.answer);
            $('#loading').hide();
        }, (error) => {
            console.log(error);
            $('#loading').hide();
        });

    }, (error) => {
        console.log(error);
        // 여기에 오류 처리 로직을 추가할 수 있습니다.
    });
}

    	
        
    </script>    
    <!-- jQuery and Bootstrap Bundle -->
    
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>
