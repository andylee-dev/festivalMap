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
		let selectedTags = []; // 선택한 옵션을 저장할 배열 선언 --> 초기에 DB에 저장되어 있던 태그 모두 저장
		let allTags = [];      // 전체 태그 정보를 모두 가져와 저장
		let myTagsArea;
		
		document.addEventListener("DOMContentLoaded", function() {
			<!-- 지역 코드 넣는 코드  Start -->	
			updateAreaOptions();
			$(".area-dropdown").change(function() {
				const selectedArea = $(this).val();
				if (selectedArea) {
					updateSigunguOptions(selectedArea);
				} else {
					$(".sigungu-dropdown").empty().append("<option value='0'>전체</option>");
				}
			});
			<!-- 지역 코드 넣는 코드  End -->
			
			<!-- 태그 코드 Start -->
			myTagsArea = document.querySelector('.my-tags'); // 저장한 태그 버튼을 보여줄 박스
			allTagOptions();
		});
		
		function allTagOptions() {
			$.ajax({
				url: "<%=request.getContextPath()%>/getAllTags",
				method: "GET",
				dataType: "json",
				success: function(tags) {
					tags.forEach(function(tag) {
						allTags.push({id:tag.id, name:tag.name});
					});
					console.log("getAllTags success");
				},
				error: function() {
					console.log("전체 태그 정보를 가져오지 못했습니다.");
				}
			})
		}; 
		
		function newTagBadge(selectedTag) {
			// 태그 버튼 생성 
			const newTag = document.createElement('button');
			newTag.className = "btn btn-outline-secondary align-items-center";
			newTag.value = selectedTag.name;
			newTag.innerHTML = "#" +selectedTag.name;
			newTag.id = selectedTag.id;
			console.log(newTag);
				
			// x버튼 및 클릭시의 이벤트 생성
			const closeButton = document.createElement('span');
			closeButton.innerHTML        = "&times";
			closeButton.className        = "close-icon";
			closeButton.style.marginLeft = "5px";
			closeButton.style.cursor     = "pointer";
			closeButton.addEventListener('click', (event) => {
				event.preventDefault();
				var deletedTag = {
					id: event.target.parentElement.id,
					name: event.target.parentElement.value.substr(1) // #를 제외한 텍스트를 name으로
				}
					
				// 삭제할 옵션의 인덱스 찾기 -> selectedTags를 돌면서 deletedTag의 id와 같은 요소가 있으면 삭제하고 badge도 삭제
				for(var i = 0; i < selectedTags.length; i++) {
					if(selectedTags[i].id == deletedTag.id) {
						selectedTags.splice(i, 1);
						event.target.parentElement.remove();
						i--; // splice() 사용하면 바로 요소가 제거되고 배열의 길이가 변경되기 때문에 i--를 해준다
					}
				}
			});	
			
			newTag.appendChild(closeButton);
			myTagsArea.appendChild(newTag);
		}
		
		function addTag() {
			var newTagId;
			var newTagName = $('.searchForm').val(); // 선택된 tag의 name을 가져옴
			
			// keyword 입력했을 때만 태그 버튼 추가
			if(newTagName != '' && newTagName != null) {
				// 선택된 tag의 id를 가져옴
				for(var i = 0; i < allTags.length; i++) {
					if(allTags[i].name == newTagName) {
						newTagId = allTags[i].id;
					}
				}

				var selectedTag = {
					id: newTagId,
					name: newTagName
				};
				
				// 이미 배열에 있는 태그인지 체크
				var isDuplicate = false;
				for(var i = 0; i < selectedTags.length; i++) {
					if(selectedTags[i].id == selectedTag.id) {
						isDuplicate = true;
						alert("이미 추가한 태그입니다.");
					}
				}
				
				// 배열에 없었던 태그일 경우에만 추가
				if(!isDuplicate) {
					selectedTags.push(selectedTag); 
					newTagBadge(selectedTag);
				}
				
				$('.searchForm').value = "";
			}
		}
		<!-- 태그 코드 End -->
			
			function updateForm() {
				event.preventDefault();
			
				var formData = new FormData($('#updateForm')[0]);
				
				var finalTags = [];
				for(var i = 0; i < selectedTags.length; i++) {
					finalTags.push(Number(selectedTags[i].id));
				}
				formData.append('finalTags', finalTags);
				
				if(confirm("수정하시겠습니까?")) {
					$.ajax({
						url: "<%=request.getContextPath()%>/admin/content/festivalUpdate",
						method: "POST",
						data: formData,
						contentType: false,
				        processData: false,
						dataType: "text",
						success: function(str) {
							alert(str);
							location.href="<%=request.getContextPath()%>/admin/content/festival";
						}
					})
				}
			};	
			

		</script>
		<style type="text/css">
		
		#detail-top-container {
			position: absolute;
			width: 250px;
			height: 83px;
			border-radius: 10px;
			border: 1px solid #000;
			flex-shrink: 0;
			top: -35px; /* B의 상단에 A를 위치시키기 위해 top을 0으로 설정 */
			margin: auto; /* 수평 및 수직 가운데 정렬을 위해 margin을 auto로 설정 */
			z-index: -1; /* A를 B 뒤로 보내기 위해 z-index를 -1로 설정 */
			background-color: black;
		}
		
		#detail-top-text {
			color: white;
			font-family: Noto Sans;
			font-size: 16px;
			font-style: normal;
			font-weight: 600;
			line-height: normal;
			letter-spacing: -0.48px;
			padding-top: 5px;
		}
		
		#detail-top-id{
			color: #FF4379;
			font-family: Noto Sans;
			font-size: 16px;
			font-style: normal;
			font-weight: 600;
			line-height: normal;
			letter-spacing: -0.48px;
			padding-top: 5px;
			word-wrap: break-word;
		}	
		
		#detail-top-id2{
			color: #BDEB50;
			font-family: Noto Sans;
			font-size: 16px;
			font-style: normal;
			font-weight: 600;
			line-height: normal;
			letter-spacing: -0.48px;
			padding-top: 5px;
			word-wrap: break-word;
		}	
		
		#detail-main-container {
			position: relative;
			border: 1px solid #000;
			border-radius: 10px;
			background-color: white;
		}
		.detail-body-container {
			justify-content: center;
			padding-right: 0;
			padding-left: 0;
			margin-right: 0;
			margin-left: 0;
		}
		.form-label{
			color: #000;
			font-family: Noto Sans;
			font-size: 16px;
			font-style: normal;
			font-weight: 600;
			line-height: normal;
		}
		h1 {
			color: black;
			font-size: 32px;
			font-family: Noto Sans;
			font-weight: 600;
			word-wrap: break-word
		}
		h3 {
			color: #FF4379;
			font-size: 24px;
			font-family: Noto Sans;
			font-weight: 600;
			word-wrap: break-word
		}
		
		.btn-primary2 {
		    background-color: #9BDB04; 
		    border-color: #9BDB04; 
		    color: white;
		}
		
		.btn-primary2:hover {
		    background-color: #52525C ; 
		    border-color: #52525C; 
		    color: #9BDB04;
		}
		</style>
	</head>
	
	<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
		<main class="col-10 p-0">
			<div class="admin-header-container">
				<div class="container m-4">
					<i class="title-bi bi bi-pencil-square "></i>
				<label  class="admin-header-title ">축제 정보 등록 </label>	
				</div>
			</div>
				<div class="container my-5" id="detail-body-container">
							<div>
								<h1>축제 등록</h1>
								<hr class="hr">
							</div>	
							<div>
								<h3 style="color: #FF4379">축제정보 등록하기</h3>
							</div>
							<div class="my-5">
							<div class="" id="detail-main-container">
								<div class="container p-5" id="form-container">
			  						<form id="updateForm" action="festivalUpdate" 
			  						 method="post" enctype="multipart/form-data">
			  						 	<input type="hidden" name="content_id" value="${festival.content_id}">
										<input type="hidden" name="user_id" value="${userId}">
										<input type="hidden" name="big_code" value="11">
										<input type="hidden" name="status" value="1">
										<div class="mb-3">
											<label for="title" class="form-label">축제 이름(필수 입력)</label>
											<input type="text" class="form-control" name="title" id="title" value="${festival.title }" required>
										</div>
										<div class="mb-3">
											<label for="small_code" class="form-label">축제 테마(필수 선택)</label>
											<select class="form-select" aria-label="small_code" name="small_code" required>
												<c:forEach var="smallCode" items="${listCodes}">
													<c:if test="${smallCode.big_code == 11 && smallCode.small_code != 999}">
														<option value="${smallCode.small_code}">${smallCode.content}</option>
													</c:if>
												</c:forEach>
											</select>
										</div>
										<div class="mb-3">
											<div class="row">
												<div class="col-6 md-4 mb-3">
													<label for="start_date" class="form-label">시작일</label>
													<input type="date" class="form-control" name="start_date" id="start_date" value="${festival.start_date }">
												</div>
												<div class="col-6 md-4 mb-3">
													<label for="end_date" class="form-label">종료일</label>
													<input type="date" class="form-control" name="end_date" id="end_date" value="${festival.end_date }">
												</div>
											</div>
										</div>
										<div class="mb-3">
											<label for="sponsor" class="form-label">주최자</label>
											<input type="text" class="form-control" name="sponsor" id="sponsor" value="${festival.sponsor }">
										</div>
										<div class="mb-3">
											<label for="area" class="form-label">주소(필수 선택)</label>
											<div class="row">
												<div class="col-6 md-4 mb-3">
													<select name="area" class="form-select area-dropdown"></select>
												</div>
												<div class="col-6 md-4 mb-3">
													<select name="sigungu" class="form-select sigungu-dropdown"></select>
												</div>
												<div class="col-12 mb-3">
													<input type="text" class="form-control" name="address" id="address" 
													 placeholder="상세주소를 입력해주세요.(60자 이내)" maxlength="60" value="${festival.address }">
												</div>
												<div class="col-12">
													<input type="text" class="form-control" name="eventplace" id="eventplace" 
													 placeholder="장소명을 입력해주세요.(60자 이내)" maxlength="60" value="${festival.eventplace }">
												</div>
											</div>
										</div>
										<div class="mb-3">
											<label for="homepage" class="form-label">홈페이지</label>
											<input type="text" class="form-control" name="homepage" id="homepage" value="${festival.homepage }">
										</div>
										<div class="mb-3">
											<div class="row">
												<div class="col-6">
													<label for="phone" class="form-label">전화번호</label>
													<input type="text" class="form-control" name="phone" id="phone" placeholder="010-0000-0000~0" value="${festival.phone }">
												</div>
												<div class="col-6">
													<label for="email" class="form-label">이메일</label>
													<input type="text" class="form-control" name="email" id="email" value="${festival.email }">
												</div>
											</div>	
										</div>
										<div class="mb-3">
											<label for="content" class="form-label">축제 개요</label>
											<textarea class="form-control" name="content" id="content" rows="5" 
											 maxlength="1200">${festival.content }</textarea>
										</div>
										<div class="mb-3">
											<label for="overview" class="form-label">상세 내용</label>
											<textarea rows="5" class="form-control" name="overview" id="overview"
											 maxlength="600">${festival.overview }</textarea>
										</div>	
										<div class="mb-3">
											<label for="hours" class="form-label">진행시간</label>
											<input type="text" class="form-control" id="hours" name="hours" value="${festival.hours }">
										</div>
										<div class="mb-3">
											<label for="cost" class="form-label">이용요금</label>
											<input type="text" class="form-control" id="cost" name="cost" value="${festival.cost}">
										</div>
										<div class="mb-3">
											<label for="images" class="form-label">이미지 등록</label>
										</div>
										<div class="mb-3">
											<label for="facilities" class="form-label">부대/편의 시설</label>
											<div class="col-12 d-flex justify-content-between">
										  		<div class="col-3 form-check">
										  			<input class="form-check-input" type="checkbox" name="is_parking"
													id="is_credit" value="1" ${festival.is_parking == 1?"checked":""}>
										  			<label class="form-check-label" for="is_parking">주차여부</label>
										  		</div>
										  		<div class="col-3 form-check">
										  			<input class="form-check-input" type="checkbox" name="is_stroller"
													id="is_credit" value="1" ${festival.is_stroller == 1?"checked":""}>
										  			<label class="form-check-label" for="is_stroller">유아차 대여</label>
										  		</div>
										  		<div class="col-3 form-check">
										  			<input class="form-check-input" type="checkbox" name="is_wheelchair"
													id="is_credit" value="1" ${festival.is_wheelchair == 1?"checked":""}>
										  			<label class="form-check-label" for="is_wheelchair">휠체어 대여</label>
										  		</div>
										  		<div class="col-3 form-check">
										  			<input class="form-check-input" type="checkbox" name="is_restroom"
													id="is_credit" value="1" ${festival.is_restroom == 1?"checked":""}>
										  			<label class="form-check-label" for="is_restroom">장애인 화장실</label>
										  		</div>
										  	</div>
										</div>
										<div class="mb-3">
											<label for="searchType" class="form-label">태그</label>
											<div class="col-12 mb-3 d-flex">
												<input type="text" name="keyword" class="form-control searchForm" 
												 placeholder="키워드를 입력해주세요." autocomplete="off" list="autoTags">
												<img class="keyword-img align-self-center mx-1" src="<%=request.getContextPath()%>/image/icon_search1.png" 
												 alt="icon_search1.png" id="searchIcon" onclick="addTag()"/>
													<datalist id="autoTags">
														<c:forEach var="tag" items="${listAllTags}">
															<option id="${tag.id}" value="${tag.name}">
														</c:forEach>
													</datalist>
											</div>
											<div class="tags-container my-tags"><!-- 태그 badge가 들어갈 곳 --></div>
										</div>	
										<div class="mb-3 mt-3">
										    <div class="row p-0 insert_row2_custom">
										        <div class="form-group col">
										            <label class="lable2" for="file">첫번째 이미지</label>
										            <input type="file" class="form-control" name="file">
										        </div>
										        
										        <div class="form-group col">
										            <label class="lable2" for="file1">두번째 이미지</label>
										            <input type="file" class="form-control" name="file1">
										        </div>
										        
										        <div class="form-group col">
										            <label class="lable2" for="file2">세번째 이미지</label>
										            <input type="file" class="form-control" name="file2">
										        </div>
										    </div>
										</div>	
										<hr class="hr" />		
										<div align="center">
											<button type="button" class="btn btn-outline-secondary" onclick="updateForm()">수정</button>
											<button type="reset" class="btn btn-outline-secondary" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
										</div>
									</form>
								</div>	
							</div>
							</div>
						</div>
				</main>
			</div>
		</div>
	</body>
</html>