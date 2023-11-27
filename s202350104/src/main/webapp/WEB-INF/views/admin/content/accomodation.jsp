<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역정보 숙박</title>
		<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="/js/updateArea.js"></script>
		<script type="text/javascript">

		document.addEventListener("DOMContentLoaded", function() {
			updateAreaOptions();
			$(".area-dropdown").change(function() {
				const selectedArea = $(this).val();
				if (selectedArea) {
					updateSigunguOptions(selectedArea);
				} else {
					$(".sigungu-dropdown").empty().append("<option value='0'>전체</option>");
				}
			});
		});
		
	</script>
</head>
<body>
	<div class="container-fluid">
	<div class="row">
		<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
		<main class="col-10 overflow-auto p-0">
			<!-- Section1: Title -->
			<div class="admin-header-container">
				<div class="container m-4">
					<i class="title-bi bi bi-pencil-square "></i>
					<label class="admin-header-title ">숙박 정보 관리 </label>					
				</div>
			</div>
	
			<!-- Section2: Search Form -->		
			<div class="container col-9 justify-content-center mt-5">
					<form action="accomodationSearch" method="get" class="container justify-content-center">
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="col-form-label col-1  mx-2">검색어</label>
								<div class="col-4">
					              <select id="searchType" name="searchType" class="form-select">
						              <option value="" selected>숙소명</option>
						          </select>
						        </div>
								<div class="col-5 mx-2">
									<input type="text" name="keyword" class="form-control" placeholder="숙소이름을 입력하세요">
								</div>
						</div>
						
						<div class="col-12 my-4 d-flex align-items-center">
				            	<label for="searchType" class="col-form-label col-1  mx-2">분류</label>
									<div class="col-2 d-flex align-items-center">
										<select name="small_code" class="form-select">
											<option value="999">전체</option>
											<c:forEach var="small" items="${listSmallCode}">
												<option value="${small.small_code}"${small.small_code == small_code? 'selected':''} >${small.content}</option>									
											</c:forEach>
										</select>
									</div>
									
									<div class="col-12 my-4 d-flex align-items-center">	
				            			<label for="searchType" class="col-form-label col-1  mx-2">지역</label>
					            			<div class="col-2 mx-2 d-flex align-items-center">
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
									<select name="status" class="form-select">
										<option value="2" ${status == 2 ? 'selected' : ''}>전체</option>
										<option value="1" ${status == 1 ? 'selected' : ''}>승인완료</option>
										<option value="0" ${status == 0 ? 'selected' : ''}>승인대기</option>
									</select>
								</div>
						
							<label for="searchType" class="col-form-label col-1  mx-2">삭제여부</label>
								<div class="col-2 mx-2 d-flex align-items-center">
									<select name="is_deleted" class="form-select">
										<option value="2" ${is_deleted == 2 ? 'selected' : ''}>전체</option>
										<option value="0" ${is_deleted == 0 ? 'selected' : ''}>등록숙소</option>
										<option value="1" ${is_deleted == 1 ? 'selected' : ''}>삭제숙소</option>
									</select>
								</div>
						</div>
						
						<div class="container col-10 d-flex justify-content-center">
							<button type="submit" class="btn btn-primary col-2 mx-3">검색</button>
							<button type="reset" name="deleted" class="btn btn-outline-secondary col-2 mx-3">초기화</button><p>	
							<input type="hidden" name="big_code" value="13">
						</div>
					</form>
			</div>		
			
			<!-- Section3: Table -->		
			<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
				<div class="container d-flex justify-content-end p-0">
					<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4" onclick="location.href='accomodationInsertForm'">등록</button>
				</div>	
				<div class="container table-container p-4">
				<div class="table-responsive">
					<table id="userTable" class="table table-md text-center p-3">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">지역</th>
								<th scope="col">숙박업장이름</th>
								<th scope="col">주소</th>
								<th scope="col">작성자</th>
								<th scope="col">신청일</th>
								<th scope="col">승인여부</th>
								<th scope="col">게시</th>	
								<th scope="col">관리</th>							
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="accomodation" items="${listAccomodation}" varStatus="st">
								<tr id="accomodation${st.index}">
										<td><input type="hidden" value="${accomodation.content_id}" id="id${st.index}">${num}</td>
										<td>${accomodation.area_content} ${accomodation.sigungu_content}</td>
										<td>${accomodation.title}</td>
										<td>${accomodation.address}</td>
										<td>${accomodation.user_id}</td>
										<td><fmt:formatDate value="${accomodation.created_at}" type="date" pattern="YY/MM/dd"/></td>
										<td>
							 				<c:if test="${accomodation.status == 0 }">승인대기</c:if>
											<c:if test="${accomodation.status == 1 }">승인완료</c:if>
										</td>
										<td>
											<c:if test="${accomodation.is_deleted == 0}">Y</c:if>
											<c:if test="${accomodation.is_deleted == 1}">N</c:if>
										</td>
										<td><a class="detail-btn" 
											href='accomodationDetail?contentId=${accomodation.content_id}&currentPage=${page.currentPage}'>관리</a></td>
									 	
								</tr>
									 <c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>
				</div>
				</div>
			</div>
				
				<nav aria-label="Page navigation example ">
						<ul class="pagination">
							<c:if test="${page.startPage > page.pageBlock}">
								<c:choose>
									<c:when test="${path ==0}">
										<li class="page-item">
											<a href="accomodation?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
										</li>
									</c:when>
									<c:when test="${path ==1}">
										<li class="page-item">
											<a href="accomodationSearch?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
										</li>
									</c:when>
								</c:choose>
									
							</c:if>
							<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
								<c:choose>
									<c:when test="${path ==0}">
										<li class="page-item">
											<a href="accomodation?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
										</li>
									</c:when>
									<c:when test="${path == 1}">
										<li class="page-item">
											<a href="accomodationSearch?currentPage=${i}&keyword=${keyword}&big_code=${big_code}&small_code=${small_code}&is_deleted=${is_deleted}&status=${status}&area=${area}&sigungu=${sigungu}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
										</li>
									</c:when>
								</c:choose>
							</c:forEach>
											
							<c:if test="${page.endPage < page.totalPage}">
								<c:choose>
									<c:when test="${path ==0}">
										<li class="page-item">
											<a href="accomodation?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
										</li>
									</c:when>
									<c:when test="${path ==1}">
										<li class="page-item">
											<a href="accomodationSearch?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
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