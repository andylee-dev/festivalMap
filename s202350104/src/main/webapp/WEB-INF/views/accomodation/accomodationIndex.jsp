<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>숙박 리스트</title>
		<style type="text/css">
			.pageblock {
				text-align: center;
						}
			.card-text {
				overflow: hidden;
				text-overflow: ellipsis; /* 말줄임표 */
				display: -webkit-box;
				-webkit-line-clamp: 10;  /* 박스 안 텍스트가 10줄 넘어가면 말줄임표 */
				-webkit-box-orient: vertical;
						}
		</style>
	<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript">
		function getSigungu(pArea){
			$.ajax(
					{
						url:"<%=request.getContextPath()%>/getSigungu/"+pArea,
						data:pArea,
						dataType:'json',
						success:function(areas) {
							$('#sigungu_list_select option').remove();
							str = "<option value=''>전체</option>";
							$(areas).each(
								function() {
									if(this.sigungu != 999 && this.content != null) {
										strOption = "<option value='"+this.sigungu+"'> "+this.content+"</option>";
										str += strOption;
									}
								}		
							)
							$('#sigungu_list_select').append(str);
						}
						}		
				)
			}
			
		</script>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<main>
	<div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
		<!-- HeaderBanner by.엄민용 -->
		<c:forEach var="headers" items="${bannerHeader }">
			<c:choose>
				<c:when test="${headers.title == '숙박' }">
					<img alt="숙박_headerBanner" src="${headers.image }">
				</c:when>
			</c:choose> 
		</c:forEach>
		<!-- HeaderBanner end -->
	</div>
	<div class="border p-3 m-3">
				<h1 class="border">검색폼</h1>
			<select name="area" onchange="getSigungu(this.value)">
				<option value="">전체</option>
				<c:forEach var="areas" items="${listAreas}">
					<c:if test="${areas.sigungu == 999}">
						<option value="${areas.area}">${areas.content}</option>
					</c:if>
				</c:forEach>
			</select>
			<select name="sigungu" id="sigungu_list_select"><!-- ajax getSigungu --></select>
			<button type="button" class="btn btn-outline-secondary">검색</button>
			<button type="button" class="btn btn-outline-secondary">초기화</button>
		</div>

				 	

	<div class="album py-5 bg-body-tertiary">
		</div>
			<div class="container">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<c:forEach var="accomodation" items="${listAccomodation}">
						<div class="col">
							<div class="card" style="width: 20rem;">
  							<img src="${accomodation.img1}" class="card-img-top" alt="${accomodation.title}이미지" style="height: 190px;">
  							<div class="card-body">
    							<p class="card-text" style="height: 240px;">
    								숙소명 : ${accomodation.title} <br>
    								숙소위치 : ${accomodation.address}<br>
    								숙소소개  : ${accomodation.content}
    							</p>
    							<a href="accomodation/detail?contentId=${accomodation.content_id}" class="btn btn-primary">더보기</a>
 						 </div>	
						</div>
					</div>
				</c:forEach>
				</div>
			</div>
			<div align="center">
			<c:if test="${page.startPage > page.pageBlock}">
				<a href="accomodation?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<a href="accomodation?currentPage=${i}">[${i}]</a>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">
				<a href="accomodation?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
			</c:if>
		</div>
		
	</main>
	
	
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>