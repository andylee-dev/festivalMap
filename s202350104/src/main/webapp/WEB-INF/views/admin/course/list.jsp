<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Course Content</title>

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
						<i class="title-bi bi bi-image-fill "></i>
						<label  class="admin-header-title ">코스리스트 </label>					
					</div>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="container col-9 justify-content-center my-5">
				    <form action="" method="POST" class="container justify-content-center">
				    
				    <!-- 검색어 -->
			            <div class="col-12 my-4 d-flex align-items-center">
			                <label for="searchType" class="form-label col-2  mx-2">검색어</label>
			                <div class="col-4">
				                <select id="searchType" name="searchType" class="form-select">
				                    <option selected value="">전체</option>
				                </select>
			                </div>
			                <div class="col-5 mx-2">
				                <input type="text" name="keyword" class="form-control" value="${keyword}">
			                </div>
			            </div>
			            
			            <div class="col-12 my-4 d-flex align-items-center">
					    	<label for="searchType" class="form-label col-2  mx-2">지역</label>
					        <div class="col-4">
								<select name="area" class="area-dropdown form-select"></select>
							</div>
							<div class="col-5 mx-2">
								<select name="sigungu" class="sigungu-dropdown form-select"></select><p>
							</div>
						</div>
						
						<div class="container col-10 d-flex justify-content-center">
							<button type="submit" class="btn btn-primary  col-2 mx-3">검색</button>
							<button type="reset"  class="btn btn-outline-secondary col-2 mx-3">초기화</button>
						</div>
					</form>
				</div>
				
				<!-- Section3: Table -->		
				<div class="container col-9 justify-content-center my-2">
					<button onclick="location.href='courseInsertForm'" type="button" class="btn btn-outline-secondary mt-4">등록</button>
				</div>	
				<div class="container col-9 justify-content-center my-2 border p-2">
					<table class="table table-striped table-sm text-center mb-2">
						<thead>
							<tr>
								<th scope="col">코스ID</th>
								<th scope="col">코스이름</th>
								<th scope="col">총거리</th>
								<th scope="col">소요시간</th>
								<th scope="col">등록일</th>
								<th scope="col">지역</th>
								<th scope="col">관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="course" items="${courseList }">
								<tr>
									<td>${course.id }</td>
									<td>${course.course_title }</td>
									<td>${course.distance }</td>
									<td>${course.time }</td>
									<td><fmt:formatDate value="${course.created_at }" type="date" pattern="YY/MM/dd"/></td>
									<td>-</td>
									<%-- <td><input onclick="location.href='courseUpdateForm?id=${course.course_id}'" type="button" 
									class="btn btn-primary" value="관리${course.course_id}"></td> --%>
									
									<td><a href="location.href='courseUpdateForm?id=${course.course_id}'" class="detail-link">관리${course.course_id}</a></td>
									
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<nav aria-label="Page navigation example ">
					<ul class="pagination">
						<c:if test="${page.startPage > page.pageBlock}">
							<li class="page-item">
								<a href="list?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
							</li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<a href="list?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item">
								<a href="list?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
							</li>
						</c:if>
					</ul>
				</nav>
			</main>
		</div>
	</div>
</body>
</html>