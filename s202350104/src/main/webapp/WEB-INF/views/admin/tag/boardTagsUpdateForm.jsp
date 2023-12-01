<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style type="text/css">
			.detail-body-container {
				justify-content: center;
				padding-right: 0;
				padding-left: 0;
				margin-right: 0;
				margin-left: 0;
			}
			
			h1 {
				color: #000;
				font-family: Noto Sans;
				font-size: 32px;
				font-style: normal;
				font-weight: 600;
				line-height: normal;
				letter-spacing: -0.96px;
			}
			
			#detail-main-container {
				position: relative;
				border: 1px solid #000;
				border-radius: 10px;
				background-color: white;
			}
			
			#detail-top-container {
				position: absolute;
				width: 250px;
				height: 83px;
				border-radius: 10px;
				border: 1px solid #000;
				flex-shrink: 0;
				top: -40px; /* B의 상단에 A를 위치시키기 위해 top을 0으로 설정 */
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
				white-space: nowrap; /* 줄바꿈을 방지 */
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
				white-space: nowrap; /* 줄바꿈을 방지 */
			}
			
			
			.form-label{
				color: #000;
				
				font-family: Noto Sans;
				font-size: 16px;
				font-style: normal;
				font-weight: 600;
				line-height: normal;
			}
			
			.form-input[disabled] {
				color: #000;
				border: 0px solid #F4F4F4;
				border-radius: 10px;
				background: #F4F4F4;
				font-family: Noto Sans;
				font-size: 24px;
				font-style: normal;
				font-weight: 400;
				line-height: normal;
				letter-spacing: -0.72px;
			}
			
			.form-input {
				color: #000;
				border: 1px solid ;
				border-radius: 10px;
				font-family: Noto Sans;
				font-size: 24px;
				font-style: normal;
				font-weight: 400;
				line-height: normal;
				letter-spacing: -0.72px;
			}
			
			#tagsArea {
				color: #000;
				border: 1px solid ;
				border-radius: 10px;
				padding: 10px;
			}
		</style>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			var selectedTags = []; // 선택한 옵션을 저장할 배열 선언 --> 초기에 DB에 저장되어 있던 태그 모두 저장
			var tagOptions = []; // 선택할 수 있는 옵션을 저장할 배열 선언 --> existingTags에 있는 요소 제외하고 모두 저장
			var allTags = [];
			
			document.addEventListener("DOMContentLoaded", (event) => {
	
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
				var boardId = Number($('#boardId').val());
				$.ajax({
					url: "<%=request.getContextPath()%>/getMyBoardTags",
					method: "GET",
					data: {boardId: boardId},
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
						console.log("getMyBoardTags success");
					},
					error: function() {
						console.log("게시글 태그 정보를 가져오지 못했습니다.");
					}
				})
			}
			
			function updateTagOptions() {
				$("#tagSelectBox").empty().append("<option value='0'>태그를 선택해주세요.</option>");
				tagOptions.forEach(function(tag) {
					$("#tagSelectBox").append("<option value='"+tag.id+"'>"+tag.name+"</option>");
				});
				console.log("updateTagOptions() success");
			};
			
			function newTagBadge(selectedTag) {
				// 태그 뱃지 생성 
				const newTag = document.createElement('button');
				newTag.className = "btn btn-primary align-items-center";
				newTag.value = selectedTag.name;
				newTag.innerHTML = "#" +selectedTag.name;
				newTag.id = selectedTag.id;
					
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
			
			function updateTags() {
				confirm('정말 수정하시겠습니까?') {
					var boardId = Number($('#boardId').val());
					var finalTags = [];
					for(var i = 0; i < selectedTags.length; i++) {
						finalTags.push(Number(selectedTags[i].id));
					}
					$.ajax({
						url: "<%=request.getContextPath()%>/admin/tag/boardTagsUpdate",
						method: "POST",
						data: {boardId: boardId,
							   tagId:   finalTags
							  },
						dataType: "text",
						success: function(str) {
							alert(str);
							location.href="<%=request.getContextPath()%>/admin/tag/boardTag";
						},
						error: function() {
							console.log("태그 정보를 가져오지 못했습니다.");
						}
					})
				}	
			}
			<!-- 태그 관련 코드 end -->
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
						<i class="title-bi bi bi-grid-fill "></i>
					<label  class="admin-header-title ">게시글태그관리</label>
					</div>
				</div>
				
				<!-- Section2: Insert Form -->		
				<div id="detail-body-container" class="container col-9 my-5">
					<div>
						<h1>태그수정</h1>
					</div>
					<div>
						<hr>
					</div>
					<div class="my-5">
						<div class="" id="detail-main-container">
							<div class="container p-5 mx-3" id="form-container">
								<div class="form-row d-flex justify-content-between">
									<div class="col-md-11 mb-3 px-2">
										<label for="id" class="form-label">번호</label>
										<input type="text" class="form-control form-input" id="boardId"
										 name="id" value="${board.id}" disabled>
									</div>
								</div>
								<div class="form-row d-flex justify-content-between">
									<div class="col-md-11 mb-3 px-2">
										<label for="title" class="form-label">이름</label>
										<input type="text" class="form-control form-input" id="title"
										 name="title" value="${board.title}" disabled>
									</div>
								</div>
								<div class="form-row d-flex justify-content-between">
									<div class="col-md-11 mb-4 px-2">
										<label for="group_name" class="form-label col-md-1">태그추가</label>
										<input type="text" name="group_name" class="form-control form-input col-9" id="searchForm" 
										 placeholder="키워드를 입력해주세요." autocomplete="off" list="autoTags" value="${tags.group_name}">
										<%-- <img class="keyword-img align-self-center mx-1" src="<%=request.getContextPath()%>/image/icon_search1.png" 
										 alt="icon_search1.png" id="searchIcon" onclick="addTag()"/> --%>
										<datalist id="autoTags">
											<c:forEach var="tag" items="${listAllTags}">
												<option id="${tag.id}" value="${tag.name}">
											</c:forEach>
										</datalist>
									</div>
								</div>
								<div id="form-row d-flex justify-content-between">
									<div class="col-md-11 mb-3 px-2" id="tagsArea"><!-- 태그 badge가 들어갈 곳 --></div>
								</div>
								<div align="center" class="mt-3">
									<button type="button" class="btn btn-primary" onclick="updateTags()">수정</button>
									<button type="button" class="btn btn-outline-secondary" onclick="location.href='<%=request.getContextPath()%>/admin/tag/boardTag'">목록</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
		</div>	
	</body>
</html>