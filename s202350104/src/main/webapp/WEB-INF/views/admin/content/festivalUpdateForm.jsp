<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>축제 정보 수정</title>
		
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="/js/updateArea.js"></script>
		<script type="text/javascript">
			var selectedTags = []; // 선택한 옵션을 저장할 배열 선언 --> 초기에 DB에 저장되어 있던 태그 모두 저장
			var tagOptions = []; // 선택할 수 있는 옵션을 저장할 배열 선언 --> existingTags에 있는 요소 제외하고 모두 저장
			
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
			<!-- 지역 코드 넣는 코드  End-->	
			
			<!-- 태그 관련 코드 Start -->
				const tagsArea = document.querySelector('#tagsArea');
				
				initialTagOptions(); // 모든 tags 가져오기
				initialSelectedTags(); // DB에 이미 저장되어 있던 tags만 selectedTags에 저장
				
				$('#tagSelectBox').change(function() {		
					var selectedTagId = $(this).val(); // 선택된 tag의 id를 가져옴
					var selectedTagName = $(this).find('option:selected').text(); // 선택된 tag의 name을 가져옴
					
					var selectedTag = {
						id: selectedTagId,
						name: selectedTagName 
					};
					
					// 이미 배열에 있는 태그인지 체크
					var isDuplicate = false;
					for(var i = 0; i < selectedTags.length; i++) {
						if(selectedTags[i].id == selectedTag.id) {
							isDuplicate = true;
						}
					}
					
					// 배열에 없었던 태그일 경우에만 추가
					if(!isDuplicate) {
						selectedTags.push(selectedTag); 
						
						for(var i = 0; i < tagOptions.length; i++) {
							if(tagOptions[i].id == selectedTag.id) {
								tagOptions.splice(i,1); // 선택한 태그를 select box option에서 삭제
								i--;
							}
						}	
						updateTagOptions(); // select box의 option을 업데이트하는 method
						newTagBadge(selectedTag);
					}
					
				});
			
			});
			
			function initialTagOptions() {
				$.ajax({
					url: "<%=request.getContextPath()%>/getAllTags",
					method: "GET",
					dataType: "json",
					success: function(tags) {
						tags.forEach(function(tag) {
							tagOptions.push({id:tag.id, name:tag.name});
						});
						console.log("getAllTags success");
					},
					error: function() {
						console.log("전체 태그 정보를 가져오지 못했습니다.");
					}
				})
			}; 
			
			function initialSelectedTags() {
				var contentId = Number($('#content_id').val());
				$.ajax({
					url: "<%=request.getContextPath()%>/getMyContentTags",
					method: "GET",
					data: {contentId: contentId},
					dataType: "json",
					success: function(tags) {
						if(tags != null) {
							tags.forEach(function(tag) {
								for(var i = 0; i < tagOptions.length; i++) {
									if(tagOptions[i].id == tag.id) {
										tagOptions.splice(i, 1);
										selectedTags.push(tag);
										newTagBadge(tag);
									}
								}
							});
						};
						
						updateTagOptions();
						console.log("getMyContentTags success");
					},
					error: function() {
						console.log("컨텐츠 태그 정보를 가져오지 못했습니다.");
					}
				})
			};
			
			function updateTagOptions() {
				$("#tagSelectBox").empty().append("<option value='0'>태그를 선택해주세요.</option>");
				tagOptions.forEach(function(tag) {
					$("#tagSelectBox").append("<option value='"+tag.id+"'>"+tag.name+"</option>");
				});
				console.log("updateTagOptions() success");
			};
			
			function newTagBadge(selectedTag) {
				// 태그 뱃지 생성 
				const newTag = document.createElement('span');
				newTag.className = "badge bg-primary";
				newTag.textContent = "#"+selectedTag.name;
				newTag.id = selectedTag.id;
					
				// x버튼 및 클릭시의 이벤트 생성
				const closeButton = document.createElement('button');
				closeButton.className = "btn-close";
				closeButton.setAttribute('aria-label', 'Close');
				closeButton.addEventListener('click', (event) => {
					event.preventDefault();
					var deletedTag = {
						id: event.target.parentElement.id,
						name: event.target.parentElement.textContent.substr(1) // #를 제외한 텍스트를 name으로
					}
					tagOptions.push(deletedTag); // select box의 option 목록에 삭제된 태그 다시 추가
						
					// 삭제할 옵션의 인덱스 찾기 -> selectedTags를 돌면서 deletedTag의 id와 같은 요소가 있으면 삭제하고 badge도 삭제
					for(var i = 0; i < selectedTags.length; i++) {
						if(selectedTags[i].id == deletedTag.id) {
							selectedTags.splice(i, 1);
							event.target.parentElement.remove();
							i--; // splice() 사용하면 바로 요소가 제거되고 배열의 길이가 변경되기 때문에 i--를 해준다
						}
					}
					updateTagOptions(); // 수정된 tagOptions로 update
				});	
				
				newTag.appendChild(closeButton);
				tagsArea.appendChild(newTag);
			};
			<!-- 태그 관련 코드 end -->
			
			function updateForm() {
				event.preventDefault();
			
				var updateFormData = $('#updateForm').serializeArray();
				var finalTags = [];
				for(var i = 0; i < selectedTags.length; i++) {
					finalTags.push(Number(selectedTags[i].id));
				}
				updateFormData.push({name: 'finalTags', value: finalTags});
				
				if(confirm("수정하시겠습니까?")) {
					$.ajax({
						url: "<%=request.getContextPath()%>/admin/content/festivalUpdate",
						method: "POST",
						data: updateFormData,
						dataType: "text",
						success: function(str) {
							alert(str);
							location.href="<%=request.getContextPath()%>/admin/content/festival";
						}
					})
				}
			};			

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
						<label  class="admin-header-title ">축제 정보 수정 </label>					
					</div>
				</div>
				
				<!-- Section2: Table -->		
				<div class="border p-3 m-3">
					<form action="festivalUpdate" method="post" id="updateForm">
						<%-- <input type="hidden" name="user_id" value="<%= loggedId %>"> --%>
						<input type="hidden" name="currentPage" value="${currentPage}">
						<input type="hidden" name="status" value="${festival.status}">
						<table class="table table-striped table-sm">
							<tr>
								<th>컨텐츠 ID</th>
								<td><input type="hidden" name="content_id" id="content_id" value="${festival.content_id}">${festival.content_id}</td>
							</tr>
							<tr>
								<th>분류</th>
								<td>
									<input type="hidden" name="big_code" value="11">[Festival] ${festival.scode_content}<br>
									<select id="small_code" name="small_code">
										<c:forEach var="code" items="${listCodes}">
											<c:if test="${code.big_code == 11 && code.small_code != 999}">
												<option value="${code.small_code}" ${code.small_code == festival.small_code? 'selected' : '' }>${code.content}</option>
											</c:if>
										</c:forEach>
									</select></td>
							</tr>
							<tr>
								<th>축제명</th>
								<td><input type="text" name="title" value="${festival.title}" required="required"></td>
							</tr>
							<tr>
								<th>시작일</th>
								<td><input type="date" name="start_date" value="${festival.start_date}"></td>
							</tr>
							<tr>
								<th>종료일</th>
								<td><input type="date" name="end_date" value="${festival.end_date}"></td>
							</tr>
							<tr>
								<th>진행시간</th>
								<td><input type="text" name="hours" value="${festival.hours}"></td>
							</tr>
							<tr>
								<th>주최자</th>
								<td><input type="text" name="sponsor" value="${festival.sponsor}"></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><input type="tel" name="phone" placeholder="010 - 0000 - 0000"
									pattern="\d{2,3}-\d{3,4}-\d{4}" value="${festival.phone}"></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type="email" name="email" value="${festival.email}"></td>
							</tr>
							<tr>
								<th>장소명</th>
								<td><input type="text" name="eventplace" value="${festival.eventplace}"></td>
							</tr>
							<tr>
								<th>지역</th>
								<td>${festival.area_content} ${festival.sigungu_content} <br>
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
									placeholder="축제에 대한 설명을 4000자 이내로 입력해주세요">${festival.content}</textarea></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea rows="10" cols="60" name="overview" maxlength="2000" 
									placeholder="축제 내용에 대한 설명을 2000자 이내로 입력해주세요  ">${festival.overview}</textarea></td>
							</tr>
							<tr>
								<th>이용요금</th>
								<td><input type="text" name="cost" value="${festival.cost}"></td>
							</tr>
							<tr>
								<th>홈페이지</th>
								<td><input type="text" name="homepage" value="${festival.homepage}"></td>
							</tr>
							<tr>
								<th>이미지</th>
								<td><!-- 이미지 추가/삭제할 수 있는 폼 만들기 img1 img2 img3 --></td>
							</tr>
							<tr>
								<th>태그</th>
								<td>
									<select id="tagSelectBox" name="tag_id" onchange="event.preventDefault();">
									</select>
									<div id="tagsArea"><!-- 태그 badge가 들어갈 곳 --></div>
								</td>
							</tr>
							<tr>
								<th>가능 여부</th>
								<td>
									<input type="checkbox" name="is_parking" value="1" ${festival.is_parking == 1? 'checked':''}>주차시설<br>
									<input type="checkbox" name="is_stroller" value="1" ${festival.is_stroller == 1? 'checked':''}>유모차대여<br>
									<input type="checkbox" name="is_wheelchair" value="1" ${festival.is_wheelchair == 1? 'checked':''}>휠체어대여<br>
									<input type="checkbox" name="is_restroom" value="1" ${festival.is_restroom == 1? 'checked':''}>장애인화장실
								</td>
							</tr>
							<tr>
								<th>등록자</th>
								<td>
									<input type="text" name="user_id" value="${festival.user_id}">
								</td>
							</tr>
						</table>
						<div align="center">
							<button type="button" class="btn btn-outline-secondary" onclick="updateForm()">수정</button>
							<button type="reset" class="btn btn-outline-secondary" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
						</div>
					</form>
				</div>		
			</main>
		</div>
		</div>
	</body>
</html>