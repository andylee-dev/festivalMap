<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
		   $(document).ready(function() {
			   const urlParams = new URL(location.href).searchParams;
			   const smallCodeStr = urlParams.get('smallCodeStr');
			   
			   $.ajax(
					   {
						   method:"POST",
						   url:"<%=request.getContextPath()%>/admin/tag/getBoardTags",
						   data:{smallCodeStr : smallCodeStr},
						   dataType:'json',
						   success:function(listTags) {
							   
							   for(let i = 0; i < ${page.end - page.start + 1}; i++) {
								   var str = "";
								   for(let j = 0; j < listTags.length; j++) {
									   if(listTags[j].board_id == $("#board_id"+i).val()) {
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
					<h1 class="border">게시글 태그 관리</h1>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="border p-3 m-3">
					<h1 class="border">검색폼</h1>
					<button type="button" class="btn btn-outline-secondary">검색</button>
					<button type="button" class="btn btn-outline-secondary">초기화</button>
				</div>		
				
				<!-- Section3: Table -->		
				<div class="border p-3 m-3">
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='boardTag?smallCodeStr=2'">매거진</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='boardTag?smallCodeStr=3'">자유게시판</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='boardTag?smallCodeStr=4'">포토게시판</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='boardTag?smallCodeStr=5'">이벤트게시판</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='boardTag?smallCodeStr=6'">리뷰</button>
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">게시글 번호</th>
								<th scope="col">제목</th>
								<th scope="col">태그명</th>
								<th scope="col">수정</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="board" items="${listBoard}" varStatus="st">
								<tr>
									<td>${num}</td>
									<td><input type="hidden" id="board_id${st.index}" value="${board.id}">
										${board.id}</td><!-- 나중에 상세정보 페이지로 연결할 수 있도록 -->
									<td>${board.title}</td>
									<td id="tag_name${st.index}"></td>
									<td><input type="button" value="수정" onclick="location.href='boardTagsUpdate?boardId=${board.id}'"></td>
								</tr>
								<c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>
					<p>총 건수 : ${totalBoard}</p>
					<div align="center">
						<c:if test="${page.startPage > page.pageBlock}">
							<a href="boardTag?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<a href="boardTag?currentPage=${i}" class="pageblock">[${i}]</a>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<a href="boardTag?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
						</c:if>
					</div>
				</div>		
			</main>
		</div>
		</div>
		
	
	</body>
</html>