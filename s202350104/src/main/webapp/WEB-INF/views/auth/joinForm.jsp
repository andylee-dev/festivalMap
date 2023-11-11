<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
		
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			document.addEventListener("DOMContentLoaded", function () {
			    const badgeSelect = document.querySelector('#badgeSelect');
			    const addBadgeBtn = document.querySelector('#addBadgeBtn');
			    const badgesArea = document.querySelector('#badgesArea');
			
			    // Initialize the list of available badges
			    const availableBadges = Array.from(badgeSelect.options).map(option => option.value).filter(value => value !== '');
			
			    addBadgeBtn.addEventListener('click', () => {
			      if (badgeSelect.value !== '') {
			        // Create a new badge and add it to the page
			        const newBadge = document.createElement('span');
			        newBadge.className = 'badge bg-primary';
			        newBadge.textContent = badgeSelect.value;
			
			        const closeButton = document.createElement('button');
			        closeButton.className = 'btn-close';
			        closeButton.setAttribute('aria-label', 'Close');
			        closeButton.addEventListener('click', (event) => {
			          // When the badge is deleted, add its value back to the select box
			          const deletedBadgeValue = event.target.parentElement.textContent.trim();
			          availableBadges.push(deletedBadgeValue);
			          updateSelectOptions();
			          event.target.parentElement.remove();
			        });
			
			        newBadge.appendChild(closeButton);
			        badgesArea.appendChild(newBadge);
			
			        // Remove the added badge's value from the select box
			        availableBadges.splice(availableBadges.indexOf(badgeSelect.value), 1);
			        updateSelectOptions();
			        badgeSelect.value = '';
			      }
			    });
			
			    function updateSelectOptions() {
			      badgeSelect.innerHTML = '<option value="">Select a badge</option>';
			      availableBadges.forEach(badge => {
			        const option = document.createElement('option');
			        option.value = badge;
			        option.textContent = badge;
			        badgeSelect.appendChild(option);
			      });				
			    }
			});
		</script>
	</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<h1>일반회원 회원가입</h1>
	<div class="container border p-5">
		<form action="/signUp" method="post">
			<input type="hidden" name="status" value="1">
			<input type="hidden" name="big_code" value="1">
			<input type="hidden" name="small_code" value="2">
			<input type="hidden" name="point" value="0">
			<input type="hidden" name="file_name" value="">
			아이디 <input type="text" name="id" placeholder="아이디를 입력하세요"><p>
			비밀번호 <input type="password" name="password" placeholder="비밀번호를 입력하세요"><p>
			비밀번호 확인 <input type="password" placeholder="비밀번호를 다시 한 번 입력하세요"><p>
			이름 <input type="text" name="name"><p>
			닉네임 <input type="text" name="nickname"><p>
			성별 <input type="radio" name="gender" value="0">남자
				<input type="radio" name="gender" value="1">여자<p>
			생년월일 <input type="date" name="birthday"><p>
			전화번호 <input type="tel" name="phone_num" placeholder="010 - 0000 - 0000"
					pattern="\d{2,3}-\d{3,4}-\d{4}"><p>
			이메일 <input type="email" name="email"><p> <!-- 이메일 도메인 주소를 select할 수 있도록 바꾸기 -->
			주소 <!-- 우편번호 검색 api 및 기본주소 자동입력 -->
				<input type="text" name="address"><p>
			관심사
	  			<div class="container">
				  <select id="badgeSelect" name="tag_id">
				    <option value="">태그를 선택해주세요.</option>
				    <c:forEach var="tag" items="${listTags}">
				    	<option value="${tag.id}">${tag.name}</option>
				    </c:forEach>
				    <!-- Add more options as needed -->
				  </select>
				  <button id="addBadgeBtn">Add Badge</button>
				  <div id="badgesArea">
				    <!-- New badges will be added here -->
				  </div>
				</div>
			<button type="submit" class="btn btn-primary">회원가입</button>
			<button type="reset" class="btn btn-light">초기화</button>
		</form>
	</div>

	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>