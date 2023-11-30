<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
<style type="text/css">
h1 {
	color: black;
	font-size: 32px;
	font-family: Noto Sans;
	font-weight: 600;
	word-wrap: break-word
}

h2 {
	color: #FF4379;
	font-size: 24px;
	font-family: Noto Sans;
	font-weight: 800;
	word-wrap: break-word
}

</style>
</head>
<body>
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<main>
	<div class="d-flex">
			<div class="col-2">
				<%@ include file="/WEB-INF/components/BizPageSideBar.jsp"%>
			</div>
			<div class="container p-5 col-10">
				<div class="container my-5">
			
				<h1 >등록된 컨텐츠 목록</h1>		
				<hr class="hr" />
				<div class="container justify-content-center align-items-center mb-2 mt-5 p-3 pt-0">
					<div class="container d-flex justify-content-end p-0">
						<button id="regist-btn" type="button"  class="btn btn-primary btn-sm mb-4"onclick="window.location.href='/user/bizPage/addContent'">등록</button>
					</div>
					<div class="container table-container p-4">
						<div class="table-responsive">
							<table id="userTable" class="table table-md text-center p-3">
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">제목</th>
										<th scope="col">유형</th>
<!-- 										<th scope="col">도/시</th>
										<th scope="col">시/군/구</th>
 -->										<th scope="col">상태</th>
										<th scope="col">조회수</th>
										<th scope="col">생성일</th>
										<th scope="col">관리</th>
									</tr>
								</thead>
								<tbody>
									<c:set var="num" value="${page.start}"/>
									<c:forEach var="contents" items="${contentsList}" varStatus="st">
										<tr id="user${st.index}">
										
											<td id="contentId">${contents.id}</td>
											<td>${contents.title}</td>
											<td>
											
												${contents.big_code==11?"축제":
												(contents.big_code==12?"맛집":
												(contents.big_code==13?"숙박":
												(contents.big_code==14?"명소":
												(contents.big_code==15?"체험":"N"))))
												}
											
											
											</td>
<%-- 											<td>${contents.area}</td>
											<td>${contents.sigungu}</td>
 --%>											<td>${contents.status==1?"승인":"미승인"}</td>
											<td>${contents.readcount}</td>
											<td><fmt:formatDate value="${contents.created_at}" type="date" pattern="YY/MM/dd"/></td>
											<td><a class="detail-btn" href="/user/bizPage/contentDetail/${contents.id}?currentPage=${page.currentPage}&big_code=${contents.big_code}">관리</a></td>
										</tr>
										<c:set var="num" value="${num + 1}"/>
									</c:forEach>
								</tbody>
							</table>
							</div>
						</div>
					</div>
<%-- 					<nav aria-label="Page navigation example ">
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
					</nav> --%>
			</div>
		</div>
	</div>
	</main>
</body>
</html>