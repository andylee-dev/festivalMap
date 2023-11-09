<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>체험ㅁ정보 등록</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function getSigungu(pArea){
				$.ajax(
						{
							url:"<%=request.getContextPath()%>/getSigungu/"+pArea,
							data:pArea,
							dataType:'json',
							success:function(areas) {
								$('#sigungu_list_select option').remove();
								str = "<option value=''>전체</option>";
								$(areas).each(
									function() {
										if(this.sigungu != 999 && this.content != null) {
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
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">체험 정보 등록</h1>
				</div>
				
				<!-- Section2: Table -->		
				<div class="border p-3 m-3">
					<form action="experienceInsert" method="post">
					
						<table class="table table-striped table-sm">
							<tr>
								<th>분류</th>
								<td>
									<input type="hidden" name="big_code" value="15">체험종류<br>
									<select name="small_code">
										<c:forEach var="code" items="${listCodes}">
											<c:if test="${code.big_code == 15 && code.small_code != 999}">
												<option value="${code.small_code}">${code.content}</option>
											</c:if>
										</c:forEach>
									</select></td>
							</tr>
							<tr>
								<th>체험명</th>
								<td><input type="text" name="title" required="required"></td>
							</tr>
							<tr>
								<th>개요</th>
								<td><textarea rows="10" cols="60" name="content" maxlength="4000" 
									placeholder="체험에 대한 설명을 4000자 이내로 입력해주세요"></textarea></td>
							</tr>
							<tr>
								<th>주소</th>
								<td><input type="text" name="address"></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type="email" name="email"></td>
							</tr>
							<tr>
								<th>홈페이지</th>
								<td><input type="text" name="homepage"></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><input type="tel" name="phone" placeholder="010 - 0000 - 0000~0"></td>
							</tr>
							<tr>
								<th>수용인원</th>
								<td><input type="text" name="capacity"></td>
							</tr>
							<tr>
								<th>지역</th>
								<td>
									<select name="area" onchange="getSigungu(this.value)">
										<option value="">전체</option>
										<c:forEach var="areas" items="${listAreas}">
											<c:if test="${areas.sigungu == 999}">
												<option value="${areas.area}">${areas.content}</option>
											</c:if>
										</c:forEach>
									</select>
									<select name="sigungu" id="sigungu_list_select"></select>
								</td>
							</tr>
							<tr>
								<th>체험연령</th>
								<td><input type="text" name="age"></td>
							</tr>
							<tr>
								<th>체험안내</th>
								<td><textarea rows="10" cols="60" name="inform" maxlength="4000" 
									placeholder="체험에 대한 설명을 4000자 이내로 입력해주세요"></textarea></td>
							</tr>
							<tr>
								<th>개장시간</th>
								<td><input type="text" name="open_time"></td>
							</tr>
							<tr>
								<th>휴무일</th>
								<td><input type="text" name="rest_time"></td>
							</tr>
							<tr>
								<th>이용요금</th>
								<td><input type="text" name="cost"></td>
							</tr>
							<tr>
								<th>이미지</th>
								<td></td>
							</tr>
							<tr>
								<th>태그</th>
								<td></td>
							</tr>
							<tr>
								<th>가능 여부</th>
								<td>
									<input type="checkbox" name="is_credit"   	value="1">카드여부<br>
									<input type="checkbox" name="is_pet"   		value="1">반려동물여부<br>
									<input type="checkbox" name="is_parking"    value="1">주차여부<br>
									<input type="checkbox" name="is_stroller"   value="1">유모차여부
								</td>
							</tr>
						</table>
						<div align="center">
							<button type="submit" class="btn btn-outline-secondary" onclick="return confirm('등록하시겠습니까?')">등록</button>
							<button type="reset" class="btn btn-outline-secondary" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
						</div>
					</form>
				</div>		
			</main>
		</div>
		</div>
	</body>
</html>