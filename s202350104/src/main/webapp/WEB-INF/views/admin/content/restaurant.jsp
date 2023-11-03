<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Restaurant content</title>
		<style type="text/css">
			.pageblock{
				text-align: center;
			}
			.card-text {
				overflow: 			hidden;
				text-overflow: 		ellipsis; /* 말줄임표 */
				diplay: 		    -webkit-box; /* 박스 안 텍스트가 10줄 넘어가면 말줄임표 */
				-webkit-line-clamp: 10;
				-webkit-box-orient: vertical;
			}
		</style>
		<script type="text/javascript" src="js/jquery.js"></script>
		<script type="text/javascript">
		
			function getSigungu(pArea){
				$.ajax(
						{
							url:"restaurant/getSigungu",
							dataType: 'json',
							success:function(areas) {
								$('#sigungu_list_select option').remove();
								str = "<option value=''>전체</option>";
								$(areas).each(
									function() {
										if(pArea == this.area && this.sigungu != 999 && this.content != null) {
											strOption = "<option value='"+this.sigungu+"'> "+this.content+"</option>";
											str += strOption;
										}
									}
								)
								$('#sigungu_list_select').append(str);
							}
						}
				  )	
				
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
					<h1 class="border">지역정보 - 식당</h1>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="border p-3 m-3">
					<h1 class="border">검색폼</h1>
					<select name="area" onchange="getSigungu(this.value)">
						<option value="">전체</option>
						<c:forEach var="areas" items="${listAreas}">
							<c:if test="${areas.sigungu == 999}">
								<option value="${areas.area}">${areas.content}</option>
							</c:if>
						</c:forEach>
					</select>	
					<select name="sigungu" id="sigungu_list_select">
					<%-- 	<c:forEach var="areas" items="${listAreas}">
							<c:if test="${areas.sigungu != 999}">
								<option value="${areas.sigungu}">${areas.content}</option>
							</c:if>
							</c:forEach> --%>
					 </select>
					  <!-- 빈칸으로 나오는 부분 없애기 / 시도를 선택했을 때 그에 해당하는 시군구가 나올 수 있도록 하기 -->					
					 <button type="button" class="btn btn-outline-secondary">검색</button>
					 <button type="button" class="btn btn-outline-secondary">초기화</button>
				</div>		
				
				<!-- Section3: Table -->		
				<div class="border p-3 m-3">
					<button type="button" class="btn btn-outline-secondary ">등록</button>
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">지역</th>
								<th scope="col">음식점명</th>
								<th scope="col">메뉴</th>
								<th scope="col">신청일</th>
								<th scope="col">승인여부</th>
								<th scope="col">수정</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="restaurant" items="${listRestaurant}">
								<tr>
									<td>${num}</td>
									<td>${restaurant.area_content} ${restaurant.sigungu_content}</td>
									<td>${restaurant.title}</td>
						 			<td>${restaurant.menu}</td>
						 			<td><fmt:formatDate value="${restaurant.created_at}" type="date" pattern="YY/MM/dd"/></td>
						 			<td>
						 				<c:if test="${restaurant.status == 0 }">승인대기</c:if>
										<c:if test="${restaurant.status == 1 }">승인완료</c:if>
									</td>
									<td><input type="button" value="수정"></td>
									<td><input type="button" value="삭제"></td>					
								 </tr>
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
			<a href="restaurant?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
		</c:if>
		<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
			<a href="restaurant?currentPage=${i}" class="pageblock">[${i}]</a>
		</c:forEach>
		<c:if test="${page.endPage < page.totalPage}">
			<a href="restaurant?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
		</c:if>
		</div>
		
	</body>
</html>