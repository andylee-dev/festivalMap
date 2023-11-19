<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>컨텐츠 태그</title>
		<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="/js/updateArea.js"></script>
		<script type="text/javascript">
			document.addEventListener("DOMContentLoaded", function() {
			   // parameter로 가져온 bigCode값으로 변수 선언
			   const urlParams = new URL(location.href).searchParams;
			   const bigCodeStr = urlParams.get('bigCodeStr');
			   
			   // 
			   $.ajax({
						   method:"POST",
						   url:"<%=request.getContextPath()%>/admin/tag/getContentTags",
						   data:{bigCodeStr : bigCodeStr},
						   dataType:'json',
						   success:function(listTags) {
							   for(let i = 0; i < ${page.end - page.start + 1}; i++) {
								   var str = "";
								   for(let j = 0; j < listTags.length; j++) {
									   if(listTags[j].content_id == $("#content_id"+i).val()) {
										   str += "<span class='badge text-bg-primary'>"+listTags[j].name+"</span>";
										   str += " ";
									   }
								   }	   
								   $("#tag_name"+i).append(str);   
							   }
						   }
					   })
				
				<!-- 지역 코드 넣는 코드  Start-->	
				updateAreaOptions();
				$(".area-dropdown").change(function() {
					const selectedArea = $(this).val();
					if (selectedArea) {
						updateSigunguOptions(selectedArea);
					} else {
						$(".sigungu-dropdown").empty().append("<option value='0'>전체</option>");
					}
				});
				<!-- 지역 코드 넣는 코드  End-->
		   });
		   
		   function detail(pId) {
			  const urlParams = new URL(location.href).searchParams;
			  const bigCodeStr = urlParams.get('bigCodeStr');
			  var id = String(pId);
			   
			  switch(bigCodeStr) {
			  	case '11':
			  		location.href='../content/festivalDetail?contentIdStr='+id;
			  		break;
			  	case '12':
			  		location.href='../content/restaurantDetail?contentId='+id;
			  		break;
			  	case '13':
			  		location.href='../content/accomodationDetail?contentIdStr='+id;
			  		break;
			  	case '14':
			  		location.href='../content/spotDetail?contentIdStr='+id;
			  		break;
			  	case '15':
			  		location.href='../content/experienceDetail?contentId='+id;
			  		break;
			  	case '16':
			  		location.href='';
			  		break;	
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
						<i class="title-bi bi bi-grid-fill "></i>
					<label  class="admin-header-title ">컨텐츠태그</label>
					</div>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="container col-9 justify-content-center my-5">
					<form action="contentTag" method="GET" class="container justify-content-center">
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="col-form-label col-1  mx-2">검색어</label>
							<div class="col-2">
								<select name="search" class="form-select">
									<option value="tagname">태그명</option>
									<option value="title">이름</option>
									<option value="contentId">컨텐츠 번호</option>
								</select>
							</div>
							<div class="col-5 mx-2">
					        	<input type="text" name="keyword" class="form-control" value="${keyword}"
					             placeholder="검색어를 입력하세요.">
				            </div>
							<div class="col-4 mx-1 d-flex justify-content-center">					
								<button type="submit" class="btn btn-primary  col-3 mx-1">검색</button>
								<button type="reset" class="btn btn-outline-secondary col-3 mx-1">초기화</button>
							</div>
						</div>
					</form>				
				</div>		
				
				<!-- Section3: Table -->		
				<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
					<div class="container d-flex justify-content-start p-0">
						<button type="button" class="btn btn-primary col-1 mx-1" onclick="location.href='contentTag?bigCodeStr=11'">축제</button>
						<button type="button" class="btn btn-primary col-1 mx-1" onclick="location.href='contentTag?bigCodeStr=12'">맛집</button>
						<button type="button" class="btn btn-primary col-1 mx-1" onclick="location.href='contentTag?bigCodeStr=13'">숙박</button>
						<button type="button" class="btn btn-primary col-1 mx-1" onclick="location.href='contentTag?bigCodeStr=14'">명소</button>
						<button type="button" class="btn btn-primary col-1 mx-1" onclick="location.href='contentTag?bigCodeStr=15'">체험</button>
						<button type="button" class="btn btn-primary col-1 mx-1" onclick="location.href='contentTag?bigCodeStr=16'">코스</button>
					</div>
					<div class="container table-container mt-1 p-4">
					<div class="table-responsive">
						<table id="userTable" class="table table-md text-center p-3">
							<thead>
								<tr>
									<th scope="col">순번</th>
									<th scope="col">컨텐츠 번호</th>
									<th scope="col">분류</th>
									<th scope="col">이름</th>
									<th scope="col">지역</th>
									<th scope="col">태그명</th>
									<th scope="col"></th>
								</tr>
							</thead>
							<tbody>
								<c:set var="num" value="${page.start}"/>
								<c:forEach var="content" items="${listContent}" varStatus="st">
									<tr>
										<td>${num}</td>
										<td><input type="hidden" id="content_id${st.index}" value="${content.id}">${content.id}</td>
										<td id="small_code_input${st.index}">
											<input type="hidden" id="small_code${st.index}" value="${content.small_code}">
											${content.small_code}
										</td>
										<td><span onclick="detail(${content.id})">${content.title}</span></td>
										<td id="areas_input${st.index}">
											<input type="hidden" id="area${st.index}" value="${content.area}">
											<input type="hidden" id="sigungu${st.index}" value="${content.sigungu}">
											${content.area} ${content.sigungu}
										</td>
										<td id="tag_name${st.index}"></td>
										<td><a href="contentTagsUpdateForm?contentIdStr=${content.id}" class="detail-link">관리</a></td>
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
								<a href="contentTag?currentPage=${page.startPage-page.pageBlock}&bigCodeStr=${bigCode}" class="pageblock page-link">Prev</a>
							</li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<a href="contentTag?currentPage=${i}&bigCodeStr=${bigCode}" class="pageblock page-link ${page.currentPage == i ? 'active':''}">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item">
								<a href="contentTag?currentPage=${page.startPage+page.pageBlock}&bigCodeStr=${bigCode}" class="pageblock page-link">Next</a>
							</li>
						</c:if>
					</ul>
				</nav>
					
			</main>
		</div>
		</div>
	</body>
</html>