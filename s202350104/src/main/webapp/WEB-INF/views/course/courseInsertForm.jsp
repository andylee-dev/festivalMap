<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>course Insert</title>

<!-- 부트스트랩 5.3.1-->
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
<script src="/js/updateArea.js"></script>
<script type="text/javascript">
	var selectedTags = []; // 선택한 옵션을 저장할 배열 선언 --> 초기에 DB에 저장되어 있던 태그 모두 저장
	var tagOptions = []; // 선택할 수 있는 옵션을 저장할 배열 선언 --> existingTags에 있는 요소 제외하고 모두 저장
	
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
		const tagsArea = document.querySelector('#tagsArea');
		
		// content insert시에는 초기에 모든 tags 리스트를 가져와서 tagOptions에 저장
		initialTagOptions();
		
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
				updateTagOptions();
			},
			error: function() {
				console.log("태그 정보를 가져오지 못했습니다.");
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
	}
	<!-- 태그 관련 코드 end -->
</script>

<script type="text/javascript">
	function closeAndRedirect() {
		// 취소 시 이전페이지 이동
		window.history.back();
	}
</script>

<!-- <script type="text/javascript">
	function showPopUp() {
	
		//창 크기 지정
		var width = 800;
		var height = 600;
		
		//pc화면기준 가운데 정렬
		var left = (window.screen.width / 2) - (width/2);
		var top = (window.screen.height / 4);
		
		//윈도우 속성 지정
		var windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+', scrollbars=yes, status=yes, resizable=yes, titlebar=yes';
		
		//연결하고싶은url
		const url = "contentListAll"
		
		//등록된 url 및 window 속성 기준으로 팝업창을 연다.
		window.open(url, "contentList popup", windowStatus);
	}
	
	function receiveContentList(contentList) {
		
	    // contentList 데이터를 HTML 테이블로 변환
	    /* var table = "<table>";
	    table += "<thead><tr><th>ID</th><th>이미지</th><th>이름</th><th>주소</th><th>홈페이지</th><th>연락처</th></tr></thead>";
	    table += "<tbody>";

	    for (var i = 0; i < contentList.length; i++) {
	        table += "<tr>";
	        table += "<td>" + contentList[i].id + "</td>";
	        table += "<td><img src='" + contentList[i].img + "' alt='이미지' style='height: 150px;'></td>";
	        table += "<td>" + contentList[i].title + "</td>";
	        table += "<td>" + contentList[i].address + "</td>";
	        table += "<td>" + contentList[i].homepage + "</td>";
	        table += "<td>" + contentList[i].phone + "</td>";
	        table += "</tr>";
	    }

	    table += "</tbody></table>"; */

	    // 테이블을 HTML 요소에 삽입
	    /* document.getElementById("contentTable").innerHTML = table; */
		
	    var cardContainer = "";

		for (var i = 0; i < contentList.length; i++) {
		  var card = '<div class="card course-card" style="width: 208px; height: 340px; margin: 20px; padding: 18px;">';
		  card += '<h5 class="card-title card-font-title">' + contentList[i].contentType + '</h5>';
		  card += '<img src="' + contentList[i].img + '" class="card-image-size" alt="...">';
		  card += '<div class="card-body" style="padding: 0px; padding-top: 16px;">';
		  card += '<h5 class="card-title card-font-title">' + contentList[i].title + '</h5>';
		  card += '<p class="card-text card-font-content">' + contentList[i].address + '</p>';
		  card += '<p class="card-text card-font-content">' + contentList[i].content + '</p>';
		  card += '</div>';
		  card += '<div class="d-flex justify-content-end mt-auto">'; // 버튼을 오른쪽에 배치하기 위한 추가된 div
		  card += '<a href="" class="btn btn-primary card-button-style card-button-text">상세정보보기</a>'; // 버튼 추가
		  card += '</div>'; // 추가된 div 닫기
		  card += '</div>';
		
		  cardContainer += card;
		}
		
		document.getElementById("cardContainer").innerHTML = cardContainer;
	    
	    
	    for (var i = 0; i < contentList.length; i++) {
	    	const form =document.getElementById("myForm");
	    	const hiddenInput = document.createElement("input");
	    	hiddenInput.type = "hidden";
	    	hiddenInput.name = "contents";
	    	hiddenInput.value = contentList[i].id;
	    	form.appendChild(hiddenInput);
	    }
	}
</script> -->


