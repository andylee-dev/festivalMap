<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@ include file="/WEB-INF/components/header.jsp"%>
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FestivalList</title>

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
       		$("#festival").submit();
    	});
	});
	
</script>
<!-- 지역 코드 넣는 코드  End-->

</head>

<body>
	<!-- 임시, 여백용-->
	<div id="content_title" class="container"></div>
	
	<!-- 상단 banner 영역 -->
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
					<img src="../image/BANNER1.png" class="d-block w-100" alt="메인배너1"/>
				</div>
				<div class="carousel-item">
					<img src="../image/BANNER2.png" class="d-block w-100" alt="메인배너2"/>
				</div>
				<div class="carousel-item">
					<img src="../image/BANNER3.png" class="d-block w-100" alt="메인배너3"/>
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
	
	<!-- keyword, title 영역 -->	
	<form id="festival" action="festival" method="get">
		<div class="container homeCommon-keyword-title-custom">
	
			<div class="co1 title-div">
						F E S T I V A L!</div>
			<div class="co1 text-div">
				<h4><strong>어느 축제로 떠나볼까요~♫</strong></h4>
			</div>
			<input class="form-control keyword-input" type="text" name="keyword" placeholder="가고 싶은 축제의 이름이나 키워드를 검색해보세요."
			 value="${keyword}">
			<img class="keyword-img" src="../image/icon_search1.png" alt="icon_search1.png" id="searchIcon" onclick="submitForm()"/>
		</div>
		
		<!-- 경계선 표현 -->
		<hr class="container homeCommon-top-custom">	
			
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
					<select class="form-select" 
							aria-label="Default select example" name="small_code">
						<option value="0" selected>테마 선택</option>
						<c:forEach var="theme" items="${listCodes}">
							<c:if test="${theme.big_code == 11 && theme.small_code != 999 }">
								<option value="${theme.small_code}" ${theme.small_code == small_code? 'selected':''}>${theme.content}</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
				<div class="col d-flex justify-content-center">
					<select class="form-select" 
							aria-label="Default select example"  name="goingOn">
						<option selected>진행 여부 선택</option>
						<option value="past" ${goingOn eq 'past'? 'selected':''}>진행완료</option>
						<option value="present" ${goingOn eq 'present'? 'selected':''}>진행중</option>
						<option value="future" ${goingOn eq 'future'? 'selected':''}>진행예정</option>
					</select>
				</div>
			</div>		
		</div>
	</form>
	
	<!-- 경계선 표현 -->	
	<hr class="container homeCommon-top-custom">	

	<!-- 목록 영역 -->
	<div class="container homeList-menu-custom">
		<c:if test="${listFestivals.size() == 0}">해당하는 축제 정보가 없습니다.</c:if>
		<div class="row row-cols-3 g-6 homeList-mdMenu-custom">
			<c:forEach var="festival" items="${listFestivals}">							
				<div class="col d-flex justify-content-center">
					<div class="card homeList-card-custom">
					
						<div class="homeList-tag-custom">
<!-- 							<div class="homeList-tag-custom2">
								<p class="tag-p">#지역태그</p>
							</div> -->
							<a href="festival/detail?contentId=${festival.content_id}&currentPage=${page.currentPage}">
								<img src="${festival.img1}" class="card-img-top" alt="${festival.title}">
							</a>
						</div>

						<div class="card-body ">
					    <p class="card-text title-p">${festival.title}</p>
					    <p class="card-text period-p">
					    	<fmt:formatDate value="${festival.start_date}" pattern="yyyy.MM.dd"/>
							&nbsp;~&nbsp;
							<fmt:formatDate value="${festival.end_date}" pattern="MM.dd"/>
					    </p>
					    <p class="card-text contet-p">${festival.content}</p>
					  </div>
					</div>			
				</div>
			</c:forEach>
		</div>	
	</div>
	
	<!-- 페이징 처리 -->
	<nav aria-label="Page navigation example">
		<ul class="pagination">

			<c:if test="${page.startPage > page.pageBlock}">
				<li class="page-item">
					<a href="festival?currentPage=${page.startPage-page.pageBlock}&keyword=${keyword}&area=${area}&sigungu=${sigungu}&small_code=${small_code}&goingOn=${goingOn}"
					   class="pageblock page-link">Prev</a></li>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<li class="page-item">
					<a href="festival?currentPage=${i}&keyword=${keyword}&area=${area}&sigungu=${sigungu}&small_code=${small_code}&goingOn=${goingOn}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">
				<li class="page-item">
					<a href="festival?currentPage=${page.startPage+page.pageBlock}&keyword=${keyword}&area=${area}&sigungu=${sigungu}&small_code=${small_code}&goingOn=${goingOn}"
					   class="pageblock page-link">Next</a></li>
			</c:if>

		</ul>
	</nav>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>