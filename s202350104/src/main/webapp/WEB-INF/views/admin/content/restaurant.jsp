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
		<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<div class="container-fluid">
			<div class="row">
				<%@ include file="/WEB-INF/components/AdminSideBar.jsp"%>
				<main class="col-10 overflow-auto p-0">
				
					<!-- Section1: Title -->
					<div class="admin-header-container">
						<div class="container m-4">
							<i class="title-bi bi bi-pencil-square "></i>
							<label  class="admin-header-title ">맛집 정보 관리 </label>					
						</div>
					</div>
	
					<!-- Section2: Search Form -->
					<div class="container col-9 justify-content-center mt-5">
						<form action="adminRestaurantSearch" class="container justify-content-center">
							<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="col-form-label col-1  mx-2">검색어</label>
								<div class="col-4">
					              <select id="searchType" name="searchType" class="form-select">
						              <option value="s_title" selected>전체</option>
					              </select>
				                </div>
				                <div class="col-5 mx-2">
					                <input type="text" name="keyword" class="form-control" value="${keyword}"
					                placeholder="검색어를 입력하세요.">
				                </div>
				            </div>	
				            
				            <div class="col-12 my-4 d-flex align-items-center">
				            	<label for="searchType" class="col-form-label col-1  mx-2">테마</label>
									<div class="col-2 d-flex align-items-center">
										<select name="small_code" id="small_code" class="form-select">
											<option value="999">전체</option>
											<option value="1" ${small_code == 1? 'selected':''}>한식</option>
											<option value="2" <c:if test="${small_code =='2'}">selected="selected"</c:if>>양식</option>
											<option value="3" <c:if test="${small_code =='3'}">selected="selected"</c:if>>일식</option>
											<option value="4" <c:if test="${small_code =='4'}">selected="selected"</c:if>>중식</option>
											<option value="5" <c:if test="${small_code =='5'}">selected="selected"</c:if>>이색음식점</option>
											<option value="6" <c:if test="${small_code =='6'}">selected="selected"</c:if>>카페</option>
											<option value="7" <c:if test="${small_code =='7'}">selected="selected"</c:if>>클럽</option>
										</select>
									</div>
								
								<div class="col-12 my-4 d-flex align-items-center">	
					            	<label for="searchType" class="col-form-label col-1  mx-2">지역</label>
						            	<div class="col-2 d-flex align-items-center">
											<select name="area" class="area-dropdown form-select"></select>
										</div>
										<div class="col-2 mx-2 d-flex align-items-center">
											<select name="sigungu" class="sigungu-dropdown form-select"></select><p>
										</div>
								</div>
							</div>
							
							<div class="col-12 my-4 d-flex align-items-center">
					            <label for="searchType" class="col-form-label col-1  mx-2">승인여부</label>
					            	<div class="col-2 d-flex align-items-center">
										<select name="status" id="status" class="form-select">
											<option value="2">전체</option>
											<option value="1" <c:if test="${status =='1'}">selected="selected"</c:if>>완료</option>
											<option value="0" <c:if test="${status =='0'}">selected="selected"</c:if>>대기</option>
										</select> 
									</div>
										
								<label for="searchType" class="col-form-label col-1  mx-2">삭제여부</label>
									<div class="col-2 mx-2 d-flex align-items-center">
										<select name="is_deleted" id="is_deleted" class="form-select">
											<option value="2">전체</option>
											<option value="1" <c:if test="${is_deleted == '1'}">selected="selected"</c:if>>Y</option>
											<option value="0" <c:if test="${is_deleted == '0'}">selected="selected"</c:if>>N</option>
										</select>
									</div>
							</div>
							
							<input type="hidden" name="big_code" value="12">
							<input type="hidden" name="currentPage" value="${page.currentPage}">
							<br>
							
							<div class="container col-10 d-flex justify-content-center">
								<button type="submit" class="btn btn-primary  col-2 mx-3">검색</button>
								<button type="reset"  class="btn btn-outline-secondary col-2 mx-3">초기화</button>
							</div>
						</form>
					</div>

				
				<!-- Section3: Table -->		
				<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
					<div class="container d-flex justify-content-end p-0">
						<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4" onclick="location.href='restaurantInsertForm'">등록</button>
					</div>
					<div class="container table-container p-4">
					<div class="table-responsive">
					<table id="userTable" class="table table-md text-center p-3">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">분류</th>
								<th scope="col">음식점명</th>
								<th scope="col">주소</th>
								<th scope="col">메뉴</th>
								<th scope="col">신청일</th>
								<th scope="col">진행상황</th>
								<th scope="col">관리</th>
								<th scope="col">삭제여부</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="restaurant" items="${listRestaurant}">
								<tr>
									<td>${num}</td>
									<td>${restaurant.theme}</td>
							  <!-- 	<td><a href="restaurantDetail?contentId=${restaurant.content_id}&currentPage=${page.currentPage}">${restaurant.title}</a></td> -->
									<td>${restaurant.title}</td>
									<td>${restaurant.address}</td>
									<td>${restaurant.first_menu}</td>
						 			<td><fmt:formatDate value="${restaurant.created_at}" type="date" pattern="YY/MM/dd"/></td>
						 			<td>
						 			<!-- <c:if test="${restaurant.status == 0 }">대&emsp;기</c:if>
										<c:if test="${restaurant.status == 1 }">완&emsp;료</c:if> -->
										<c:if test="${restaurant.status == 0 }">대기</c:if>
										<c:if test="${restaurant.status == 1 }">완료</c:if> 
									</td>
									<td><a class="detail-btn" 
									href="restaurantDetail?contentId=${restaurant.content_id}&currentPage=${page.currentPage}">관리</a></td>
							  <!-- <td><c:if test="${restaurant.status == 1 }">
										<c:choose>
											<c:when test="${restaurant.is_deleted == 0 }"><input type="button" value="수정" class="btn btn-primary" 
											onclick="location.href='restaurantUpdateForm?contentId=${restaurant.content_id}&currentPage=${page.currentPage}'"></c:when>
											<c:when test="${restaurant.is_deleted == 1 }"></c:when>
										</c:choose>
										</c:if></td>
									<td><c:if test="${restaurant.status == 1 }">		
										<c:choose>
											<c:when test="${restaurant.is_deleted == 0 }"><input type="button" value="삭제" class="btn btn-outline-secondary" 
											onclick="location.href='restaurantDelete?contentId=${restaurant.content_id}'"></c:when>
											<c:when test="${restaurant.is_deleted == 1 }"></c:when>
										</c:choose>
										</c:if></td> -->
										
									<td><c:if test="${restaurant.is_deleted ==1 }">Y</c:if></td>			
								 </tr>
								 <c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>
		</div>
		</div>	
		
		<nav aria-label="Page navigation example ">
			<ul class="pagination">
				<c:if test="${page.startPage > page.pageBlock}">
					<c:choose>
						<c:when test="${path==0}">
							<li class="page-item">
								<a href="restaurant?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
							</li>
						</c:when>
						<c:when test="${path==1}">
							<li class="page-item">
								<a href="restaurantSearch?area=${area}?sigungu=${sigungu}?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>	
							</li>
						</c:when>
						<c:when test="${path==2}">
							<li class="page-item">
								<a href="adminRestaurantSearch?status=${status}&small_code=${small_code}&big_code=${big_code}&currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>	
							</li>
						</c:when>
					</c:choose>	
				</c:if>
				<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
					<c:choose>
						<c:when test="${path==0}">
							<li class="page-item">
								<a href="restaurant?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
							</li>
						</c:when>
						<c:when test="${path==1}">
							<li class="page-item">
								<a href="restaurantSearch?area=${area}&sigungu=${sigungu}&currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
							</li>
						</c:when>
						<c:when test="${path==2}">
							<li class="page-item">
								<a href="adminRestaurantSearch?status=${status}&small_code=${small_code}&big_code=${big_code}&currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
							</li>
						</c:when>
					</c:choose>	
				</c:forEach>
				<c:if test="${page.endPage < page.totalPage}">
					<c:choose>
						<c:when test="${path==0}">
							<li class="page-item">
								<a href="restaurant?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
							</li>
						</c:when>
						<c:when test="${path==1}">
							<li class="page-item">
								<a href="restaurantSearch?area=${area}&sigungu=${sigungu}&currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
							</li>
						</c:when>
						<c:when test="${path==2}">
							<li class="page-item">
								<a href="adminRestaurantSearch?status=${status}&small_code=${small_code}&big_code=${big_code}&currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
							</li>
						</c:when>
					</c:choose>	
				</c:if>
			</ul>
		</nav>
	  </main>
	  </div>
	  </div>
	</body>
</html>