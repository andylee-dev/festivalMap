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
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function getSigungu(pArea){
				var pSigungu = ${experience.sigungu}
				$.ajax(
						{
							url:"<%=request.getContextPath()%>/getSigungu/"+pArea,
							dataType:'json',
							success:function(areas) {
								$('#sigungu_select option').remove();
								str = "<option value='999'>전체</option>";
								$(areas).each(
									function() {
										if(this.sigungu != 999 && this.content != null) {
											strOption = "<option value='"+this.sigungu+"' ${"+this.sigungu+" == "+pSigungu+"? 'selected':''}>"+this.content+"</option>";
											str += strOption;
										}
									}		
								)
								$('#sigungu_select').append(str);
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
			<main class="col-md-10 ms-sm-auto col-lg-20 px-md-20">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">지역정보 - 체험수정</h1>
				</div>
			
				<!-- Section3: Table -->		
				<form action="experienceUpdate" method="post">
							<table class="table table-striped table-sm">
							<tr><th>등록ID</th><td>
								<input type="hidden" name="id" value="${experience.id }">${experience.id }</td></tr>
							<tr><th>체험종류</th><td>
							<select id="small_code" name="small_code">
										<c:forEach var="smallCode" items="${listSmallCode}">
											<c:if test="${smallCode.small_code != 999}">
												<option value="${smallCode.small_code}" ${smallCode.small_code == experience.small_code? 'selected' : '' }>${smallCode.content}</option>
											</c:if>
										</c:forEach>
									</select></td>	
							<tr><th>체험이름</th><td>
								<input type="text" name="title" value="${experience.title }"></td></tr>
							<tr><th>개요</th><td><textarea rows="10" cols="60" name="content" maxlength="4000" placeholder="체험에 대한 설명을 4000자 이내로 입력해 주세요">
												${experience.content}</textarea></td></tr>
							<tr><th>체험지역</th><td>
								<select id="area" name="area" onchange="getSigungu(this.value)">
										<option value="">전체</option>
										<c:forEach var="areas" items="${listAreas}">
											<c:if test="${areas.sigungu == 999}">
												<option value="${areas.area}" ${areas.area == experience.area? 'selected':''}>${areas.content}</option>
											</c:if>
										</c:forEach>
									</select>
									<select id="sigungu_select" name="sigungu" >
										<option value="999">전체</option>
										<c:forEach var="areas" items="${listSigungu}">
											<c:if test="${areas.sigungu != 999 && areas.sigungu != null}">
												<option value="${areas.sigungu}" ${areas.sigungu == experience.sigungu? 'selected':''}>${areas.content}</option>
											</c:if>
										</c:forEach>
									</select>					
							<tr><th>등록상태</th><td>
								<input type="hidden" name="status" value="${experience.status }">${experience.status }</td></tr>
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
							<tr><th>삭제여부</th><td>
								<input type="hidden" name="is_deleted" value="${experience.is_deleted }">${experience.is_deleted }</td></tr>
							<tr><th>수용인원</th><td>
								<input type="text" name="capacity" value="${experience.capacity }"></td></tr>
							<tr><th>연령</th><td>
								<input type="text" name="age" value="${experience.age }"></td></tr>
							<tr><th>체험내용</th><td><textarea rows="10" cols="60" name="inform" maxlength="2000" 
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
									<input type="checkbox" name="is_credit" value="1" ${experience.is_credit == 1? 'checked':''}>카드결제여부<br>
									<input type="checkbox" name="is_pet" value="1" ${experience.is_pet == 1? 'checked':''}>반려동물출입여부<br>
									<input type="checkbox" name="is_parking" value="1" ${experience.is_parking == 1? 'checked':''}>주차여부<br>
									<input type="checkbox" name="is_stroller" value="1" ${experience.is_stroller == 1? 'checked':''}>유모차여부
								</td>
							</tr>
							<tr><td>
								<button type="submit" class="btn btn-outline-secondary" onclick="return confirm('수정하시겠습니까?')">수정</button>
								<button type="reset" class="btn btn-outline-secondary" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
								</td>		
							</tr>	
							</table>
						</form>
					</main>
				</div>		
			
		</div>
		
	</body>
</html>