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
			<div class="type">
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
		</form>
		<div class="album py-5 bg-body-tertiary">
			<div class="container">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<c:forEach var="spot" items="${listSpot}">
						<div class="col">
							<div class="card" style="width: 18rem;">
								<img src="${spot.img1}" class="card-img-top"
									alt="${spot.title}이미지" style="height: 190px;">
								<div class="card-body">
									<p class="card-text" style="height: 240px;">
										명소명 : ${spot.title} <br> 휴무일 : ${spot.rest_date}<br>
										${spot.content}
									</p>
									<a href="spot/detail?contentId=${spot.content_id}&currentPage=${page.currentPage}"class="btn btn-primary">더보기</a>
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