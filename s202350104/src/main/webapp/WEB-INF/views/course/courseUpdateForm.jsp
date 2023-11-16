<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>course UpdateForm</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous">
</script>

<!-- jQuery 라이브러리 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
	function closeAndRedirect() {
		// 취소 시 이전페이지 이동
		window.history.back();
	}
</script>

<script type="text/javascript">
	let oldList = [];
	let newList = [];

	// 3. 컨텐츠 등록 창을 열었을 때.
	function showPopUp() {
		 console.log("showPopUp 함수 호출됨");
		 console.log("course_id value:", ${course.course_id});
		
		//창 크기 지정
		var width = 800;
		var height = 600;
		
		//pc화면기준 가운데 정렬
		var left = (window.screen.width / 2) - (width/2);
		var top = (window.screen.height / 4);
		
		//윈도우 속성 지정
		var windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+', scrollbars=yes, status=yes, resizable=yes, titlebar=yes';
		
		//연결하고싶은url
		const url = 'contentListAll?course_id=${course.course_id}';
	 	
		 //등록된 url 및 window 속성 기준으로 팝업창을 연다.
		window.open(url, "contentList popup", windowStatus);
	}
	
	//4. popup창에서 받은 데이터 리스트.
	function receiveContentList(contentList) {
		
		const contentsTableEl = document.getElementById("contentsTable");
		
		for (var i = 0; i < contentList.length; i++) {
			// newList에 contentList[i].id가 있다면 스킵.
	        if ( getCurrentContentList().includes(contentList[i].id)) continue;

			// 테이블의 row 하나를 생성한다.
			const rowEl = makeTableRow(contentList[i]);
			
			// contentsTable에 row한줄 추가.
			contentsTableEl.appendChild(rowEl);
		}
	}
	
	// 5. 테이블의 row하나 생성.
	function makeTableRow(content){
        const tableEl = document.createElement("tr");
		
		const idEl = document.createElement("td");
		idEl.className = "td-id";
		idEl.textContent = content.id;
		tableEl.appendChild(idEl);
		
		const imgEl = document.createElement("td");
		imgEl.className = "td-img";
		
		// 이미지 URL을 사용하여 img 요소를 생성하고 src 속성을 설정합니다.
        const imgTag = document.createElement("img");
        imgTag.src = content.img;
        // 이미지의 높이를 150px로 설정합니다.
        imgTag.style.height = "150px";
        imgEl.appendChild(imgTag);
        tableEl.appendChild(imgEl);
		
		const titleEl = document.createElement("td");
		titleEl.className = "td-title";
		titleEl.textContent = content.title;
		tableEl.appendChild(titleEl);
		
		const addressEl = document.createElement("td");
		addressEl.className = "td-address";
		addressEl.textContent = content.address;
		tableEl.appendChild(addressEl);
		
		const homepageEl = document.createElement("td");
		homepageEl.className = "td-homepage";
		homepageEl.textContent = content.homepage;
		tableEl.appendChild(homepageEl);
		
		const phoneEl = document.createElement("td");
		phoneEl.className = "td-phone";
		phoneEl.textContent = content.phone;
		tableEl.appendChild(phoneEl);
		
		// 새로운 td 요소를 만들어 버튼을 추가합니다.
        const deleteButtonTd = document.createElement("td");
        const deleteButton = document.createElement("button");
        deleteButton.textContent = `삭제${content.id}`;
        deleteButton.onclick = function() {
        	deleteContent(event);
            event.preventDefault();
        };
        deleteButton.className = "btn btn-primary";
        deleteButtonTd.appendChild(deleteButton);
        tableEl.appendChild(deleteButtonTd);		

        return tableEl;
	}
	
	
	
	function getCurrentContentList() {
	
		// ID를 저장할 배열을 만듭니다.
		var idList = [];
	
		// contentsTable 테이블을 찾습니다.
		var contentsTable = document.getElementById("contentsTable");
	
		// contentsTable의 모든 tr 요소를 가져옵니다.
		var rows = contentsTable.getElementsByTagName("tr");
	
		// 첫 번째 행은 헤더이므로 1부터 시작합니다.
		for (var i = 1; i < rows.length; i++) {
		    // 현재 행에서 td 요소를 찾습니다.
		    var cells = rows[i].getElementsByTagName("td");
	
		    // ID가 있는 첫 번째 셀을 가져와서 idList 배열에 추가합니다.
		    var id = cells[0].textContent;
		    idList.push(id);
		}

 		return idList;
	}
	

	
	// 최종적으로 submit 눌렀을때, delList, addList 요소 추가.
	function submitHandler(){
		const finalList = getCurrentContentList();	
		let delList = [];
 	    for (var i = 0; i < oldList.length; i++) {
	        if (!finalList.includes(oldList[i])){
	        	delList.push(oldList[i]);
	        }
 	    }
 	    const addList = difference(finalList,oldList);
 	    
 	    console.log("delList ->",delList);
 	    console.log("addList ->",addList);

 	    // form input에 hidden 요소를 넣는다. 
 	    for (var i = 0; i < addList.length; i++) {
	    	const form =document.getElementById("myForm");
	    	const hiddenInput = document.createElement("input");
	    	hiddenInput.type = "hidden";
	    	hiddenInput.name = "addList";
	    	hiddenInput.value = addList[i];
	    	form.appendChild(hiddenInput);
	    }			

 		// form input에 hidden 요소를 넣는다.
 	    for (var i = 0; i < delList.length; i++) {
	    	const form =document.getElementById("myForm");
	    	const hiddenInput = document.createElement("input");
	    	hiddenInput.type = "hidden";
	    	hiddenInput.name = "delList";
	    	hiddenInput.value = delList[i];
	    	form.appendChild(hiddenInput);
	    }			
 	    
 	    
 	   alert('submitHandler')
	};

	function difference(list1, list2) {
	    return list1.filter(item => !list2.includes(item));
	}
	
	function removeValue(list, value) {
	    let index = list.indexOf(value);
	    if (index !== -1) {
	        list.splice(index, 1);
	    }
	}
	// 화면table에서 삭제버튼 누른 요소를 제거.
	function deleteContent(event){
	    event.target.parentElement.parentElement.remove();
	}
	
	// 1. 처음에 html이 다 만들어 지고 난 이후에 실행.
	document.addEventListener('DOMContentLoaded', function() {
		oldList = getCurrentContentList();
	});
	
	
