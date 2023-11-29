<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
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
			myTagsArea = document.querySelector('#my_tags'); // 저장한 태그 버튼을 보여줄 박스
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
			var newTagName = $('#searchForm').val(); // 선택된 tag의 name을 가져옴
			
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
			
			$('#searchForm').value = "";
		}
		<!-- 태그 코드 End -->
		
		<!-- 축제 insert -->
		function submitFestival() {
			event.preventDefault();
			
			var insertFormData = $('#festivalInsertForm').serializeArray();
			var finalTags = [];
			for(var i = 0; i < selectedTags.length; i++) {
				finalTags.push(Number(selectedTags[i].id));
			}
			insertFormData.push({name: 'finalTags', value: finalTags});
			
			if(confirm("등록하시겠습니까?")) {
				$.ajax({
					url: "<%=request.getContextPath()%>/festival/insert",
					method: "POST",
					data: insertFormData,
					dataType: "text",
					success: function(str) {
						alert(str);
						location.href="<%=request.getContextPath()%>/user/bizPage/content";
					}
				})
			}
		}
	</script>

	<style type="text/css">
	    .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
	        background-color: #F8FCF4 !important; /* 원하는 배경색으로 변경 */
	        color: #00000 !important; /* 원하는 텍스트 색상으로 변경 */
	    }
	    .tab-pane.fade.show.active {
	        background-color: #F8FCF4; /* 원하는 배경색으로 변경 */
	    }
	    
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
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<main >
	<div class="d-flex">
			<div class="col-2">
				<%@ include file="/WEB-INF/components/BizPageSideBar.jsp"%>
			</div>
		<div id="exTab3" class="container p-5 col-10">	
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
			  	<div class="container-fluid">
			  		<div class="row">
			  			<div class="container my-5 detail-body-container">
							<div>
								<h1>축제 등록</h1>
							</div>		  		
							<div>
								<hr class="hr">
							</div>	
							<div>
								<h3 style="color: #FF4379">축제정보 등록하기</h3>
							</div>
							<div class="my-5">
							<div class="" id="detail-main-container">
								<div class="container p-5" id="form-container">
			  						<form id="festivalInsertForm" action="<%=request.getContextPath()%>/bizFestivalInsert" 
			  						 method="post" enctype="multipart/form-data">
										<input type="hidden" name="user_id" value="${userId}">
										<input type="hidden" name="big_code" value="11">
										<div class="mb-3">
											<label for="title" class="form-label">축제 이름(필수 입력)</label>
											<input type="text" class="form-control" name="title" id="title" required>
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
													<input type="date" class="form-control" name="start_date" id="start_date">
												</div>
												<div class="col-6 md-4 mb-3">
													<label for="end_date" class="form-label">종료일</label>
													<input type="date" class="form-control" name="end_date" id="end_date">
												</div>
											</div>
										</div>
										<div class="mb-3">
											<label for="sponsor" class="form-label">주최</label>
											<input type="text" class="form-control" name="sponsor" id="sponsor">
										</div>
										<div class="mb-3">
											<label for="area" class="form-label">주소(필수 선택)</label>
											<div class="row">
												<div class="col-2">
													<select name="area" class="form-select area-dropdown"></select>
												</div>
												<div class="col-2">
													<select name="sigungu" class="form-select sigungu-dropdown"></select>
												</div>
												<div class="col-4">
													<input type="text" class="form-control" name="address" id="address" 
													 placeholder="상세주소를 입력해주세요.(60자 이내)" maxlength="60">
												</div>
												<div class="col-4">
													<input type="text" class="form-control" name="eventplace" id="eventplace" 
													 placeholder="장소를 입력해주세요.(60자 이내)" maxlength="60">
												</div>
											</div>
										</div>
										<div class="mb-3">
											<label for="homepage" class="form-label">홈페이지</label>
											<input type="text" class="form-control" name="homepage" id="homepage">
										</div>
										<div class="mb-3">
											<div class="row">
												<div class="col-6">
													<label for="phone" class="form-label">전화번호</label>
													<input type="text" class="form-control" name="phone" id="phone" placeholder="010-0000-0000~0">
												</div>
												<div class="col-6">
													<label for="email" class="form-label">이메일</label>
													<input type="text" class="form-control" name="email" id="email">
												</div>
											</div>	
										</div>
										<div class="mb-3">
											<label for="content" class="form-label">축제 개요</label>
											<textarea class="form-control" name="content" id="content" rows="5" 
											 placeholder="축제의 개요를 입력해주세요.(1200자 이내)" maxlength="1200"></textarea>
										</div>
										<div class="mb-3">
											<label for="overview" class="form-label">상세 내용</label>
											<textarea rows="5" class="form-control" name="content" id="overview"
											 placeholder="축제의 상세 내용을 입력해주세요.(600자 이내)" maxlength="600"></textarea>
										</div>	
										<div class="mb-3">
											<label for="hours" class="form-label">진행시간</label>
											<input type="text" class="form-control" id="hours" name="hours">
										</div>
										<div class="mb-3">
											<label for="cost" class="form-label">이용요금</label>
											<input type="text" class="form-control" id="cost" value="${festival.cost}">
										</div>
										<div class="mb-3">
											<label for="images" class="form-label">이미지 등록</label>
										</div>
										<div class="mb-3">
											<label for="facilities" class="form-label">부대/편의 시설</label>
											<div class="col-12 d-flex justify-content-between">
										  		<div class="col-3 form-check">
										  			<input class="form-check-input" type="checkbox" name="is_parking" id="is_parking" value="1">
										  			<label class="form-check-label" for="is_parking">주차여부</label>
										  		</div>
										  		<div class="col-3 form-check">
										  			<input class="form-check-input" type="checkbox" name="is_stroller" id="is_stroller" value="1">
										  			<label class="form-check-label" for="is_stroller">유아차 대여</label>
										  		</div>
										  		<div class="col-3 form-check">
										  			<input class="form-check-input" type="checkbox" name="is_wheelchair" id="is_wheelchair" value="1">
										  			<label class="form-check-label" for="is_wheelchair">휠체어 대여</label>
										  		</div>
										  		<div class="col-3 form-check">
										  			<input class="form-check-input" type="checkbox" name="is_restroom" id="is_restroom" value="1">
										  			<label class="form-check-label" for="is_restroom">장애인 화장실</label>
										  		</div>
										  	</div>
										</div>
										<div class="mb-3">
											<label for="searchType" class="form-label">태그</label>
											<div class="col-9">
												<input type="text" name="keyword" class="form-control" id="searchForm" 
												 placeholder="키워드를 입력해주세요." autocomplete="off" list="autoTags">
													<datalist id="autoTags">
														<c:forEach var="tag" items="${listAllTags}">
															<option id="${tag.id}" value="${tag.name}">
														</c:forEach>
													</datalist>
											</div>
											<!-- 버튼 -->
											<div class="col-2 d-flex justify-content-start">
												<button type="button" class="btn btn-primary col-2 mx-1" onclick="addTag()">저장</button>
											</div>
											<div id="my_tags"><!-- 태그 badge가 들어갈 곳 --></div>
										</div>			
										<div align="center">
											<button type="submit" class="btn btn-outline-secondary" onclick="submitFestival()">등록</button>
											<button type="reset" class="btn btn-outline-secondary" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
										</div>
									</form>
								</div>	
							</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			 
			<!-- 명소 -->			
			 <div class="tab-pane fade" id="nav-spot" role="tabpanel" aria-labelledby="nav-spot-tab" tabindex="0">
			  	<div class="container-fluid">
					<div class="row">
					<div class="container my-5" id="detail-body-container">
					<div>
						<h1>명소 등록</h1>
						<hr class="hr" />
					</div>
					<div>
						<h3 style="color: #FF4379 ">명소정보 등록하기</h3>
					</div>
					<div class="my-5">
					<div class="" id="detail-main-container">
						<div class="container p-5" id="form-container">
					<form action="<%=request.getContextPath()%>/admin/content/spotInsertResult" method="post">
						<div class="mb-3 ">
						  <label for="title" class="form-label">명소 이름(필수 입력)</label>
						  <input type="text" class="form-control" name="title" id="title" value="${spot.title}" required="required">
						</div>
						<div class="mb-3" id="detail-content-title">
						  <label for="small_code" class="form-label">명소 종류(필수 선택)</label>
							<input type="hidden" name="big_code" value="14">
								<select class="form-select" aria-label="small_code" name="small_code" required="required">
									<c:forEach var="code" items="${listCodes}">
										<c:if test="${code.big_code == 14 && code.small_code != 999}">
											<option value="${code.small_code}" ${code.small_code== spot.small_code? 'selected' : '' }>${code.content}</option>
										</c:if>
									</c:forEach>
								</select>
							</div>
							<div class="mb-3 ">
								<label for="content" class="form-label ">지역(필수 선택)</label>
									<div class="row">
								   		<div class="col-2">  
											<select name="area" class="form-select area-dropdown"></select>
										</div>
										<div class="col-4">
								       		<select name="sigungu"  class="form-select sigungu-dropdown"></select>
								   	 	</div>
								   	 </div>
							</div>	   	 
							<div class="mb-3 ">
								<label for="content" class="form-label ">주소</label>
								   	 <div class="row">
								   	 	<div class="col-2">
								    		<input type="text" class="form-control" name="postcode" id="postcode" value="${spot.postcode}" placeholder="우편번호">
								    	</div>
								    	<div class="col-10">
								    		<input type="text" class="form-control" name="address" id="address" value="${spot.address}" placeholder="상세주소 입력해주세요">
								    	</div>
								   	 </div>
							</div>
							<div class="mb-3 ">
						  		<label for="content" class="form-label">개요</label>
								<textarea rows="5" class="form-control" name="content" id="content" maxlength="4000" 
									placeholder="명소에 대한 설명을 4000자 이내로 입력해주세요">${experience.content}</textarea>
							</div>
							<div class="mb-3 ">
						 		<label for="email" class="form-label">email</label>
						  		<input type="text" class="form-control" name="email" id="email" value="${spot.email} ">
							</div>
							<div class="mb-3 ">
						 	 	<label for="phone" class="form-label">전화번호</label>
						  		<input type="text" class="form-control" name="phone" id="phone" value="${spot.phone}" placeholder="010 - 0000 - 0000~0">
							</div>
							<div class="mb-3 ">
						 		<label for="homepage" class="form-label">홈페이지</label>
						  		<input type="text" class="form-control" name="homepage" id="homepage" value="${spot.homepage} ">
							</div>
							<div class="mb-3 ">
						  		<label for="opening_hours" class="form-label">영업시간</label>
						  		<input type="text" class="form-control" name="opening_hours" id="opening_hours" value="${spot.opening_hours} ">
							</div>
							<div class="mb-3 ">
						  		<label for="rest_date" class="form-label">휴무일</label>
						  		<input type="text" class="form-control" name="rest_date" id="rest_date" value="${spot.rest_date} ">
							</div>
							<div class="mb-3 ">
						  		<label for="entrance_fee" class="form-label">입장료</label>
								<input type="text" class="form-control" name="ntrance_fee" id="ntrance_fee" value="${spot.ntrance_fee} ">
							</div>
							<div class="mb-3 ">
						 	 	<label for="img1" class="form-label">이미지</label>
						  		<input type="text" class="form-control" name="img1" id="img1 value="${spot.img1} ">
							</div>
							<div class="mb-3 ">
							 <label for="rest_time" class="form-label">태그</label>
								<div class="tag-container">
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                       </div>
			    				</div>
		                   </div>
							
							<label for="facilities" class="form-label">부대시설</label><br>
								<div class="col-12 d-flex justify-content-between">
						  			<div class="col-2 form-check mx-3">
										<input class="form-check-input" type="checkbox" name="is_wheelchair"
										  	   id="is_wheelchair" value="1" ${experience.is_credit == 1?"checked":""}> 
										<label class="form-check-label" for="is_wheelchair">휠체어대여</label>
									</div>
									<div class="col-2 form-check mx-3">
										<input class="form-check-input" type="checkbox" name="is_restroom"
										  	   id="is_restroom" value="1" ${experience.is_credit == 1?"checked":""}> 
										<label class="form-check-label" for="is_restroom">장애인화장실</label>
									</div>
									<div class="col-2 form-check mx-3">
										<input class="form-check-input" type="checkbox" name="is_pet"
												  id="is_pet" value="1" ${spot.is_pet == 1?"checked":""}> 
										<label class="form-check-label" for="is_pet">반려동물</label>
									</div>
									<div class="col-2 form-check mx-3">
										<input class="form-check-input" type="checkbox" name="is_parking"
												  id="is_parking" value="1" ${spot.is_parking == 1?"checked":""}> 
										<label class="form-check-label" for="is_parking">주차시설</label>
									</div>
									<div class="col-2 form-check mx-3">
										<input class="form-check-input" type="checkbox" name="is_stroller"
												  id="is_stroller" value="1" ${spot.is_stroller == 1?"checked":""}> 
										<label class="form-check-label" for="is_stroller">유모차대여</label>
									</div>
								</div>
								
								<hr class="hr" />			
						
								<div class="d-flex justify-content-between">
									<div class="col-6 mb-3" >
	                        			<button type="submit" class="form-control btn btn-primary w-100" onclick="return confirm('등록 하시겠습니까?')">등록</button>
	                        		</div>
	                        		<div class="col-3 mb-3">
	                        			<button type="reset" class="btn btn-outline-secondary w-100" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
	                        		</div>
	                        		<div class="col-2 mb-3">
	                        			<button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/spot'">취소</button>
	                        		</div>
								</div>
			  			</form>
						</div>
					</div>
					</div>
					</div>
					</div>
				</div>
			</div>
			<!-- 명소끝 --> 
			 
			<div class="tab-pane fade" id="nav-restaurant" role="tabpanel" aria-labelledby="nav-restaurant-tab" tabindex="0">
			  	<div class="container-fluid">
				<div class="row">
				<div class="container my-5" id="detail-body-container">
					<div>
						<h1>맛집 등록</h1>
						<hr class="hr" />
					</div>
					<div>
						<h3 style="color: #FF4379 ">맛집정보 등록하기</h3>
					</div>
					<div class="my-5">
					<div class="" id="detail-main-container">
						<div class="container p-5" id="form-container">
						<form action="restaurantInsert" method="post">
							<div class="mb-3 ">
							  <label for="title" class="form-label">맛집 이름(필수 입력)</label>
							  <input type="text" class="form-control" name="title" id="title" value="${restaurant.title}" required="required">
							</div>
							<div class="mb-3" id="detail-content-title">
							  <label for="small_code" class="form-label">맛집 종류(필수 선택)</label>
							  	<input type="hidden" name="big_code" value="12">
								<select class="form-select" aria-label="small_code" name="small_code" required="required">
									<c:forEach var="smallCode" items="${listSmallCode}">
										<c:if test="${smallCode.big_code == 12 && smallCode.small_code != 999}">
											<option value="${smallCode.small_code}" ${smallCode.small_code == restaurant.small_code? 'selected' : '' }>${smallCode.content}</option>
										</c:if>
								 	</c:forEach>
								</select>
							</div>			
							<div class="mb-3 ">
								<label for="content" class="form-label ">지역(필수 선택)</label>
									<div class="row">
									    <div class="col-2">
									        <select name="area" class="form-select area-dropdown"></select>
									    </div>
									    <div class="col-2">
									       <select name="sigungu"  class="form-select sigungu-dropdown"></select>
									    </div>
									    <div class="col-8">
									    <input type="text" class="form-control" name="address" id="address" value="${restaurant.address}" placeholder="상세주소 입력해주세요">
									    </div>
									</div>
							</div>
							<div class="mb-3 ">
							  <label for="phone" class="form-label">전화번호</label>
							  <input type="text" class="form-control" name="phone" id="phone" value="${restaurant.phone} " >
							</div>
							<div class="mb-3 ">
							  <label for="first_menu" class="form-label">대표메뉴</label>
							  <input type="text" class="form-control" name="first_menu" id="first_menu" value="${restaurant.first_menu} " >
							</div>
							<div class="mb-3 ">
							  <label for="menu" class="form-label">추천메뉴</label>
							  <input type="text" class="form-control" name="menu" id="menu" value="${restaurant.menu} " >
							</div>
							<div class="mb-3 ">
							  <label for="content" class="form-label">개요</label>
							  <textarea class="form-control" name="content" id="content" rows="5" >${restaurant.content}</textarea>
							</div>		
							<div class="mb-3 ">
							  <label for="open_time" class="form-label">영업시간</label>
							  <input type="text" class="form-control" name="open_time" id="open_time" value="${restaurant.open_time} " >
							</div>
							<div class="mb-3 ">
							  <label for="rest_date" class="form-label">휴무일</label>
							  <input type="text" class="form-control" name="rest_date" id="rest_date" value="${restaurant.rest_date} " >
							</div>
							<div class="mb-3 ">
								 <label for="rest_time" class="form-label">태그</label>
									<div class="tag-container">
				                         <div class="tag-item">
				                             <div>#MZ추천</div>
				                         </div>
				                         <div class="tag-item">
				                             <div>#MZ추천</div>
				                         </div>
				                         <div class="tag-item">
				                             <div>#MZ추천</div>
				                         </div>
				                         <div class="tag-item">
				                             <div>#MZ추천</div>
				                         </div>
				                         <div class="tag-item">
				                             <div>#MZ추천</div>
				                      	 </div>
				    				</div>
			                 </div>	 
							 				  
							  <label for="facilities" class="form-label">부대시설</label><br>
							<div class="col-12 d-flex justify-content-between">
							  	<div class="col-3 form-check">
									<input class="form-check-input" type="checkbox" name="is_smoking"
									id="is_credit" value="1" ${restaurant.is_smoking == 1?"checked":""} > 
									<label class="form-check-label" for="is_credit">흡연가능</label>
								</div>
								<div class="col-3 form-check">
									<input class="form-check-input" type="checkbox" name="is_packing"
									id="is_pet" value="1" ${restaurant.is_packing == 1?"checked":""} > 
									<label class="form-check-label" for="is_packing">포장가능</label>
								</div>
								<div class="col-3 form-check">
								<input class="form-check-input" type="checkbox" name="is_parking"
									id="is_parking" value="1" ${restaurant.is_parking == 1?"checked":""} > 
									<label class="form-check-label" for="is_parking">주차가능</label>
								</div>
							</div>
																		
							<hr class="hr" />			
												
							<div class="d-flex justify-content-between">
								<div class="col-6 mb-3" >
		                        	<button type="submit" class="form-control btn btn-primary w-100" onclick="return confirm('등록 하시겠습니까?')">등록</button>
		                        </div>
		                        <div class="col-3 mb-3">
		                        	<button type="reset" class="btn btn-outline-secondary w-100" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
		                        </div>
		                        <div class="col-2 mb-3">
		                        	<button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/restaurant'">취소</button>
		                        </div>
							</div>
														
							</form>
						</div>
					</div>
					</div>
				</div>
			</div>
			</div>
		</div>	
			  	
			 
			 
			  <div class="tab-pane fade" id="nav-accomodation" role="tabpanel" aria-labelledby="nav-accomodation-tab" tabindex="0">
			  	<div class="container-fluid">
				<div class="row">
				<div class="container my-5" id="detail-body-container">
				<div>
				<h1>숙소 등록</h1>
				<hr class="hr" />
				</div>
				<div>
				<h3 style="color: #FF4379 ">숙소정보 등록하기</h3>
				</div>
				<div class="my-5">
				<div class="" id="detail-main-container">
				
					<div class="container p-5" id="form-container">
					<form action="<%=request.getContextPath()%>/admin/content/accomodationInsert" method="post" enctype="multipart/form-data">
						<div class="mb-3 ">
						  <label for="title" class="form-label">숙소 이름(필수 입력)</label>
						  <input type="hidden" class="form-control" name="user_id" id="user_id" value="${userId }">
						  <input type="text" class="form-control" name="title" id="title" value="${accomodaiton.title}" required="required">
						</div>
						<div class="mb-3" id="detail-content-title">
						  <label for="small_code" class="form-label">숙소 종류(필수 선택)</label>
						  	<input type="hidden" name="big_code" value="13">
							<select class="form-select" aria-label="small_code" name="small_code" required="required">
								<c:forEach var="smallCode" items="${listCodes}">
									<c:if test="${smallCode.big_code == 13 && smallCode.small_code != 999}">
										<option value="${smallCode.small_code}" ${smallCode.small_code == accomodaiton.small_code? 'selected' : '' }>${smallCode.content}</option>
									</c:if>
							 	</c:forEach>
							</select>
						</div>			
						<div class="mb-3 ">
							<label for="content" class="form-label ">지역(필수 선택)</label>
								<div class="row">
								    <div class="col-2">
								        <select name="area" class="form-select area-dropdown"></select>
								    </div>
								    <div class="col-2">
								       <select name="sigungu"  class="form-select sigungu-dropdown"></select>
								    </div>
								    <div class="col-8">
								    <input type="text" class="form-control" name="address" id="address" value="${accomodation.address}" placeholder="상세주소 입력해주세요">
								    </div>
								</div>
						</div>
						<div class="mb-3 ">
						  <label for="content" class="form-label">개요</label>
						  <textarea class="form-control" name="content" id="content" rows="5" placeholder="체험에 대한 설명을 4000자 이내로 입력해주세요 ">${accomodaiton.content}</textarea>
						</div>		
						<div class="mb-3 ">
						  <label for="email" class="form-label">email</label>
						  <input type="text" class="form-control" name="email" id="email" value="${accomodaiton.email} ">
						</div>
						<div class="mb-3 ">
						  <label for="phone" class="form-label">전화번호</label>
						  <input type="text" class="form-control" name="phone" id="phone" value="${accomodaiton.phone}" placeholder="010 - 0000 - 0000~0">
						</div>
						<div class="mb-3 ">
						  <label for="homepage" class="form-label">홈페이지</label>
						  <input type="text" class="form-control" name="homepage" id="homepage" value="${accomodaiton.homepage} ">
						</div>
						<div class="mb-3 ">
						  <label for="age" class="form-label">객실수</label>
						  <input type="text" class="form-control" name="room_count" id="room_count" value="${accomodaiton.room_count} ">
						</div>
						<div class="mb-3 ">
						  <label for="reservation_url" class="form-label">예약처</label>
						  <input type="text" name="reservation_url" class="form-control" id="reservation_url" value="${accomodation.reservation_url} " >
						</div>			
						<div class="mb-3 ">
						  <label for="refund" class="form-label">환불규정</label>
						  <input type="text" name="refund" class="form-control" id="refund" value="${accomodation.refund} " >
						</div>
						<div class="mb-3 ">
						   <label for="check_in" class="form-label">입실시간</label>
						  <input type="text" name="check_in" class="form-control" id="check_in" value="${accomodation.check_in} " >
						</div>
						<div class="mb-3 ">
						  <label for="check_out" class="form-label">퇴실시간</label>
						  <input type="text" name="check_out" class="form-control" id="check_out" value="${accomodation.check_out} " >
						</div>
						  
						 <div class="mb-3 ">
							 <label for="rest_time" class="form-label">태그</label>
								<div class="tag-container">
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                       </div>
			    				</div>
		                   </div>	 
						  
						  <label for="facilities" class="form-label">부대시설</label><br>
						<div class="col-12 d-flex justify-content-between">
						  	<div class="col-3 form-check mx-3">
								<input class="form-check-input" type="radio" name="is_credit"
								id="is_cook" value="1" ${accomodation.is_cook == 1?"checked":""} > 
								<label class="form-check-label" for="is_credit">조리가능</label>
							</div>
							<div class="col-3 form-check mx-3">
								<input class="form-check-input" type="radio" name="is_pet"
								id="is_pickup" value="1" ${accomodation.is_pickup == 1?"checked":""} > 
								<label class="form-check-label" for="is_pet">픽업가능</label>
							</div>
							<div class="col-3 form-check mx-3">
							<input class="form-check-input" type="radio" name="is_parking"
								id="is_parking" value="1" ${accomodation.is_parking == 1?"checked":""} > 
								<label class="form-check-label" for="is_parking">주차가능</label>
							</div>
						</div>
						<hr class="hr" />			
						
						
						
						<div class="d-flex justify-content-between">
							<div class="col-6 mb-3" >
	                        	<button type="submit" class="form-control btn btn-primary w-100" onclick="return confirm('등록 하시겠습니까?')">등록</button>
	                        </div>
	                        <div class="col-3 mb-3">
	                        	<button type="reset" class="btn btn-outline-secondary w-100" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
	                        </div>
	                        <div class="col-2 mb-3">
	                        	<button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../bizPage/content'">취소</button>
	                        </div>
	                    
						</div>
						</form>
						</div>
						</div>
						</div>
					</div>
				</div>
				</div>
			</div>

			
			  
			  <div class="tab-pane fade" id="nav-experience" role="tabpanel" aria-labelledby="nav-experience-tab" tabindex="0">
			  	<div class="container-fluid">
		<div class="row">
