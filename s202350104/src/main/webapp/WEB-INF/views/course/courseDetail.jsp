<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CourseDetail</title>

<!-- 지역 코드 넣는 코드  -->
<script src="/js/updateArea.js"></script>

<!-- script 영역 -->
<script>

	/* 대분류, 소분류 기능 js */
	document.addEventListener("DOMContentLoaded", function() {
		updateAreaOptions();
		$(".area-dropdown").change(
				function() {
					const selectedArea = $(this).val();
					if (selectedArea) {
						updateSigunguOptions(selectedArea);
					} else {
						$(".sigungu-dropdown").empty().append(
								"<option value='0'>전체</option>");
					}
				});
	});
</script>

</head>
<body>
	<div>
		<c:forEach var="courseDetail" items="${courseDetail }">
			<c:if test="${courseDetail.order_num == 1}">
				<h1>${courseDetail.course_title }</h1>
				<div class="container border p-5">
					<img alt="${courseDetail.course_title }" src="${courseDetail.img1 }">
				</div>
				<div class="container border p-5">
					<ul>
						<li>코스 이름 : ${courseDetail.course_title }
						<li>코스 내용 : ${courseDetail.course_info }
						<li>코스 거리 : ${courseDetail.distance }
						<li>주 소 :	${courseDetail.address }
						<li>전화번호 :	${courseDetail.phone }
					</ul>
				</div>
			</c:if>
		</c:forEach>
	</div>
	
	<div>
		<c:forEach var="courseDetail" items="${courseDetail }">
		<div class="container border p-5">
			<a href='../${courseDetail.cd_content.toLowerCase() }/detail?contentId=${courseDetail.content_id}'>
				<img alt="${courseDetail.course_title }" src="${courseDetail.img1 }">
			</a>
			<ul>
				<li>코스이름 : ${courseDetail.title }
				<li>개요 : ${courseDetail.content }
				<li>홈페이지 : ${courseDetail.homepage }
			</ul>
		</div>
		</c:forEach>
	</div>
	<!-- review test -->
	<div>
		<h3>review 구역</h3>
	</div>
</body>
</html>