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
		</style>
		
		<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
		<!-- 지역 코드 넣는 코드  Start-->	
		<script src="/js/updateArea.js"></script>
		<script type="text/javascript">
		
			document.addEventListener("DOMContentLoaded", function() {
				updateAreaOptions();
				$(".area-dropdown").change(function() {
					const selectedArea = $(this).val();
					if (selectedArea) {
						updateSigunguOptions(selectedArea);
					} else {
						$(".sigungu-dropdown").empty().append("<option value='0'>전체</option>");
					}
				});
			});
			
		</script>
		<!-- 지역 코드 넣는 코드  End-->	
		
	</head>
	
	<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<main>
		<div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
			<!-- HeaderBanner by.엄민용 -->
			<c:forEach var="headers" items="${bannerHeader }">
				<c:choose>
					<c:when test="${headers.title == '축제' }">
						<img alt="축제_headerBanner" src="${headers.image }">
					</c:when>
				</c:choose> 
			</c:forEach>
			<!-- HeaderBanner end -->
		</div>
		
		<!-- 검색 -->
		<form action="festival" method="post">
			<div class="border p-3 m-3">
				<select name="area" class="area-dropdown"></select>
				<select name="sigungu"  class="sigungu-dropdown"></select>
				<input type="text" name="keyword" placeholder="키워드를 입력하세요.">
				
				<button type="submit" class="btn btn-outline-secondary">검색</button>
				<button type="reset" class="btn btn-outline-secondary">초기화</button>
			</div>
		</form>
		
		<!-- 정렬(만드는 중) -->
		<div align="right">
			<select name="ordering">
				<option value="o_id">기본순</option>
				<option value="o_title">이름순</option>
				<option value="o_readcount">조회순</option>
			</select>
		</div>
	
		<!-- 콘텐츠 -->
		<div class="album py-5 bg-body-tertiary">
			<div class="container">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<c:if test="${listFestivals.size() == 0}">해당하는 축제 정보가 없습니다.</c:if>
					<c:forEach var="festival" items="${listFestivals}">
						<div class="col">
							<div class="card app-card">
							<div class="app-tag-container" style="position: relative;">
              					<div class="app-tag" style="position: absolute; left: 12px; top: 12px;">
                				<div class="app-tag-text" style="font-size: 14">#지역해시태그</div>
             					</div>
				  				<a href="festival/detail?contentId=${festival.content_id}&currentPage=${page.currentPage}">
				  				<img src="${festival.img1}" class="app-card-img-top" alt="${festival.title}이미지""></a>
				  				</div>
				  				<div class="card-body app-card-body">
				    				<p class="app-card-text">
				    					축제명 : ${festival.title} <br>
				    					<span style="color: #FF4379;">축제기간 : ${festival.start_date} ~ ${festival.end_date}</span><br>
				    					<span style="font-weight: normal;">${festival.content}</span>
				    				</p>
				    				
				 				 </div>	
				 			</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		
		<div align="center">
			<c:if test="${page.startPage > page.pageBlock}">
				<a href="festival?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<a href="festival?currentPage=${i}" class="pageblock">[${i}]</a>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">
				<a href="festival?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
			</c:if>	
		</div>
		
	</main>
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>