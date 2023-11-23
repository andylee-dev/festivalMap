<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spot</title>
<style type="text/css">
.type {
	display: flex;
	justify-content: center;
	align-items: center;
}

.theme_type {
	height: 100px;
	width: 100px;
	border-radius: 100px;
	margin: 20px;
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
							$(".sigungu-dropdown").empty().append("<option value=''>전체</option>");
					}
				});
			});
			
			// 서치이미지를 클릭할 때 폼을 제출하는 함수
			$(document).ready(function () {
    			$("#searchIcon").click(function () {
       				$("#").submit();
    			});
			});
	
		</script>

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

	<!-- 테마버튼 검색 -->
	<div class="container homeList-md-nav-custom">
		<div class="row row-cols-8">
			<div class="col nav-img-box">
				<a href="spot1?big_code=14&small_code=1">
				<img alt="test" src="../image/nature_icon.png"></a>
			</div>
			<div class="col nav-img-box">
				<a href="spot1?big_code=14&small_code=2">
				<img alt="test" src="../image/history_icon.png"></a>
			</div>
			<div class="col nav-img-box">
				<a href="spot1?big_code=14&small_code=5">
				<img alt="test" src="../image/construct_icon.png"></a>
			</div>
			<div class="col nav-img-box">
				<a href="spot1?big_code=14&small_code=3">
				<img alt="test" src="../image/vacation_icon.png"></a>
			</div>
			<div class="col nav-img-box">
				<a href="spot1?big_code=14&small_code=4">
				<img alt="test" src="../image/industry_icon.png"></a>
			</div>
			<div class="col nav-img-box">
				<a href="spot1?big_code=14&small_code=6">
				<img alt="test" src="../image/culture_icon.png"></a>
			</div>
			<div class="col nav-img-box">
				<a href="spot1?big_code=14&small_code=7">
				<img alt="test" src="../image/sight_icon.png"></a>
			</div>
			<div class="col nav-img-box">
				<a href="spot1?big_code=14&small_code=8">
				<img alt="test" src="../image/etc_icon.png"></a>
			</div>
	
		</div>
	</div>
	
	<form action="spot1" method="get">
		<div class="m-3">
			<c:if test="${big_code != null}">
				<input type="hidden" name="big_code" value="${big_code}">
			</c:if>
			<c:if test="${small_code != null}">
				<input type="hidden" name="small_code" value="${small_code}">
			</c:if>
		</div>
	</form>

	<!-- keyword, title 영역 -->
	<form id="spot" action="spot" method="get">
		<div class="container homeCommon-keyword-title-custom">

			<div class="co1 title-div">S&nbsp;P&nbsp;O&nbsp;T&nbsp;!</div>
			<div class="co1 text-div">
				<h4>
					<strong>어느 명소로 떠나볼까요~♫</strong>
				</h4>
			</div>
			<input class="form-control keyword-input" type="text" name="keyword"
					placeholder="가고 싶은 명소의 이름이나 키워드를 검색해보세요."> 
			<img class="keyword-img" src="../image/icon_search1.png"
				 alt="icon_search1.png" id="searchIcon" onclick="submitForm()" />
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
					<select class="form-select" aria-label="Default select example">
						<option selected>명소 테마</option>
						<option value="1">One</option>
						<option value="2">Two</option>
						<option value="3">Three</option>
					</select>
				</div>
			</div>
		</div>
	</form>

	<!-- 경계선 표현 -->
	<hr class="container homeCommon-top-custom">

	<!-- 목록 영역 -->
	<div class="container homeList-menu-custom">
		<c:if test="${listSpot.size() == 0}">해당하는 명소 정보가 없습니다.</c:if>
		<div class="row row-cols-3 g-6 homeList-mdMenu-custom">
			<c:forEach var="spot" items="${listSpot}">
				<div class="col d-flex justify-content-center">
					<div class="card homeList-card-custom">

						<div class="homeList-tag-custom">
							<div class="homeList-tag-custom2">
								<p class="tag-p">#지역태그</p>

							</div>
							<a href="spot/detail?contentId=${spot.content_id}&currentPage=${page.currentPage}">
								<img src="${spot.img1}" class="card-img-top" alt="${spot.title}">
							</a>
						</div>

						<div class="card-body">
							<p class="card-text title-p">${spot.title}</p>
							<p class="card-text period-p">휴무일&nbsp;:&nbsp;${spot.rest_date}</p>
							<p class="card-text contet-p">${spot.content}</p>
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
				<a href="spot?currentPage=${page.startPage-page.pageBlock}"
				   class="pageblock page-link">[이전]</a></li>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<li class="page-item">
				<a href="spot?currentPage=${i}"
				   class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">
				<li class="page-item">
				<a href="spot?currentPage=${page.startPage+page.pageBlock}"
				   class="pageblock page-link">[다음]</a></li>
			</c:if>

		</ul>
	</nav> 
	
	<!-- Footer -->	
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>