</script>
<script type="text/javascript">
	/* function deleteCourseContent(content_id, course_id) {
		$.ajax({
			type: 'POST',
			url:  'deleteCourseContentAjax',
			data: {content_id: content_id, course_id: course_id},
			success : function(result) {
				// // 성공적으로 삭제된 경우의 처리
				alert('삭제되었습니다.')
				location.reload();
			},
			error: function(xhr, status, error) {
				//오류 발생 시의 처리
				alert('삭제에 실패했습니다.');
			}
		});
	} */
	
	
	/* function deleteCourseContent(content_id, course_id) {
		alert(content_id)
		alert(course_id)
 	    // ContentCourse 객체를 생성하고 필드에 값을 할당
 	    var courseContent = {
 	    	course_id: course_id,
 	        content_id: content_id
 	    };

 	    $.ajax({
 	        url: "/admin/course/deleteCourseContentAjax",
 	        method: "POST",
 	        contentType: "application/json", 
 	        data: JSON.stringify(courseContent), // Contents 객체를 data에 할당
 	        success: function(deleteCourseContentStr) {
 	        	console.log(deleteCourseContentStr)
				// 성공적으로 삭제된 경우의 처리
				alert('삭제되었습니다.')
 				location.reload();
			},
			error: function(xhr, status, error) {
				console.log(xhr,status,error)
				//오류 발생 시의 처리
				alert('삭제에 실패했습니다.');
 				location.reload();
			}
 	    });
 	} */
	
</script>

</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	
	<!-- Add the following lines for debugging -->
	<script type="text/javascript">
		console.log("course_id value:", ${course.id});
	</script>
	
	<h1>코스 수정${courseContent.id }</h1>
	<div class="container mt-5">
		<form id="myForm" action="courseUpdate" method="post" enctype="multipart/form-data">
			<input type="hidden" name="id" value="${course.id}">
			<div class="form-group">
				<label for="course_title">코스 명</label>
				<input type="text" id="course_title" name="course_title" class="form-control" required="required" value="${course.course_title }">
			</div>
				<div class="form-group">
					<label>코스항목</label>
					<button class="btn btn-primary" onclick="showPopUp(); event.preventDefault();">코스 수정</button>
					
					<div>
						<table border="1" id="contentsTable">
							<tr>
								<th>ID</th><th>이미지</th><th>이름</th><th>주소</th><th>홈페이지</th><th>연락처</th>
							</tr>
							<c:forEach var="courseContentList" items="${courseContentList }" varStatus="status">
								<tr>
									<td>${courseContentList.content_id }</td>
									<td><img alt="${courseContentList.title }" src="${courseContentList.img1 }" style="height: 150px;"></td>
									<td>${courseContentList.title }</td>
									<td>${courseContentList.address }</td>
									<td>${courseContentList.homepage }</td>
									<td>${courseContentList.phone }</td>
									<td><button onclick="deleteContent(event); event.preventDefault();" class="btn btn-primary">삭제${courseContentList.content_id}</button></td>
								</tr>
							</c:forEach>
							
						</table>
					</div>
				</div>
			
			<div class="form-group">
				<label for="distance">거리(km)</label>
				<input type="text" id="distance" name="distance" class="form-control" required="required" value="${course.distance }">
			</div>
			<div class="form-group">
				<label for="time">소요시간</label>
				<input type="text" id="time" name="time" class="form-control" required="required" value="${course.time }">
			</div>
			<div class="form-group">
				<label for="course_info">코스 내용</label>
				<textarea class="form-control" id="course_info" name="course_info" rows="5">${course.course_info }</textarea>
			</div>
			<div class="text-center">
				<button type="submit" class="btn btn-primary" onclick="submitHandler()">확인</button>
				<button class="btn btn-secondary" onclick="closeAndRedirect()">취소</button>
				<button class="btn btn-primary" onclick="location.href='courseDelete?id=${course.course_id}'">삭제</button>
			</div>
		</form>
	</div>
	
	<!-- review test -->
	<div>
		<h3>review 구역</h3>
	</div>
	
</body>
</html>