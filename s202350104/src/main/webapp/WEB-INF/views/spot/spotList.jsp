<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
		<title>Spot</title>
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
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	<main>
		<div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
			<!-- HeaderBanner by.엄민용 -->
			<c:forEach var="headers" items="${bannerHeader }">
				<c:choose>
					<c:when test="${headers.title == '명소' }">
						<img alt="명소_headerBanner" src="${headers.image }">
					</c:when>
				</c:choose> 
			</c:forEach>
			<!-- HeaderBanner end -->
		</div>
		
		<!-- 상단 분홍색 영역 -->
		<div class="container p-0 top_custom"></div>
		
		<!-- keyword, title 영역 -->	
			<form id="restaurantSearch" action="restaurantSearch">
			<div class="container p-0 keyword_title_custom">
			<div class="co1 title_div">
						F E S T I V A L!</div>
			<div class="co1 text_div">
				<h4><strong>어느 명소에서 구경할까요~♫</strong></h4>
			</div>
			<input class="form-control keyword_input" type="text" name="keyword" placeholder="가고 싶은 명소의 이름이나 키워드를 검색해보세요." style="margin-right: 15px;">
			<img class="keyword_img" src="../image/icon_search1.png" alt="icon_search1.png" id="searchIcon"/>
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
		
			<%-- <div class="type">
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=1'">자연</button>
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=2'" >역사</button>
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=5'" >건축</button>
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=3'">휴양</button>
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=4'" >산업</button>
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=6'" >문화</button>
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=7'" >N개의 경</button>
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=8'" >기타</button>
			</div>
		<form action="spot1" method="get">
		<div class="border p-3 m-3">
			<c:if test="${big_code != null}">
				<input type="hidden" name="big_code" value="${big_code}">
			</c:if>
			<c:if test="${small_code != null}">
				<input type="hidden" name="small_code" value="${small_code}">
			</c:if>
			<input type="text" name="keyword" placeholder="명소이름을 입력하세요">
			<button type="submit" class="btn btn-outline-secondary">명소이름검색</button>
			<button type="reset" name="deleted" class="btn btn-outline-secondary">초기화</button><p>
			<div class="container">
					<select name="area" class="area-dropdown"></select>
					<select name="sigungu"  class="sigungu-dropdown"></select>
			</div>
		</div>
		</form> --%>
		
		<div class="album py-5 bg-body-tertiary">
			<div class="container">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<c:forEach var="spot" items="${listSpot}">
						<div class="col">
							<div class="card app-card">
								<div class="app-tag-container" style="position: relative;">
              					<div class="app-tag" style="position: absolute; left: 12px; top: 12px;">
                				<div class="app-tag-text" style="font-size: 14">#지역해시태그</div>
             					</div>
								<a href="spot/detail?contentId=${spot.content_id}&currentPage=${page.currentPage}">
								<img src="${spot.img1}" class="app-card-img-top"
									alt="${spot.title}이미지"></a>
								</div>	
								<div class="card-body app-card-body">
									<p class="app-card-text">
										명소명 : ${spot.title} <br> 
										<span style="color: #FF4379;">휴무일 : ${spot.rest_date}</span> <br>
										<span style="font-weight: normal;">${spot.content}</span>
									</p>
									<c:set var="card" value="${card - 1}"></c:set>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<div align="center">
		<input type="hidden" name="currentPage" value="${page.currentPage}">
			<c:if test="${page.startPage > page.pageBlock}">
				<a href="spot1?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<a href="spot1?currentPage=${i}">[${i}]</a>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">
				<a href="spot1?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
			</c:if>
		</div>
	</main>
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>