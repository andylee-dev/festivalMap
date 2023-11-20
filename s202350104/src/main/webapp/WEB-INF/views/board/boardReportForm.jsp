<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<link href="/css/global.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	function closeWindow() {
	    window.close();
	}
	
	function checkMinLength(element, minLength) {
	    if (element.value.length < minLength) {
	        element.setCustomValidity('최소 ' + minLength + '글자 이상 입력하세요.');
	    } else {
	        element.setCustomValidity('');
	    }
	}
</script>
<style type="text/css">
	#report-container {
		position: relative;
		border: 1px solid #000;
		border-radius: 10px;
		background-color: white;
	}
	h1 {
		margin-top : 30px;
		color: black;
		font-size: 32px;
		font-family: Noto Sans;
		font-weight: 600;
		word-wrap: break-word
	}



</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<main class="col-10 offset-1">
				<h1 align="left">신고하기</h1>
					<hr class="hr" />	
					<c:if test="${userId == 0}">
					    <div class="container border p-5">
					        <div class="row">
					            <div class="col text-center">
					                <p>로그인 후 신고 가능합니다</p>
					            </div>
					        </div>
					        <div class="row">
					            <div class="col text-center">
					                <button class="btn btn-primary" onclick="closeWindow()">취소</button>
					            </div>
					        </div>
					    </div>
					</c:if>
					<c:if test="${userId != 0 }">
					
					<div>
					<form action="boardReportUpdate">
						
						<div class="table-container p-5" id="report-container">
						<table class="table table-bordered" style="border-radius: 10px;">
						<tr class="table">
							<th scope="col" style="text-align: center;">제목</th>
							<td style="background-color: white;">
							<input type="hidden" name="board_id" value="${board.id }">${board.title }</td>
							
							<th scope="col" style="text-align: center;">작성자</th>
							<td style="background-color: white;">
							<input type="hidden" name="user_id" value="${board.user_id }">${board.name }</td>
						</tr>
						
						<tr class="table">
							<th scope="col" style="text-align: center;">내용</th>
							<td colspan="3" style="background-color: white;">${board.content }</td>
						</tr>
						
						<%-- <tr class="table">
							<th scope="col" style="text-align: center;">신고내용</th>
							<td colspan="3"  style="background-color: white;">	
							<input type="hidden" name="id" value="${userId }">
							<input type="text" name="content" class="form-control" placeholder="신고내용을 입력하세요(10글자 이상)" minlength="10" required="required">	
							</td>
						</tr> --%>
						</table>
						
						<div class="mb-3">
  							<label for="exampleFormControlTextarea1" class="form-label">신고내용</label>
  								<input type="hidden" name="id" value="${userId }">
  								<textarea style="background-color: #F4F4F4;" class="form-control" name="content" id="exampleFormControlTextarea1" rows="2" 
  										 placeholder="신고내용을 입력하세요(10글자 이상)" oninput="checkMinLength(this, 10)" required></textarea>
						</div>
						
						<button type="submit" class="btn btn-primary" >신고</button>
						<button class="btn btn-primary" onclick="closeWindow()">취소</button>
					</div>
					</form>
					</div>
				</c:if>
			</main>		
		</div>
	</div>	
</body>
</html>