<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>체험정보2211</title>
<style type="text/css">
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
	 <%@ include file="/WEB-INF/components/TobBar.jsp" %>
	 <main>
		<div
			class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
			<h1>체험 ㄱㄱㄱ</h1>
		</div>
		<div class="album py-5 bg-body-tertiary">		
	 		<div class="container">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
	 				<c:forEach var="experience" items="${listExperience}">
	 					<div class="col">
						<div class="card" style="width: 20rem;">
  							<img src="${experience.img1}" class="card-img-top" alt="${experience.title}이미지" style="height: 190px;">
  							<div class="card-body">
    							<p class="card-text" style="height: 240px;">
			    					체험명 : ${experience.title} <br>
			    					체험정보 :${experience.content}
    							</p>
    							<a href="experience/detail?content_id=${experience.content_id}" class="btn btn-primary">더보기</a>
			 				 </div>	
						</div>
					 </div>	
				</c:forEach>
				</div>
			</div>
		</div>				
		<div align="center">
		<c:if test="${page.startPage > page.pageBlock}">
			<a href="experience?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
		</c:if>
		<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
			<a href="experience?currentPage=${i}" class="pageblock">[${i}]</a>
		</c:forEach>
		<c:if test="${page.endPage < page.totalPage}">
			<a href="experience?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
		</c:if>	
		</div>		
	</main>
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>