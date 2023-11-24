<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<%@ include file="/WEB-INF/components/TobBar.jsp" %>
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
		<!-- 임시, 여백용-->
		<div id="content_title" class="container"></div>

		<div class="container p-0 homeList-banner-custom">
			<div id="carouselExampleIndicators" class="carousel slide"
				 data-bs-ride="carousel" data-bs-interval="3000" data-bs-pause="hover"
			 	 data-bs-wrap="true">

			<!-- 중앙 하단 버튼용 -->
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="0" class="active" aria-current="true"
						aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>

			<!-- 아이템 재료 영역 -->
			<div class="carousel-inner homeList-banner-img">
				<div class="carousel-item active">
					<img src="../image/BANNER1.png" class="d-block w-100" alt="메인배너1" />
				</div>
				<div class="carousel-item">
					<img src="../image/BANNER2.png" class="d-block w-100" alt="메인배너2" />
				</div>
				<div class="carousel-item">
					<img src="../image/BANNER3.png" class="d-block w-100" alt="메인배너3" />
				</div>
			</div>

			<!-- 좌,우 버튼 영역 -->
			<button class="carousel-control-prev" type="button"
					data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true">
					<img src="../image/arrowLeft.png" alt="Previous">
				</span> 
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
					data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true">
					<img src="../image/arrowRight.png" alt="Next">
				</span>
				<span class="visually-hidden">Next</span>
			</button>

		</div>
	</div>
		
		<!-- 상단 분홍색 영역 -->
		<div class="container homeList-top-custom"></div>
		
		<div>
			<form id="experience1" action="experience1" method="get">
				<input type="hidden" name="big_code" value="15">
				<!-- keyword, title 영역 -->	
				<div class="container homeCommon-keyword-title-custom">
					
					<div class="co1 title-div">
								EXPERIENCE!</div>
					<div class="co1 text-div">
						<h4><strong>어느 체험으로 즐겨볼까요~♫</strong></h4>
					</div>
					<input class="form-control keyword-input" type="text" name="keyword" placeholder="가고 싶은 체험의 이름이나 키워드를 검색해보세요." style="margin-right: 15px;">
					<img class="keyword-img" src="../image/icon_search1.png" alt="icon_search1.png" id="searchIcon" onclick="submitForm()"/>
				
				</div>
			
				<!-- 경계선 표현 -->
				<div>
				<hr class="container homeCommon-top-custom">	
				</div>	
			
				<!-- select 영역 -->
				<div class="container homeCommon-select-custom">
					<div class="row g-2 text-center">
						<div class="col d-flex justify-content-center">
							<select class="form-select area-dropdown" 
									aria-label="Default select example" name="area">
							</select>
						</div>
						<div class="col d-flex justify-content-center">
							<select class="form-select sigungu-dropdown" 
									aria-label="Default select example" name="sigungu">
							</select>
						</div>
						<div class="col d-flex justify-content-center">
							<select class="form-select" aria-label="Default select example" name="small_code">
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
		<div><hr class="container homeCommon-top-custom"></div>	
			
		
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
				
		<div class="container homeList-menu-custom">
		<c:if test="${listExperience.size() == 0}">해당하는 체험 정보가 없습니다.</c:if>
	 		<div class="row row-cols-3 g-6 homeList-mdMenu-custom">
				<c:forEach var="experience" items="${listExperience}">
	 				<div class="col d-flex justify-content-center">
						<div class="card homeList-card-custom">
							<div class="homeList-tag-custom">
								<div class="homeList-tag-custom2">
									<p class="tag-p">#지역태그</p>
								</div>
								<a href="experience/detail?contentId=${experience.id}&currentPage=${page.currentPage}">
									<img src="${experience.img1}" class="card-img-top" alt="${experience.title}">
								</a>
							</div>							
							<div class="card-body">
							    <p class="card-text title-p">${experience.title}</p>
							    <p class="card-text period-p"> 휴무일 : ${experience.rest_time}</p>
							    <p class="card-text contet-p">${experience.content}</p>
							</div>
					 	</div>
					</div> 	
				</c:forEach>
			</div>
		</div>		
		
	<nav aria-label="Page navigation example">		
		<ul class="pagination">	
			<c:choose>
				<c:when test="${path ==0}">
					<c:if test="${page.startPage > page.pageBlock}">
						<li class="page-item">
							<a href="experience?currentPage=${page.startPage-page.pageBlock}"
					  			 class="pageblock page-link">[이전]</a></li>
					</c:if>
					<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
						<li class="page-item">
							<a href="experience?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
						</li>
					</c:forEach>
					<c:if test="${page.endPage < page.totalPage}">
						<li class="page-item">
							<a href="experience?currentPage=${page.startPage+page.pageBlock}"
							   class="pageblock page-link">[다음]</a></li>
					</c:if>
				</c:when>
				<c:otherwise>
					<c:if test="${page.startPage > page.pageBlock}">
						<li class="page-item">
							<a href="experience1?currentPage=${page.startPage-page.pageBlock}"
					  			 class="pageblock page-link">[이전]</a></li>
					</c:if>
					<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
						<li class="page-item">
							<a href="experience1?currentPage=${i}&keyword=${keyword}&big_code=${big_code}&small_code=${small_code}&area=${area}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
						</li>
					</c:forEach>
					<c:if test="${page.endPage < page.totalPage}">
						<li class="page-item">
							<a href="experience1?currentPage=${page.startPage+page.pageBlock}"
							   class="pageblock page-link">[다음]</a></li>
					</c:if>
				</c:otherwise>
			</c:choose>
		</ul>
	</nav>	
		
		
		
		
		
		
		
		
		
		
		
		<%-- <div align="center">
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
					</div>	 --%>
					
					
				

	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>