<script type="text/javascript">
    let oldList = []; // 이전 목록을 저장하기 위한 배열
    let newList = []; // 새로운 목록을 저장하기 위한 배열

    function showPopUp() {
        console.log("showPopUp 함수 호출됨");
        console.log("course_id value:", "${course.course_id}");

        var width = 800;
        var height = 600;

        var left = (window.screen.width / 2) - (width/2);
        var top = (window.screen.height / 4);

        var windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+', scrollbars=yes, status=yes, resizable=yes, titlebar=yes';

        const url = 'contentListAll?course_id=${course.course_id}';

        window.open(url, "contentList popup", windowStatus);
    }

    function receiveContentList(contentList) {
        console.log("contentList", contentList);

        for (var i = 0; i < contentList.length; i++) {
            if (getCurrentContentList().includes(contentList[i].id)) continue; // 이미 목록에 있는 경우 스킵

            const rowEl = makeCard(contentList[i]); // 카드 요소 생성

         	// 수정: cardContainer에 생성한 카드 추가
            const cardContainer = document.getElementById("cardContainer");
            cardContainer.appendChild(rowEl);

            console.log("rowEl : ", rowEl);
            
            /* document.body.appendChild(rowEl); // 생성한 카드 요소를 body에 추가
            console.log("rowEl : ", rowEl); */
        }
    }

    function makeCard(content) {
        const cardEl = document.createElement("div"); // 카드 요소 생성
        cardEl.id = 'card'+content.id; // 고유한 id 부여
        cardEl.className = "card course-card"; // 클래스 추가
        cardEl.style = "width: 208px; height: 340px; margin: 20px; padding: 18px;"; // 스타일 지정

        const deleteIconContainerEl = document.createElement("div"); // 삭제 아이콘 컨테이너 요소 생성
        deleteIconContainerEl.className = "d-flex justify-content-end"; // 클래스 추가

        const deleteIconEl = document.createElement("i"); // 삭제 아이콘 요소 생성
        deleteIconEl.className = "bi bi-x-square-fill"; // 클래스 추가
        deleteIconEl.style = "color: #FF4379"; // 스타일 지정
        deleteIconEl.onclick = function(event) { // 삭제 아이콘 클릭 이벤트 핸들러
            deleteContent(event); // 삭제 함수 호출
            event.preventDefault();
        };

        deleteIconContainerEl.appendChild(deleteIconEl); // 삭제 아이콘 요소를 컨테이너에 추가
        cardEl.appendChild(deleteIconContainerEl); // 컨테이너를 카드 요소에 추가

        const contentIdInputEl = document.createElement("input"); // 숨겨진 input 요소 생성
        contentIdInputEl.type = "hidden"; // 타입 설정
        contentIdInputEl.id = "content_id"; // id 설정
        contentIdInputEl.value = content.id; // 값 설정
        cardEl.appendChild(contentIdInputEl); // input 요소를 카드 요소에 추가

        const titleEl = document.createElement("h5"); // 제목 요소 생성
        titleEl.className = "card-title card-font-title"; // 클래스 추가
        titleEl.textContent = "컨텐츠 타입"; // 텍스트 설정
        cardEl.appendChild(titleEl); // 제목 요소를 카드 요소에 추가

        const imgEl = document.createElement("img"); // 이미지 요소 생성
        imgEl.src = content.img; // 이미지 소스 설정
        imgEl.className = "card-image-size"; // 클래스 추가
        imgEl.alt = content.title; // 대체 텍스트 설정
        cardEl.appendChild(imgEl); // 이미지 요소를 카드 요소에 추가

        const bodyEl = document.createElement("div"); // 본문 요소 생성
        bodyEl.className = "card-body"; // 클래스 추가
        bodyEl.style = "padding: 0px; padding-top: 16px;"; // 스타일 지정

        const cardTitleEl = document.createElement("h5"); // 카드 제목 요소 생성
        cardTitleEl.className = "card-title card-font-title"; // 클래스 추가
        cardTitleEl.textContent = content.title; // 텍스트 설정
        bodyEl.appendChild(cardTitleEl); // 카드 제목 요소를 본문 요소에 추가

        const addressEl = document.createElement("p"); // 주소 요소 생성
        addressEl.className = "card-text card-font-content"; // 클래스 추가
        addressEl.textContent = content.address; // 텍스트 설정
        bodyEl.appendChild(addressEl); // 주소 요소를 본문 요소에 추가

        const phoneEl = document.createElement("p"); // 전화번호 요소 생성
        phoneEl.className = "card-text card-font-content"; // 클래스 추가
        phoneEl.textContent = content.phone; // 텍스트 설정
        bodyEl.appendChild(phoneEl); // 전화번호 요소를 본문 요소에 추가

        cardEl.appendChild(bodyEl); // 본문 요소를 카드 요소에 추가

        const linkEl = document.createElement("div"); // 링크 요소 생성
        linkEl.className = "d-flex justify-content-end mt-auto"; // 클래스 추가

        const detailLink = document.createElement("a"); // 상세 정보 링크 요소 생성
        detailLink.href = ""; // 링크 설정
        detailLink.className = "btn btn-primary card-button-style card-button-text"; // 클래스 추가
        detailLink.textContent = "상세정보보기"; // 텍스트 설정
        linkEl.appendChild(detailLink); // 상세 정보 링크 요소를 링크 요소에 추가

        cardEl.appendChild(linkEl); // 링크 요소를 카드 요소에 추가

        return cardEl; // 생성한 카드 요소 반환
    }

    function getCurrentContentList() {
        var idList = [];

        var cards = document.getElementsByClassName("card"); // 클래스명이 "card"인 요소들을 가져옴

        for (var i = 0; i < cards.length; i++) {
            var cardId = cards[i].id.replace("card", ""); // "card" 부분을 제거하여 id 추출
            idList.push(cardId); // id를 배열에 추가
        }

        return idList; // id 목록 반환
        console.log("idList : ", idList)
    }
	
 	// 최종적으로 submit 눌렀을때, delList, addList 요소 추가.
    function submitHandler() {
        const finalList = getCurrentContentList(); // 현재 목록 가져오기
        console.log("getCurrentContentList() ->", getCurrentContentList());
        let delList = [];
        for (var i = 0; i < oldList.length; i++) {
            if (!finalList.includes(oldList[i])) {
                delList.push(oldList[i]);
            }
        }
        const addList = difference(finalList, oldList); // 추가 목록과 삭제 목록 구하기

        console.log("finalList :", finalList);
        console.log("oldList :", oldList);
		
     	// form input에 hidden 요소를 넣는다. 
        for (var i = 0; i < addList.length; i++) {
            const form = document.getElementById("myForm"); // 폼 요소 가져오기
            const hiddenInput = document.createElement("input"); // 숨겨진 input 요소 생성
            hiddenInput.type = "hidden"; // 타입 설정
            hiddenInput.name = "contents"; // 이름 설정
            hiddenInput.value = addList[i]; // 값 설정
            form.appendChild(hiddenInput); // input 요소를 폼에 추가
        }
		
     	// form input에 hidden 요소를 넣는다.
        for (var i = 0; i < delList.length; i++) {
            const form = document.getElementById("myForm"); // 폼 요소 가져오기
            const hiddenInput = document.createElement("input"); // 숨겨진 input 요소 생성
            hiddenInput.type = "hidden"; // 타입 설정
            hiddenInput.name = "contents"; // 이름 설정
            hiddenInput.value = delList[i]; // 값 설정
            form.appendChild(hiddenInput); // input 요소를 폼에 추가
        }

        alert('submitHandler');
    }

    function difference(list1, list2) {
        return list1.filter(item => !list2.includes(item)); // list1에는 포함되고 list2에는 포함되지 않는 요소들을 반환
    }

    function deleteContent(event) {
        event.target.parentElement.parentElement.remove(); // 클릭한 요소의 부모 요소 제거
    }

    document.addEventListener('DOMContentLoaded', function() {
        oldList = getCurrentContentList(); // 초기 목록 가져오기

        console.log("oldList : ", oldList);
    });
