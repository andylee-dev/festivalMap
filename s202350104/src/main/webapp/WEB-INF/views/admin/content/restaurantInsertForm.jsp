<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>맛집 정보 등록</title>
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
			<main class="col-10 overflow-auto p-0">
			
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-pencil-square "></i>
						<label  class="admin-header-title ">맛집 정보 등록 </label>					
					</div>
				</div>	
				
				<!-- Section2: Table -->		
				<div class="border p-3 m-3">
					<form action="restaurant/insert" method="post">
						<table class="table table-striped table-sm">
							<!-- <tr><th>콘텐츠ID</th><td><input 	type="number" 	name="contentId" 	required="required" maxlength="10" value="">
													<input 	type="button" 	value="중복확인" 	 	onclick="chk()"> -->
							<tr><th>분류</th>
								<td>
									<input type="hidden" name="big_code" value="12">[Restaurant]<br>
									<select name="small_code">
										<c:forEach var="listCodes" items="${listCodes}">
											<c:if test="${listCodes.big_code == 12 && listCodes.small_code != 999 }">
												<option value="${listCodes.small_code}">${listCodes.content}</option>
											</c:if>
										</c:forEach>
									</select>
								</td>
							<tr><th>음식점명</th><td><input 	type="text" 	name="title" 		required="required"></td></tr>
							<tr>
								<th>지역</th>
								<td>
									<select name="area" onchange="getSigungu(this.value)" required="required">
										<option value="">전체</option>
										<c:forEach var="areas" items="${listAreas}">
											<c:if test="${areas.sigungu == 999}">
												<option value="${areas.area}">${areas.content}</option>
											</c:if>
										</c:forEach>
									</select>
									<select name="sigungu" id="sigungu_list_select" required="required"><!-- ajax getSigungu --></select>
								</td>
							</tr>
							<tr><th>주소</th><td><input 		type="text"    	name="address" 		></td></tr>
							<tr><th>우편번호</th><td><input 	type="number" 	name="postcode" required="required"></td></tr>
							<tr><th>전화번호</th><td><input   type="tel"  		name="phone"        placeholder="010 - 0000 - 0000" pattern="\d{2,3}-\d{3,4}\d{4}"></td>       
							<tr><th>대표메뉴</th><td><input 	type="text" 	name="first_menu" 	></td></tr>
							<tr><th>추천메뉴</th><td><input 	type="text" 	name="menu" 		></td></tr>
							<tr><th>영업시간</th><td><input 	type="text" 	name="open_time" 	></td></tr>
							<tr><th>휴무일</th><td><input 	type="text" 	name="rest_date" 	></td></tr>
							<tr><th>내용</th><td><textarea   rows="10" cols="60" name="content" maxlength="6000" placeholder="맛집에 대한 설명을 1000자 이내로 입력해주세요"></textarea></tr>
							<tr><th>이미지</th><td></td></tr>
							<tr><th>태그</th><td></td></tr>
							<tr><th>가능여부</th>
								<td>
									<input type="checkbox" name="is_smoking" value="1">흡연<br>
									<input type="checkbox" name="is_packing" value="1">포장<br>
									<input type="checkbox" name="is_parking" value="1">주차<br>
								</td>
							</tr>
							<tr><th>등록자ID</th><td></td></tr>
							<tr><th>등록일</th><td></td></tr>
						</table>
						<div align="center">
							<button type="submit" class="btn btn-outline-secondary" onclick="return confirm('등록하시겠습니까?')">등록</button>
							<button type="reset" class="btn btn-outline-secondary"  onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까')">초기화</button>
						</div>	
					</form>	
				</div>
			</main>	
		</div>
		</div>	
	</body>
</html>