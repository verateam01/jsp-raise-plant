<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">

<!-- Font-awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/js/all.min.js"></script>
</head>
<body>
	<div>
		<!-- Button trigger modal -->
		<button type="button" class="btn btn-secondary" data-bs-toggle="modal"
			data-bs-target="#exampleModal" style="border-radius: 20px;">
			<i class="fa-solid fa-question fa-xl"></i>
		</button>

		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-scrollable">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="exampleModalLabel">Modal
							title</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">

						456<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>
						123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>
						123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>
						123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>123<br></br>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary">Save
							changes</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>