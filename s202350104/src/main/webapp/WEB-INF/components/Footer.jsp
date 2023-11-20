<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>		
<style>
footer {
  margin-top: auto;
  background-color: #f8f9fa;
  text-align: center;
}
</style>

<footer class="py-5">
	<div class="container p-5" style="background-color: #EEFFC2;">
		<h1>Footer</h1>
		
		<!-- Banner test -->
		<div style="display: flex; justify-content: center; align-items: center;">
		<c:forEach var="footer" items="${bannerFooter }">
			<c:choose>
				<c:when test="${footer.title == '한국관광공사' }">
					<a href="${footer.url}" target="_blank" style="margin-right: 15px; border: 1px solid #D5D5D5;">
						<img src="${footer.image}" class="card-img-top" alt="한국관광공사CI" style="width: 130px; height: 45px; ">
					</a>
				</c:when>
				<c:when test="${footer.title == '서울특별시' }">
					<a href="${footer.url}" target="_blank" style="margin-right: 15px; border: 1px solid #D5D5D5;">
						<img src="${footer.image}" class="card-img-top" alt="서울특별시CI" style="width: 130px; height: 45px;">
					</a>
				</c:when>
				<c:when test="${footer.title == '인천광역시' }">
					<a href="${footer.url}" target="_blank" style="margin-right: 15px; border: 1px solid #D5D5D5;">
						<img src="${footer.image}" class="card-img-top" alt="인천광역시CI" style="width: 130px; height: 45px;">
					</a>
				</c:when>
				<c:when test="${footer.title == '충청남도' }">
					<a href="${footer.url}" target="_blank" style="margin-right: 15px; border: 1px solid #D5D5D5;">
						<img src="${footer.image}" class="card-img-top" alt="충청남도CI" style="width: 130px; height: 45px;">
					</a>
				</c:when>
				<c:when test="${footer.title == '부산광역시' }">
					<a href="${footer.url}" target="_blank" style="margin-right: 15px; border: 1px solid #D5D5D5;">
						<img src="${footer.image}" class="card-img-top" alt="부산광역시CI" style="width: 130px; height: 45px;">
					</a>
				</c:when>
			</c:choose>
		</c:forEach>
		</div>
	</div>
</footer>