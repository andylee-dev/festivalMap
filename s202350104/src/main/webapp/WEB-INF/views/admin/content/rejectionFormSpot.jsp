<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>등록반려</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			// 폼 제출 후 팝업창 닫기
			function submitForm() {
				var submitForm = document.myForm;
				submitForm.action = "insertHistory?contentId=${spot.content_id}";
				submitForm.target = opener.name;
				submitForm.submit();
				alert("반려사유 등록이 완료되었습니다.");
				self.close(); // 팝업창 닫기
			}
		</script>
	</head>
	<body>
		<div class="container-fluid">
			<main>
				<div>
					<h1>반려사유 등록</h1>
				</div>
				
				<hr>
				
				<div class="container">
					<label>신청정보</label>
					<div class="container">
						<label>신청자ID</label>
						<div>${spot.user_id}</div>
						
						<button>계정확인</button>
						<label>신청일시</label>
						<div>${spot.created_at}</div>
						
						<label>희망게시위치</label>
						<div></div>
						<button>위치확인</button>
					</div>
				</div>
				<hr>
				<div class="container">
					<label>신청서</label>
					<div>
						${spot.bcode_content}
						${spot.scode_content}
						${spot.content_id}
						<c:if test="${spot.status == 0}">승인대기</c:if>
						<c:if test="${spot.status == 1 && spot.is_deleted != 1}">승인완료</c:if>
					</div>
					
					명소명<div>${spot.title}</div>
					영업시간<div>${spot.opening_hours}</div>
					휴무일<div>${spot.rest_date}</div>
					입장료<div>${spot.entrance_fee}</div>
					축제장소<div>${spot.area_content}</div>
					<div>${spot.sigungu_content}</div>
					<div>${spot.address}</div>
					홈페이지<div>${spot.homepage}</div>
					명소 개요<div>${spot.content}</div>
					부대/편의 시설<div></div>
					등록 이미지<div></div>
					등록 태그<div></div>
						
					<form name="myForm" id="myForm" method="post">
						<input type="hidden" name="target_id" value="${spot.content_id}">
						<input type="hidden" name="big_code" value="${spot.big_code}">
						<input type="hidden" name="small_code" value="${spot.small_code}">
						<input type="text"   name="title" placeholder="제목을 입력해주세요."><p>
						<textarea rows="20" cols="100" id="content" name="content" placeholder="반려 사유를 입력해주세요."></textarea>
						<div>
							<button type="button" onclick="submitForm();">반려사유 등록 완료</button>
							<button type="button">대기(임시저장)</button>
							<button type="button">승인전환</button>
							<button type="button">삭제</button>
						</div>
					</form>
				</div>
			</main>
		</div>
	</body>
</html>