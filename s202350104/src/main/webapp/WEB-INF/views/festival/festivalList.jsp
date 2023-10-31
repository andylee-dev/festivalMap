<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>FestivalList</title>
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
	</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<main>
		<div
			class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
			<h1>어느 축제로 떠나볼까요?</h1>
		</div>
	<!-- select box 만들기 	
	<div class="container border p-5">
		<form action="festival"></form>
	</div> -->
	
		<div class="album py-5 bg-body-tertiary">
			<div class="container">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<c:forEach var="festival" items="${listFestivals}">
						<div class="col">
							<div class="card" style="width: 20rem;">
				  				<img src="${festival.img1}" class="card-img-top" alt="${festival.title}이미지" style="height: 190px;">
				  				<div class="card-body">
				    				<p class="card-text" style="height: 240px;">
				    					축제명 : ${festival.title} <br>
				    					축제기간 : ${festival.start_date} ~ ${festival.end_date} <br>
				    					${festival.content}
				    				</p>
				    				<a href="festival/detail?contentId=${festival.content_id}" class="btn btn-primary">더보기</a>
				 				 </div>	
				 			</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		
		<c:if test="${page.startPage > page.pageBlock}">
			<a href="festival?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
		</c:if>
		<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
			<a href="festival?currentPage=${i}" class="pageblock">[${i}]</a>
		</c:forEach>
		<c:if test="${page.endPage < page.totalPage}">
			<a href="festival?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
		</c:if>
	</main>
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>