<div class="container my-5" id="detail-body-container">
				<div>
				<h1>체험 등록</h1>
				<hr class="hr" />
				</div>
				<div>
				<h3 style="color: #FF4379 ">체험정보 등록하기</h3>
				</div>
				<div class="my-5">
				<div class="" id="detail-main-container">
				
					<div class="container p-5" id="form-container">
					<form action="<%=request.getContextPath()%>/admin/content/experienceInsert" method="post" enctype="multipart/form-data">
						<div class="mb-3 ">
						  <label for="title" class="form-label">체험 이름(필수 입력)</label>
						  <input type="hidden" class="form-control" name="user_id" id="user_id" value="${userId }">
						  <input type="text" class="form-control" name="title" id="title" value="${experience.title}" required="required">
						</div>
						<div class="mb-3" id="detail-content-title">
						  <label for="small_code" class="form-label">체험 종류(필수 선택)</label>
						  	<input type="hidden" name="big_code" value="15">
							<select class="form-select" aria-label="small_code" name="small_code" required="required">
								<c:forEach var="smallCode" items="${listCodes}">
									<c:if test="${smallCode.big_code == 15 && smallCode.small_code != 999}">
										<option value="${smallCode.small_code}" ${smallCode.small_code == experience.small_code? 'selected' : '' }>${smallCode.content}</option>
									</c:if>
							 	</c:forEach>
							</select>
						</div>			
						<div class="mb-3 ">
							<label for="content" class="form-label ">지역(필수 선택)</label>
								<div class="row">
								    <div class="col-2">
								        <select name="area" class="form-select area-dropdown"></select>
								    </div>
								    <div class="col-2">
								       <select name="sigungu"  class="form-select sigungu-dropdown"></select>
								    </div>
								    <div class="col-8">
								    <input type="text" class="form-control" name="address" id="address" value="${experience.address}" placeholder="상세주소 입력해주세요">
								    </div>
								</div>
						</div>
						<div class="mb-3 ">
						  <label for="content" class="form-label">개요</label>
						  <textarea class="form-control" name="content" id="content" rows="5" placeholder="체험에 대한 설명을 4000자 이내로 입력해주세요 ">${experience.content}</textarea>
						</div>		
						<div class="mb-3 ">
						  <label for="email" class="form-label">email</label>
						  <input type="text" class="form-control" name="email" id="email" value="${experience.email} ">
						</div>
						<div class="mb-3 ">
						  <label for="phone" class="form-label">전화번호</label>
						  <input type="text" class="form-control" name="phone" id="phone" value="${experience.phone}" placeholder="010 - 0000 - 0000~0">
						</div>
						<div class="mb-3 ">
						  <label for="homepage" class="form-label">홈페이지</label>
						  <input type="text" class="form-control" name="homepage" id="homepage" value="${experience.homepage} ">
						</div>
						<div class="mb-3 ">
						  <label for="capacity" class="form-label">수용인원</label>
						  <input type="text" class="form-control" name="capacity" id="capacity" value="${experience.capacity} ">
						</div>
						<div class="mb-3 ">
						  <label for="age" class="form-label">체험연령</label>
						  <input type="text" class="form-control" name="age" id="age" value="${experience.age} ">
						</div>
						<div class="mb-3 ">
						  <label for="inform" class="form-label">체험안내</label>
						  <textarea class="form-control" name="inform" id="inform" rows="5" placeholder="체험에 대한 안내을 4000자 이내로 입력해주세요 ">${experience.inform}</textarea>
						</div>
						<div class="mb-3 ">
						  <label for="open_time" class="form-label">개장시간</label>
						  <input type="text" class="form-control" name="open_time" id="open_time" value="${experience.open_time} ">
						</div>
						<div class="mb-3 ">
						  <label for="rest_time" class="form-label">휴무일</label>
						  <input type="text" class="form-control" name="rest_time" id="rest_time" value="${experience.rest_time} ">
						</div>
						<div class="mb-3 ">
						  <label for="cost" class="form-label">비용안내</label>
						  <input type="text" class="form-control" name="cost" id="cost" value="${experience.cost} ">
						</div>
						  
						 <div class="mb-3 ">
							 <label for="rest_time" class="form-label">태그</label>
								<div class="tag-container">
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                       </div>
			    				</div>
		                   </div>	 
						  
						  <label for="facilities" class="form-label">부대시설</label><br>
						<div class="col-12 d-flex justify-content-between">
						  	<div class="col-3 form-check mx-3">
								<input class="form-check-input" type="checkbox" name="is_credit"
								id="is_credit" value="1" ${experience.is_credit == 1?"checked":""}> 
								<label class="form-check-label" for="is_credit">카드여부</label>
							</div>
							<div class="col-3 form-check mx-3">
								<input class="form-check-input" type="checkbox" name="is_pet"
								id="is_pet" value="1" ${experience.is_pet == 1?"checked":""}> 
								<label class="form-check-label" for="is_pet">반려동물</label>
							</div>
							<div class="col-3 form-check mx-3">
							<input class="form-check-input" type="checkbox" name="is_parking"
								id="is_parking" value="1" ${experience.is_parking == 1?"checked":""}> 
								<label class="form-check-label" for="is_parking">주차시설</label>
							</div>
							<div class="col-3 form-check mx-3">
							<input class="form-check-input" type="checkbox" name="is_stroller"
								id="is_stroller" value="1" ${experience.is_stroller == 1?"checked":""}> 
								<label class="form-check-label" for="is_stroller">유모차대여</label>
							</div>
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
						
						
						
						<div class="d-flex justify-content-between">
							<div class="col-6 mb-3" >
	                        	<button type="submit" class="form-control btn btn-primary w-100" onclick="return confirm('등록 하시겠습니까?')">등록</button>
	                        </div>
	                        <div class="col-3 mb-3">
	                        	<button type="reset" class="btn btn-outline-secondary w-100" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
	                        </div>
	                        <div class="col-2 mb-3">
	                        	<button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/experience'">취소</button>
	                        </div>
						</div>
						
						
							
						</form>
					</div>
				</div>
				</div>
			</div>

		</div>
	</div>
				
			  
	</div>
	</div>
	</div>
	</div>
	</main>
</body>
</html>