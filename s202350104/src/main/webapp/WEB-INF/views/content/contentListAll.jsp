<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- jQuery 라이브러리 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Content List</title>
<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/updateArea.js"></script>
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
		updateAreaOptions();
		$(".area-dropdown").change(function() {
			const selectedArea = $(this).val();
			if (selectedArea) {
				updateSigunguOptions(selectedArea);
			} else {
				$(".sigungu-dropdown").empty().append("<option value='0'>전체</option>");
			}
		});
	});
</script>

	<script type="text/javascript">
		function getcheckboxValue(){
		    const checkboxes = document.getElementsByName("content");
		    const contentList = [];

		    for (let i = 0; i < checkboxes.length; i++) {
		        if (checkboxes[i].checked) {
		        	const row = checkboxes[i].closest("tr");
		            const columns = row.querySelectorAll("td"); // 로우의 모든 컬럼

		            const contentData = {
		                id: checkboxes[i].value, // 체크박스의 값
		                img: columns[2].querySelector("img").getAttribute("src"),
		                title: columns[3].textContent,
		                address: columns[4].textContent,
		                /* homepage: columns[5].textContent, */
		                phone: columns[5].textContent
		            };

		            contentList.push(contentData);
		            console.log("contentList-popup", contentList);
		            
		        }
		    }			
		    // 데이터를 원래 페이지로 전송
		    window.opener.receiveContentList(contentList);

		    // 팝업 창 닫기
		    window.close();
		}
	</script>
	<style type="text/css">
	
	.parent-container {
        width: 100%;
        height: 100%;
        padding: 8px;
        justify-content: center; /* 가로 가운데 정렬 */
        align-items: center; /* 세로 가운데 정렬 */
        gap: 8px;
        display: flex;
    }
    
    .child-container {
        width: 16px;
        height: 16px;
        position: relative;
    }
    
    .outer-circle {
        width: 16px;
        height: 16px;
        left: 0;
        top: 0;
        position: absolute;
        background: #FF4379;
        border-radius: 50%;
    }
    
    .inner-circle {
        width: 6px;
        height: 6px;
        left: 5px;
        top: 5px;
        position: absolute;
        background: white;
        border-radius: 50%;
    }
    
    /* 체크박스 스타일 */
    input[type="checkbox"] {
        /* 체크박스의 외곽선 제거 */
        outline: none;
        /* 체크박스의 기본 스타일 제거 */
        appearance: none;
        -webkit-appearance: none;
        -moz-appearance: none;
        /* 체크박스 크기 조정 */
        width: 16px;
        height: 16px;
        /* 체크박스 배경색 설정 */
        background-color: transparent;
        /* 체크박스 커서 설정 */
        cursor: pointer;
        /* 체크박스 위치 설정 */
        position: relative;
    }
    
    /* 체크박스의 가상 선택자 스타일 설정 */
    input[type="checkbox"]::before {
        /* 체크박스의 외곽선 제거 */
        outline: none;
        /* 체크박스의 기본 스타일 제거 */
        appearance: none;
        -webkit-appearance: none;
        -moz-appearance: none;
        /* 체크박스 크기 조정 */
        width: 16px;
        height: 16px;
        /* 체크박스 배경색 설정 */
        background-color: transparent;
        /* 체크박스 위치 설정 */
        position: absolute;
        /* 체크박스 가상 선택자 스타일 설정 */
        content: "";
        /* 체크박스 가상 선택자 스타일 설정 - 외곽선 */
        border: 2px solid #FF4379;
        /* 체크박스 가상 선택자 스타일 설정 - 모양 */
        border-radius: 50%;
    }
    
    /* 체크박스의 가상 선택자 스타일 설정 - 체크된 상태 */
    input[type="checkbox"]:checked::before {
        /* 체크박스 가상 선택자 스타일 설정 - 배경색 */
        background-color: #FF4379;
        /* 체크박스 가상 선택자 스타일 설정 - 모양 */
        border-radius: 50%;
    }
    
    /* 체크박스 숨김 처리 */
    input[type="checkbox"] + label {
        display: none;
    } */
    
    /* 테이블 셀 가운데 정렬 */
    td, th {
        text-align: center;
    }
	
	</style>
