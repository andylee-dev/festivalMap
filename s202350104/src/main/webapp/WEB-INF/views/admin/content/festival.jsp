<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>축제 관리</title>
		
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="/js/updateArea.js"></script>
		<script type="text/javascript">
		
			function festivalDeleteAjax(pIndex) {
				var deleteId = Number($('#id'+pIndex).val());
				var currentPage = ${page.currentPage};
				
				if(confirm("정말 삭제하시겠습니까?")) {
					$.ajax(
							{
								method:"POST",
								url:"<%=request.getContextPath()%>/admin/content/festivalDeleteAjax",
								data:{contentId : deleteId},
								dataType:'text',
								success:
									function(result) {
											if(result == '1') {
												$('#festival'+pIndex).remove();
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
						<label class="admin-header-title ">축제 정보 관리 </label>					
					</div>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="container col-9 justify-content-center my-5">
					<form action="festival" method = "get">
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="form-label col-2  mx-2">검색어</label>
				               <div class="col-4">
					              <select id="searchType" name="searchType" class="form-select">
						              <option value="s_title" selected>축제명</option>
									  <option value="s_content">내용</option>
									  <option value="s_sponsor">주최자</option>
									  <option value="s_eventplace">장소</option>
					              </select>
				                </div>
				                <div class="col-5 mx-2">
					                <input type="text" name="keyword" class="form-control" value="${keyword}"
					                placeholder="검색어를 입력하세요.">
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
							
							<div class="col-12 my-4 d-flex align-items-center">
								<label for="searchType" class="form-label col-2  mx-2">승인여부</label>
									<div class="col-2 align-self-center">
										<select name = "status" class="form-select">
											<option value = "" selected>전체</option>
											<option value = "0">승인대기</option>
											<option value = "1">승인완료</option>
											<!-- <option>승인반려</option> -->
										</select>
									</div>
							
								<label for="searchType" class="form-label col-2  mx-2">삭제여부</label>
									<div class="col-2 align-self-center">
										<select name="is_deleted" class="form-select">
											<option value = "" selected>전체</option>
											<option value = "0">등록</option>
											<option value = "1">삭제</option>
										</select><p>
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
					<button type="button" class="btn btn-outline-secondary mt-4" onclick="location.href='festivalInsertForm'">등록</button>
				</div>
				<div class="container col-9 justify-content-center my-2 border p-2">
					<table class="table table-striped table-sm text-center mb-2">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">지역</th>
								<th scope="col">축제명</th>
								<th scope="col">주최자</th>
								<th scope="col">등록일</th>
								<th scope="col">승인여부</th>
								<th scope="col">삭제여부</th>
								<th scope="col">관리</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${listFestivals.size() == 0}"><td colspan="8">해당하는 축제 정보가 없습니다.</td></c:if>
							
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="festival" items="${listFestivals}" varStatus="st">				
								<tr id="festival${st.index}">
									<td><input type="hidden" value="${festival.content_id}" id="id${st.index}">${num}</td>
									<td>${festival.area_content} ${festival.sigungu_content}</td>
									<td>${festival.title}</td>
									<td>${festival.sponsor}</td>
									<td><fmt:formatDate value="${festival.created_at}" type="date" pattern="YY/MM/dd"/></td> <!-- 신청일 컬럼?? -->
									<td>
										<c:if test="${festival.status == 0}">승인대기</c:if>
										<c:if test="${festival.status == 1}">승인완료</c:if>
									</td>
									<td>
										<c:if test="${festival.is_deleted == 0}">N</c:if>
										<c:if test="${festival.is_deleted == 1}">Y</c:if>
									</td>
									<td><a href="festivalDetail?contentIdStr=${festival.content_id}&currentPage=${page.currentPage}" class="detail-link">관리</a></td>
								</tr>
								<c:set var="num" value="${num + 1}"/>
							</c:forEach>
							
						</tbody>
					</table>
					
					<p>총 건수 : ${totalFestivals}</p>
					
				</div>		
				<nav aria-label="Page navigation example ">
					<ul class="pagination">
						<c:if test="${page.startPage > page.pageBlock}">
							<li class="page-item">
								<a href="festival?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
							</li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<a href="festival?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item">
								<a href="festival?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
							</li>
						</c:if>
					</ul>
				</nav>
			</main>
		</div>
		</div>
	</body>
</html>