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
	<script type="text/javascript">
		// init
	    $(document).ready(function() {
	        const is_deleted = '${searchOption.is_deleted != null ? searchOption.is_deleted :""}';
	        const status = '${searchOption.status != null ? searchOption.status : ""}';
			const dateOptions = '${searchOption.dateOptions != null ? searchOption.dateOptions : ""}';
	        if(is_deleted != '') {
	            $('input[name="is_deleted"][value="'+is_deleted+'"]').attr('checked', 'checked');
	        }
	        if(status != '') {
	            $('select[name="status"][value="'+status+'"]').attr('checked', 'checked');
	        }
	        if(dateOptions != '') {
	            $('input[name="dateOptions"][value="'+dateOptions+'"]').attr('checked', 'checked');
	        }

	        const dateFormat = {
		          singleDatePicker: true, // 시작 날짜만 선택
		          linkedCalendars: false, // 두 개의 독립된 달력 사용
		          autoApply: true, // 날짜를 선택하면 자동으로 적용
		          locale: {
		            format: 'yyyy-MM-DD',
		          },
		        }
	        const onChangeDate = () => {
	            const date = $('input[name="dateOptions"]:checked').val();
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
	        $('input[name="dateOptions"]').change(onChangeDate);        
	        onChangeDate();        
	    }); 
	    
	    function createQueryURL(page) {
	        const keyword = document.querySelector('input[name="keyword"]').value;
	        const is_deleted = document.querySelector('input[name="is_deleted"]:checked') ? document.querySelector('input[name="is_deleted"]:checked').value : '';
	        const startDate = document.querySelector('input[name="startDate"]').value;
	        const endDate = document.querySelector('input[name="endDate"]').value;
	        const dateOptions = document.querySelector('input[name="dateOptions"]:checked') ? document.querySelector('input[name="dateOptions"]:checked').value : '';

	        const params = {
	            small_code: 3,
	            dateOptions: dateOptions,
	            keyword: keyword,
	            is_deleted: is_deleted,
	            startDate: startDate,
	            endDate: endDate,
	            currentPage: page
	        };
	        return 'bizUserList?' + Object.entries(params)
			        .filter(([key, value]) => value !== undefined && value !== null && value !== '') // 값이 없는 경우를 필터링합니다.
			        .map(([key, value]) => key+'='+value).join('&');
	    }
	</script>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp"%>
			<main class="col-10 overflow-auto p-0">
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-people-fill "></i>
						<label  class="admin-header-title ">비즈니스 회원 리스트</label>>
					</div>
				</div>	

					<!-- Section2: Search Form -->
				<div class="container col-9 justify-content-center my-5">
					<form action="/admin/user/bizUserList" method="POST" class="container justify-content-center">
						<input type="hidden" name="small_code" value="3">						
						
						<!-- 검색어 -->
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="form-label col-2  mx-2">검색어</label>
							<div class="col-4">
								<select name="searchType" class="form-select" >
									<option selected value="name">사용자 이름</option>
									<option value="email">이메일</option>
									<option value="nickname">닉네임</option>
								</select>
							</div>
							<div class="col-5 mx-2">	
								<input type="text" name="keyword" class="form-control" value="${keyword}">
							</div>
						</div>
						
						<!-- 기간 -->
						<div class="col-12 my-4 d-flex align-items-center " >
						  <label for="searchType" class="col-form-label col-2  mx-1">가입기간</label>
						  <div class="col-6  mx-2 d-flex">
						  	<input type="radio" class="btn-check" name="dateOptions" id="TO" value="TO" autocomplete="off">
						    <label class="btn col-2 mx-1" for="TO">오늘</label>
						    <input type="radio" class="btn-check" name="dateOptions" id="1W" value="1W" autocomplete="off">
						    <label class="btn col-2 mx-1" for="1W">1주일</label>
						    <input type="radio" class="btn-check" name="dateOptions" id="1M" value="1M" autocomplete="off">
						    <label class="btn col-2 mx-1" for="1M">1개월</label>
						    <input type="radio" class="btn-check" name="dateOptions" id="3M" value="3M" autocomplete="off">
						    <label class="btn col-2 mx-1" for="3M">3개월</label>
						    <input type="radio" class="btn-check" name="dateOptions" id="6M" value="6M" autocomplete="off">
						    <label class="btn col-2 mx-1" for="6M">6개월</label>
						    <input type="radio" class="btn-check" name="dateOptions" id="ALL" value="ALL" autocomplete="off" checked>
						    <label class="btn col-2 mx-1" for="ALL">전체</label>
						    
						   	<div class="col-4 d-flex">
								<input type="date" class="mx-1" id="startDatePicker" name="startDate" value="${startDate}">
								<input type="date" class="mx-1" id="endDatePicker" name="endDate" value="${endDate}">
							</div>
						  </div>	
						</div>
						
						<!-- 옵션 -->
						<div class="col-12 my-4 d-flex align-items-center ">
							 <label for="searchType" class="col-form-label col-2  mx-1">회원조회</label>
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
						<div class="container col-10 d-flex justify-content-center">
							<button type="submit" class="btn btn-primary  col-2 mx-3">검색</button>
							<button type="reset" class="btn btn-outline-secondary col-2 mx-3">초기화</button>
						</div>
				    </form>
				</div>
				<div class="container col-9 justify-content-center my-2">
					<button type="button" class="btn btn-outline-secondary mt-4">등록</button>
				</div>

				<!-- Section3: Table -->
				<div class="container col-9 justify-content-center my-2 border p-2">
					<table id="bizuserTable" class="table table-striped table-sm text-center">
						<br>
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
									<td><input class="btn btn-primary" type="button" value="수정"></td>
									<td><input class="btn btn-outline-secondary" type="button" value="삭제"></td>
								</tr>
								<c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>
					</div>
					<nav aria-label="Page navigation example ">
						<ul class="pagination">
					    	<c:if test="${page.startPage > page.pageBlock}">
							    <li class="page-item">
						        	<a href="javascript:void(0)" onclick="location.href=createQueryURL(${page.startPage-page.pageBlock})" class="pageblock page-link">[이전]</a>
						    	</li>
					    	</c:if>
						    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							    <li class="page-item">
									<a href="javascript:void(0)" onclick="location.href=createQueryURL(${i})" class="pageblock page-link ${page.currentPage == i ? "active":"" }">${i}</a>					    
						    	</li>
							</c:forEach>
						    <c:if test="${page.endPage < page.totalPage}">
							    <li class="page-item">
							        <a href="javascript:void(0)" onclick="location.href=createQueryURL(${page.startPage+page.pageBlock})"  class="pageblock page-link" >[다음]</a>
						    	</li>
						    </c:if>
						</ul>
					</nav>
			</main>
		</div>
	</div>
</body>
</html>