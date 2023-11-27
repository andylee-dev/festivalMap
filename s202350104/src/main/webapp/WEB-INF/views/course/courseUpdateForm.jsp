<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>course UpdateForm</title>

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
	};
	<!-- 태그 관련 코드 end -->
	
	function getSigungu(pArea){
		var pSigungu = ${experience.sigungu}
		$.ajax(
				{
					url:"<%=request.getContextPath()%>/getSigungu/"+pArea,
					dataType:'json',
					success:function(areas) {
						$('#sigungu_select option').remove();
						str = "<option value='999'>전체</option>";
						$(areas).each(
							function() {
								if(this.sigungu != 999 && this.content != null) {
									strOption = "<option value='"+this.sigungu+"' ${"+this.sigungu+" == "+pSigungu+"? 'selected':''}>"+this.content+"</option>";
									str += strOption;
								}
							}		
						)
						$('#sigungu_select').append(str);
					}
				}		
		)
	}
</script>

<script type="text/javascript">
	function closeAndRedirect() {
		// 취소 시 이전페이지 이동
		window.history.back();
	}
</script>

<script type="text/javascript">
	let oldList = [];
	let newList = [];
	
	// 컨텐츠 디테일 조회창을 열었을 때.
	function ContentPopUp() {
		console.log("ContentPopUp 함수 호출됨");
		
		//창 크기 지정
		var width = 800;
		var height = 600;
		
		//pc화면기준 가운데 정렬
		var left = (window.screen.width / 2) - (width/2);
		var top = (window.screen.height / 4);
		
		//윈도우 속성 지정
		var windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+', scrollbars=yes, status=yes, resizable=yes, titlebar=yes';
		
		//연결하고싶은url
		const url = '../../${cd_content.toLowerCase() }/detail?contentId=${content_id}';
	 	
		//등록된 url 및 window 속성 기준으로 팝업창을 연다.
		window.open(url, "content popup", windowStatus);
	}

	
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
		console.log("contentList", contentList);
		
		const contentsTableEl = document.getElementById("contentsTable");
		
		for (var i = 0; i < contentList.length; i++) {
			// newList에 contentList[i].id가 있다면 스킵.
	        if (getCurrentContentList().includes(contentList[i].id)) continue;

			// 테이블의 row 하나를 생성한다.
			const rowEl = makeCard(contentList[i]);
			
			// contentsTable에 row한줄 추가.
			contentsTableEl.appendChild(rowEl);
			console.log("contentsTableEl : ", contentsTableEl);
			console.log("rowEl : ", rowEl);
		}
	}
	
	function makeCard(content) {
	    // 카드를 위한 div 요소 생성
	    const cardEl = document.createElement("div");
	    cardEl.id = 'card'+content.id;
	    cardEl.className = "card course-card";
	    cardEl.style = "width: 208px; height: 340px; margin: 20px; padding: 18px;";

	 	// 카드 삭제 아이콘을 위한 div 요소 생성
	    const deleteIconContainerEl = document.createElement("div");
	    deleteIconContainerEl.className = "d-flex justify-content-end";

	    const deleteIconEl = document.createElement("i");
	    deleteIconEl.className = "bi bi-x-square-fill";
	    deleteIconEl.style = "color: #FF4379";
	    deleteIconEl.onclick = function(event) {
	      deleteContent(event);
	      event.preventDefault();
	    };

	    deleteIconContainerEl.appendChild(deleteIconEl);
	    cardEl.appendChild(deleteIconContainerEl);
		
	 	// <input> 요소 추가
	    const contentIdInputEl = document.createElement("input");
	    contentIdInputEl.type = "hidden";
	    contentIdInputEl.id = "content_id";
	    contentIdInputEl.value = content.id;
	    cardEl.appendChild(contentIdInputEl);
	    
	    // 카드 콘텐츠를 위한 요소 생성
	    const titleEl = document.createElement("h5");
	    titleEl.className = "card-title card-font-title";
	    titleEl.textContent = "컨텐츠 타입";
	    cardEl.appendChild(titleEl);

	    const imgEl = document.createElement("img");
	    imgEl.src = content.img;
	    imgEl.className = "card-image-size";
	    imgEl.alt = content.title;
	    cardEl.appendChild(imgEl);

	    const bodyEl = document.createElement("div");
	    bodyEl.className = "card-body";
	    bodyEl.style = "padding: 0px; padding-top: 16px;";

	    const cardTitleEl = document.createElement("h5");
	    cardTitleEl.className = "card-title card-font-title";
	    cardTitleEl.textContent = content.title;
	    bodyEl.appendChild(cardTitleEl);

	    const addressEl = document.createElement("p");
	    addressEl.className = "card-text card-font-content";
	    addressEl.textContent = content.address;
	    bodyEl.appendChild(addressEl);

	    const phoneEl = document.createElement("p");
	    phoneEl.className = "card-text card-font-content";
	    phoneEl.textContent = content.phone;
	    bodyEl.appendChild(phoneEl);

	    cardEl.appendChild(bodyEl);

	    const linkEl = document.createElement("div");
	    linkEl.className = "d-flex justify-content-end mt-auto";

	    const detailLink = document.createElement("a");
	    detailLink.href = "";
	    detailLink.className = "btn btn-primary card-button-style card-button-text";
	    detailLink.textContent = "상세정보보기";
	    linkEl.appendChild(detailLink);

	    cardEl.appendChild(linkEl);

	    return cardEl;
	}
	
	
	
	function getCurrentContentList() {
	
		// ID를 저장할 배열을 만듭니다.
		var idList = [];
	
		// contentsTable 테이블을 찾습니다.
		var contentsTable = document.getElementById("contentsTable");
		
		// contentsTable의 모든 card 요소를 가져옵니다.
	    var cards = contentsTable.getElementsByClassName("card");
		
		// 각 card의 ID를 idList 배열에 추가합니다.
	    for (var i = 0; i < cards.length; i++) {
	        // cardId에서 "card"를 제외한 부분을 가져와서 idList 배열에 추가합니다.
	        var cardId = cards[i].id.replace("card", "");
	        idList.push(cardId);
	    }

 		return idList;
 		console.log("idList : ", idList)
	}
	

	
	// 최종적으로 submit 눌렀을때, delList, addList 요소 추가.
	function submitHandler(){
		const finalList = getCurrentContentList();	
		console.log("getCurrentContentList() ->",getCurrentContentList());
		let delList = [];
 	    for (var i = 0; i < oldList.length; i++) {
	        if (!finalList.includes(oldList[i])) {
	        	delList.push(oldList[i]);
	        }
 	    }
 	    const addList = difference(finalList,oldList);
 	    
 	    console.log("finalList :", finalList)
 	    console.log("oldList :", oldList)
 	    
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
		
		console.log("oldList : ", oldList);
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

.card-image-size {
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
						<h1 class="course-header-text">코스 수정</h1>
					</div>
				</div>
				
				<!-- Section2: Table -->
				<div class="container mt-5" style="padding: 0px;">
					<form id="myForm" action="courseUpdate" method="post" enctype="multipart/form-data">
						<input type="hidden" name="id" value="${course.id}">
						<div class="form-group d-flex course-body-text col-12"
							 style="margin-bottom: 26px;">
							<label class="form-label col-2" for="course_title">코스명</label>
							<input type="text" id="course_title" name="course_title" class="form-control input-text" required="required" value="${course.course_title }">
						</div>
						
						<div class="form-group d-flex course-body-text col-12" id="detail-content-title" style="margin-bottom: 24px;">
						  <label for="small_code" class="form-label col-2">코스타입(필수 선택)</label>
						  	<input type="hidden" name="big_code" value="16">
						  	<div class="col-4" style="padding-right: 24px;">
							<select class="form-select" aria-label="small_code" name="small_code" required="required">
								<c:forEach var="smallCode" items="${listCodes }">
									<c:if test="${smallCode.big_code == 16 && smallCode.small_code != 999}">
										<option value="${smallCode.small_code}"${smallCode.small_code == course.small_code? 'selected':''} >${smallCode.content}</option>		
									</c:if>
								</c:forEach>
							</select>
							</div>
						</div>
						
						<div class="form-group d-flex course-body-text col-12" style="margin-bottom: 24px;">
							<label for="content" class="form-label col-2">지역(필수 선택)</label>
								
							<div class="row col-12">
							    <div class="col-2">
							        <select class="form-select" id="area" name="area" onchange="getSigungu(this.value)">
							            <option value="">전체</option>
							            <c:forEach var="areas" items="${listAreas}">
							                <c:if test="${areas.sigungu == 999}">
							                    <option value="${areas.area}" ${areas.area == course.area? 'selected':''}>${areas.content}</option>
							                </c:if>
							            </c:forEach>
							        </select>
							    </div>
							    <div class="col-2">
							        <select class="form-select" id="sigungu_select" name="sigungu">
							            <option value="999">전체</option>
							            <c:forEach var="areas" items="${listSigungu}">
							                <c:if test="${areas.sigungu != 999 && areas.sigungu != null}">
							                    <option value="${areas.sigungu}" ${areas.sigungu == course.sigungu? 'selected':''}>${areas.content}</option>
							                </c:if>
							            </c:forEach>
							        </select>
							    </div>
							</div>
							
							<!-- <div class="row col-12">
							    <div class="col-2">
							        <select name="area" class="form-select area-dropdown"></select>
							    </div>
							    <div class="col-2">
							       <select name="sigungu"  class="form-select sigungu-dropdown"></select>
							    </div>
							</div> -->
							
						</div>
						
						<div class="form-group course-body-text"
							 style="margin-bottom: 40px;">
							<label class="col-2" style="padding-bottom: 53px">코스항목</label>
							<button class="btn btn-primary button-submit-font button-submit-design" onclick="showPopUp(); event.preventDefault();">코스 수정</button>
							
							<div style="color: #FF4379; font-size: 16px; font-family: Noto Sans; font-weight: 600; word-wrap: break-word padding-bottom: 53px;">
								코스미리보기
								<i class="bi bi-arrow-right-circle-fill" style="color: #FF4379"></i>
							</div>
							<div style="width: 100%; height: auto; background: white; border-radius: 10px; border: 1px #FF4379 solid">
								
								<div id="contentsTable" class="d-flex flex-wrap" style="margin: 20px; padding: 20px;">
									<c:forEach var="courseContentList" items="${courseContentList }" varStatus="status">
										<div id="card${courseContentList.content_id}" class="card course-card" style="width: 208px; height: 340px; margin: 20px; padding: 18px;">
											<input type="hidden" id="content_id" value="${courseContentList.content_id}">
											<div class="d-flex justify-content-end">
										    	<i onclick="deleteContent(event)" class="bi bi-x-square-fill" style="color: #FF4379"></i>
											</div>
											<h5 class="card-title card-font-title">${courseContentList.cd_content }</h5>
											<img src="${courseContentList.img1 }" class="card-image-size" alt="${courseContentList.title }">
											<div class="card-body" style="padding: 0px; padding-top: 16px;">
												<h5 class="card-title card-font-title">${courseContentList.title }</h5>
												<p class="card-text card-font-content">${courseContentList.address }</p>
											</div>
											<div class="d-flex justify-content-end mt-auto">
												<a id="contentId${courseContentList.content_id}" class="btn btn-primary card-button-style card-button-text" onclick="ContentPopUp()">상세정보보기</a>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
						
						<div class="form-group d-flex course-body-text col-12"
							 style="margin-bottom: 24px;">
							<label class="form-label col-2" for="distance">거리(km)</label>
							<input type="text" id="distance" name="distance" class="form-control input-text" required="required" value="${course.distance }">
						</div>
						<div class="form-group d-flex course-body-text col-12"
							 style="margin-bottom: 24px;">
							<label class="form-label col-2" for="time">소요시간</label>
							<input type="text" id="time" name="time" class="form-control input-text" required="required" value="${course.time }">
						</div>
						<div class="form-group d-flex course-body-text"
							 style="margin-bottom: 24px;">
							<label class="col-2" for="course_info">코스 내용</label>
							<textarea class="form-control" id="course_info" name="course_info" rows="5">${course.course_info }</textarea>
						</div>
						<div class="text-center">
							<button type="submit" class="btn btn-primary button-submit-font button-submit-design" onclick="submitHandler()">확인</button>
							<button class="btn btn-secondary button-cancle-font button-cancle-design" onclick="closeAndRedirect()">취소</button>
							<button class="btn btn-primary button-submit-font button-submit-design" onclick="location.href='courseDelete?id=${course.id}'">삭제</button>
							
						</div>
					</form>
				</div>
				
				<!-- review test -->
				<div>
					<h3>review 구역</h3>
				</div>
			</main>
		</div>
	</div>
	
</body>
</html>