<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!-- jQuery 라이브러리 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Course_contents</title>
	<script type="text/javascript">
		function AddCourseContent(pIndex) {
			alert("AddCourseContent Run...");  
			alert("AddCourseContent pIndex->" + pIndex); 
			var selTitle =   $("#title"+pIndex).val();
			var selAddress =   $("#address"+pIndex).val();
			console.log(selTitle);

		}
		function getcheckboxValue(){
			var checkbox = document.getElementsByName("content").length;
			
			for(var i = 0; i < checkbox; i++) {
				if(document.getElementsByName("content")[i].checked === true) {
					//alert(document.getElementsByName("content")[i].value);
				}
			};
						
			console.log("1. 체크박스 갯수만큼 포문돌린다.\n 각 체크박스에 해당하는 콘텐츠아이디를 콜솔에 찍거나 럴럿트 한다.");
			console.log("2. 체크된 녀석들의 콘텐츠를 어딘가담는다 . 특정규칙을 추가해서");
			console.log("3. 자식창을 닫고 부모창에 2번에 해당하는 값을 던진다.");

		}
	</script>
</head>
<body>
<div class="container-fluid">
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<main>
		<!-- Section1: Title -->
		<div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
			<h1>여행 코스의 컨텐츠를 추가 해주세요</h1>
		</div>
		
		<!-- Section2: Search Form -->		
		<div class="border p-3 m-3">
			<h1 class="border">검색폼</h1>
			<button type="button" class="btn btn-outline-secondary">검색</button>
			<button type="button" class="btn btn-outline-secondary">초기화</button>
			<button type="button" class="btn btn-outline-secondary" onclick="getcheckboxValue()">확인</button>
			
		</div>
		
		
		<!-- Section3: Table -->		
		<div class="border p-3 m-3">
			<c:forEach var="content" items="${listContents }" varStatus="status">
				<input type="hidden" name="id" value="${content.id }">
				<input type="checkbox" name="content" value="${content.id }"  style="height: 20px;, widows: 20px;">
				<table class="table table-striped table-sm">
					<tr>
						<th>사진</th><th>이름</th><th>주소</th><th>홈페이지</th><th>연락처</th>
					</tr>
					<tr>
						<td><img src="${content.img1 }" alt="${content.title }" class="card-img-top" style="height: 150px;"></td>
						<td>${content.title }</td>
						<td>${content.address }</td>
						<td>${content.homepage }</td>
						<td>${content.phone }</td>
					</tr>
				</table>
			</c:forEach>
		</div>
		
	</main>
</div>
</body>
</html>