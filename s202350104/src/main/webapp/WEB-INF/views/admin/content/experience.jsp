<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>experience content</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
		function confirmDelete(contentId) {
	        if (confirm('정말로 이 항목을 삭제하시겠습니까?')) {
	            $.ajax({
	                type: 'POST', // 또는 'POST' 등의 HTTP 메서드 사용 가능
	                url: 'experienceDeleteAjax',
	                data: { contentId: contentId },
	                success: function(result) {
	                    // 성공적으로 삭제된 경우의 처리
	                    alert('삭제되었습니다.');
	                    location.reload();
	                },
	                error: function(xhr, status, error) {
	                    // 오류 발생 시의 처리
	                    alert('삭제에 실패했습니다.');
	                }
	            });
	        } else {
	            // 취소 버튼을 눌렀을 때의 처리
	            // 필요한 로직을 추가하세요.
	        }
	    }
		
		function confirmRestore(contentId) {
	        if (confirm('정말로 이 항목을 복원하시겠습니까?')) {
	            $.ajax({
	                type: 'POST', // 또는 'POST' 등의 HTTP 메서드 사용 가능
	                url: 'experienceRestoreAjax',
	                data: { contentId: contentId },
	                success: function(result) {
	                    // 성공적으로 복원된 경우의 처리
	                    alert('복원되었습니다.');
	                    location.reload();
	                },
	                error: function(xhr, status, error) {
	                    // 오류 발생 시의 처리
	                    alert('복원에 실패했습니다.');
	                }
	            });
	        } else {
	            // 취소 버튼을 눌렀을 때의 처리
	            // 필요한 로직을 추가하세요.
	        }
	    }
		
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
						<label  class="admin-header-title ">체험 정보 관리 </label>					
					</div>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="border p-3 m-3">
						<form action="experience1" method="get">
							<input type="text" name="keyword" placeholder="체험이름을 입력하세요">
							<button type="submit" class="btn btn-outline-secondary">체험이름검색</button>
							<button type="reset" name="deleted" class="btn btn-outline-secondary">초기화</button><p>
							<input type="hidden" name="big_code" value="15">
							<select name="is_deleted">
								<option value="2" ${is_deleted == 2 ? 'selected' : ''}>전체</option>
								<option value="0" ${is_deleted == 0 ? 'selected' : ''}>등록체험</option>
								<option value="1" ${is_deleted == 1 ? 'selected' : ''}>삭제체험</option>
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
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='experienceInsertForm'">등록</button>
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">테마</th>
								<th scope="col">체험명</th>
								<th scope="col">주소</th>
								<th scope="col">작성자</th>
								<th scope="col">신청일</th>
								<th scope="col">승인여부</th>
								<th scope="col">수정</th>
								<th scope="col">삭제/복원</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="experience" items="${listExperience}">
								<tr>
									<td>${num}</td>
									<td>
										<c:if test="${experience.small_code == 1}">자연</c:if>
										<c:if test="${experience.small_code == 2}">전통</c:if>
										<c:if test="${experience.small_code == 3}">산사</c:if>
										<c:if test="${experience.small_code == 4}">이색</c:if>
										<c:if test="${experience.small_code == 5}">레포츠</c:if>										
									</td>
									<td><a href="experienceDetail?contentId=${experience.id}&currentPage=${page.currentPage}">${experience.title}</a></td>
									<td>${experience.address}</td>
									<td>${experience.user_id}</td>
									<td><fmt:formatDate value="${experience.created_at}" type="date" pattern="YY/MM/dd"/></td> <!-- 신청일 컬럼?? -->
									<td>
										<c:if test="${experience.status == 0}">승인대기</c:if>
										<c:if test="${experience.status == 1}">승인완료</c:if>
										<!-- 승인반려됐을 경우 status -->
									</td>
									<td>
									<c:if test="${experience.status == 0}">
									</c:if>
									<c:if test="${experience.status == 1}">
									<button onclick="location.href='experienceUpdateForm?contentId=${experience.id}'" class="btn btn-outline-secondary">수정</button>
									</c:if>
									</td>
									<td>
									<c:if test="${experience.is_deleted == 1}">
									<button onclick="confirmRestore(${experience.id})" class="btn btn-outline-secondary">복원</button>
									</c:if>
									<c:if test="${experience.is_deleted == 0}">									
									<button onclick="confirmDelete(${experience.id})" class="btn btn-outline-secondary">삭제</button>
									</c:if>
									</td>
								</tr>
								<c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>					
					
					<nav aria-label="Page navigation example ">
						<ul class="pagination">
					
							<c:if test="${page.startPage > page.pageBlock}">
								<c:choose>
									<c:when test="${path ==0}">
										<li class="page-item">
											<a href="experience?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">이전</a>
										</li>
									</c:when>
									<c:when test="${path ==1}">
										<li class="page-item">
											<a href="experience1?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">이전</a>
										</li>
									</c:when>
								</c:choose>
								
								
							</c:if>
							<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
								<c:choose>
									<c:when test="${path ==0}">
										<li class="page-item">
											<a href="experience?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
										</li>
									</c:when>
									<c:when test="${path == 1}">
										<li class="page-item">
											<a href="experience1?currentPage=${i}&keyword=${keyword}&big_code=${big_code}&small_code=${small_code}&is_deleted=${is_deleted}&status=${status}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
										</li>
									</c:when>
								</c:choose>
							</c:forEach>
							
											
							<c:if test="${page.endPage < page.totalPage}">
								<c:choose>
									<c:when test="${path ==0}">
										<li class="page-item">
											<a href="experience?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">다음</a>
										</li>
									</c:when>
									<c:when test="${path ==1}">
										<li class="page-item">
											<a href="experience1?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">다음</a>
										</li>
									</c:when>
								</c:choose>
							</c:if>
						</ul>
					</nav>
				</div>		
			</main>
		</div>
		</div>
	</body>
</html>