</script>


<style type="text/css">
.course-card {
	width: 100%; 
	height: 100%; 
	background: #F4F4F4; 
	border-radius: 10px
}

.course-body-text {
	width: 100%; 
	color: black; 
	font-size: 16px; 
	font-family: Noto Sans; 
	font-weight: 600; 
	word-wrap: break-word
}

.course-header-text {
	color: black; 
	font-size: 32px; 
	font-family: Noto Sans; 
	font-weight: 600; 
	word-wrap: break-word
}

.input-text {

	align-self: stretch; 
	padding-left: 16px; 
	padding-right: 16px; 
	padding-top: 14px; 
	padding-bottom: 14px; 
	background: white; 
	border-radius: 10px; 
	border: 1px #DEE2E6 solid; 
	justify-content: flex-start; 
	align-items: center; 
	gap: 8px; display: inline-flex
}

.button-submit-design{
	width: 123px; 
	height: 43px; 
	padding-left: 24px; 
	padding-right: 24px; 
	padding-top: 16px; 
	padding-bottom: 16px; 
	background: #FF4379; 
	border-radius: 10px; 
	border: 1px #D9D9D9 solid; 
	justify-content: center; 
	align-items: center; 
	gap: 8px; 
	display: inline-flex
}

.button-cancle-design{
	width: 123px; 
	height: 43px; 
	padding-left: 24px; 
	padding-right: 24px; 
	padding-top: 16px; 
	padding-bottom: 16px; 
	background: #FFFFFF; 
	border-radius: 10px; 
	border: 1px #D9D9D9 solid; 
	justify-content: center; 
	align-items: center; 
	gap: 8px; 
	display: inline-flex
}


