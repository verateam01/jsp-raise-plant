<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/manager/manager.css">
<!-- Font-awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>
</head>
<body>
	<div id="container">
		<div id="side_menu_area">
			<div id="menu_top">
				<h3>Virtual Plant</h3>
				<p>관리자 페이지</p>
			</div>
			<div id="menu_mid">
				<div class="menu_button" id="user_tab_button">
					<p>
						<i class="fa-solid fa-user" style="padding-right: 10px;"></i>회원관리
					</p>
				</div>
				<div class="menu_button" id="plant_tab_button">
					<p>
						<i class="fa-solid fa-seedling" style="padding-right: 10px;"></i>식물관리
					</p>
				</div>
			</div>
			<div id="menu_bottom">
				<div class="menu_button" id="exit_button">
					<p>
						<i class="fa-solid fa-arrow-right-from-bracket"
							style="padding-right: 10px;"></i>나가기
					</p>
				</div>
			</div>
		</div>

			
<%-- 회원관리 --%>
		<section id="user_tab" class="tab-section">
			<div id="content_top">
				<h1>회원관리</h1>
			</div>
			<div id="content_mid">

				<table border="1" id="userTable">
					<thead>
						<tr>
							<th>고유 아이디</th>
							<th>아이디</th>
							<th>이름</th>
							<th>닉네임</th>
							<th>이메일</th>
							<th>타입</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<%-- 유저데이터 --%>
					</tbody>
				</table>
			</div>
			</section>
			
			<%-- 식물관리 --%>
		<section id="plant_tab" class="tab-section" style="display:none;">
			<div id="content_top">
				<h1>식물관리</h1>
			</div>
			<div id="content_mid">

				<table border="1" id="plantTable">
					<thead>
						<tr>
							<th>고유 아이디</th>
							<th>아이디</th>
							<th>닉네임</th>
							<th>치자나무 이름</th>
							<th>히아신스 이름</th>
							<th>선인장 이름</th>
							<th>관리</th>
						</tr>
					</thead>
					<%-- 식물데이터 --%>
					<tbody>
					</tbody>
				</table>
			</div>
			</section>
					<%-- 모달 --%>
<div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="modifyModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modifyModalLabel">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        
      </div>
    </div>
  </div>
</div>
</div>
		
	



	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>



               
	
</body>
<script>

const sendAjaxRequest = (url, type, data, successCallback, errorCallback) => {
    $.ajax({
        url: url,
        type: type,
        data: data,
        success: successCallback,
        error: errorCallback
    });
};

