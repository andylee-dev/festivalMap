<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>축제 정보 등록</title>
		
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
 		
 		
		<script src="/js/updateArea.js"></script>
		<script type="text/javascript">
			document.addEventListener("DOMContentLoaded", function() {
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
			});
			<!-- 지역 코드 넣는 코드  End-->
			    const badgeSelect = document.querySelector('#badgeSelect');
			    const addBadgeBtn = document.querySelector('#addBadgeBtn');
			    const badgesArea = document.querySelector('#badgesArea');
			
			    // Initialize the list of available badges
			    const availableBadges = Array.from(badgeSelect.options).map(option => option.value).filter(value => value !== '');
			
			    addBadgeBtn.addEventListener('click', () => {
			      if (badgeSelect.value !== '') {
			        // Create a new badge and add it to the page
			        const newBadge = document.createElement('span');
			        newBadge.className = 'badge bg-primary';
			        newBadge.textContent = badgeSelect.value;
			
			        const closeButton = document.createElement('button');
			        closeButton.className = 'btn-close';
			        closeButton.setAttribute('aria-label', 'Close');
			        closeButton.addEventListener('click', (event) => {
			          // When the badge is deleted, add its value back to the select box
			          const deletedBadgeValue = event.target.parentElement.textContent.trim();
			          availableBadges.push(deletedBadgeValue);
			          updateSelectOptions();
			          event.target.parentElement.remove();
			        });
			
			        newBadge.appendChild(closeButton);
			        badgesArea.appendChild(newBadge);
			
			        // Remove the added badge's value from the select box
			        availableBadges.splice(availableBadges.indexOf(badgeSelect.value), 1);
			        updateSelectOptions();
			        badgeSelect.value = '';
			      }
			    });
			
			    function updateSelectOptions() {
			      badgeSelect.innerHTML = '<option value="">Select a badge</option>';
			      availableBadges.forEach(badge => {
			        const option = document.createElement('option');
			        option.value = badge;
			        option.textContent = badge;
			        badgeSelect.appendChild(option);
			      });				
			    }
			});
		</script>
	</head>
	
	<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">축제 정보 등록</h1>
				</div>
				
				<!-- Section2: Table -->		
				<div class="border p-3 m-3">
					<form action="festival/insert" method="post">
						<%-- <input type="hidden" name="user_id" value="<%= loggedId %>"> --%>
						<table class="table table-striped table-sm">
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
									</select></td>
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
									<div class="container">
										<select name="area" class="area-dropdown"></select>
										<select name="sigungu"  class="sigungu-dropdown"></select>
								  	</div>
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
									  <select id="badgeSelect" name="tag_id">
									    <option value="">태그를 선택해주세요.</option>
									    <c:forEach var="tag" items="${listTags}">
									    	<option value="${tag.id}">${tag.name}</option>
									    </c:forEach>
									    <!-- Add more options as needed -->
									  </select>
									  <button id="addBadgeBtn">Add Badge</button>
									  <div id="badgesArea">
									    <!-- New badges will be added here -->
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
			</main>
		</div>
		</div>
	</body>
</html>