<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>포인트 등록</title>
		<link rel="stylesheet" type="text/css" href="/css/adminContentsDetail.css">
		<script src="/js/updateArea.js"></script>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<style type="text/css">
		
		#detail-top-container {
			position: absolute;
			width: 250px;
			height: 83px;
			border-radius: 10px;
			border: 1px solid #000;
			flex-shrink: 0;
			top: -35px; /* B의 상단에 A를 위치시키기 위해 top을 0으로 설정 */
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
			word-wrap: break-word;
		}	
		
		#detail-top-id2{
			color: #BDEB50;
			font-family: Noto Sans;
			font-size: 16px;
			font-style: normal;
			font-weight: 600;
			line-height: normal;
			letter-spacing: -0.48px;
			padding-top: 5px;
			word-wrap: break-word;
		}	
		
		#detail-main-container {
			position: relative;
			border: 1px solid #000;
			border-radius: 10px;
			background-color: white;
		}
		.detail-body-container {
			justify-content: center;
			padding-right: 0;
			padding-left: 0;
			margin-right: 0;
			margin-left: 0;
		}
		.form-label{
			color: #000;
			font-family: Noto Sans;
			font-size: 16px;
			font-style: normal;
			font-weight: 600;
			line-height: normal;
		}
		h1 {
			color: black;
			font-size: 32px;
			font-family: Noto Sans;
			font-weight: 600;
			word-wrap: break-word
		}
		h3 {
			color: #FF4379;
			font-size: 24px;
			font-family: Noto Sans;
			font-weight: 600;
			word-wrap: break-word
		}
		
		.btn-primary2 {
		    background-color: #9BDB04; 
		    border-color: #9BDB04; 
		    color: white;
		}
		
		.btn-primary2:hover {
		    background-color: #52525C ; 
		    border-color: #52525C; 
		    color: #9BDB04;
		}
		</style>
	</head>
	<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
		<main class="col-10 p-0">
			<div class="admin-header-container">
				<div class="container m-4">
					<i class="title-bi bi bi-pencil-square "></i>
				<label  class="admin-header-title ">포인트 등록</label>	
				</div>
			</div>
			<div class="container my-5" id="detail-body-container">
				<div>
				<h1>포인트 등록</h1>
				<hr class="hr" />
				</div>
				<div>
				<h3 style="color: #FF4379 ">포인트 등록하기</h3>
				</div>
				<div class="my-5">
				<div class="" id="detail-main-container">
				
  		 <div class="container p-5" id="form-container">
        <form action="writePoint" method="post">
        <div class="mb-3 ">
            <input type="hidden" name="id" value="${point.id}" />
            <label for="title" class="form-label">포인트 제목</label>
            <input type="text" class="form-control" id="title" name="title" value="${point.title}">
        </div>
        <div class="mb-3 ">
            <label for="content" class="form-label">포인트 내용</label>
            <textarea class="form-control" name="content" id="content" rows="3" placeholder="포인트 설명을 입력해주세요 ">${point.content}</textarea>
        </div>
        <div class="mb-3 ">
            <label for="point" class="form-label">포인트 점수</label>
            <input type="text" class="form-control" id="point" name="point" value="${point.point}">
        </div>
           <div class="row">
    	<div class="col-1 mb-3">
        <button type="submit" class="form-control btn btn-primary w-100">등록</button>
    	</div>
   		 <div class="col-1 mb-3">
        <button type="button" class="form-control btn btn-primary w-100" onclick="location.href='../point/point'">취소</button>
        </div>
        </div>
		</form>
		</div>
		</div>
		</div>
		</div>
		</main>
		</div>
    </div>
</body>
</html>
