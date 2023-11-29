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
			let allTags = []; // 전체 태그 정보를 모두 가져와 저장
			let myTagsArea;

			
			document.addEventListener("DOMContentLoaded", (event) => {
				
				myTagsArea = document.querySelector('#my_tags'); // 저장한 태그 버튼을 보여줄 박스
				allTagOptions();	
				initialSelectedTags(); // DB에 이미 저장되어 있던 tags만 selectedTags에 저장
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

		</script>
	</head>
	<body>
		<!-- Top bar -->
		<%@ include file="/WEB-INF/components/TobBar.jsp"%>
		<main>
			<div class="d-flex">
				<div class="col-2">
				<%@ include file="/WEB-INF/components/MyPageSideBar.jsp"%>
				</div>
				<div class="container p-5 col-10">
					<div class="container my-5">
						<div class="col-11">
							<h1>내 관심사(태그)</h1>
						</div>
						<div class="col-11 align-items-center">
							<hr class="hr">
						</div>
						<div class="container col-10 justify-content-center mt-5">
							<form action="list" method="GET" class="container justify-content-center">
								<!-- 검색 -->
								<div class="col-12 my-4 d-flex align-items-center">
									<label for="searchType" class="col-form-label col-1  mx-2">태그찾기</label>
									<div class="col-8 mx-1">
										<input type="text" name="keyword" class="form-control" id="searchForm" 
										 placeholder="키워드를 입력해주세요." autocomplete="off" list="autoTags">
										<datalist id="autoTags">
											<c:forEach var="tag" items="${listAllTags}">
												<option id="${tag.id}" value="${tag.name}">
											</c:forEach>
										</datalist>
									</div>
									<!-- 버튼 -->
									<div class="col-5 mx-1 d-flex justify-content-start">
										<button type="button" class="btn btn-primary col-2 mx-1" onclick="addTag()">저장</button>
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