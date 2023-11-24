<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>spot content</title>
		<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="/js/updateArea.js"></script>
		<script type="text/javascript">
			function spotDeleteAjax(pIndex) {
				var deleteId = Number($('#id'+pIndex).val());
				var currentPage = ${page.currentPage};
				if(confirm("정말 삭제하시겠습니까?")) {
					$.ajax(
							{
								method:"POST",
								url:"<%=request.getContextPath()%>/admin/content/spotDeleteAjax",
								data:{contentId : deleteId},
								dataType:'text',
								success:
									function(result) {
											if(result == '1') {
												$('#spot'+pIndex).remove();
												alert("성공적으로 삭제되었습니다.");
												location.reload();
											} else {
												alert("삭제에 실패하였습니다.");
											}		
									}
							}		
					)
				}
			}
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
						<label  class="admin-header-title ">명소 정보 관리 </label>					
					</div>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="container col-9 justify-content-center mt-5">
					<form action="spot" method ="get" class="container justify-content-center">
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="col-form-label col-1  mx-2">검색어</label>
				               <div class="col-4">
					              <select id="searchType" name="searchType" class="form-select">
						              <option value = "s_title">명소명</option>
						          </select>
				                </div>
				                <div class="col-5 mx-2">
					                <input type="text" name="keyword" class="form-control" value="${keyword}"
					                placeholder="검색어를 입력하세요.">
				                </div>
				        </div>
				        
				        <div class="col-12 my-4 d-flex align-items-center">
								<label for="searchType" class="col-form-label col-1  mx-2">분류</label>
									<div class="col-2 d-flex align-items-center">
									<input type="hidden" name="big_code" value="14">
										<select name="small_code" class="form-select">
											<option value="0">전체</option>
											<c:forEach var="small" items="${listCommonCodes}">
											<c:if test="${small.big_code == 14 && small.small_code != 999}">
												<option value="${small.small_code}"${small.small_code == small_code? 'selected':''} >${small.content}</option>									
											</c:if>
											</c:forEach>
										</select>
									</div>
									
									<div class="col-12 my-4 d-flex align-items-center">
							            <label for="searchType" class="col-form-label col-1  mx-2">지역</label>
							            	<div class="col-2 d-flex align-items-center">
												<select name="area" class="area-dropdown form-select"></select>
											</div>
											<div class="col-2 mx-2 d-flex align-items-center">
												<select name="sigungu" class="sigungu-dropdown form-select "></select><p>
											</div>
									</div>
							</div>
						              
						
							<div class="col-12 my-4 d-flex align-items-center">	
								<label for="searchType" class="col-form-label col-1  mx-2">승인여부</label>
									<div class="col-2 d-flex align-items-center">
										<select name = "status" class="form-select">
											<option value = "" selected>전체</option>
											<option value = "0">승인대기</option>
											<option value = "1">승인완료</option>
											<!-- <option>승인반려</option> -->
										</select>
									</div>
									
								<label for="searchType" class="col-form-label col-1  mx-2">삭제여부</label>
									<div class="col-2 mx-2 d-flex align-items-center">
										<select name="is_deleted" class="form-select">
											<option value = "" selected>전체</option>
											<option value = "0">등록</option>
											<option value = "1">삭제</option>
										</select><p>
									</div>
						</div>
	
						<div class="container col-10 d-flex justify-content-center">
								<button type="submit" class="btn btn-primary  col-2 mx-3">검색</button>
								<button type="reset"  class="btn btn-outline-secondary col-2 mx-3" onclick="location.href='../content/spot?currentPage=1'">초기화</button>
						</div>
					</form>
				</div>			
				
				<!-- Section3: Table -->		
				<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
					<div class="container d-flex justify-content-end p-0">
						<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4" onclick="location.href='spotInsertForm'">등록</button>
					</div>	
					<div class="container table-container p-4">
					<div class="table-responsive">
						<table id="userTable" class="table table-md text-center p-3">
							<thead>
								<tr>
									<th scope="col">순번</th>
									<th scope="col">테마</th>
									<th scope="col">명소명</th>
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
								<c:forEach var="spot" items="${listSpot}">
									<tr id="spot${st.index}">
										<td><input type="hidden" value="${spot.content_id}" id="id${st.index}">${num}</td>
										<td>${spot.cc_content}</td>
										<td>${spot.title}</td>
										<td>${spot.address}</td>
										<td>${spot.user_id}</td>
										<td><fmt:formatDate value="${spot.created_at}" type="date" pattern="YY/MM/dd"/></td> <!-- 신청일 컬럼?? -->
										<td>
											<c:if test="${spot.status == 0}">승인대기</c:if>
											<c:if test="${spot.status == 1}">승인완료</c:if>
										</td>
										<td>
											<c:if test="${spot.is_deleted == 0}">Y</c:if>
											<c:if test="${spot.is_deleted == 1}">N</c:if>
										</td>
										<td><a class="detail-btn" 
										href="spotDetail?contentIdStr=${spot.content_id}&currentPage=${page.currentPage}">관리</a></td>
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
							<li class="page-item">
								<a href="spot?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
							</li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<a href="spot?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item">
								<a href="spot?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
							</li>
						</c:if>
					</ul>
				</nav>	
		</main>
	</div>
	</div>
</body>
</html>