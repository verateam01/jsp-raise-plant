<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/views/register/register.css">
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>

</head>
<body>
    <div class="container d-flex flex-column" style="height: 100vh;">
        <div style="margin: 50px;" class="needs-validation" novalidate>
            <h1>회원가입</h1>
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingName" placeholder="이름" name="name" required>
                <label for="floatingName">이름</label>
                <div class="invalid-feedback">이름을 입력해주세요.</div>
            </div>
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingNick" placeholder="닉네임" name="nick" required>
                <label for="floatingNick">닉네임</label>
                <div class="invalid-feedback">닉네임을 입력해주세요.</div>
            </div>
            <div class="form-floating mb-3 d-flex">
                <input type="text" class="form-control" id="floatingId" placeholder="아이디" name="id" required>
                <label for="floatingId">아이디</label>
                <button id="duplicatedId" class="btn btn-primary" style="margin-left: 20px; width:100px; background-color: #f97178; border:none;">중복확인</button>
                <div class="invalid-feedback feedback-id">아이디를 입력해주세요.</div>
            </div>
            <div id="idWarning" class="alert alert-danger mt-2" style="display: none;">아이디가 이미 존재합니다!</div>
            <div id="idSuccess" class="alert alert-success mt-2" style="display: none;">사용가능한 아이디입니다!</div>
            <div class="form-floating mb-3">
                <input type="email" class="form-control" id="floatingEmail" placeholder="이메일" name="email" required>
                <label for="floatingEmail">이메일</label>
                <div class="invalid-feedback">이메일형식이 맞지않습니다</div>
            </div>
            <div class="form-floating mb-3">
                <input type="password" class="form-control" id="floatingPassword" placeholder="비밀번호" name="pw" required>
                <label for="floatingPassword">비밀번호</label>
                <div class="invalid-feedback">비밀번호를 입력해주세요.</div>
            </div>
            <div class="d-flex justify-content-end mt-3">
                <button id="registerButton" class="btn btn-primary" style="width: 90px; height:65px; background-color: #f97178; border:none;">회원가입</button>
            </div>
            <div class="d-flex justify-content-center mt-2">
                <p>회원이신가요? <a href="/login" style="text-decoration:none; color:#f97178;">로그인하러가기</a></p>
            </div>
            <div class="d-flex justify-content-center mt-2">
                <img src="../../img/plant_img/welcome.jpg" style="width:60%;">
            </div>
        </div>
    </div>

    <script>
        $(document).ready(() => {
        	//이메일검사
        	 function validateEmail(email) {
                 const re = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
                 return re.test(String(email).toLowerCase());
             }

             // 이메일 필드 변경 이벤트
             $("input[name='email']").on('input', function() {
                 if (!validateEmail($(this).val())) {
                     $(this).addClass('is-invalid');
                     $(".feedback-email").text("유효하지 않은 이메일 형식입니다."); // 피드백 메시지 변경
                 } else {
                     $(this).removeClass('is-invalid').addClass('is-valid');
                     $(".feedback-email").text(""); // 피드백 메시지 제거
                 }
             });
        	
            let idValid = false;

            function validateField(field) {
                if (field.val().trim() === "") {
                    field.addClass('is-invalid').removeClass('is-valid');
                } else {
                    field.removeClass('is-invalid').addClass('is-valid');
                }
            }

            $("#duplicatedId").click(() => {
            	let id = $("input[name='id']").val().trim();
                checkDuplicateId(id);
            });

            let checkDuplicateId = (id) => {
                $.ajax({
                    url: "/api/duplicate",
                    type: "POST",
                    data: { id: id },
                    success: (response) => {
                        if (response.status === "success") {
                        	$('#idWarning').show();
                            $('#idSuccess').hide();
                            $("#floatingId").addClass('is-invalid').removeClass('is-valid');
                            $(".feedback-id").hide();
                            idValid = false;
                        } else {
                        	$('#idWarning').hide();
                            $('#idSuccess').show();
                            $("#floatingId").removeClass('is-invalid').addClass('is-valid');
                            $(".feedback-id").hide(); 
                            idValid = true;
                        }
                    }
                });
            }

            $("#registerButton").click(() => {
                let isValid = true;
                $('.needs-validation input').each(function() {
                    validateField($(this));
                    if ($(this).hasClass('is-invalid')) {
                        isValid = false;
                    }
                });
                
                const email = $("input[name='email']").val();
                if (!validateEmail(email)) {
                    $("input[name='email']").addClass('is-invalid');
                    isValid = false;
                }
                
                if (!idValid) {
                    alert("사용자 중복 체크를 해주세요.");
                    return;
                }
                
                if(!isValid){
                	alert('빈칸이존재합니다');
                	return;
                }
                
                if (isValid && idValid) {
                	let name = $("input[name ='name']").val();
                    let nick = $("input[name ='nick']").val();
                    let id = $("input[name ='id']").val();
                    let email = $("input[name='email']").val();
                    let pw = $("input[name ='pw']").val();

                    $.ajax({
                        url: "/api/register",
                        type: "POST",
                        data: {
                            name,
                            nick,
                            id,
                            email,
                            pw
                        },
                        success: (response) => {
                            window.location.href = "/login";
                        }
                    });
    
                }
                
            });
        });
    </script>
</body>
</html>
