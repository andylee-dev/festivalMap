<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>내 관심사</title>
		<style type="text/css">
			h1 {
				color: black;
				font-size: 32px;
				font-family: Noto Sans;
				font-weight: 600;
				word-wrap: break-word
			}
			
			h2 {
				color: #FF4379;
				font-family: Noto Sans;
				font-size: 24px;
				font-style: normal;
				font-weight: 600;
				line-height: normal;
				padding-bottom: 10px;
			}
						
			.tags-container {
				border-radius: 10px;
				border: 1px solid #000;
			}

			.col-form-label{
				color: #000;				
				font-family: Noto Sans;
				font-size: 16px;
				font-style: normal;
				font-weight: 800;
				line-height: normal;
			}
			
			button {
				white-space: nowrap;
			}
			
			/* 현재 선택된 검색어 */
			.autocomplete > div.active {
				background: #EEFFC2;
				color: black;
			}
			
			/* 전체 검색어 */
			.autocomplete > div {
				background: #f1f3f499;
				padding: .2rem .6rem;
			}
		</style>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			let initialTags = []; // 원래 DB에 저장되어 있던 태그 모두 저장
			let selectedTags = []; // 선택한 옵션을 저장할 배열 선언 --> 초기에 DB에 저장되어 있던 태그 모두 저장
			let allTags = []; // 태그 자동완성을 위해 모든 태그들의 id와 name을 저장한 배열 
			let myTagsArea;
			
			document.addEventListener("DOMContentLoaded", (event) => {
				
				<!-- 자동완성 관련 코드 Start -->
				let searchForm = document.getElementById(searchForm);
				let autocomplete = document.getElementById(autocomplete);
				
				allTagOptions();
				
				const value = searchForm.value.trim(); // 검색어
				const matchDataList = allTags.filter((label) => label.includes(value)); // 자동완성 필터링(리스트)
				
				var nowIndex = 0;
				
				searchForm.input(function(event) {
					
					switch(event.keyCode) {
						// 방향키 up					
						case 38:
							nowIndex = Math.max(nowIndex-1, 0); // -1 했을 때 0보다 작다면 0으로 지정
							break;
							
						// 방향키 down
						case 40:
							nowIndex = Math.min(nowIndex+1, matchDataList.length-1); // +1 했을 때 리스트 개수보다 커지지 않도록 지정
							break;
							
						// 엔터키
						case 13:
							// 엔터키를 눌렀을 때 선택한 검색어로 대체
							$('#searchForm').value = matchDataList[nowIndex] || "";
							 
							// 기존 데이터 초기화
							nowIndex = 0;
							matchDataList.length = 0;
							break;
							 
						// 그외 입력 초기화
						default:
							nowIndex = 0;
					}
					
					showList(matchDataList, value, nowIndex);
				});
				
				const showList = (data, value, nowIndex) => {
					// 정규식 변환
					const regex = new RegExp('(${value})','g');
					
					autoComplete.innerHTML = data
						.map(
								(label, index) => '
									<div class='${nowIndex === index? "active" : ""}'>
										${label.replace(regex, "<mark>$1</mark>")}
									</div>
								'
						)
						.join("");
					
				}
					
				<!-- 자동완성 관련 코드 End -->
	
				<!-- 태그 관리 관련 코드 Start -->	
				myTagsArea = document.querySelector('#my_tags');
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
							alert("이미 추가한 태그입니다.");
						}
					}
					
					// 배열에 없었던 태그일 경우에만 추가
					if(!isDuplicate) {
						selectedTags.push(selectedTag); 
						newTagBadge(selectedTag);
					}
					
				});
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
			
			
			function initialSelectedTags() {
				var userId = '${userId}';
				$.ajax({
					url: "<%=request.getContextPath()%>/getMyUserTags",
					method: "GET",
					data: {userId: userId},
					dataType: "json",
					success: function(tags) {
						console.log(tags)
						if(tags != null) {
							tags.forEach(function(tag) {
								initialTags.push(tag);
								selectedTags.push(tag);
								newTagBadge(tag);
							});
						};
						console.log("getMyUserTags success");
					},
					error: function() {
						console.log("회원 태그 정보를 가져오지 못했습니다.");
					}
				})
			}
			
			function newTagBadge(selectedTag) {
				// 태그 버튼 생성 
				const newTag = document.createElement('button');
				newTag.className = "btn btn-outline-secondary align-items-center no-hover";
				newTag.value = selectedTag.name;
				newTag.innerHTML = "#" +selectedTag.name;
				newTag.id = selectedTag.id;
				console.log(newTag);
					
				// x버튼 및 클릭시의 이벤트 생성
				const closeButton = document.createElement('span');
				closeButton.innerHTML = "&times";
				closeButton.className = "close-icon";
				closeButton.style.marginLeft = "5px";
				closeButton.style.cursor = "pointer";
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
			
			function updateTags() {
				var userId = '${userId}';
				var finalTags = [];
				for(var i = 0; i < selectedTags.length; i++) {
					finalTags.push(Number(selectedTags[i].id));
				}
				$.ajax({
					url: "<%=request.getContextPath()%>/user/myPage/userTagsUpdate",
					method: "POST",
					data: {userId: userId,
						   tagId:  finalTags
						  },
					dataType: "text",
					success: function(str) {
						alert(str);
						location.href="<%=request.getContextPath()%>/user/myPage/myTag";
					},
					error: function() {
						console.log("태그 업데이트에 실패했습니다.");
					}
				})
			}
			<!-- 태그 관리 관련 코드 end -->
		</script>
	</head>
	<body>
		<!-- Top bar -->
		<%@ include file="/WEB-INF/components/TobBar.jsp"%>
		<main>
			<div class="d-flex">
				<%@ include file="/WEB-INF/components/MyPageSideBar.jsp"%>
				<div class="container border p-5">
					<div class="container my-5">
						<div class="col-11">
							<h1>내 관심사(태그)</h1>
						</div>
						<div class="col-11 align-items-center">
							<hr class="hr">
						</div>
						<div class="container col-10 justify-content-center mt-5">
							<form action="list" method="GET" class="container justify-content-center">
								<!-- 검색어 -->
								<div class="col-12 my-4 d-flex align-items-center">
									<label for="searchType" class="col-form-label col-2  mx-2">검색어</label>
									<div class="col-7 mx-1">
										<input type="text" name="keyword" class="form-control" id="searchForm" 
										 value="${keyword}" placeholder="검색어를 입력해주세요.">
										<div id="autocomplete" class="selectArea"></div>
									</div>
									<!-- 버튼 -->
									<div class="col-5 mx-1 d-flex justify-content-start">
										<button type="submit" class="btn btn-primary col-2 mx-1">검색</button>
										<button type="reset" class="btn btn-outline-secondary col-2 mx-1">초기화</button>
									</div>
								</div>
							</form>	
						</div>
						<div class="col-11">
							<div class="d-flex justify-content-between align-items-end mt-5">
								<div class="col-3 p-1">
									<h2>추천태그</h2>
								</div>
								<div class="col-8 p-1" align="right">
									<span>페스티맵에서 추천하는 태그를 선택해보세요.</span>
								</div>
							</div>	
							<div class="container tags-container p-4 mb-4">
								<div class="" id="recommend_tags">
									<button class="btn btn-primary">#선택태그</button>
									<button class="btn btn-outline-secondary">#미선택태그</button>
								</div>
							</div>
						</div>
						<div class="col-11">
							<div class="d-flex justify-content-between align-items-end mt-5">
								<div class="col-3 p-1">
									<h2>저장한 태그</h2>
								</div> 
								<div class="col-8 p-1" align="right">
									<span>내가 저장한 관심사 태그를 관리할 수 있습니다.</span>
								</div>
							</div>
							<div class="container tags-container p-4">
								<div id="my_tags">
								</div>
							</div>
						</div>
						<div class="d-flex justify-content-center mt-3">
							<button type="button" class="btn btn-primary" onclick="updateTags()">수정</button>
						</div>
					</div>
				</div>
			</div>
		</main>
	</body>
</html>