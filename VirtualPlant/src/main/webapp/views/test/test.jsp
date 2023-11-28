<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
</head>
<body>

	<div class="container">
	<div id="loading" class="spinner-border text-primary mt-3" style="display:none;" role="status">
  		<span class="visually-hidden">Loading...</span>
	</div>
		<p class="write-gpt"></p>
		<input type="text" id="chat" class="form-control" />
		<button class="btn btn-primary" onclick="sendRequest()">전송</button>
	</div>


<script>
    const sendRequest = () => {
        let chatInput = $('#chat').val();
        // 식물 캐릭터의 성격과 말투를 반영하는 프롬프트
        let prompt = `간단하고 순수한 어휘 사용, 궁금한 것에 대한 무한한 호기심, 그리고 어린아이와 같은 단순하고 직관적인 사고 방식, 귀엽고 긍정적인 어휘를 사용해서 대답해줘. 너의 이름은 [응애식물이]이야. ${chatInput}`;

        $.ajax({
            url: '/api/gpt',
            type: 'GET',
            data: {'prompt': prompt},
            success: (response) => {
                console.log(response);
                $('.write-gpt').html(response.answer);
            },
            error: (error) => {
                console.log('Error:', error);
            }
        });
    }
</script>
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>

</body>
</html>