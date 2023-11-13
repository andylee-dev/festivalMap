<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Restaurant content</title>
		<%-- <%@ include file="/WEB-INF/components/AdminUpdateAreas.jsp"%> --%>
	</head>
	<body>
		<div class="container-fluid">
			<div class="row">
				<%@ include file="/WEB-INF/components/AdminSideBar.jsp"%>
				<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
					<!-- Section1: Title -->
					<div
						class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
						<h1 class="border">지역정보 - 맛집</h1>
					</div>
	
					<!-- Section2: Search Form -->
					<div class="border p-3 m-3">
						<form action="adminRestaurantSearch">
							<h1 class="border">검색폼</h1>
							<select name="status" id="status">
								<option value="2">전체</option>
								<option value="1" <c:if test="${status =='1'}">selected="selected"</c:if>>활성화</option>
								<option value="0" <c:if test="${status =='0'}">selected="selected"</c:if>>비활성화</option>
							</select> 
							
							<select name="small_code" id="small_code">
								<option value="999">전체</option>
								<option value="1" <c:if test="${small_code =='1'}">selected="selected"</c:if>>한식</option>
								<option value="2" <c:if test="${small_code =='2'}">selected="selected"</c:if>>양식</option>
								<option value="3" <c:if test="${small_code =='3'}">selected="selected"</c:if>>일식</option>
								<option value="4" <c:if test="${small_code =='4'}">selected="selected"</c:if>>중식</option>
								<option value="5" <c:if test="${small_code =='5'}">selected="selected"</c:if>>이색음식점</option>
								<option value="6" <c:if test="${small_code =='6'}">selected="selected"</c:if>>카페</option>
								<option value="7" <c:if test="${small_code =='7'}">selected="selected"</c:if>>클럽</option>
							</select>
							<input type="hidden" name="big_code" value="12">
							<input type="hidden" name="currentPage" value="${page.currentPage}">
							<button type="submit" class="btn btn-outline-secondary">검색</button>
							<input type="reset" class="btn btn-outline-secondary" value="초기화">
						</form>
					</div>

				
				<!-- Section3: Table -->		
				<div class="border p-3 m-3">
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='restaurantInsertForm'">등록</button>
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">테마</th>
								<th scope="col">음식점명</th>
								<th scope="col">주소</th>
								<th scope="col">메뉴</th>
								<th scope="col">신청일</th>
								<th scope="col">진행상황</th>
								<th scope="col">수정</th>
								<th scope="col">삭제</th>
								<th scope="col">삭제여부</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="restaurant" items="${listRestaurant}">
								<tr>
									<td>${num}</td>
									<td>${restaurant.theme}</td>
									<td><a href="restaurantDetail?contentId=${restaurant.content_id}&currentPage=${page.currentPage}">${restaurant.title}</a></td>
									<td>${restaurant.address}</td>
									<td>${restaurant.menu}</td>
						 			<td><fmt:formatDate value="${restaurant.created_at}" type="date" pattern="YY/MM/dd"/></td>
						 			<td>
						 				<c:if test="${restaurant.status == 0 }">대&emsp;기</c:if>
										<c:if test="${restaurant.status == 1 }">완&emsp;료</c:if>
									</td>
									<td><c:if test="${restaurant.status == 1 }">
										<c:choose>
											<c:when test="${restaurant.is_deleted == 0 }"><input type="button" value="수정" onclick="location.href='restaurantUpdateForm?contentId=${restaurant.content_id}&currentPage=${page.currentPage}'"></c:when>
											<c:when test="${restaurant.is_deleted == 1 }"></c:when>
										</c:choose>
										</c:if></td>
									<td><c:if test="${restaurant.status == 1 }">		
										<c:choose>
											<c:when test="${restaurant.is_deleted == 0 }"><input type="button" value="삭제" onclick="location.href='restaurantDelete?contentId=${restaurant.content_id}'"></c:when>
											<c:when test="${restaurant.is_deleted == 1 }"></c:when>
										</c:choose>
										</c:if></td>
									<td><c:if test="${restaurant.is_deleted ==1 }">Y</c:if></td>			
								 </tr>
								 <c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>
				</div>		
			</main>
		</div>
		</div>
		
		<div align="center">
		<c:if test="${page.startPage > page.pageBlock}">
			<c:choose>
				<c:when test="${path==0}">
					<a href="restaurant?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
				</c:when>
				<c:when test="${path==1}">
					<a href="restaurantSearch?area=${area}?sigungu=${sigungu}?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>	
				</c:when>
				<c:when test="${path==2}">
					<a href="adminRestaurantSearch?status=${status}&small_code=${small_code}&big_code=${big_code}&currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>	
				</c:when>
			</c:choose>	
		</c:if>
		<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
			<c:choose>
				<c:when test="${path==0}">
					<a href="restaurant?currentPage=${i}" class="pageblock">[${i}]</a>
				</c:when>
				<c:when test="${path==1}">
					<a href="restaurantSearch?area=${area}&sigungu=${sigungu}&currentPage=${i}" class="pageblock">[${i}]</a>
				</c:when>
				<c:when test="${path==2}">
					<a href="adminRestaurantSearch?status=${status}&small_code=${small_code}&big_code=${big_code}&currentPage=${i}" class="pageblock">[${i}]</a>
				</c:when>
			</c:choose>	
		</c:forEach>
		<c:if test="${page.endPage < page.totalPage}">
			<c:choose>
				<c:when test="${path==0}">
					<a href="restaurant?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
				</c:when>
				<c:when test="${path==1}">
					<a href="restaurantSearch?area=${area}&sigungu=${sigungu}&currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
				</c:when>
				<c:when test="${path==2}">
					<a href="adminRestaurantSearch?status=${status}&small_code=${small_code}&big_code=${big_code}&currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
				</c:when>
			</c:choose>	
		</c:if>
		</div>
		
	</body>
</html>