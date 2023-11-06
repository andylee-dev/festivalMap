<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>		

<footer class="container py-5">
	<div class="container p-5 border">
		<h1>Footer</h1>
		
		<!-- Banner test -->
		<div style="display: flex; justify-content: center; align-items: center;">
		<c:forEach var="footer" items="${banner }">
			<c:choose>
				<c:when test="${footer.title == '한국관광공사' }">
					<a href="${footer.url}">
						<img src="../image/sigkor.jpg" class="card-img-top" alt="한국관광공사CI" style="width: 120px; height: auto;">
					</a>
				</c:when>
				<c:when test="${footer.title == '서울특별시' }">
					<a href="${footer.url}">
						<img src="../image/seoul.png" class="card-img-top" alt="서울특별시CI" style="width: 120px; height: auto;">
					</a>
				</c:when>
				<c:when test="${footer.title == '인천광역시' }">
					<a href="${footer.url}">
						<img src="../image/incheon.jpeg" class="card-img-top" alt="인천광역시CI" style="width: 120px; height: auto;">
					</a>
				</c:when>
				<c:when test="${footer.title == '충청남도' }">
					<a href="${footer.url}">
						<img src="../image/chungcheongnamdo.jpg" class="card-img-top" alt="인천광역시CI" style="width: 120px; height: auto;">
					</a>
				</c:when>
				<c:when test="${footer.title == '부산광역시' }">
					<a href="${footer.url}">
						<img src="../image/busan.png" class="card-img-top" alt="부산광역시CI" style="width: 120px; height: auto;">
					</a>
				</c:when>
			</c:choose>
		</c:forEach>
		</div>
	</div>
</footer>