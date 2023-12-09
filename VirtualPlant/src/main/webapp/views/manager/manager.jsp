<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/views/manager/manager.css">
<!-- Font-awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
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
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
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


$(document).ready(function() {
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
});





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
                '<td><button type="button" class="btn btn-outline-secondary" id="user_edit_btn" data-userid="' + user.user_id + '" data-bs-toggle="modal" data-bs-target="#exampleModal"><i class="fa-solid fa-pen"></i></button>' +
                '<button type="button" class="btn btn-outline-secondary" id="user_delete_btn" data-userid="' + user.user_id + '" data-bs-toggle="modal" data-bs-target="#exampleModal"><i class="fa-solid fa-trash"></i></button></td>' + 
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
		                let gardenia = user.plants.length > 0 ? user.plants[2] : "";
		                let hyacinth = user.plants.length > 1 ? user.plants[1] : "";
		                let cactus = user.plants.length > 2 ? user.plants[0] : "";

		               
		                var row = '<tr>' + 
		                    '<td>' + user.user_id + '</td>' + 
		                    '<td>' + user.id + '</td>' +
		                    '<td>' + user.user_nick + '</td>' + 
		                    '<td>' + gardenia + '</td>' + 
		                    '<td>' + hyacinth + '</td>' + 
		                    '<td>' + cactus + '</td>' + 
		                    '<td><button type="button" class="btn btn-outline-secondary" id="plant_edit_btn" data-userid="' + user.user_id + '" data-bs-toggle="modal" data-bs-target="#exampleModal"><i class="fa-solid fa-pen"></i></button>' +
		                    '<button type="button" class="btn btn-outline-secondary" id="plant_delete_btn" data-userid="' + user.user_id + '" data-bs-toggle="modal" data-bs-target="#exampleModal"><i class="fa-solid fa-trash"></i></button></td>' + 
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
	
	// 수정 삭제 로직
	
	$(document).on('click', '#user_edit_btn', function() {
	    $('#exampleModal .modal-body').text('유저 수정중');
	});
	$(document).on('click', '#user_delete_btn', function() {
	    $('#exampleModal .modal-body').text('유저 삭제중');
	});
	$(document).on('click', '#plant_edit_btn', function() {
	    $('#exampleModal .modal-body').text('식물 수정중');
	});
	$(document).on('click', '#plant_delete_btn', function() {
	    $('#exampleModal .modal-body').text('식물 삭제중');
	});

	// 메인으로 돌아가기
	$('#exit_button').click(()=>{
		window.location.href='/main';
    })
	
});



</script>
</html>