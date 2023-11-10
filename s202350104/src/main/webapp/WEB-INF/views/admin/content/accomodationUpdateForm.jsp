<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>숙박 정보 수정</title>
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
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			<div style="overflow-y: auto; max-height: 80vh;">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">숙박 정보 수정</h1>
				</div>
				
				<!-- Section2: Table -->		
				<div class="border p-3 m-3">
					<form action="accomodation/update" method="post">
						<%-- <input type="hidden" name="user_id" value="<%= loggedId %>"> --%>
						<input type="hidden" name="currentPage" value="${currentPage}">
						<input type="hidden" name="status" value="${accomodation.status}">
						<table class="table table-striped table-sm">
	 						<tr>
								<th>컨텐츠 ID</th>
								<td><input type="hidden" name="content_id" value="${accomodation.content_id}">${accomodation.content_id}</td>
							</tr>
							<tr>
								<th>분류</th>
								<td>
									<input type="hidden" name="big_code" value="13">[Accomodation]<br>
									<select name="small_code">
										<c:forEach var="code" items="${listCodes}">
											<c:if test="${code.big_code == 13 && code.small_code != 999}">
												<option value="${code.small_code}">${code.content}</option>
											</c:if>
										</c:forEach>
									</select></td> <!-- select box -->
							</tr>
							<tr>
								<th>숙소명</th>
								<td><input type="text" name="title" required="required" value="${accomodation.title}"></td>
							</tr>
							<tr>
								<th>지역</th>
								<td>
									<select name="area" onchange="getSigungu(this.value)">
										<option value="">전체</option>
										<c:forEach var="areas" items="${listAreas}">
											<c:if test="${areas.sigungu == 999}">
												<option value="${areas.area}" ${areas.area eq accomodation.area ? 'selected' : ''}>${areas.content}</option>
											</c:if>
										</c:forEach>
									</select>
									<select name="sigungu" id="sigungu_list_select">
									<option value="${accomodation.sigungu}" selected>${accomodation.sigungu}</option>
									</select>
									
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td><input type="text" name="address" value="${accomodation.address}"></td>
							</tr>
							<tr>
								<th>우편번호</th>
								<td><input type="text" name="postcode" value="${accomodation.postcode}"></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><input type="tel" name="phone" placeholder="010 - 0000 - 0000"
									pattern="\d{2,3}-\d{3,4}-\d{4}" value="${accomodation.phone}"></td>
							</tr>
							<tr>
								<th>홈페이지</th>
								<td><input type="text" name="homepage" value="${accomodation.homepage}"></td>
							</tr>
							<tr>
								<th>객실수</th>
								<td><input type="text" name="room_count" value="${accomodation.room_count}"></td>
							</tr>
							<tr>
								<th>예약처</th>
								<td><input type="text" name="reservation_url" value="${accomodation.reservation_url}"></td>
							</tr>
							<tr>
								<th>환불규정</th>
								<td><textarea rows="10" cols="60" name="refund" maxlength="2000" 
									placeholder="환불규정에 대한 설명을 2000자 이내로 입력해주세요">${accomodation.refund}</textarea></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea rows="10" cols="60" name="content" maxlength="2000" 
									placeholder="숙소 내용에 대한 설명을 2000자 이내로 입력해주세요  ">${accomodation.content}</textarea></td>
							</tr>
							<tr>
								<th>입실시간</th>
								<td><input type="time" name="chcek_in" value="${accomodation.check_in}"></td>
							</tr>
							<tr>
								<th>퇴실시간</th>
								<td><input type="time" name="chcek_out" value="${accomodation.check_out}"></td>
							</tr>
							<tr>
								<th>이미지</th>
								<td><!-- 이미지 업로드 폼 만들기 img1 img2 img3 --></td>
							</tr>
							<tr>
							<th>지도</th>
							<td><div id="map" style="width:500px;height:400px; margin: 0 auto;"></div>
							<input type="hidden" name="mapx" id="mapx_input">
  							<input type="hidden" name="mapy" id="mapy_input">
							</td>
							</tr>
							<tr>
								<th>가능 여부</th>
								<td>
									<input type="checkbox" name="is_pickup" value="1">픽업<br>
									<input type="checkbox" name="is_cook" value="1">조리<br>
									<input type="checkbox" name="is_parking" value="1">주차									
								</td>
							</tr>
						</table>
						
						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3d40db7fe264068aa3438b9a0b8b2274&libraries=services"></script>
						<script>
						
						var accomodation_mapx = ${accomodation.mapx};
  						var accomodation_mapy = ${accomodation.mapy};
  						
						window.onload = function() {
						    var mapContainer = document.getElementById('map'), 
						        mapOption = {
						            center: new kakao.maps.LatLng(accomodation_mapy, accomodation_mapx), 
						            level: 3 
						        };

						    var map = new kakao.maps.Map(mapContainer, mapOption); 
						    var geocoder = new kakao.maps.services.Geocoder();
						    var marker = new kakao.maps.Marker({
			        			  position: new kakao.maps.LatLng(accomodation_mapy, accomodation_mapx),
			        			  map: map
			    													});  // 마커 생성
						    var infowindow = new kakao.maps.InfoWindow();  // 인포윈도우 생성
						    
						    

						    document.getElementById('address').onchange = function() {  // onkeyup 대신 onchange 사용
						        var address = this.value;

						        geocoder.addressSearch(address, function(result, status) {
						            if (status === kakao.maps.services.Status.OK) {
						                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
						                
						        						                
						                marker.setPosition(coords);  // 마커 위치 업데이트
						                infowindow.setContent('<div style="width:150px;text-align:center;padding:6px 0;">우리숙소</div>');  // 인포윈도우 내용 업데이트
						                infowindow.open(map, marker);
						                map.setCenter(coords);

						                document.getElementById("mapx_input").value = result[0].x;
						                document.getElementById("mapy_input").value = result[0].y;
						            } else {  // 주소 검색 실패 시 처리
						                alert('주소 검색 결과가 없습니다.');
						            }
						        });
						    };
						};
					        
					</script>
					
						<div align="center">
							<button type="submit" class="btn btn-outline-secondary" onclick="return confirm('등록하시겠습니까?')">등록</button>
							<button type="reset" class="btn btn-outline-secondary" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
						</div>
					</form>
				</div>
				</div>		
			</main>
		</div>
		</div>
	</body>
</html>