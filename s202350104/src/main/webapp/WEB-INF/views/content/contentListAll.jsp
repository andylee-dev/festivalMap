<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!-- jQuery 라이브러리 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Course_contents</title>
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
		                homepage: columns[5].textContent,
		                phone: columns[6].textContent
		            };

		            contentList.push(contentData);
		            console.log(contentData);
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
    }
    
    /* 테이블 셀 가운데 정렬 */
    td, th {
        text-align: center;
    }
    
    /* 테이블 헤더 고정 너비 설정 */
    th.check {
        width: 50px; /* 원하는 너비로 설정해주세요 */
    }
	
	
	</style>
</head>
<body>
<div class="container-fluid">
	<main>
		<!-- Section1: Title -->
		<div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
			<h1>여행 코스의 컨텐츠를 추가 해주세요</h1>
		</div>
		
		<!-- Section2: Search Form -->		
		<div class="border p-3 m-3">
			<h1 class="border">검색폼</h1>
			<button type="button" class="btn btn-outline-secondary">검색</button>
			<button type="button" class="btn btn-outline-secondary">초기화</button>
			<button type="button" class="btn btn-outline-secondary" onclick="getcheckboxValue()">확인</button>
			
		</div>
		
		
		<!-- Section3: Table -->		
		<div class="border p-3 m-3">
			<table class="table table-striped table-sm">
				<tr>
			        <th class="check">선택</th>
			        <th class="id">번호</th>
			        <th class="img1">사진</th>
			        <th class="title">이름</th>
			        <th class="address">주소</th>
			        <th class="homepage">홈페이지</th>
			        <th class="phone">연락처</th>
				</tr>
				<c:forEach var="content" items="${listContents }" varStatus="status">
					<tr>
						<td><input class="parent-container child-container outer-circle inner-circle" style="padding: 0px;" type="checkbox" name="content" value="${content.id}"></td>
						<td>${content.id }</td>
						<td><img src="${content.img1 }" alt="${content.title }" class="card-img-top" style="height: 150px;"></td>
						<td>${content.title }</td>
						<td>${content.address }</td>
						<td>${content.homepage }</td>
						<td>${content.phone }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		
	</main>
</div>
</body>
</html>