</head>
<body>
<div class="container-fluid">
	<div class="row">
		<main class="col-12 overflow-auto p-0">
			
			<!-- Section1: Title -->
			<div class="container mt-5">
				<div class="d-flex justify-content-between col-12 flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="course-header-text">코스 등록</h1>
				</div>
			</div>
			
			<!-- Section2: Search Form -->		
			<!-- <div class="border p-3 m-3">
				<h1 class="border">검색폼</h1>
				<button type="button" class="btn btn-outline-secondary">검색</button>
				<button type="button" class="btn btn-outline-secondary">초기화</button>
				<button type="button" class="btn btn-outline-secondary" onclick="getcheckboxValue()">확인</button>
				
			</div> -->
			
			<!-- Section2: Search Form -->		
				<div class="container col-9 justify-content-center my-5">
				    <form action="" method="POST" class="container justify-content-center">
				    
				    <!-- 검색어 -->
			            <div class="col-12 my-4 d-flex align-items-center">
			                <label for="searchType" class="col-form-label col-2  mx-2">검색어</label>
			                <div class="col-3 d-flex align-items-center">
				                <select id="searchType" name="searchType" class="form-select">
				                    <option value="" selected>코스이름</option>
				                </select>
			                </div>
			                <div class="col-5 mx-2">
				                <input type="text" name="keyword" class="form-control" value="${keyword}">
			                </div>
			            </div>
			            
			            <div class="col-12 my-4 d-flex align-items-center">
					    	<label for="searchType" class="col-form-label col-2 mx-2">지역</label>
						        <div class="col-3 d-flex align-items-center">
									<select name="area" class="area-dropdown form-select"></select>
								</div>
								<div class="col-3 mx-2 d-flex align-items-center">
									<select name="sigungu" class="sigungu-dropdown form-select"></select><p>
								</div>
						</div>
						
						<div class="container col-10 d-flex justify-content-center">
								<button type="submit" class="btn btn-primary col-2 mx-3">검색</button>
								<button type="reset"  class="btn btn-outline-secondary col-2 mx-3">초기화</button>
								<button type="button" class="btn btn-primary col-2 mx-3" onclick="getcheckboxValue()">추가</button>
						</div>
					</form>
				</div>
			
			<!-- Section3: Table -->
			<div class="container col-12 justify-content-center align-items-center mb-2 p-3 pt-0">
				<div class="container table-container p-4">
					<div class="table-responsive">
						<table id="userTable" class="table table-md text-center p-3">
							<thead>
								<tr>
							        <th class="check">선택</th>
							        <th class="id">번호</th>
							        <th class="img1">사진</th>
							        <th class="title">이름</th>
							        <th class="address">주소</th>
							        <th class="phone">연락처</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="content" items="${listContents }" varStatus="status">
									<tr>
										<td style="white-space: normal;"><input class="parent-container child-container outer-circle inner-circle" style="padding: 0px; width: 40px;" type="checkbox" name="content" value="${content.id}"></td>
										<td style="white-space: normal;">${content.id }</td>
										<td style="white-space: normal;"><img src="${content.img1 }" alt="${content.title }" class="card-img-top" style="height: 100px; width: 150px;"></td>
										<td style="white-space: normal;">${content.title }</td>
										<td style="white-space: normal;">${content.address }</td>
										<td style="white-space: normal;">${content.phone }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
			<nav aria-label="Page navigation example ">
				<ul class="pagination">
					<c:if test="${page.startPage > page.pageBlock}">
						<li class="page-item">
							<a href="contentListAll?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
						</li>
					</c:if>
					<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
						<li class="page-item">
							<a href="contentListAll?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
						</li>
					</c:forEach>
					<c:if test="${page.endPage < page.totalPage}">
						<li class="page-item">
							<a href="contentListAll?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
						</li>
					</c:if>
				</ul>
			</nav>
			
		</main>
	</div>
</div>
</body>
</html>