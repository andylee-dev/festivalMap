<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>체험정보2211</title>

<style type="text/css">
	.pageblock {
		text-align: center;
	}
</style>

<!-- 지역 코드 넣는 코드  Start-->
<script src="/js/updateArea.js"></script>

<script type="text/javascript">
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
	
	 	
	// 서치이미지를 클릭할 때 폼을 제출하는 함수
		$(document).ready(function () {
    	$("#searchIcon").click(function () {
       		$("#experience1").submit();
    	});
	});

	
</script>
<!-- 지역 코드 넣는 코드  End-->
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
		
		<!-- 상단 분홍색 영역 -->
		<div class="container p-0 top_custom"></div>
	<div>
		<form id="experience1" action="experience1" method="get">
		<!-- keyword, title 영역 -->	
		<div class="container p-0 keyword_title_custom">
			
			<input type="hidden" name="big_code" value="15">
			<div class="co1 title_div">
						EXPERIENCE!</div>
			<div class="co1 text_div">
				<h4><strong>어느 체험으로 즐겨볼까요~♫</strong></h4>
			</div>
			<input class="form-control keyword_input" type="text" name="keyword" placeholder="가고 싶은 체험의 이름이나 키워드를 검색해보세요." style="margin-right: 15px;">
			<img class="keyword_img" src="../image/icon_search1.png" alt="icon_search1.png" id="searchIcon" onclick="submitForm()"/>
		
		</div>
		<!-- 경계선 표현 -->
		<div>
		<hr class="container p-0 hr_custom">	
		</div>	
		
		<!-- select 영역 -->
		<div class="container p-0 select_custom">
			<div class="row g-2 text-center">
				<div class="col d-flex justify-content-center">
					<select class="form-select text-center border-3 select_text_custom area-dropdown" 
							aria-label="Default select example" name="area">
					</select>
				</div>
				<div class="col d-flex justify-content-center">
					<select class="form-select text-center border-3 select_text_custom sigungu-dropdown" 
							aria-label="Default select example" name="sigungu">
					</select>
				</div>
				<div class="col d-flex justify-content-center">
					<select class="form-select text-center border-3 select_text_custom" 
							aria-label="Default select example" name="small_code">
						<option value="999">체험종류</option>
							<c:forEach var="small" items="${listSmallCode}">
								<option value="${small.small_code}"${small.small_code == small_code? 'selected':''} >${small.content}</option>									
							</c:forEach>
					</select>
				</div>
			</div>		
		</div>
		</form>
	</div>	
		
		<!-- 경계선 표현 -->
		<div><hr class="container p-0 hr_custom"></div>	
			
		
		<%-- <div class="border p-3 m-3">
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
				</div> --%>
				
		<div class="container p-1 list_custom">	
		<c:if test="${listExperience.size() == 0}">해당하는 체험 정보가 없습니다.</c:if>
	 		<div class="row row-cols-3 g-2">
				<c:forEach var="experience" items="${listExperience}">
	 				<div class="col d-flex justify-content-center">
						<div class="card card_custom border-0">
							<div class="tag_custom">
								<div class="tag_custom2">
									<p class="tag_p">#지역태그</p>
								</div>
								<a href="experience/detail?contentId=${experience.id}&currentPage=${page.currentPage}">
									<img src="${experience.img1}" class="card-img-top" alt="${experience.title}">
								</a>
							</div>							
							<div class="card-body">
							    <p class="card-text title_p">${experience.title}</p>
							    <p class="card-text period_p"> 휴무일 : ${experience.rest_time}</p>
							    <p class="card-text contet_p">${experience.content}</p>
							</div>
					 	</div>
					</div> 	
				</c:forEach>
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