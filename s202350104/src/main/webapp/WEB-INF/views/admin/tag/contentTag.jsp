<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>컨텐츠 태그</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="/js/updateArea.js"></script>
		<script type="text/javascript">
			document.addEventListener("DOMContentLoaded", function() {
			   const urlParams = new URL(location.href).searchParams;
			   const bigCodeStr = urlParams.get('bigCodeStr');
			   
			   $.ajax(
					   {
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
					   }
				)
				
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
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">컨텐츠 태그 관리</h1>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="border p-3 m-3">
					<form action="contentTag">
						<!-- 지역 검색 -->
						<select name="area" class="area-dropdown"></select>
						<select name="sigungu"  class="sigungu-dropdown"></select><p>
						
						검색어<select name="search">
							<option value="tagname">태그명</option>
							<option value="title">이름</option>
							<option value="contentId">컨텐츠 번호</option>
						</select>
						<input type="text" name="keyword" placeholder="검색어를 입력해주세요.">
						
						<button type="submit" class="btn btn-outline-secondary">검색</button>
						<button type="reset" class="btn btn-outline-secondary">초기화</button>
					</form>				
				</div>		
				
				<!-- Section3: Table -->		
				<div class="border p-3 m-3">
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='contentTag?bigCodeStr=11'">축제</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='contentTag?bigCodeStr=12'">맛집</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='contentTag?bigCodeStr=13'">숙박</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='contentTag?bigCodeStr=14'">명소</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='contentTag?bigCodeStr=15'">체험</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='contentTag?bigCodeStr=16'">코스</button>
					
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">컨텐츠 번호</th>
								<th scope="col">분류</th>
								<th scope="col">이름</th>
								<th scope="col">지역</th>
								<th scope="col">태그명</th>
								<th scope="col">수정</th>
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
									<td><input type="button" value="수정" onclick="location.href='contentTagsUpdateForm?contentIdStr=${content.id}'"></td>
								</tr>
								<c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>
					<p>총 건수 : ${totalContents}</p>
					
					<div align="center">
						<c:if test="${page.startPage > page.pageBlock}">
							<a href="contentTag?currentPage=${page.startPage-page.pageBlock}&bigCodeStr=${bigCode}" class="pageblock">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<a href="contentTag?currentPage=${i}&bigCodeStr=${bigCode}" class="pageblock">[${i}]</a>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<a href="contentTag?currentPage=${page.startPage+page.pageBlock}&bigCodeStr=${bigCode}" class="pageblock">[다음]</a>
						</c:if>
					</div>
				</div>		
			</main>
		</div>
		</div>
		
	</body>
</html>