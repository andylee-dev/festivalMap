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
		 console.log("showPopUp 함수 호출됨");
		
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
<script type="text/javascript">
	/* function deleteCourseContent(content_id, course_id) {
		$.ajax({
			type: 'POST',
			url:  'deleteCourseContentAjax',
			data: {content_id: content_id, course_id: course_id},
			success : function(result) {
				// // 성공적으로 삭제된 경우의 처리
				alert('삭제되었습니다.')
				location.reload();
			},
			error: function(xhr, status, error) {
				//오류 발생 시의 처리
				alert('삭제에 실패했습니다.');
			}
		});
	} */
	
	
	function deleteCourseContent(content_id, course_id) {
		alert(content_id)
		alert(course_id)
 	    // ContentCourse 객체를 생성하고 필드에 값을 할당
 	    var courseContent = {
 	    	course_id: course_id,
 	        content_id: content_id
 	    };

 	    $.ajax({
 	        url: "/admin/course/deleteCourseContentAjax",
 	        method: "POST",
 	        contentType: "application/json", 
 	        data: JSON.stringify(courseContent), // Contents 객체를 data에 할당
 	        success: function(deleteCourseContentStr) {
 	        	console.log(deleteCourseContentStr)
				// 성공적으로 삭제된 경우의 처리
				alert('삭제되었습니다.')
 				location.reload();
			},
			error: function(xhr, status, error) {
				console.log(xhr,status,error)
				//오류 발생 시의 처리
				alert('삭제에 실패했습니다.');
 				location.reload();
			}
 	    });
 	}
	
</script>

</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	
	<h1>코스 수정</h1>
	<div class="container mt-5">
		<form id="myForm" action="courseUpdate" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${courseContent.id }">
			<input type="hidden" name="course_title" value="${courseContent.course_title }">
			<div class="form-group">
				<label for="course_title">코스 명</label>
				<input type="text" id="course_title" name="course_title" class="form-control" required="required" value="${courseContent.course_title }">
			</div>
				<div class="form-group">
					<label>코스항목</label>
					<button class="btn btn-primary" onclick="showPopUp(); event.preventDefault();">코스 수정</button>
					<div id="contentTable">
			
					</div>
					<div>
						<c:forEach var="courseContentList" items="${courseContentList }" varStatus="status">
							<table border="1">
								<tr>
									<th>ID</th><th>이미지</th><th>이름</th><th>주소</th><th>홈페이지</th><th>연락처</th>
								</tr>
								<tr>
									<td>${courseContentList.content_id }</td>
									<td><img alt="${courseContentList.title }" src="${courseContentList.img1 }" style="height: 150px;"></td>
									<td>${courseContentList.title }</td>
									<td>${courseContentList.address }</td>
									<td>${courseContentList.homepage }</td>
									<td>${courseContentList.phone }</td>
								</tr>
								<button onclick="deleteCourseContent(${courseContentList.content_id}, ${courseContentList.course_id}); event.preventDefault();" class="btn btn-primary">삭제${courseContentList.content_id}</button>

							</table>
						</c:forEach>
					</div>
				</div>
			
			<div class="form-group">
				<label for="distance">거리(km)</label>
				<input type="text" id="distance" name="distance" class="form-control" required="required" value="${courseContent.distance }">
			</div>
			<div class="form-group">
				<label for="time">소요시간</label>
				<input type="text" id="time" name="time" class="form-control" required="required" value="${courseContent.time }">
			</div>
			<div class="form-group">
				<label for="course_info">코스 내용</label>
				<textarea class="form-control" id="course_info" name="course_info" rows="5">${courseContent.course_info }</textarea>
			</div>
			<div class="text-center">
				<button type="submit" class="btn btn-primary">확인</button>
				<button class="btn btn-secondary" onclick="closeAndRedirect()">취소</button>
			</div>
		</form>
	</div>
	
	<!-- review test -->
	<div>
		<h3>review 구역</h3>
	</div>
	
</body>
</html>