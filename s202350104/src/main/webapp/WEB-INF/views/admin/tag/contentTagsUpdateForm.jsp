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
			document.addEventListener("DOMContentLoaded", function() {
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
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">컨텐츠 태그 관리</h1>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="border p-3 m-3" data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
					<table class="table table-striped table-sm">
						<tr>
							<th>컨텐츠 번호</th>
							<td>${contents.id}</td>
						</tr>
						<tr>
							<th>분류</th>
							<td>${contents.big_code} ${contents.small_code}</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>${contents.title}</td>
						</tr>
						<tr>
							<th>지역</th>
							<td>${contents.area} ${contents.sigungu}</td>
						</tr>
					</table>
					
					<!-- tag 선택 -->
					<div class="container">
						<select id="badgeSelect" name="tag_id">
							<option value="">태그를 선택해주세요.</option>
							<c:forEach var="tag" items="${listAllTags}">
								<option value="${tag.id}">${tag.name}</option>
							</c:forEach>
							<!-- Add more options as needed -->
						</select>
						<button id="addBadgeBtn">Add Badge</button>
						<div id="badgesArea">
							<!-- New badges will be added here -->
							<c:if test="${listMyTags != null}">
								<c:forEach var="mytag" items="${listMyTags}">
									${mytag.name}
								</c:forEach>
							</c:if>
						</div>
					</div>
					
					<!-- 수정/목록 버튼 -->
					
				</div>
			</main>
		</div>
		</div>
	</body>
</html>