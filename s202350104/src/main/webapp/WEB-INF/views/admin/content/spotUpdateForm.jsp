<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>명소 정보 수정</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function getSigungu(pArea){
				var pSigungu = ${spot.sigungu}
				$.ajax(
						{
							url:"<%=request.getContextPath()%>/getSigungu/"+pArea,
							dataType:'json',
							success:function(areas) {
								$('#sigungu_list_select option').remove();
								str = "<option value='999'>전체</option>";
								$(areas).each(
									function() {
										if(this.sigungu != 999 && this.content != null) {
											strOption = "<option value='"+this.sigungu+"' ${"+this.sigungu+" == "+pSigungu+"? 'selected':''}>"+this.content+"</option>";
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
					<h1 class="border">명소 정보 수정</h1>
				</div>
				
				<!-- Section2: Table -->		
				<div class="border p-3 m-3">
					<form action="spot/update?currentPage=${currentPage}" method="post">
						<%-- <input type="hidden" name="user_id" value="<%= loggedId %>"> --%>
						<input type="hidden" name="status" value="${spot.status}">
						<table class="table table-striped table-sm">
							<tr>
								<th>컨텐츠 ID</th>
								<td><input type="hidden" name="content_id" value="${spot.content_id}">${spot.content_id}</td>
							</tr>
							<tr>
								<th>분류</th>
								<td>
									<input type="hidden" name="big_code" value="11">[Spot] ${spot.scode_content}<br>
									<select id="small_code" name="small_code">
										<c:forEach var="code" items="${listCodes}">
											<c:if test="${code.big_code == 11 && code.small_code != 999}">
												<option value="${code.small_code}" ${code.small_code == spot.small_code? 'selected' : '' }>${code.content}</option>
											</c:if>
										</c:forEach>
									</select></td>
							</tr>
							<tr>
								<th>명소명</th>
								<td><input type="text" name="title" value="${spot.title}" required="required"></td>
							</tr>
							<tr>
								<th>영업시간</th>
								<td><input type="date" name="start_date" value="${spot.opening_hours}"></td>
							</tr>
							<tr>
								<th>휴무일</th>
								<td><input type="date" name="end_date" value="${spot.rest_date}"></td>
							</tr>
							<tr>
								<th>입장료</th>
								<td><input type="text" name="hours" value="${spot.entrance_fee}"></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><input type="tel" name="phone" placeholder="010 - 0000 - 0000"
									pattern="\d{2,3}-\d{3,4}-\d{4}" value="${spot.phone}"></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type="email" name="email" value="${spot.email}"></td>
							</tr>
							<tr>
								<th>지역</th>
								<td>${spot.area_content} ${spot.sigungu_content} <br>
									<select id="area" name="area" onchange="getSigungu(this.value)">
										<option value="">전체</option>
										<c:forEach var="areas" items="${listAreas}">
											<c:if test="${areas.sigungu == 999}">
												<option value="${areas.area}" ${areas.area == spot.area? 'selected':''}>${areas.content}</option>
											</c:if>
										</c:forEach>
									</select>
									<select name="sigungu" id="sigungu_list_select">
										<option value="999">전체</option>
										<c:forEach var="areas" items="${listSigungu}">
											<c:if test="${areas.sigungu != 999 && areas.sigungu != null}">
												<option value="${areas.sigungu}" ${areas.sigungu == spot.sigungu? 'selected':''}>${areas.content}</option>
											</c:if>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td><%-- postcode & address --%></td>
							</tr>
							<tr>
								<th>개요</th>
								<td><textarea rows="10" cols="60" name="content" maxlength="4000" 
									placeholder="축제에 대한 설명을 4000자 이내로 입력해주세요">${spot.content}</textarea></td>
							</tr>
							<tr>
								<th>홈페이지</th>
								<td><input type="text" name="homepage" value="${spot.homepage}"></td>
							</tr>
							<tr>
								<th>이미지</th>
								<td><!-- 이미지 추가/삭제할 수 있는 폼 만들기 img1 img2 img3 --></td>
							</tr>
							<tr>
								<th>태그</th>
								<td><!-- 태그 선택란 만들기 --></td>
							</tr>
							<tr>
								<th>가능 여부</th>
								<td>
									<input type="checkbox" name="is_parking" 	value="1" ${spot.is_parking == 1? 'checked':''}>주차시설<br>
									<input type="checkbox" name="is_stroller" 	value="1" ${spot.is_stroller == 1? 'checked':''}>유모차대여<br>
									<input type="checkbox" name="is_wheelchair" value="1" ${spot.is_wheelchair == 1? 'checked':''}>휠체어대여<br>
									<input type="checkbox" name="is_pet" 		value="1" ${spot.is_pet== 1? 'checked':''}>반려동물동반<br>
									<input type="checkbox" name="is_restroom" 	value="1" ${spot.is_restroom == 1? 'checked':''}>장애인화장실
								</td>
							</tr>
							<tr>
								<th>등록자</th>
								<td>
									<input type="text" name="user_id" value="${spot.user_id}">
								</td>
							</tr>
						</table>
						<div align="center">
							<button type="submit" class="btn btn-outline-secondary" onclick="return confirm('수정하시겠습니까?')">수정</button>
							<button type="reset" class="btn btn-outline-secondary" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
						</div>
					</form>
				</div>		
			</main>
		</div>
		</div>
	</body>
</html>