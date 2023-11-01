<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spot</title>
<style type="text/css">
	.card-text {
		overflow: hidden;
		/* text-overflow: ellipsis; */
	}
	
	.parent {
		width: 90%;
		margin: 10px auto;
	}
	
	.first {
		float: left;
		width: 30%;
		box-sizing: border-box;
	}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	<main>
		<div
			class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
			<h1>주변명소</h1>
		</div>
		<div class="border p-3 m-3">
				<h1 class="border">검색폼</h1>
				<button type="button" class="btn btn-outline-secondary">검색</button>
				<button type="button" class="btn btn-outline-secondary">초기화</button>
		</div>
		<div>
		<select name="area">
			<c:forEach var="areas" items="${listAreas}">
				<c:if test="${areas.sigungu == 999}"><option value="${areas.area}">${areas.content}</option></c:if>
			</c:forEach>
		</select>
		</div>
		<div>
		<select name="sigungu">
			<c:forEach var="areas" items="${listAreas}">
				<c:if test="${areas.sigungu != 999}"><option value="${areas.sigungu}">${areas.content}</option></c:if>
			</c:forEach>
		</select>
		</div>
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
										축제명 : ${spot.title} <br> 휴무일 : ${spot.rest_date}<br>
										${spot.content}
									</p>
									<a href="spot/detail?content_id=${spot.content_id}"
										class="btn btn-primary">더보기</a>
									<c:set var="card" value="${card - 1}"></c:set>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<div align="center">
			<c:if test="${page.startPage > page.pageBlock}">
				<a href="spot?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<a href="spot?currentPage=${i}">[${i}]</a>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">
				<a href="spot?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
			</c:if>
		</div>
	</main>
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>