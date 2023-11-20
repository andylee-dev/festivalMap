<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<!-- 지역 코드 넣는 코드  Start-->	
	<script src="/js/updateArea.js"></script>
	<script type="text/javascript">
		document.addEventListener("DOMContentLoaded", function() {
			updateAreaOptions();
			$(".area-dropdown").change(function() {
				const selectedArea = $(this).val();
				if (selectedArea) {
					updateSigunguOptions(selectedArea);
				} else {
					$(".sigungu-dropdown").empty().append("<option value='0'>전체</option>");
				}
			});
		});
	</script>
	<!-- 지역 코드 넣는 코드  End-->	

	<style type="text/css">
	    .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
	        background-color: #F8FCF4 !important; /* 원하는 배경색으로 변경 */
	        color: #00000 !important; /* 원하는 텍스트 색상으로 변경 */
	    }
	    .tab-pane.fade.show.active {
	        background-color: #F8FCF4; /* 원하는 배경색으로 변경 */
	    }
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<main >
	<div class="d-flex">
		<%@ include file="/WEB-INF/components/BizPageSideBar.jsp" %>
		<div id="exTab3" class="container p-5">	
			<nav>
			  <div class="nav nav-tabs " id="nav-tab" role="tablist">
			    <button class="nav-link active" id="nav-festival-tab" data-bs-toggle="tab" data-bs-target="#nav-festival" type="button" role="tab" aria-controls="nav-festival" aria-selected="true">축제</button>
			    <button class="nav-link" id="nav-restaurant-tab" data-bs-toggle="tab" data-bs-target="#nav-restaurant" type="button" role="tab" aria-controls="nav-restaurant" aria-selected="false">맛집</button>
			    <button class="nav-link" id="nav-accomodation-tab" data-bs-toggle="tab" data-bs-target="#nav-accomodation" type="button" role="tab" aria-controls="nav-accomodation" aria-selected="false">숙박</button>
			    <button class="nav-link" id="nav-experience-tab" data-bs-toggle="tab" data-bs-target="#nav-experience" type="button" role="tab" aria-controls="nav-experience" aria-selected="false">체험</button>
			    <button class="nav-link" id="nav-spot-tab" data-bs-toggle="tab" data-bs-target="#nav-spot" type="button" role="tab" aria-controls="nav-spot" aria-selected="false">명소</button>
			  </div>
			</nav>
			<div class="tab-content" id="nav-tabContent">
			  
			  
			  <div class="tab-pane fade show active" id="nav-festival" role="tabpanel" aria-labelledby="nav-festival-tab" tabindex="0">
			  	<div class="border p-3 m-3">
					<form action="<%=request.getContextPath()%>/admin/content/festivalInsert" method="post">
						<%-- <input type="hidden" name="user_id" value="<%= loggedId %>"> --%>
						<table class="table table-striped table-sm">
							<%-- <tr>
								<th>컨텐츠 ID</th>
								<td>${festival.content_id}</td>
							</tr> 등록할 때 컨텐츠 번호를 확인할 수 있으면 좋을 것 같다(nextval, 입력할 때는 currval) --%>
							<tr>
								<th>분류</th>
								<td>
									<input type="hidden" name="big_code" value="11">[Festival]<br>
									<select name="small_code">
										<c:forEach var="code" items="${listCodes}">
											<c:if test="${code.big_code == 11 && code.small_code != 999}">
												<option value="${code.small_code}">${code.content}</option>
											</c:if>
										</c:forEach>
									</select></td> <!-- select box -->
							</tr>
							<tr>
								<th>축제명</th>
								<td><input type="text" name="title" required="required"></td>
							</tr>
							<tr>
								<th>시작일</th>
								<td><input type="date" name="start_date"></td>
							</tr>
							<tr>
								<th>종료일</th>
								<td><input type="date" name="end_date"></td>
							</tr>
							<tr>
								<th>진행시간</th>
								<td><input type="text" name="hours"></td>
							</tr>
							<tr>
								<th>주최자</th>
								<td><input type="text" name="sponsor"></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><input type="tel" name="phone" placeholder="010 - 0000 - 0000"
									pattern="\d{2,3}-\d{3,4}-\d{4}"></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type="email" name="email"></td>
							</tr>
							<tr>
								<th>장소명</th>
								<td><input type="text" name="eventplace"></td>
							</tr>
							<tr>
								<th>지역</th>
								<td>
									<select name="area" class="area-dropdown"></select>
									<select name="sigungu"  class="sigungu-dropdown"></select>
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td><%-- postcode & address --%></td>
							</tr>
							<tr>
								<th>개요</th>
								<td><textarea rows="10" cols="60" name="content" maxlength="4000" 
									placeholder="축제에 대한 설명을 4000자 이내로 입력해주세요"></textarea></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea rows="10" cols="60" name="overview" maxlength="2000" 
									placeholder="축제 내용에 대한 설명을 2000자 이내로 입력해주세요  "></textarea></td>
							</tr>
							<tr>
								<th>이용요금</th>
								<td><input type="text" name="cost"></td>
							</tr>
							<tr>
								<th>홈페이지</th>
								<td><input type="text" name="homepage"></td>
							</tr>
							<tr>
								<th>이미지</th>
								<td><!-- 이미지 업로드 폼 만들기 img1 img2 img3 --></td>
							</tr>
							<tr>
								<th>태그</th>
								<td>
									 <div class="container">
										<div class="row mb-3 g-3">
						      			  <div class="col-md-4">
						         			 <select class="form-select" id="validationTagsClear" name="tagsClear[]" multiple data-allow-clear="true">
						            			<option selected disabled hidden value="">태그를 선택해주세요.</option>
									            <c:forEach var="tag" items="${listTags}">
									            	<option value="${tag.id}" data-badge-style="info">${tag.name}</option>
									            </c:forEach>
									          </select>
									          <div class="invalid-feedback">유효한 태그를 선택해주세요.</div>
									        </div>
									      </div>
						  			</div>
								</td>
							</tr>
							<tr>
								<th>가능 여부</th>
								<td>
									<input type="checkbox" name="is_parking" value="1">주차시설<br>
									<input type="checkbox" name="is_stroller" value="1">유모차대여<br>
									<input type="checkbox" name="is_wheelchair" value="1">휠체어대여<br>
									<input type="checkbox" name="is_restroom" value="1">장애인화장실
								</td>
							</tr>
						</table>
						<div align="center">
							<button type="submit" class="btn btn-outline-secondary" onclick="return confirm('등록하시겠습니까?')">등록</button>
							<button type="reset" class="btn btn-outline-secondary" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
						</div>
					</form>
				</div>
				
			   </div>
			 
			 
			 
			  <div class="tab-pane fade" id="nav-restaurant" role="tabpanel" aria-labelledby="nav-restaurant-tab" tabindex="0">
			  	<div class="border p-3 m-3">
					<form action="<%=request.getContextPath()%>/admin/content/restaurant/insert" method="post">
						<table class="table table-striped table-sm">
							<!-- <tr><th>콘텐츠ID</th><td><input 	type="number" 	name="contentId" 	required="required" maxlength="10" value="">
													<input 	type="button" 	value="중복확인" 	 	onclick="chk()"> -->
							<tr><th>분류</th>
								<td>
									<input type="hidden" name="small_code" value="12">[Restaurant]<br>
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
									<select name="area" class="area-dropdown"></select>
									<select name="sigungu"  class="sigungu-dropdown"></select>
			  					</td>
							</tr>
							<tr><th>주소</th><td><input 		type="text"    	name="address" 		></td></tr>
							<tr><th>우편번호</th><td><input 	type="number" 	name="postcode" 	></td></tr>
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
			   </div>
			 
			 
			  <div class="tab-pane fade" id="nav-accomodation" role="tabpanel" aria-labelledby="nav-accomodation-tab" tabindex="0">
				<div class="border p-3 m-3">
					<form action="<%=request.getContextPath()%>/admin/content/accomodationInsert" method="post">
						<%-- <input type="hidden" name="user_id" value="<%= loggedId %>"> --%>
						<table class="table table-striped table-sm">
							<%--<tr>
								<th>컨텐츠 ID</th>
								<td>${festival.content_id}</td>
							</tr> 등록할 때 컨텐츠 번호를 확인할 수 있으면 좋을 것 같다(nextval, 입력할 때는 currval) --%>
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
								<td><input type="text" name="title" required="required"></td>
							</tr>
							<tr>
								<th>지역</th>
								<td>
									<select name="area" class="area-dropdown"></select>
									<select name="sigungu"  class="sigungu-dropdown"></select>
			  					</td>
							</tr>
							<tr>
								<th>주소</th>
								<td><input type="text" name="address"></td>
							</tr>
							<tr>
								<th>우편번호</th>
								<td><input type="text" name="postcode"></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><input type="tel" name="phone" placeholder="010 - 0000 - 0000"
									pattern="\d{2,3}-\d{3,4}-\d{4}"></td>
							</tr>
							<tr>
								<th>홈페이지</th>
								<td><input type="text" name="homepage"></td>
							</tr>
							<tr>
								<th>객실수</th>
								<td><input type="text" name="room_count"></td>
							</tr>
							<tr>
								<th>예약처</th>
								<td><input type="text" name="reservation_url"></td>
							</tr>
							<tr>
								<th>환불규정</th>
								<td><textarea rows="10" cols="60" name="refund" maxlength="2000" 
									placeholder="환불규정에 대한 설명을 2000자 이내로 입력해주세요"></textarea></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea rows="10" cols="60" name="content" maxlength="2000" 
									placeholder="축제 내용에 대한 설명을 2000자 이내로 입력해주세요  "></textarea></td>
							</tr>
							<tr>
								<th>입실시간</th>
								<td><input type="time" name="chcek_in"></td>
							</tr>
							<tr>
								<th>퇴실시간</th>
								<td><input type="time" name="chcek_out"></td>
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
						<div id="clickLatlng"></div>
						<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3d40db7fe264068aa3438b9a0b8b2274"></script>
						<script>
  						
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
  						mapOption = { 
       					center: new kakao.maps.LatLng(37.56682, 126.97865), // 지도의 중심좌표
        				level: 3 // 지도의 확대 레벨
  						 };

					    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

						// 지도를 클릭한 위치에 표출할 마커입니다
						var marker = new kakao.maps.Marker({ 
   						 // 지도 중심좌표에 마커를 생성합니다 
   						position: map.getCenter() 
						}); 
						// 지도에 마커를 표시합니다
						marker.setMap(map);

						// 지도에 클릭 이벤트를 등록합니다
						// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
						kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
						    
						    // 클릭한 위도, 경도 정보를 가져옵니다 
						     var latlng = mouseEvent.latLng; 
      						 var clickedLat = latlng.getLat();
        					 var clickedLng = latlng.getLng();
						    
						    // 마커 위치를 클릭한 위치로 옮깁니다
						    marker.setPosition(latlng);
						    
						    console.log('클릭한 위치의 위도: ' + clickedLat);
					        console.log('클릭한 위치의 경도: ' + clickedLng);

					     // 클릭한 위치의 위도와 경도를 각 input 태그에 설정합니다
					        document.getElementById("mapx_input").value = clickedLng;
					        document.getElementById("mapy_input").value = clickedLat;
					    });

					    // 폼을 서버에 제출하는 코드
					    document.getElementById("accomodationForm").addEventListener("submit", function(e) {
					        e.preventDefault(); // 폼 제출 기본 동작을 막습니다.

					        var form = e.target;
					        var formData = new FormData(form);
					        var xhr = new XMLHttpRequest();
					        xhr.open("POST", form.action, true);
					        xhr.onreadystatechange = function() {
					            if (xhr.readyState === 4 && xhr.status === 200) {
					                console.log("데이터가 성공적으로 업데이트되었습니다.");
					            }
					        };
					        xhr.send(formData);
					    });
					        
					</script>
						<div align="center">
							<button type="submit" class="btn btn-outline-secondary" onclick="return confirm('등록하시겠습니까?')">등록</button>
							<button type="reset" class="btn btn-outline-secondary" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
						</div>
					</form>
				</div>
				
				
				
				
			  	<
			  </div>
			  
			  
			  <div class="tab-pane fade" id="nav-experience" role="tabpanel" aria-labelledby="nav-experience-tab" tabindex="0">
			  	<div class="border p-3 m-3">
					<form action="<%=request.getContextPath()%>/admin/content/experienceInsert" method="post">
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
									<select name="area" class="area-dropdown"></select>
									<select name="sigungu"  class="sigungu-dropdown"></select>
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
				</div>
					
			  
			  
			  
			  <div class="tab-pane fade" id="nav-spot" role="tabpanel" aria-labelledby="nav-spot-tab" tabindex="0">
			  	<div class="border p-3 m-3">
					<form action="<%=request.getContextPath()%>/admin/content/spotInsertResult" method="post">
						<%-- <input type="hidden" name="user_id" value="<%= loggedId %>"> --%>
						<table class="table table-striped table-sm">
	<%-- 						<tr>
								<th>컨텐츠 ID</th>
								<td>${festival.content_id}</td>
							</tr> 등록할 때 컨텐츠 번호를 확인할 수 있으면 좋을 것 같다(nextval, 입력할 때는 currval) --%>
							<tr>
								<th>분류</th>
								<td>
									<input type="hidden" name="big_code" value="14">[spot]<br>
									<select name="small_code">
										<c:forEach var="code" items="${listCodes}">
											<c:if test="${code.big_code == 14 && code.small_code != 999}">
												<option value="${code.small_code}">${code.content}</option>
											</c:if>
										</c:forEach>
									</select></td> <!-- select box -->
							</tr>
							<tr>
								<th>명소명</th>
								<td><input type="text" name="title" required="required"></td>
							</tr>
							<tr>
								<th>영업시간</th>
								<td><input type="text" name="opening_hours"></td>
							</tr>
							<tr>
								<th>휴무일</th>
								<td><input type="text" name="rest_date"></td>
							</tr>
							<tr>
								<th>입장료</th>
								<td><input type="text" name="entrance_fee"></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><input type="tel" name="phone" placeholder="010 - 0000 - 0000"
									pattern="\d{2,3}-\d{3,4}-\d{4}"></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type="email" name="email"></td>
							</tr>
							<tr>
								<th>지역</th>
								<td>
									<select name="area" class="area-dropdown"></select>
									<select name="sigungu"  class="sigungu-dropdown"></select>
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td><input type="text" name="postcode" placeholder="우편번호"><input type="text" name="address"></td> 
							</tr>
							<tr>
								<th>개요</th>
								<td><textarea rows="10" cols="60" name="content" maxlength="4000" 
									placeholder="명소에 대한 설명을 4000자 이내로 입력해주세요"></textarea></td>
							</tr>
							<tr>
								<th>홈페이지</th>
								<td><input type="text" name="homepage"></td>
							</tr>
							<tr>
								<th>이미지</th>
								<td><!-- 이미지 업로드 폼 만들기 img1 img2 img3 --></td>
							</tr>
							<tr>
								<th>태그</th>
								<td><!-- 태그 선택란 만들기 --></td>
							</tr>
							<tr>
								<th>가능 여부</th>
								<td>
									<input type="checkbox" name="is_parking"    value="1">주차시설<br>
									<input type="checkbox" name="is_stroller"   value="1">유모차대여<br>
									<input type="checkbox" name="is_wheelchair" value="1">휠체어대여<br>
									<input type="checkbox" name="is_pet"        value="1">반려동물동반<br>
									<input type="checkbox" name="is_restroom"   value="1">장애인화장실
								</td>
							</tr>
						</table>
						<div align="center">
							<button type="submit" class="btn btn-outline-secondary" onclick="return confirm('등록하시겠습니까?')">등록</button>
							<button type="reset" class="btn btn-outline-secondary" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
						</div>
					</form>
				</div>	
			  </div>
			  
			  
			  
			  
			</div>
		</div>
	</div>
	</main>
</body>
</html>