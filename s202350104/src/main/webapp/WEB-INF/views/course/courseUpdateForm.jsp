<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>course UpdateForm</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous">
</script>

<!-- jQuery 라이브러리 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
	function closeAndRedirect() {
		// 취소 시 이전페이지 이동
		window.history.back();
	}
</script>

<script type="text/javascript">
	function showPopUp() {
		
		//창 크기 지정
		var width = 800;
		var height = 600;
		
		//pc화면기준 가운데 정렬
		var left = (window.screen.width / 2) - (width/2);
		var top = (window.screen.height / 4);
		
		//윈도우 속성 지정
		var windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+', scrollbars=yes, status=yes, resizable=yes, titlebar=yes';
		
		//연결하고싶은url
		const url = "contentListAll"
		
		//등록된 url 및 window 속성 기준으로 팝업창을 연다.
		window.open(url, "contentList popup", windowStatus);
	}
	
	function receiveContentList(contentList) {
		
	    // contentList 데이터를 HTML 테이블로 변환
	    var table = "<table>";
	    table += "<thead><tr><th>ID</th><th>이미지</th><th>이름</th><th>주소</th><th>홈페이지</th><th>연락처</th></tr></thead>";
	    table += "<tbody>";

	    for (var i = 0; i < contentList.length; i++) {
	        table += "<tr>";
	        table += "<td>" + contentList[i].id + "</td>";
	        table += "<td><img src='" + contentList[i].img + "' alt='이미지'></td>";
	        table += "<td>" + contentList[i].title + "</td>";
	        table += "<td>" + contentList[i].address + "</td>";
	        table += "<td>" + contentList[i].homepage + "</td>";
	        table += "<td>" + contentList[i].phone + "</td>";
	        table += "</tr>";
	    }

	    table += "</tbody></table>";
	    

	    // 테이블을 HTML 요소에 삽입
	    document.getElementById("contentTable").innerHTML = table;

	    for (var i = 0; i < contentList.length; i++) {
	    	const form =document.getElementById("myForm");
	    	const hiddenInput = document.createElement("input");
	    	hiddenInput.type = "hidden";
	    	hiddenInput.name = "contents";
	    	hiddenInput.value = contentList[i].id;
	    	form.appendChild(hiddenInput);
	    }
	}
</script>

</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	
	<div class="container mt-5">
		<div class="card">
			<div class="card_header">
				<h2>코스 수정</h2>
			</div>
			<div class="card-body">
				<form action="courseUpdate" method="post">
					<input type="hidden" name="id" value="${courseContent.id }">
					<input type="hidden" name="course_title" value="${courseContent.course_title }">
					<div class="mb-3">
						<label for="course_title" class="form-label">코스 명</label>
						<input type="text" id="course_title" name="course_title" class="form-control" required="required" value="${courseContent.course_title }">
					</div>
					<div class="mb-3">
						<label for="">코스항목</label>
						<button class="btn btn-primary" onclick="location.href='javascript:showPopUp()'">코스 수정</button>
						<div id="contentTable">
				
						</div>
					</div>
					
					<div class="mb-3">
						<label for="distance" class="form-label">거리(km)</label>
						<input type="text" id="distance" name="distance" class="form-control" required="required" value="${courseContent.distance }">
					</div>
					<div class="mb-3">
						<label for="time" class="form-label">소요시간</label>
						<input type="text" id="time" name="time" class="form-control" required="required" value="${courseContent.time }">
					</div>
					<div class="mb-3">
						<label for="course_info" class="form-label">코스 내용</label>
						<textarea class="form-control" id="course_info" name="course_info" rows="5">${courseContent.course_info }</textarea>
					</div>
					<div class="text-center">
						<button type="submit" class="btn btn-primary">확인</button>
						<a href="#" class="btn btn-secondary" onclick="closeAndRedirect()">취소</a>
					</div>
				</form>
			</div>
		</div>
	
	
		<%-- <c:forEach var="courseContent" items="${courseContent }">
			<c:if test="${courseContent.order_num == 1}">
				<h1>${courseContent.course_title }</h1>
				<div class="container border p-5">
					<img alt="${courseContent.course_title }" src="${courseContent.img1 }">
				</div>
				<div class="container border p-5">
					<ul>
						<li>코스 이름 : ${courseContent.course_title }
						<li>코스 내용 : ${courseContent.course_info }
						<li>코스 거리 : ${courseContent.distance }
						<li>주 소 :	${courseContent.address }
						<li>전화번호 :	${courseContent.phone }
					</ul>
				</div>
			</c:if>
		</c:forEach>
	</div>
	
	<div>
		<c:forEach var="courseContent" items="${courseContent }">
		<div class="container border p-5">
			<a href='../${courseContent.cd_content.toLowerCase() }/detail?contentId=${courseContent.content_id}'>
				<img alt="${courseContent.course_title }" src="${courseContent.img1 }">
			</a>
			<ul>
				<li>코스이름 : <input type="text" id="title" name="title" value="${courseContent.title }"> 
				<li>개요 : <input type="text" id="content" name="content" value="${courseContent.content }">
				<li>홈페이지 : <input type="text" id="homepage" name="homepage" value="${courseContent.homepage }">
			</ul>
		</div>
		</c:forEach>
	</div> --%>
	<!-- review test -->
	<div>
		<h3>review 구역</h3>
	</div>
</body>
</html>