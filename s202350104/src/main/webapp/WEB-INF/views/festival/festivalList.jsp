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
       		$("#").submit();
    	});
	});
	
</script>
<!-- 지역 코드 넣는 코드  End-->

</head>

<body>
	<!-- 임시, 여백용-->
	<div id="content_title" class="container"></div>
	
	<!-- 상단 banner 영역 -->
	<div class="container p-0 banner_custom" style="">
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
			<div class="carousel-inner banner_img">
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
	<div class="container p-0 top_custom"></div>

	<!-- keyword, title 영역 -->	
	<div class="container p-0 keyword_title_custom">
		<div class="co1 title_div">
					F E S T I V A L!</div>
		<div class="co1 text_div">
			<h4><strong>어느 축제로 떠나볼까요~♫</strong></h4>
		</div>
		<input class="form-control keyword_input" type="text" name="keyword" placeholder="가고 싶은 축제의 이름이나 키워드를 검색해보세요.">
		<img class="keyword_img" src="../image/icon_search1.png" alt="icon_search1.png" id="searchIcon" />
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container p-0 hr_custom">	
		
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
				<select class="form-select text-center border-3 select_text_custom" aria-label="Default select example">
					<option selected>진행 기간 선택</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
			<div class="col d-flex justify-content-center">
				<select class="form-select text-center border-3 select_text_custom" aria-label="Default select example">
					<option selected>진행 여부 선택</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
		</div>		
	</div>	
	
	<!-- 경계선 표현 -->
	<hr class="container p-0 hr_custom">	

	<!-- 목록 영역 -->
	<div class="container p-0 list_custom">
		<c:if test="${listFestivals.size() == 0}">해당하는 축제 정보가 없습니다.</c:if>
		<div class="row row-cols-3 g-2">
			<c:forEach var="festival" items="${listFestivals}">
<%-- 			<fmt:formatDate var="startDate" value="${festival.start_date}" type="date" pattern="yyyy.MM.dd"/>
			<fmt:formatDate var="endDate" value="${festival.end_date}" type="date" pattern="yyyy.MM.dd"/>
	 --%>											
				<div class="col d-flex justify-content-center">
					<div class="card card_custom border-0">
					
						<div class="tag_custom">
							<div class="tag_custom2">
								<p class="tag_p">#지역태그</p>
							</div>
							<a href="festival/detail?contentId=${festival.content_id}&currentPage=${page.currentPage}">
								<img src="${festival.img1}" class="card-img-top" alt="${festival.title}">
							</a>
						</div>

						<div class="card-body">
					    <p class="card-text title_p">${festival.title}</p>
					    <p class="card-text period_p">${festival.start_date}&nbsp;~&nbsp;${festival.end_date}</p>
					    <p class="card-text contet_p">content영역</p>
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
					<a href="festival?currentPage=${page.startPage-page.pageBlock}"
					   class="pageblock page-link">[이전]</a></li>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<li class="page-item">
					<a href="festival?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">
				<li class="page-item">
					<a href="festival?currentPage=${page.startPage+page.pageBlock}"
					   class="pageblock page-link">[다음]</a></li>
			</c:if>

		</ul>
	</nav>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>