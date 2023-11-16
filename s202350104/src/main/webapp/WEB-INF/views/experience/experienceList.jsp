<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/components/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>체험정보2211</title>

</head>
<body>
	 <%@ include file="/WEB-INF/components/TobBar.jsp" %>
	 <main>
		<div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
			<!-- HeaderBanner by.엄민용 -->
			<c:forEach var="headers" items="${bannerHeader }">
				<c:choose>
					<c:when test="${headers.title == '체험' }">
						<img alt="체험_headerBanner" src="${headers.image }">
					</c:when>
				</c:choose> 
			</c:forEach>
			<!-- HeaderBanner end -->
		</div>
		<div class="border p-3 m-3">
						<form action="experience1" method="get">
							<input type="text" name="keyword" placeholder="체험이름을 입력하세요">
							<button type="submit" class="btn btn-outline-secondary">체험이름검색</button>
							<button type="reset" name="deleted" class="btn btn-outline-secondary">초기화</button><p>
							<input type="hidden" name="big_code" value="15">
							<select name="area">
								<option value="0">전체</option>
								<c:forEach var="areas" items="${listAreas}">
								<option value="${areas.area}"${areas.area == area? 'selected':''}>${areas.content}</option>
								</c:forEach>
							</select>
							<select name="small_code" >
								<option value="999">전체</option>
								<c:forEach var="small" items="${listSmallCode}">
								<option value="${small.small_code}"${small.small_code == small_code? 'selected':''} >${small.content}</option>									
								</c:forEach>
							</select>
						</form>
				</div>
		<div class="album py-5 bg-body-tertiary">		
	 		<div class="container">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
	 				<c:forEach var="experience" items="${listExperience}">
	 					<div class="col">
						<div class="card app-card">
								<div class="app-tag-container" style="position: relative;">
              					<div class="app-tag" style="position: absolute; left: 12px; top: 12px;">
                				<div class="app-tag-text" style="font-size: 14">#지역해시태그</div>
             					</div>
             				<a href="experience/detail?contentId=${experience.id}&currentPage=${page.currentPage}">
  							<img src="${experience.img1}" class="app-card-img-top" alt="${experience.title}이미지"></a>	
  							</div>
  							<div class="card-body app-card-body">
    							<p class="app-card-text">
			    					체험명 : ${experience.title}<br>
			    					<span style="color: #FF4379;"> 휴무일 : ${experience.rest_time } </span><br>
			    					<span style="font-weight: normal;"> 체험정보 :${experience.content}</span>
    							</p>
    							<%-- <a href="experience/detail?contentId=${experience.id}&currentPage=${page.currentPage}" class="btn btn-primary">더보기</a> --%>
			 				 </div>
						</div>
					 </div>	
				</c:forEach>
				</div>
			</div>
		</div>				
		<div align="center">
					<c:if test="${page.startPage > page.pageBlock}">
							<c:choose>
								<c:when test="${path ==0}">
									<a href="experience?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
								</c:when>
								<c:when test="${path ==1}">
									<a href="experience1?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
								</c:when>
							</c:choose>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<c:choose>
								<c:when test="${path ==0}">
									<a href="experience?currentPage=${i}" class="pageblock">[${i}]</a>
								</c:when>
								<c:when test="${path == 1}">
									<a href="experience1?currentPage=${i}&keyword=${keyword}&big_code=${big_code}&small_code=${small_code}&area=${area}" class="pageblock">[${i}]</a>
								</c:when>
							</c:choose>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<c:choose>
								<c:when test="${path ==0}">
									<a href="experience?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
								</c:when>
								<c:when test="${path ==1}">
									<a href="experience1?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
								</c:when>
							</c:choose>
						</c:if>
					</div>		
	</main>
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>