<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>AdminList content</title>
	</head>
	<body>
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-people-fill "></i>
					<label  class="admin-header-title ">관리자설정 - 관리자리스트</label>>
					</div>
				</div>
				<!-- Section2: Search Form -->
				<div class="container col-9 justify-content-center my-5">
				    <form action="/admin/adminList" method="POST" class="container justify-content-center">
					    <input  type="hidden" name="small_code" value="1">						
				
				        <!-- 검색어 -->
			            <div class="col-12 my-4 d-flex align-items-center">
			                <label for="searchType" class="form-label col-2  mx-2">검색어</label>
			                <div class="col-4">
				                <select id="searchType" name="searchType" class="form-select">
				                    <option selected value="name">사용자 이름</option>
				                    <option value="email">이메일</option>
				                    <option value="nickname">닉네임</option>
				                </select>
			                </div>
			                <div class="col-5 mx-2">
				                <input type="text" name="keyword" class="form-control" value="${keyword}">
			                </div>
			            </div>
						<!-- 기간 -->
			            <div class="col-12 my-4 d-flex align-items-center ">
			                <label for="searchType" class="col-form-label col-2  mx-1">가입기간</label>
				            <div class="col-6  mx-2 d-flex">
				                <input type="radio" class="btn-check" name="dateOptions" id="TO" value="TO" autocomplete="off">
				                <label class="btn col-2 mx-1" for="TO">오늘</label>
				                <input type="radio" class="btn-check" name="dateOptions" id="1W" value="1W" autocomplete="off">
				                <label class="btn col-2 mx-1" for="1W">1주일</label>
				                <input type="radio" class="btn-check" name="dateOptions" id="1M" value="1M" autocomplete="off">
				                <label class="btn col-2 mx-1" for="1M">1개월</label>
				                <input type="radio" class="btn-check" name="dateOptions" id="3M" value="3M" autocomplete="off">
				                <label class="btn col-2 mx-1" for="3M">3개월</label>
				                <input type="radio" class="btn-check" name="dateOptions" id="6M" value="6M" autocomplete="off">
				                <label class="btn col-2 mx-1" for="6M">6개월</label>
				                <input type="radio" class="btn-check" name="dateOptions" id="ALL" value="ALL" autocomplete="off" checked>
				                <label class="btn col-2 mx-1" for="ALL">전체</label>
				            
				           	 	<div class="col-4 d-flex">
				                	<input type="date" class="mx-1" id="startDatePicker" name="startDate" value="${startDate}">
				               		<input type="date" class="mx-1" id="endDatePicker" name="endDate" value="${endDate}">
				            	</div>
				            </div>
				        </div>
				
				        <!-- 옵션 -->
			            <div class="col-12 my-4 d-flex align-items-center ">
			                <label for="searchType" class="col-form-label col-2  mx-1">탈퇴</label>
				            <div class="form-check mx-2">
				                <input class="form-check-input" type="radio" name="is_deleted" id="is_deleted1" value='' checked>
				                <label class="form-check-label" for="is_deleted1">전체 회원</label>
				            </div>
				            <div class="form-check mx-2">
				                <input class="form-check-input" type="radio" name="is_deleted" id="is_deleted3" value="0">
				                <label class="form-check-label" for="is_deleted3">가입 회원</label>
				            </div>
				            <div class="form-check mx-2">
				                <input class="form-check-input" type="radio" name="is_deleted" id="is_deleted2" value="1">
				                <label class="form-check-label" for="is_deleted2">탈퇴 회원</label>
				            </div>
				        </div>
				        <div class="container col-10 d-flex justify-content-center">
					        <button type="submit" class="btn btn-primary  col-2 mx-3">검색</button>
					        <button type="reset" class="btn btn-outline-secondary col-2 mx-3">초기화</button>				        
				        </div>
				    </form>
				</div>
				<div class="container col-9 justify-content-center my-2">
					<button type="button" class="btn btn-outline-secondary mt-4">등록</button>
				</div>
				
				<!-- Section3: Table -->
				<div class="container col-9 justify-content-center my-2 border p-2">
					<table id="adminTable" class="table table-striped table-sm text-center">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">대분류</th>
								<th scope="col">소분류</th>
								<th scope="col">이름</th>
								<th scope="col">비밀번호</th>
								<th scope="col">별명</th>
								<th scope="col">생년월일</th>
								<th scope="col">전화번호</th>
								<th scope="col">이메일</th>
								<th scope="col">주소</th>
								<th scope="col">수정</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="adminList" items="${listUser}">
								<tr>
									<td>${num}</td>
									<td>${adminList.big_code}</td>
									<td>${adminList.small_code}</td>
									<td>${adminList.name}</td>
									<td>${adminList.password}</td>
									<td>${adminList.nickname}</td>
									<td>${adminList.birthday}</td>
									<td>${adminList.phone_num}</td>
									<td>${adminList.email}</td>
									<td>${adminList.address}</td>
						 			<td><input class="btn btn-primary" type="button" value="수정"></td>
									<td><input class="btn btn-outline-secondary" type="button" value="삭제"></td>					
								 </tr>
								 <c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>
					</div>
					<nav aria-label="Page navigation example ">
						<ul class="pagination">
					    	<c:if test="${page.startPage > page.pageBlock}">
							    <li class="page-item">
						        	<a href="javascript:void(0)" onclick="location.href=createQueryURL(${page.startPage-page.pageBlock})" class="pageblock page-link">[이전]</a>
						    	</li>
					    	</c:if>
						    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							    <li class="page-item">
									<a href="javascript:void(0)" onclick="location.href=createQueryURL(${i})" class="pageblock page-link ${page.currentPage == i ? "active":"" }">${i}</a>					    
						    	</li>
							</c:forEach>
						    <c:if test="${page.endPage < page.totalPage}">
							    <li class="page-item">
							        <a href="javascript:void(0)" onclick="location.href=createQueryURL(${page.startPage+page.pageBlock})"  class="pageblock page-link" >[다음]</a>
						    	</li>
						    </c:if>
						</ul>
					</nav>
			</main>
		</div>
	</div>
</body>
</html>