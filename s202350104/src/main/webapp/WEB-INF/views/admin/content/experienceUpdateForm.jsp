<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>experience updateForm</title>
		
	</head>
	<body>
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">지역정보 - 체험수정</h1>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="border p-3 m-3">
						
									
									
				</div>		
				
				<!-- Section3: Table -->		
				<form action="experienceUpdate" method="post">
							<input type="hidden" name="id" value="${experience.id }">
							<input type="hidden" name="status" value="${emp.job }">
							<input type="hidden" name="is_deleted"value="${emp.job }">
							<table>
							<tr><th>등록ID</th><td>${emp.ename }></td></tr>
							<tr><th>체험이름</th><td>
								<input type="text" name="title" required="required" value="${emp.ename }"></td></tr>
							<tr><th>개요</th><td>
								<input type="text" name="content" required="required" value="${emp.ename }"></td></tr>							
							<tr><th>주소</th><td>
								<input type="text" name="address" required="required" value="${emp.job }"></td></tr>							
							<tr><th>이메일</th><td>
								<input type="text" name="email" required="required" value="${emp.job }"></td></tr>								
							<tr><th>전화번호</th><td>
								<input type="text" name="phone" required="required" value="${emp.job }"></td></tr>
							<tr><th>홈페이지</th><td>
								<input type="text" name="homepage" required="required" value="${emp.job }"></td></tr>
							<tr><th>조회수</th><td>${emp.readcount }></td></tr>
							<tr><th>작성자</th><td>${emp.user_id }</td></tr>
							<tr><th>작성일</th><td>${emp.created_at }</td></tr>			
							<tr><th>수정일</th><td>${emp.updated_at }</td></tr>
							<tr><th>수용인원</th><td>
								<input type="text" name="capacity" value="${emp.job }"></td></tr>
							<tr><th>연령</th><td>
								<input type="text" name="age" value="${emp.job }"></td></tr>
							<tr><th>이용시간</th><td>
								<input type="text" name="open_time" value="${emp.job }"></td></tr>
							<tr><th>휴일</th><td>
								<input type="text" name="rest_time" value="${emp.job }"></td></tr>
							<tr><th>비용</th><td>
								<input type="text" name="cost" value="${emp.job }"></td></tr>
							<tr><th>카드</th><td>
								<input type="text" name="is_credit" value="${emp.job }"></td></tr>
							<tr><th>애완</th><td>
								<input type="text" name="is_pet" value="${emp.job }"></td></tr>							
							<tr><th>파킹</th><td>
								<input type="text" name="is_parking" value="${emp.job }"></td></tr>
							<tr><th>유모차</th><td>
								<input type="text" name="is_stroller" value="${emp.job }"></td></tr>
							<tr><td colspan="2"	>
								<input type="submit" value="확인">	
								</td>	
							</tr>	
							</table>
						</form>
					</main>
				</div>		
			
		</div>
		
	</body>
</html>