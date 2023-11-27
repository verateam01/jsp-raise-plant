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
		<p class="write-gpt"></p>
		<input type="text" id="chat" class="form-control"/>
		<button class="btn btn-primary" onclick="sendRequest()">전송</button>
	</div>
	
	<script>
		const sendRequest=()=>{
			let chatInput = $('#chat').val();			
			$.ajax({
				url:'/api/gpt',
				type:'GET',
				data:{'prompt':chatInput},
				success:(response)=>{
					console.log(response);
					$('.write-gpt').html(response.answer);
					
				},
				error:(error) => {
                    console.log('Error:', error);
                }
			})
		}
		
	</script>
	
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>