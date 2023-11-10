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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function accomodationDeleteAjax(pIndex) {
				var deleteId = Number($('#id'+pIndex).val());
				var currentPage = ${page.currentPage};
				if(confirm("정말 삭제하시겠습니까?")) {
					$.ajax(
							{
								method:"POST",
								url:"<%=request.getContextPath()%>/admin/content/accomodationDeleteAjax",
								data:{contentId : deleteId},
								dataType:'text',
								success:
									function(result) {
											if(result == '1') {
												$('#accomodation'+pIndex).remove();
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
		</script>
</head>
<body>
	<div class="container-fluid">
	<div class="row">
		<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
		<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			<!-- Section1: Title -->
			<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
				<h1 class="border">숙박 리스트</h1>
			</div>
	
			<!-- Section2: Search Form -->		
			<div class="border p-3 m-3">
					<form action="accomodationSearch" method="get">
							<input type="text" name="keyword" placeholder="숙소이름을 입력하세요">
							<button type="submit" class="btn btn-outline-secondary">숙소이름검색</button>
							<button type="reset" name="deleted" class="btn btn-outline-secondary">초기화</button><p>
							<input type="hidden" name="big_code" value="13">
							<select name="is_deleted">
								<option value="2" ${is_deleted == 2 ? 'selected' : ''}>전체</option>
								<option value="0" ${is_deleted == 0 ? 'selected' : ''}>등록숙소</option>
								<option value="1" ${is_deleted == 1 ? 'selected' : ''}>삭제숙소</option>
							</select>
							<select name="status">
								<option value="2" ${status == 2 ? 'selected' : ''}>전체</option>
								<option value="1" ${status == 1 ? 'selected' : ''}>활성화</option>
								<option value="0" ${status == 0 ? 'selected' : ''}>비활성화</option>
							</select>
							<select name="small_code" >
								<option value="999">전체</option>
								<c:forEach var="small" items="${listSmallCode}">
								<option value="${small.small_code}"${small.small_code == small_code? 'selected':''} >${small.content}</option>									
								</c:forEach>
							</select>
						</form>
			</div>		
			
			<!-- Section3: Table -->		
			<div class="border p-3 m-3">
				<button type="button" class="btn btn-outline-secondary " onclick="location.href='accomodationInsertForm'">등록</button>
				<table class="table table-striped table-sm">
					<thead>
						<tr>
							<th scope="col">순번</th>
							<th scope="col">지역</th>
							<th scope="col">숙박업장이름</th>
							<th scope="col">주소</th>
							<th scope="col">신청일</th>
							<th scope="col">승인여부</th>
							<th scope="col">수정</th>
							<th scope="col">삭제</th>
						</tr>
					</thead>
						<tbody>
						<c:set var="num" value="${page.start}"/>
						<c:forEach var="accomodation" items="${listAccomodation}" varStatus="st">
							<tr id="accomodation${st.index}">
									<td><input type="hidden" value="${accomodation.content_id}" id="id${st.index}">${num}</td>
									<td>${accomodation.area} ${accomodation.sigungu}</td>
									<td><a href="accomodationDetail?contentIdStr=${accomodation.content_id}&currentPage=${page.currentPage}">${accomodation.title}</a></td>
									<td>${accomodation.address}</td>
									<td><fmt:formatDate value="${accomodation.created_at}" type="date" pattern="YY/MM/dd"/></td>
									<td>
						 				<c:if test="${accomodation.status == 0 }">승인대기</c:if>
										<c:if test="${accomodation.status == 1 }">승인완료</c:if>
									</td>
									<td><c:if test="${accomodation.status == 1}"><input type="button" value="수정" onclick="location.href='accomodationUpdateForm?contentId=${accomodation.content_id}&currentPage=${page.currentPage}'"></c:if></td>
									<td><c:if test="${accomodation.status == 1}"><input type="button" value="삭제" onclick="accomodationDeleteAjax(${st.index})"></c:if></td>
								 </tr>
								 <td>
										<c:if test="${accomodation.is_deleted == 1}">삭제완료</c:if>
									</td>
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
			<a href="accomodation?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
		</c:if>
		<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
			<a href="accomodation?currentPage=${i}" class="pageblock">[${i}]</a>
		</c:forEach>
		<c:if test="${page.endPage < page.totalPage}">
			<a href="accomodation?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
		</c:if>
	</div>
</body>
</html>