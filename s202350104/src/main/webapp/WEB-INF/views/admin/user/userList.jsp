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
	            small_code: 2,
	            dateOptions: dateOptions,
	            keyword: keyword,
	            is_deleted: is_deleted,
	            startDate: startDate,
	            endDate: endDate,
	            currentPage: page
	        };
	        return 'userList?' + Object.entries(params)
			        .filter(([key, value]) => value !== undefined && value !== null && value !== '') // 값이 없는 경우를 필터링합니다.
			        .map(([key, value]) => key+'='+value).join('&');
	    }
	    
		function userDeleteAjax(index) {
			const table = document.getElementById("userTable");
			const row = table.rows[ index + 1 ];
			const userId = row.querySelector("#userId").textContent;
			
			if(confirm("정말 삭제하시겠습니까?")) {
			$.ajax(
				{
					method:"POST",
					url:"/admin/user/userDeleteAjax",
					data:{id : userId},
					dataType:'text',
					success:
						function(result) {
							if(result == '1') {
								// row.parentNode.removeChild(row);
								alert("성공적으로 삭제되었습니다.");
								location.reload();
							} else {
								alert("삭제에 실패하였습니다.");
							}		
						}
					}		
				)
			}
		}			
	    
	</script>
</head>
<body >
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp"%>
			<main class="col-10 overflow-auto p-0">
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-people-fill "></i>
						<label  class="admin-header-title ">일반 회원 리스트 </label>					
					</div>
				</div>
				<!-- Section2: Search Form -->
				<div class="d-flex justify-content-center my-5">
					<form action="/admin/user/userList" method="POST" class="col-6">
						<input class="col-1" type="hidden" name="small_code" value="2">						
						<div class="d-flex row col-6 mb-3">
						    <span class="col-2" >검색어</span>
						    <select name="searchType" class="form-select col-4" >
						        <option selected value="name">사용자 이름</option>
						        <option value="email">이메일</option>
						        <option value="nickname">닉네임</option>
						    </select>
						    <input type="text" name="keyword" class="form-control col-6" value="${keyword}">
						</div>
						<div class="input-group col-auto mb-3" >
						   <span class="input-group-text col-auto">가입기간</span>
						    <input type="radio" class="btn-check" name="dateOptions" id="TO" value="TO" autocomplete="off" >
						    <label class="btn" for="TO">오늘</label>
						    <input type="radio" class="btn-check" name="dateOptions" id="1W" value="1W" autocomplete="off">
						    <label class="btn" for="1W">1주일</label>
						    <input type="radio" class="btn-check" name="dateOptions" id="1M" value="1M" autocomplete="off">
						    <label class="btn" for="1M">1개월</label>
						    <input type="radio" class="btn-check" name="dateOptions" id="3M" value="3M" autocomplete="off">
						    <label class="btn" for="3M">3개월</label>
						    <input type="radio" class="btn-check" name="dateOptions" id="6M" value="6M" autocomplete="off">
						    <label class="btn" for="6M">6개월</label>
						    <input type="radio" class="btn-check" name="dateOptions" id="ALL" value="ALL" autocomplete="off" checked>
						    <label class="btn" for="ALL">전체</label>
							<input type="date" id="startDatePicker" name="startDate" value="${startDate}">
							<input type="date" id="endDatePicker" name="endDate" value="${endDate}">
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
					<table id="userTable" class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">회원번호</th>
								<th scope="col">이름</th>
								<th scope="col">비밀번호</th>
								<th scope="col">닉네임</th>
								<th scope="col">생년월일</th>
								<th scope="col">연락처</th>
								<th scope="col">이메일</th>
								<th scope="col">주소</th>
								<th scope="col">가입일</th>
								<th scope="col">수정</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="user" items="${listUsers}" varStatus="st">
								<tr id="user${st.index}">
								
									<td id="userId">${user.id}</td>
									<td>${user.name}</td>
									 
									<td>${user.password.substring(0, 1)}****${user.password.substring(user.password.length() - 2)}</td>
									<td>${user.nickname}</td>
									<td>${user.birthday}</td>
									<td>${user.phone_num}</td>
									<td>${user.email}</td>
									<td>${user.address}</td>
									<td><fmt:formatDate value="${user.created_at}" type="date" pattern="YY/MM/dd"/></td>
									<td><a class="btn btn-primary" href="userUpdateForm/${user.id}?currentPage=${page.currentPage}">수정</a></td>
									<td><c:if test="${user.is_deleted == 0}">
											<input type="button" value="삭제"
										 onclick="userDeleteAjax(${st.index})">
										</c:if>
										<c:if test="${user.is_deleted == 1}">
											탈퇴
										</c:if></td>
								</tr>
								<c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>

					<div align="center">
					    <c:if test="${page.startPage > page.pageBlock}">
					        <a href="javascript:void(0)" onclick="location.href=createQueryURL(${page.startPage-page.pageBlock})" class="pageblock">[이전]</a>
					    </c:if>
					    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<a href="javascript:void(0)" onclick="location.href=createQueryURL(${i})" class="pageblock">${i}</a>					    
						</c:forEach>
					    <c:if test="${page.endPage < page.totalPage}">
					        <a href="javascript:void(0)" onclick="location.href=createQueryURL(${page.startPage+page.pageBlock})"  class="pageblock" >[다음]</a>
					    </c:if>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>
</html>