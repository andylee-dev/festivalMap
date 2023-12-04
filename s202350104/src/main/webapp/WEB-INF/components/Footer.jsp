<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>		
<link rel="stylesheet" type="text/css" href="/css/footer.css">

<footer class="py-5">
	<div class="container footer-banner-custom">
		<div class="row  row-cols-1">
			<!-- 확장성 -->
			<div class="col footer-first-box">
				<ul>
					<li>개인정보처리방침</li>
					<li>이용약관</li>
					<li>저작권정책</li>
					<li>고객서비스현장</li>
					<li>전자우편무단수집거부</li>
					<li>Q&A</li>
					<li>찾아오시는&nbsp;길</li>
				</ul>			
			</div>
			<!-- 주소 및 회사명 -->
			<div class="col footer-second-box">
				<ul>
					<li>우)04104</li>
					<li>서울&nbsp;마포구&nbsp;신촌로&nbsp;176</li>
					<li>TEL&nbsp;:&nbsp;02-123-1234</li>
					<li>사업자등록번호&nbsp;:&nbsp;123-12-12345</li>
				</ul>				
			</div>
			
			<hr/>
			
			<!-- Banner -->
			<div class="row row-cols-2 footer-third-box">
				<div class="col text-box">
					<p>주)&nbsp;삼삼오오</p>
				</div>
				<div class="col banner-box">
				<c:forEach var="footer" items="${bannerFooter }">
					<c:choose>
						<c:when test="${footer.title == '한국관광공사' }">
							<a href="${footer.url}" target="_blank">
								<img src="${footer.image}" class="card-img-top" alt="한국관광공사CI">
							</a>
						</c:when>
						<c:when test="${footer.title == '서울특별시' }">
							<a href="${footer.url}" target="_blank">
								<img src="${footer.image}" class="card-img-top" alt="서울특별시CI">
							</a>
						</c:when>
						<c:when test="${footer.title == '인천광역시' }">
							<a href="${footer.url}" target="_blank">
								<img src="${footer.image}" class="card-img-top" alt="인천광역시CI">
							</a>
						</c:when>
						<c:when test="${footer.title == '충청남도' }">
							<a href="${footer.url}" target="_blank">
								<img src="${footer.image}" class="card-img-top" alt="충청남도CI">
							</a>
						</c:when>
						<c:when test="${footer.title == '부산광역시' }">
							<a href="${footer.url}" target="_blank" >
								<img src="${footer.image}" class="card-img-top" alt="부산광역시CI">
							</a>
						</c:when>
					</c:choose>
				</c:forEach>				
				</div>
			</div>		
		</div>	
	</div>
</footer>