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

			document.addEventListener("DOMContentLoaded", function() {
				updateAreaOptions();
				$(".area-dropdown").change(function() {
					const selectedArea = $(this).val();
					if (selectedArea) {
						updateSigunguOptions(selectedArea);
					} else {
						$(".sigungu-dropdown").empty().append("<option value='0'>시군구</option>");
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
				<div class="container col-7 justify-content-center my-5">
					<form action="festival" method = "get">
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="form-label col-2  mx-2">검색어</label>
				               <div class="col-3">
					              <select id="searchType" name="searchType" class="form-select">
						              <option value="s_title" selected>축제명</option>
									  <option value="s_content">내용</option>
									  <option value="s_sponsor">주최자</option>
									  <option value="s_eventplace">장소</option>
					              </select>
				                </div>
				                <div class="col-7 mx-2">
					                <input type="text" name="keyword" class="form-control" value="${keyword}"
					                placeholder="검색어를 입력하세요.">
				                </div>
				        </div>
				            
				            <div class="col-12 my-4 d-flex align-items-center">
					            <label for="searchType" class="form-label col-1  mx-2"></label>
					            	<div class="col-2 d-flex align-items-center">
										<select name="area" class="area-dropdown form-select"></select>
									</div>
									<div class="col-2 mx-2 d-flex align-items-center">
										<select name="sigungu" class="sigungu-dropdown form-select"></select><p>
									</div>
							</div>
							
							<div class="col-12 my-4 d-flex align-items-center">
								<label for="searchType" class="form-label col-1  mx-2">필터링</label>
									<div class="col-2 d-flex align-items-center">
										<select name = "status" class="form-select">
											<option value = "" selected>승인여부</option>
											<option value = "0">승인대기</option>
											<option value = "1">승인완료</option>
											<!-- <option>승인반려</option> -->
										</select>
									</div>
									
									<div class="col-2 mx-2 d-flex align-items-center">
										<select name="is_deleted" class="form-select">
											<option value = "" selected>삭제여부</option>
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
				<div class="container col-9 d-flex justify-content-end my-2">
					<button type="button" class="btn btn-primary mt-4" onclick="location.href='festivalInsertForm'">등록</button>
				</div>
				<!-- 컬럼 -->
				<div class="container p-3 list-column-nh">
					<div class="row row-cols-8 align-items-start">
						<div class="col-md-1">순번</div>
						<div class="col-md-2">지역</div>
						<div class="col-md-2">축제명</div>
						<div class="col-md-3">주최자</div>
						<div class="col-md-1">등록일</div>
						<div class="col-md-1">승인여부</div>
						<div class="col-md-1">삭제여부</div>
						<div class="col-md-1"></div>
					</div>
				</div>
					
				<!-- 행 -->
				<div class="container p-3 list-rows-nh">
					<div class="row row-cols-8 align-items-start">
						<c:if test="${listFestivals.size() == 0}"><div class="col-8">해당하는 축제 정보가 없습니다.</div></c:if>	
						<c:set var="num" value="${page.start}"/>
							<c:forEach var="festival" items="${listFestivals}">				
								<div class="row row-cols-5 align-items-center">
									<div class="col-md-1"><input type="hidden" value="${festival.content_id}">${num}</div>
									<div class="col-md-2">${festival.area_content} ${festival.sigungu_content}</div>
									<div class="col-md-2">${festival.title}</div>
									<div class="col-md-3">${festival.sponsor}</div>
									<div class="col-md-1"><fmt:formatDate value="${festival.created_at}" type="date" pattern="YY/MM/dd"/></div>
									<div class="col-md-1">
										<c:if test="${festival.status == 0}">승인대기</c:if>
										<c:if test="${festival.status == 1}">승인완료</c:if>
									</div>
									<div class="col-md-1">
										<c:if test="${festival.is_deleted == 0}">N</c:if>
										<c:if test="${festival.is_deleted == 1}">Y</c:if>
									</div>
									<div class="col-md-1"><a href="festivalDetail?contentIdStr=${festival.content_id}&currentPage=${page.currentPage}" class="detail-link">관리</a></div>
								</div>
								<c:set var="num" value="${num + 1}"/>
							</c:forEach>
					</div>
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