.button-submit-font {
	color: white; 
	font-size: 14px; 
	font-family: Noto Sans; 
	font-weight: 600; 
	line-height: 18px; 
	word-wrap: break-word
}

.button-cancle-font {
	color: black; 
	font-size: 14px; 
	font-family: Noto Sans; 
	font-weight: 600; 
	line-height: 18px; 
	word-wrap: break-word
}

.card-image-size{
	width: 172px; 
	height: 111px; 
	background: #D9D9D9;
}

.card-font-title {
	width: 100%; 
	color: black; 
	font-size: 14px; 
	font-family: Noto Sans; 
	font-weight: 600; 
	word-wrap: break-word;
}

.card-font-content {
	color: black; 
	font-size: 12px; 
	font-family: Noto Sans; 
	font-weight: 500; 
	line-height: 16px; 
	word-wrap: break-word;
}

.card-button-text {
	text-align: center; 
	color: #6D6A6A; 
	font-size: 12px; 
	font-family: Noto Sans; 
	font-weight: 400; 
	word-wrap: break-word"
}

.card-button-style {
	width: 100px; 
	height: 29px; 
	background: #D9D9D9; 
	border-radius: 5px
}


</style>
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
						<label class="admin-header-title">코스 관리</label>					
					</div>
				</div>
				
				<div class="container mt-5">
					<div class="d-flex justify-content-between col-12 flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
						<h1 class="course-header-text">코스 등록</h1>
					</div>
				</div>
				
				<!-- Section2: Table -->	
				<div class="container mt-5" style="padding: 0px;">
					<form id="myForm" action="courseInsert" method="post" enctype="multipart/form-data">
						<div class="form-group d-flex course-body-text col-12"
							 style="margin-bottom: 26px;">
							<label class="form-label col-2" for="course_title">코스명</label>
							<input type="text" class="form-control input-text" id="course_title" name="course_title" required="required">
						</div>
						
						<div class="form-group d-flex course-body-text col-12"
							 style="margin-bottom: 24px;">
							<label class="form-label col-2">지역</label>
							<select name="area" class="area-dropdown"></select>
							<select name="sigungu"  class="sigungu-dropdown"></select>
						</div>
							
						<div class="form-group course-body-text"
							 style="margin-bottom: 40px;">
							<label class="col-2" style="padding-bottom: 53px">코스 등록</label>
							<button class="btn btn-primary button-submit-font button-submit-design" onclick="showPopUp()">코스 추가</button>
							
							<div style="color: #FF4379; font-size: 16px; font-family: Noto Sans; font-weight: 600; word-wrap: break-word padding-bottom: 53px;">
								코스미리보기
								<i class="bi bi-arrow-right-circle-fill" style="color: #FF4379"></i>
							</div>
							<div style="width: 100%; height: auto; background: white; border-radius: 10px; border: 1px #FF4379 solid">
								<div id="cardContainer" class="d-flex flex-wrap" style="margin: 20px; padding: 20px;">
									
								</div>
							</div>
						</div>
						
						<div class="form-group d-flex course-body-text col-12"
							 style="margin-bottom: 24px;">
							<label class="form-label col-2" for="distance">거리(km)</label>
							<input type="text" class="form-control input-text" id="distance" name="distance" required="required">
						</div>
						
						<div class="form-group d-flex course-body-text col-12"
							 style="margin-bottom: 24px;">
							<label class="form-label col-2" for="time">소요시간</label>
							<input type="text" class="form-control input-text" id="time" name="time" required="required">
						</div>
						
						<div class="form-group d-flex course-body-text"
							 style="margin-bottom: 24px;">	
							<label  class="col-2" for="course_info">코스 내용</label>
							<textarea class="form-control" id="course_info" name="course_info" rows="5"></textarea>
						</div>
						
						<div class="form-group d-flex course-body-text col-12"
							 style="margin-bottom: 24px;">
							<label class="form-label col-2">태그</label>
							<select id="tagSelectBox" name="tag_id" onchange="event.preventDefault();"></select>
								<div id="tagsArea">
									<!-- 태그 badge가 들어갈 곳 -->
								</div>
						</div>
						
						<div class="text-center">
							<button type="submit" class="btn btn-primary button-submit-font button-submit-design" onclick="submitHandler()">등록</button>
							<button class="btn btn-secondary button-cancle-font button-cancle-design" onclick="closeAndRedirect()">취소</button>
						</div>
						
					</form>
				</div>
			</main>
		</div>
	</div>
</body>
</html>