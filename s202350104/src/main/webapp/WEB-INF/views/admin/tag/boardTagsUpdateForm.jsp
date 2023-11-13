<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
		var selectedTags = []; // 선택한 옵션을 저장할 배열 선언 --> 초기에 DB에 저장되어 있던 태그 모두 저장
		var tagOptions = []; // 선택할 수 있는 옵션을 저장할 배열 선언 --> existingTags에 있는 요소 제외하고 모두 저장
		
		document.addEventListener("DOMContentLoaded", function() { 

			<!-- 태그 관련 코드 Start -->
			
			const tagsArea = document.querySelector('#tagsArea');
			
			initialTagOptions();
			updateTagOptions();
			$('#tagSelectBox').change(function() {
				alert("addTag() start...");
				alert("selectedTags size => "+selectedTags.length);
				alert("tagOptions size => "+tagOptions.length);
				
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
				for(var i = 0; i < selectedTags.length; i++) {
					if(selectedTags[i].id === selectedTag.id) {
						isDuplicate = true;
						alert("i=>"+i);
						break;
					}
				}
				
				// 배열에 없었던 태그일 경우에만 추가
				if(!isDuplicate) {
					alert("!isDuplicate");
					selectedTags.push(selectedTag); 
					
					var index = -1;
					for(var i = 0; i < selectedTags.length; i++) {
						if(selectedTags[i].id === selectedTag.id) {
							index = i;
							break;
						}
					}
					
					if(index !== -1) {
						tagOptions.splice(index, 1); // 선택한 태그 목록(existingTags)에서 삭제
					}
					
					// 태그 뱃지 생성
					const newTag = document.createElement('span');
					newTag.className = "badge bg-primary";
					newTag.textContent = selectedTag.name;
					newTag.id = selectedTag.id;
					
					// x버튼 및 클릭시의 이벤트 생성
					const closeButton = document.createElement('button');
					closeButton.className = "btn-close";
					closeButton.setAttribute('aria-label', 'Close');
					closeButton.addEventListener('click', (event) => {
						event.preventDefault();
						var deletedTag = {
							id: event.target.parentElement.id,
							name: event.target.parentElement.textContent
						}
						alert("deletedTag.id => "+deletedTag.id);
						alert("deletedTag.name => "+deletedTag.name);
						alert("selectedTags size => " + selectedTags.length);
						tagOptions.push(deletedTag); // select box의 option 목록에 삭제된 태그 다시 추가
						
						// 삭제할 옵션의 인덱스 찾기
						var index = -1;
						for(var i = 0; i < selectedTags.length; i++) {
							if(selectedTags[i].id === deletedTag.id) {
								index = i;
								break;
							}
						}
						
						if(index !== -1) {
							selectedTags.splice(index, 1); // 선택한 태그 목록(existingTags)에서 삭제
							event.target.parentElement.remove(); // badge 삭제
						}
						
						updateTagOptions();
						
					});
					
					newTag.appendChild(closeButton);
					tagsArea.appendChild(newTag);
					
					tagOptions.splice(tagOptions.indexOf(selectedTag.id),1); // 선택한 태그를 select box option에서 삭제
					updateTagOptions(); // select box의 option을 업데이트하는 method
				}
				
			});
		
		});
		
		// 초기에 모든 tag options를 가져옴
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
					console.log("태그 정보를 가져오지 못했습니다.");
				}
			})
		} 
		
			// selectedTags를 제외한 select box의 tag options update
		function updateTagOptions() {
			var contentId = document.getElementById('contentId').value;
			
			$.ajax({
				url: "<%=request.getContextPath()%>/getMyContentTags",
				method: "GET",
				data: {contentId : contentId},
				dataType: "json",
				success: function(tags) {
					$("#tagSelectBox").empty().append("<option value='0'>태그를 선택해주세요.</option>");
					tagOptions.forEach(function(tag) {
						var check = 0;
						for(var i = 0; i < tags.length; i++) {
							if(tags[i].id === tag.id) {
								check = 1;
								var selectedTag = {
									id: tag.id,
									name: tag.name 
								};
								selectedTags.push(selectedTag);
								// 태그 뱃지 생성
								const newTag = document.createElement('span');
								newTag.className = "badge bg-primary";
								newTag.textContent = selectedTag.name;
								newTag.id = selectedTag.id;
								
								// x버튼 및 클릭시의 이벤트 생성
								const closeButton = document.createElement('button');
								closeButton.className = "btn-close";
								closeButton.setAttribute('aria-label', 'Close');
								closeButton.addEventListener('click', (event) => {
									event.preventDefault();
									var deletedTag = {
										id: event.target.parentElement.id,
										name: event.target.parentElement.textContent
									}
									alert("deletedTag.id => "+deletedTag.id);
									alert("deletedTag.name => "+deletedTag.name);
									alert("selectedTags size => " + selectedTags.length);
									tagOptions.push(deletedTag); // select box의 option 목록에 삭제된 태그 다시 추가
									
									// 삭제할 옵션의 인덱스 찾기
									var index = -1;
									for(var i = 0; i < selectedTags.length; i++) {
										if(selectedTags[i].id === deletedTag.id) {
											index = i;
											break;
										}
									}
									
									if(index !== -1) {
										selectedTags.splice(index, 1); // 선택한 태그 목록(existingTags)에서 삭제
										event.target.parentElement.remove(); // badge 삭제
									}
									
									updateTagOptions();
									
								});
								
								newTag.appendChild(closeButton);
								tagsArea.appendChild(newTag);
								
								const index = tagOptions.indexOf(tag.id);
								tagOptions.splice(index, 1);
								break;
							}
						}
						if(check == 0) {
							$("#tagSelectBox").append("<option value='"+tag.id+"'>"+tag.name+"</option>");
						}	
					})
					console.log("updateTagOptions() success");	
				},
				error: function() {
					console.log("태그 정보를 가져오지 못했습니다.");
				}
						
			});
					
		}
		
		// tags 수정 정보 insert 및 delete 후 페이지 이동
		function updateTags() {			
			$.ajax({
				url: "<%=request.getContextPath()%>/admin/tag/contentTagsUpdate",
				data: JSON.stringify(selectedTags),
				method: "POST",
				dataType: "text",
				success: function(str) {
					alert(str);
					location.href="<%=request.getContextPath()%>/admin/tag/contentTag";
				},
				error: function() {
					console.log("태그 수정에 실패했습니다.");
				}
			})
		}
		
		<!-- 태그 관련 코드 end -->
		</script>
	</head>
		<body>
		<div id="allTags" data-tags="${listAllTags}"></div>
		
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">게시글 태그 관리</h1>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="border p-3 m-3" data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
					<table class="table table-striped table-sm">
						<tr>
							<th>게시글 번호</th>
							<td>${board.id}</td>
						</tr>
						<tr>
							<th>분류</th>
							<td>${board.big_code}</td>
						</tr>
						<tr>
							<th>제목</th>
							<td>${board.title}</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>${board.name}</td>
						</tr>
						<tr>
							<th>작성일</th>
							<td><fmt:formatDate value="${board.created_at}" type="date" pattern="YY/MM/dd"/></td>
						</tr>
						<tr>
							<th>내용</th>
							<td>${board.content}</td>
						</tr>
					</table>
					
					<!-- tag 선택 -->
					<form action="">
					<!-- tag 선택 -->
					<div id="container">
						<select id="tagSelectBox" name="tag_id" onchange="event.preventDefault();">
						</select>
						<div id="tagsArea"><!-- 태그 badge가 들어갈 곳 --></div>
					</div>
					<button class="btn btn-primary" onclick="updateTags()">수정하기</button>
					</form>
					
				</div>
			</main>
		</div>
		</div>
		
	</body>
</html>