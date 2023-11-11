<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 태그</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
		   $(document).ready(function() {			   
			   $.ajax(
					   {
						   method:"POST",
						   url:"<%=request.getContextPath()%>/admin/tag/getUserTags",
						   dataType:'json',
						   success:function(listTags) {
							   
							   for(let i = 0; i < ${page.end - page.start + 1}; i++) {
								   var str = "";
								   for(let j = 0; j < listTags.length; j++) {
									   if(listTags[j].user_id == $("#user_id"+i).val()) {
										   str += "<span class='badge text-bg-primary'>"+listTags[j].name+"</span>";
										   str += " ";
									   }
								   }	   
								   $("#tag_name"+i).append(str);   
							   }
						   }
					   }
				)
		   })
		</script>
	</head>
	<body>
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">회원 태그 관리</h1>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="border p-3 m-3">
					<form action="userTag">
						검색어<select name="searchType">
							<option value="tagname">태그명</option>
							<option value="email">회원ID</option>
						</select>
						<input type="text" name="keyword" placeholder="검색어를 입력하세요.">
											
						<button type="submit" class="btn btn-outline-secondary">검색</button>
						<button type="reset" class="btn btn-outline-secondary">초기화</button>
					</form>
				</div>		
				
				<!-- Section3: Table -->		
				<div class="border p-3 m-3">
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">회원ID</th>
								<th scope="col">이름</th>
								<th scope="col">닉네임</th>
								<th scope="col">생년월일</th>
								<th scope="col">성별</th>
								<th scope="col">주소</th>
								<th scope="col">태그명</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="user" items="${listUsers}" varStatus="st">
								<tr>
									<td>${num}</td>
									<td><input type="hidden" id="user_id${st.index}" value="${user.id}">${user.email}</td>
									<td>${user.name}</td>
									<td>${user.nickname}</td>
									<td>${user.birthday}</td>
									<td>
										<c:if test="${user.gender == 0}">남</c:if>
										<c:if test="${user.gender == 1}">여</c:if>
									</td>
									<td>${user.address}</td>
									<td id="tag_name${st.index}"></td>
								</tr>
								<c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>
					<p>총 건수 : ${totalUsers}</p>
					
					<div align="center">
						<c:if test="${page.startPage > page.pageBlock}">
							<a href="userTag?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<a href="userTag?currentPage=${i}" class="pageblock">[${i}]</a>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<a href="userTag?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
						</c:if>
					</div>
					
				</div>		
			</main>
		</div>
		</div>
	</body>
</html>