$(document).ready(() => {		
	// 회원관리 탭 버튼 클릭 이벤트
    $("#user_tab_button").click(function() {
        // 회원관리 섹션을 표시하고, 식물관리 섹션을 숨김
        $("#user_tab").show();
        $("#plant_tab").hide();
    });

    // 식물관리 탭 버튼 클릭 이벤트
    $("#plant_tab_button").click(function() {
        // 식물관리 섹션을 표시하고, 회원관리 섹션을 숨김
        $("#plant_tab").show();
        $("#user_tab").hide();
    });

	
	const fetchUsertData  = (userType) => {
    sendAjaxRequest(
        "/api/admin/user", 
        "POST", 
        { userType: userType },
        (response) => {
        	console.log(response)
            if (typeof response === "string") {
                response = JSON.parse(response);
            }

            response.forEach((user) => {
            	console.log(user);
            	var row = '<tr>' +
                '<td>' + user.user_id + '</td>' +
                '<td>' + user.id + '</td>' +
                '<td>' + user.user_name + '</td>' +
                '<td>' + user.user_nick + '</td>' +
                '<td>' + user.email + '</td>' +
                '<td>' + user.user_type + '</td>' +
                '<td><button type="button" class="btn btn-outline-secondary" id="user_edit_btn" data-userid="' + user.user_id + '" data-bs-toggle="modal" data-bs-target="#modifyModal"><i class="fa-solid fa-pen"></i></button>' +
                '<button type="button" class="btn btn-outline-secondary" id="user_delete_btn" data-userid="' + user.user_id + '" data-bs-toggle="modal" data-bs-target="#modifyModal"><i class="fa-solid fa-trash"></i></button></td>' + 
                '</tr>';
            $("#userTable tbody").append(row);
            
            });
        },
        (error) => { 
            console.error("에러: ", error);
        }
    );
    
	}
	
	const fetchPlantData  = (userType) => {
		sendAjaxRequest(
		        "/api/admin/user", 
		        "POST", 
		        { userType: "admin" },
		        (response) => {
		            if (typeof response === "string") {
		                response = JSON.parse(response);
		            }

		            response.forEach((user) => {
		                let gardenia = user.plants.length > 0 ? user.plants[0] : "";
		                let hyacinth = user.plants.length > 1 ? user.plants[1] : "";
		                let cactus = user.plants.length > 2 ? user.plants[2] : "";

		               
		                var row = '<tr>' + 
		                    '<td>' + user.user_id + '</td>' + 
		                    '<td>' + user.id + '</td>' +
		                    '<td>' + user.user_nick + '</td>' + 
		                    '<td>' + gardenia + '</td>' + 
		                    '<td>' + hyacinth + '</td>' + 
		                    '<td>' + cactus + '</td>' + 
		                    '<td><button type="button" class="btn btn-outline-secondary" id="plant_edit_btn" data-userid="' + user.user_id + '" data-bs-toggle="modal" data-bs-target="#modifyModal"><i class="fa-solid fa-pen"></i></button>' + 
		                   '</tr>';
		                $("#plantTable tbody").append(row);
		            });
		        },
		        (error) => { 
		            console.error("에러: ", error);
		        }
		    );
	    
		}
	
	fetchUsertData("admin");
	fetchPlantData("admin");
	
	
	// 회원 수정 모달
	$(document).on('click', '#user_edit_btn', function() {
		
		$('#modifyModal .modal-title').text('회원 수정하기');
		$('#modifyModal .modal-footer').html('<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button><button type="button" id="save-user-btn" class="btn btn-primary">저장하기</button>');
		
	    let modalUserId = $(this).data('userid');

	    $.get('/views/manager/userEdit.html', function(htmlContent) {
	        $('#modifyModal .modal-body').html(htmlContent);
	        
	        
	    }).fail(function() {
	        console.error("HTML 파일을 불러오는 데 실패했습니다.");
	    });

	    sendAjaxRequest(
	        "/api/admin/user",
	        "POST",
	        { userType: "admin" },
	        (response) => {	            
	            let userData = response.find(user => {
    			return String(user.user_id) === String(modalUserId);
			});
	            console.log('전체 응답 데이터:', response);           
	            

	            if (userData) {
	            	$('#modifyModal .modal-body input[name="user_id"]').val(userData.user_id);
	                $('#modifyModal .modal-body input[name="id"]').val(userData.id);
	                $('#modifyModal .modal-body input[name="name"]').val(userData.user_name);
	                $('#modifyModal .modal-body input[name="nickname"]').val(userData.user_nick);
	                $('#modifyModal .modal-body input[name="email"]').val(userData.email);
	                $('#modifyModal .modal-body input[name="type"]').val(userData.user_type);
	            }
	            else {
	                console.log('해당 userId를 가진 사용자를 찾지 못함:', modalUserId);
	            }
	        },
	        (error) => {
	            console.error("에러: ", error);
	        }
	    );
	    $('#save-user-btn').data('userid', modalUserId);
	});

	
	// 회원정보 저장
	$(document).on('click', '#save-user-btn', function() {
    // AJAX 요청 로직
	    let userId = $(this).data('userid');
	    let id = $('#modifyModal .modal-body input[name="id"]').val();
	    let user_name = $('#modifyModal .modal-body input[name="name"]').val();
	    let user_nick = $('#modifyModal .modal-body input[name="nickname"]').val();
	    let email = $('#modifyModal .modal-body input[name="email"]').val();
	    let userType = $('#modifyModal .modal-body input[name="type"]').val();
	    console.log(userId);
	    console.log(id);
	    sendAjaxRequest('/api/admin/user/edit', 'POST', {
	        userId: userId, 
	        id: id, 
	        userName: user_name, 
	        userNick: user_nick,
	        email: email, 
	        userType: userType 
	    }, (response) => {
	        if(response.status == "success")
	            window.location.reload();
	    }, (error) => {
	        console.error("에러: ", error);
	    });
	});
	
	
	// 식물 수정 모달
	$(document).on('click', '#plant_edit_btn', function() {
		$('#modifyModal .modal-title').text('식물 수정하기');
		$('#modifyModal .modal-footer').html('<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button><button type="button" id="save-plant-btn" class="btn btn-primary">저장하기</button>');
		
	    let modalUserId = $(this).data('userid');

	    $.get('/views/manager/plantEdit.html', function(htmlContent) {
	        $('#modifyModal .modal-body').html(htmlContent);
	        
	        
	    }).fail(function() {
	        console.error("HTML 파일을 불러오는 데 실패했습니다.");
	    });

	    sendAjaxRequest(
	        "/api/admin/user",
	        "POST",
	        { userType: "admin" },
	        (response) => {	            
	            let userData = response.find(user => {
    			return String(user.user_id) === String(modalUserId);
			});
	            let gardenia = userData.plants.length > 0 ? userData.plants[0] : "";
                let hyacinth = userData.plants.length > 1 ? userData.plants[1] : "";
                let cactus = userData.plants.length > 2 ? userData.plants[2] : "";

	            if (userData) {
	            	$('#modifyModal .modal-body input[name="user_id"]').val(userData.user_id);
	            	$('#modifyModal .modal-body input[name="id"]').val(userData.id);
	            	$('#modifyModal .modal-body input[name="nickname"]').val(userData.user_nick);
	            	$('#modifyModal .modal-body input[name="gardenia"]').val(gardenia);
	            	$('#modifyModal .modal-body input[name="hyacinth"]').val(hyacinth);
	            	$('#modifyModal .modal-body input[name="cactus"]').val(cactus);
	            }
	            else {
	                console.log('해당 userId를 가진 사용자를 찾지 못함:', modalUserId);
	            }
	        },
	        (error) => {
	            console.error("에러: ", error);
	        }
	    );
	    $('#save-user-btn').data('userid', modalUserId);
	    $('#save-plant-btn').data('userid', modalUserId);
	});

	
	// 식물정보 저장
	$(document).on('click','#save-plant-btn',function(){
		let userId = $(this).data('userid');
        let gardenia = $('#modifyModal .modal-body input[name="gardenia"]').val();
        let hyacinth = $('#modifyModal .modal-body input[name="hyacinth"]').val();
        let cactus = $('#modifyModal .modal-body input[name="cactus"]').val();
        
        sendAjaxRequest('/api/admin/plant/edit', 'POST', {
            userId: userId, 
            gardenia: gardenia,
            hyacinth: hyacinth,
            cactus: cactus
        }, (response) => {
            response = JSON.parse(response);
            if(response.status == "success")
	            window.location.reload();
        }, (error) => {
            console.error("에러: ", error);
        });
		
	})


	

	$(document).on('click', '#user_delete_btn', function() {
		let modalUserId = $(this).data('userid');
		$('#modifyModal .modal-title').text('회원 삭제하기');
	    $('#modifyModal .modal-body').text('유저를 삭제하시겠습니까?');
	    $('#modifyModal .modal-footer').html('<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button><button type="button" id="delete-btn" class="btn btn-danger">삭제하기</button>');
	    $('#delete-btn').data('userid', modalUserId);
	    console.log(modalUserId);
	});
	
	// 이벤트 위임을 통한 '삭제하기' 버튼 클릭 처리
	$(document).on('click', '#delete-btn', function() {  
	    let userId = $(this).data('userid');
	    console.log(userId); // 데이터 확인
	    sendAjaxRequest('/api/admin/user/delete', 'POST', {
	        userId: userId,            
	    }, (response) => {
	        response = JSON.parse(response);
	        if(response.status == "success")
	            window.location.reload();
	    }, (error) => {
	        console.error("에러: ", error);
	    });
	});


	// 메인으로 돌아가기
	$('#exit_button').click(()=>{
		window.location.href='/main';
    })
	

	});



</script>
</html>