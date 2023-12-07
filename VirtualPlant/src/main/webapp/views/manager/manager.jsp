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
				<div class="menu_button">
					<p>
						<i class="fa-solid fa-user" style="padding-right: 10px;"></i>회원관리
					</p>
				</div>
				<div class="menu_button">
					<p>
						<i class="fa-solid fa-seedling" style="padding-right: 10px;"></i>식물관리
					</p>
				</div>
			</div>
			<div id="menu_bottom">
				<div class="menu_button">
					<p>
						<i class="fa-solid fa-arrow-right-from-bracket"
							style="padding-right: 10px;"></i>나가기
					</p>
				</div>
			</div>
		</div>
		<div id="content_area">
			<div id="content_top">
				<h1>회원관리</h1>
			</div>
			<div id="content_mid">
			
				<table border="1" class="dataframe">
					<thead>
						<tr>
							<th>아이디</th>
							<th>이름</th>
							<th>닉네임</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Row 1 Value</td>
							<td>10</td>
							<td>A</td>
						</tr>
						<tr>
							<td>Row 2 Value</td>
							<td>20</td>
							<td>B</td>
						</tr>
						<tr>
							<td>Row 3 Value</td>
							<td>30</td>
							<td>C</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script
		src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
		<script></script>
		<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>