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
			var existingTags = []; // 선택한 옵션을 저장할 배열 선언 --> 초기에 DB에 저장되어 있던 태그 모두 저장
			/* var deletedTags = []; // 삭제할 옵션을 저장할 배열 선언 */
			var availableTags = []; // 선택할 수 있는 옵션을 저장할 배열 선언 --> existingTags에 있는 요소 제외하고 모두 저장
			const tagsArea = document.querySelector('#tagsArea');
			
			document.addEventListener("DOMContentLoaded", (event) => {
				
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
				<!-- 지역 코드 넣는 코드  End-->
			
				
				<!-- 태그 관련 코드 Start -->
				
				availableTags.push({id:'1',name:'봄'});
				availableTags.push({id:'2',name:'여름'});
				availableTags.push({id:'3',name:'가을'});
				availableTags.push({id:'4',name:'겨울'});
				
				updateTagOptions();
				// initialTagOptions(); 초기 태그 옵션(DB에 저장되지 않은 태그들만 옵션으로)
				$('#tagSelectBox').change(function() {
					alert("addTag() start...");
					alert("existingTags size => "+existingTags.length);
					alert("availableTags size => "+availableTags.length);
					
					var selectedTagId = $(this).val(); // 선택된 tag의 id를 가져옴
					var selectedTagName = $(this).find('option:selected').text(); // 선택된 tag의 name을 가져옴
					
					alert(selectedTagId);
					alert(selectedTagName);
					
					var selectedTag = {
						id: selectedTagId,
						name: selectedTagName 
					};
					
					// 이미 배열에 있는 태그인지 체크
					var isDuplicate = false;
					for(var i = 0; i < existingTags.length; i++) {
						if(existingTags[i].id === selectedTag.id) {
							isDuplicate = true;
							break;
						}
					}
					
					if(!isDuplicate) {
						existingTags.push(selectedTag); // 배열에 없었던 태그일 경우에만 추가
						const newTag = document.createElement('span');
						newTag.className = "badge bg-primary";
						newTag.textContent = selectedTag.name;
						newTag.id = selectedTag.id;
						
						const closeButton = document.createElement('button');
						closeButton.className = "btn-close";
						closeButton.setAttribute('aria-label', 'Close');
						
						newTag.appendChild(closeButton);
						tagsArea.appendChild(newTag);
						updateTagOptions(); // select box의 option을 업데이트하는 method
					}
					
				})
				
				$('.btn-close').addEventListener('click', (event) => {
					event.preventDefault();
					var deletedTag = {
						id: event.target.parentElement.id,
						name: event.target.parentElement.textContent
					}
					alert("deletedTag.id => "+deletedTag.id);
					alert("deletedTag.name => "+deletedTag.name);
					/* alert("deletedTags size => " + deletedTags.length); */
					alert("existingTags size => " + existingTags.length);
					availableTags.push(deletedTag); // option 목록에 삭제된 태그 다시 추가
					
					for(var i = 0; i < existingTags.length; i++) {
						if(existingTags[i].id === deletedTag.id) {
							index = i;
							break;
						}
					}
					
					if(index !== -1) {
						existingTags.splice(index, 1); // 선택한 태그 목록에서 삭제
						event.target.parentElement.remove(); // badge 삭제
					}
				});
			
			});
			
<%-- 			function initialTagOptions() { --> 1) existing 불러오기 / 2) 아래 메소드로 태그 옵션 저장하기
				$.ajax({
					url: "<%=request.getContextPath()%>/getContentTags",
					data: contentId,
					method: "GET",
					success: function(tags) {
						$("#tagSelectBox").empty().append("<option value='0'>태그를 선택해주세요.</option>");
						tags.forEach(function(tag) {
							$("#tagSelectBox").append("<option value='"+tag.id+"'>"+tag.name+"</option>");
						});
						console.log("initialTagOptions() success");
					},
					
					error: function() {
						console.log("태그 정보를 가져오지 못했습니다.");
					}
				}) 
			} --%>
			
			function updateTagOptions() {
				$("#tagSelectBox").empty().append("<option value='0'>태그를 선택해주세요.</option>");
				availableTags.forEach(function(tag) {
					$("#tagSelectBox").append("<option value='"+tag.id+"'>"+tag.name+"</option>");
				});
				console.log("updateTagOptions() success");
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
									<select id="tagSelectBox" name="tag_id" onchange="event.preventDefault();">
									</select>
									<div id="tagsArea"><!-- 태그 뱃지가 들어갈 곳 --></div>
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