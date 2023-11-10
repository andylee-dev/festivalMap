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
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">축제 관리</h1>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="border p-3 m-3">
					<form action="festival" method = "get">
						
						지역<select name="area" class="area-dropdown"></select>
						   <select name="sigungu" class="sigungu-dropdown"></select><p>
						
						승인여부<select name = "status">
							<option value = "">전체</option>
							<option value = "0">승인대기</option>
							<option value = "1">승인완료</option>
							<!-- <option>승인반려</option> -->
						</select>
						
						삭제여부<select name="is_deleted">
							<option value = "">전체</option>
							<option value = "0">등록(전시)</option> <!-- 활성화 -->
							<option value = "1">삭제(미전시)</option><!-- 비활성화 -->
						</select><p>
						
						검색어<select name="search">
							<option value = "s_title">축제명</option>
							<option value = "s_content">내용</option>
							<option value = "s_sponsor">주최자</option>
							<option value = "s_eventplace">장소</option>
						</select>						
						<input type="text" name="keyword" placeholder = "키워드를 입력하세요.">
						
						<button type="submit" class="btn btn-outline-secondary">검색</button>
						<button type="reset" class="btn btn-outline-secondary">초기화</button>
					</form>
				</div>		
				
				<!-- Section3: Table -->		
				<div class="border p-3 m-3">
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='festivalInsertForm'">등록</button>
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">지역</th>
								<th scope="col">축제명</th>
								<th scope="col">주최자</th>
								<th scope="col">등록일</th>
								<th scope="col">승인여부</th>
								<th scope="col">수정</th>
								<th scope="col">삭제</th>
								<th scope="col">삭제여부</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${listFestivals.size() == 0}">해당하는 축제 정보가 없습니다.</c:if>
							
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="festival" items="${listFestivals}" varStatus="st">				
								<tr id="festival${st.index}">
									<td><input type="hidden" value="${festival.content_id}" id="id${st.index}">${num}</td>
									<td>${festival.area_content} ${festival.sigungu_content}</td>
									<td><a href="festivalDetail?contentIdStr=${festival.content_id}&currentPage=${page.currentPage}">${festival.title}</a></td>
									<td>${festival.sponsor}</td>
									<td><fmt:formatDate value="${festival.created_at}" type="date" pattern="YY/MM/dd"/></td> <!-- 신청일 컬럼?? -->
									<td>
										<c:if test="${festival.status == 0}">대기</c:if>
										<c:if test="${festival.status == 1}">완료</c:if>
									</td>
									<td>
										<c:if test="${festival.status == 1}">
											<input type="button" value="수정"
											 onclick="location.href='festivalUpdateForm?contentId=${festival.content_id}&currentPage=${page.currentPage}'">
										</c:if>
									</td>
									<td>
										<c:if test="${festival.status == 1}">
											<input type="button" value="삭제"
											 onclick="festivalDeleteAjax(${st.index})">
										</c:if>
									</td>
									<td>
										<c:if test="${festival.is_deleted == 1}">Y</c:if>
									</td>
								</tr>
								<c:set var="num" value="${num + 1}"/>
							</c:forEach>
							
						</tbody>
					</table>
					
					<p>총 건수 : ${totalFestivals}</p>
					
					<div align="center">
						<c:if test="${page.startPage > page.pageBlock}">
							<a href="festival?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<a href="festival?currentPage=${i}" class="pageblock">[${i}]</a>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<a href="festival?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
						</c:if>
					</div>
					
				</div>		
			</main>
		</div>
		</div>
	</body>
</html>