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
			<main class="col-md-10 ms-sm-auto col-lg-20 px-md-20">
			
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
							<input type="hidden" name="status" value="${experience.status }">
							<input type="hidden" name="is_deleted"value="${experience.is_deleted }">
							<table class="table table-responsive" >
							<tr><th>등록ID</th><td>${experience.id }</td></tr>
							<tr><th>체험이름</th><td>
								<input type="text" name="title" value="${experience.title }"></td></tr>
							<tr><th>개요</th><td><textarea rows="10" cols="60" name="content" maxlength="4000" placeholder="체험에 대한 설명을 4000자 이내로 입력해 주세요">
							${experience.content }</textarea></td>
							<tr><th>주소</th><td>
								<input type="text" name="address" value="${experience.address }"></td></tr>							
							<tr><th>이메일</th><td>
								<input type="text" name="email" value="${experience.email }"></td></tr>								
							<tr><th>전화번호</th><td>
								<input type="tel" name="phone" placeholder="010 - 0000 - 0000"
								pattern="\d{2,3}-\d{3,4}-\d{4}" value="${experience.phone}"></td></tr>
							<tr><th>홈페이지</th><td>
								<input type="text" name="homepage" value="${experience.homepage }"></td></tr>
							<tr><th>조회수</th><td>${experience.readcount }</td></tr>
							<tr><th>작성자</th><td>${experience.user_id }</td></tr>
							<tr><th>작성일</th><td>${experience.created_at }</td></tr>			
							<tr><th>수정일</th><td>${experience.updated_at }</td></tr>
							<tr><th>수용인원</th><td>
								<input type="text" name="capacity" value="${experience.capacity }"></td></tr>
							<tr><th>연령</th><td>
								<input type="text" name="age" value="${experience.age }"></td></tr>
							<tr><th>체험내용</th><td><textarea rows="10" cols="60" name="content" maxlength="2000" 
													placeholder="체험에 대한 내용을 2000자 이내로 입력해 주세요">
													${experience.inform }</textarea></td>
							<tr><th>이용시간</th><td>
								<input type="text" name="open_time" value="${experience.open_time }"></td></tr>
							<tr><th>휴일</th><td>
								<input type="text" name="rest_time" value="${experience.rest_time }"></td></tr>
							<tr><th>비용</th><td>
								<input type="text" name="cost" value="${experience.cost }"></td></tr>
							<tr>
								<th>가능 여부</th>
								<td>
									<input type="checkbox" name="is_parking" value="1">주차시설<br>
									<input type="checkbox" name="is_stroller" value="1">유모차대여<br>
									<input type="checkbox" name="is_wheelchair" value="1">휠체어대여<br>
									<input type="checkbox" name="is_restroom" value="1">장애인화장실
								</td>
							</tr>
							<tr><td colspan="2"	>
								<input type="submit" value="확인">
								</td>
								<td colspan="2"	>
								<input type="reset" value="취소">
								</td>		
							</tr>	
							</table>
						</form>
					</main>
				</div>		
			
		</div>
		
	</body>
</html>