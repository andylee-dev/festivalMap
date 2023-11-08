<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.js"></script>
	<%@ include file="/WEB-INF/components/AdminUpdateAreas.jsp"%>
	<script type="text/javascript">
	    $(document).ready(function() {
			const dateFormat = {
		          singleDatePicker: true, // 시작 날짜만 선택
		          linkedCalendars: false, // 두 개의 독립된 달력 사용
		          autoApply: true, // 날짜를 선택하면 자동으로 적용
		          locale: {
		            format: 'yyyy-MM-DD',
		          },
		        }
	        const onChangeDate = () => {
	            const date = $('input[name="date-options"]:checked').val();
	            let value = [];
	            if (date === "TO") {
	                value = [moment(), moment()]; // 오늘 선택
	            } else if(date === "1W"){
	            	value = [moment(moment()).subtract(1,"W"),moment()];
	            } else if (date === "1M"){
	            	value = [moment(moment()).subtract(1,"M"),moment()];		            	
	            } else if (date === "3M"){
	            	value = [moment(moment()).subtract(3,"M"),moment()];		            	
	            } else if (date === "6M"){
	            	value = [moment(moment()).subtract(6,"M"),moment()];		            	
	            } else if (date === "ALL"){
	            	value = [];
	            }
	            if(value && value.length > 0){
	                $('#startDatePicker').val(value[0].format('yyyy-MM-DD'));
	                $('#endDatePicker').val(value[1].format('yyyy-MM-DD'));
	            } else{
		            $('#startDatePicker').val('');
		            $('#endDatePicker').val('');
	            }
            }
	        $('#startDatePicker').daterangepicker(dateFormat);
	        $('#endDatePicker').daterangepicker(dateFormat);
	        $('input[name="date-options"]').change(onChangeDate);
	        onChangeDate();        
	    }); 
	</script>
</head>
<body >
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp"%>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
				<!-- Section1: Title -->
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">일반 회원 리스트 </h1>
				</div>

				<!-- Section2: Search Form -->
				<div class="border p-3 m-3 ">
					<h1 class="border">검색폼</h1>
					<form action="/admin/user/userList" method="POST">
						<input type="hidden" name="small_code" value="2">						
						<div class="input-group mb-3">
							<span class="input-group-text col-auto" >검색어</span>
							<select name="searchType" class="form-select col-auto">
								<option selected value="name">사용자 이름</option>
								<option value="email">이메일</option>
								<option value="nickname">닉네임</option>
							</select>
							<input type="text" name="keyword" class="form-control col-auto">
						</div>
						<div class="input-group col-auto mb-3" >
						   <span class="input-group-text col-auto">가입기간</span>
						    <input type="radio" class="btn-check" name="date-options" id="TO" value="TO" autocomplete="off" >
						    <label class="btn" for="TO">오늘</label>
						    <input type="radio" class="btn-check" name="date-options" id="1W" value="1W" autocomplete="off">
						    <label class="btn" for="1W">1주일</label>
						    <input type="radio" class="btn-check" name="date-options" id="1M" value="1M" autocomplete="off">
						    <label class="btn" for="1M">1개월</label>
						    <input type="radio" class="btn-check" name="date-options" id="3M" value="3M" autocomplete="off">
						    <label class="btn" for="3M">3개월</label>
						    <input type="radio" class="btn-check" name="date-options" id="6M" value="6M" autocomplete="off">
						    <label class="btn" for="6M">6개월</label>
						    <input type="radio" class="btn-check" name="date-options" id="ALL" value="ALL" autocomplete="off" checked>
						    <label class="btn" for="ALL">전체</label>
							<input type="date" id="startDatePicker" name="startDate" value="">
							<input type="date" id="endDatePicker" name="endDate" value="">
						</div>
						
						<div class="input-group mb-3">
							<span class="input-group-text col-auto" >지역</span>
							<select name="area" id="area" class="form-select col-auto"></select> 
							<select name="sigungu" id="sigungu" class="form-select col-auto"></select>
						</div>
						<div class="input-group mb-3 d-flex align-items-center">
							<span class="input-group-text " >탈퇴 유무</span>
							<div class="form-check mx-2">
							  <input class="form-check-input" type="radio" name="is_deleted" id="is_deleted1" value='' checked >
							  <label class="form-check-label" for="is_deleted1">전체 회원</label>
							</div>
							<div class="form-check mx-2">
							  <input class="form-check-input" type="radio" name="is_deleted" id="is_deleted3" value="0">
							  <label class="form-check-label" for="is_deleted3">가입 회원</label>
							</div>
							<div class="form-check mx-2">
							  <input class="form-check-input" type="radio" name="is_deleted" id="is_deleted2" value="1">
							  <label class="form-check-label" for="is_deleted2">탈퇴 회원</label>
							</div>
						</div>
	
						<button type="submit" class="btn btn-outline-secondary">검색</button>
						<button type="reset" class="btn btn-outline-secondary">초기화</button>
					
					</form>
				</div>

				<!-- Section3: Table -->
				<div class="border p-3 m-3">
					<button type="button" class="btn btn-outline-secondary ">등록</button>
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">id</th>
								<th scope="col">name</th>
								<th scope="col">password</th>
								<th scope="col">nickname</th>
								<th scope="col">birthday</th>
								<th scope="col">phone_num</th>
								<th scope="col">email</th>
								<th scope="col">address</th>
								<th scope="col">status</th>
								<th scope="col">created_at</th>
								<th scope="col">is_deleted</th>
								<th scope="col">수정</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="user" items="${listUsers}" varStatus="st">
								<tr id="user${st.index}">
									<td>${user.id}</td>
									<td>${user.name}</td>
									<td>${user.password}</td>
									<td>${user.nickname}</td>
									<td>${user.birthday}</td>
									<td>${user.phone_num}</td>
									<td>${user.email}</td>
									<td>${user.address}</td>
									<td>${user.status}</td>
									<td><fmt:formatDate value="${user.created_at}" type="date" pattern="YY/MM/dd"/></td>
									<td>${user.is_deleted}</td>
									<td><input type="button" value="수정"></td>
									<td><input type="button" value="삭제"></td>
								</tr>
								<c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>

					<div align="center">
						<c:if test="${page.startPage > page.pageBlock}">
							<a href="userList?small_code=2&keyword=${searchOption.keyword}&is_deleted=${searchOption.is_deleted}&startDate=${searchOption.startDate}&endDate=${searchOption.endDate}&currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<a href="userList?small_code=2&keyword=${searchOption.keyword}&is_deleted=${searchOption.is_deleted}&startDate=${searchOption.startDate}&endDate=${searchOption.endDate}&currentPage=${i}" class="pageblock">${i}</a>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<a href="userList?small_code=2&keyword=${searchOption.keyword}&is_deleted=${searchOption.is_deleted}&startDate=${searchOption.startDate}&endDate=${searchOption.endDate}&currentPage=${page.startPage+page.pageBlock}"  class="pageblock" >[다음]</a>
						</c:if>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>
</html>