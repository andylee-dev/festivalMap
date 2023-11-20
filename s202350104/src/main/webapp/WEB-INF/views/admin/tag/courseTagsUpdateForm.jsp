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
			var courseId = Number($('#courseId').val());
			$.ajax({
				url: "<%=request.getContextPath()%>/getMyCourseTags",
				method: "GET",
				data: {courseId: courseId},
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
		}
		
		function updateTags() {
			var courseId = Number($('#courseId').val());
			var finalTags = [];
			for(var i = 0; i < selectedTags.length; i++) {
				finalTags.push(Number(selectedTags[i].id));
			}
			$.ajax({
				url: "<%=request.getContextPath()%>/admin/tag/courseTagsUpdate",
				method: "POST",
				data: {courseId: courseId,
					   tagId:     finalTags
					  },
				dataType: "text",
				success: function(str) {
					alert(str);
					location.href="<%=request.getContextPath()%>/admin/tag/courseTag";
				},
				error: function() {
					console.log("태그 정보를 가져오지 못했습니다.");
				}
			})
		}
		<!-- 태그 관련 코드 end -->
		</script>
	</head>
	
	<body>
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-grid-fill "></i>
					<label  class="admin-header-title ">코스태그관리</label>
					</div>
				</div>
				
				<input type="hidden" name="course_id" id="courseId" value="${courseId}">
		
					<!-- tag 선택 -->
					<div id="container">
						<select id="tagSelectBox" name="tag_id" onchange="event.preventDefault();">
						</select>
						<div id="tagsArea"><!-- 태그 badge가 들어갈 곳 --></div>
					</div>
					<button class="btn btn-primary" onclick="updateTags()">수정하기</button>
			</main>
		</div>
		</div>
	</body>
</html>