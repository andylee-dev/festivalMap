<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>찜목록 정보 등록</title>
	</head>
	
	<body>
		<div class="container-fluid">
			<div class="row">
				<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
				<main class="col-10 overflow-auto p-0">
				
					<!-- Section1: Title -->
					<div class="admin-header-container">
						<div class="container m-4">
							<i class="title-bi bi bi-pencil-square "></i>
							<label  class="admin-header-title ">찜목록 정보 등록 </label>					
						</div>
					</div>	
					
					<!-- Section2: Table -->		
					<div class="border p-3 m-3">
						<form action="favorite/insert" method="post">
							<table class="table table-striped table-sm">
								<tr>
									<th>회원ID</th>
									<td><input type="number" name="user_id" required="required"></td>	
								</tr>
								<tr>
									<th>이름</th>
									<td><input type="text" name="name" required="required"></td>
								</tr>
								<tr>
									<th>컨텐츠ID</th>
									<td><input type="number" name="id" required="required"></td>
								</tr>		
								<tr>
									<th>찜한 날짜</th>
									<td><input type="date" name="create_at" required="required"></td>
								</tr>		
							   </table>
							<div align="center">
								<button type="submit" class="btn btn-outline-secondary" onclick="return confirm('등록하시겠습니까?')">등록</button>
								<button type="reset" class="btn btn-outline-secondary"  onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까')">초기화</button>
							</div>	
						</form>	
					</div>
				</main>	
			</div>
			</div>	
	</body>
</html>