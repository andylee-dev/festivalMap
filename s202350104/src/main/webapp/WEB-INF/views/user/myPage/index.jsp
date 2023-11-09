<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Festival</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	<div class="d-flex">
		<%@ include file="/WEB-INF/components/MyPageSideBar.jsp"%>
		<div class="container border p-5">
			<div class="container my-5">
				<h1>계정 관리</h1>
				<p>나의 페스티맵 계정, 기본 정보 등을 관리할 수 있습니다.</p>
				<div class="container p-2 my-5">
					<h2>내 정보</h2>
					<hr class="hr"/>
					<div class="container w-75 my-5" align="center">
<!-- 						<form action="">
							<div class="input-group col-3 mb-3">
								<span class="input-group-text col-auto">이메일</span> <input
									type="text" name="email" class="form-control">
							</div>
							<div class="input-group mb-3">
								<span class="input-group-text col-auto">비밀번호</span> <input
									type="password" name="password" class="form-control">
							</div>
							<button type="submit" class="btn btn-primary">수정하기</button>
						</form>
 -->
					  <div class="mb-3 row">
					    <label for="staticEmail" class="col-sm-2 col-form-label text-right " >이름</label>
					    <div class="col-sm-10">
					      <input type="text" readonly class="form-control-plaintext" id="staticEmail" value="${user.name}">
					    </div>
					  </div>
					  <div class="mb-3 row">
					    <label for="staticEmail" class="col-sm-2 col-form-label text-right" >이메일</label>
					    <div class="col-sm-10">
					      <input type="text" readonly class="form-control-plaintext" id="staticEmail" value="${user.email}">
					    </div>
					  </div>
					  <div class="mb-3 row">
					    <label for="staticEmail" class="col-sm-2 col-form-label text-right" >닉네임</label>
					    <div class="col-sm-10">
					      <input type="text" readonly class="form-control-plaintext" id="staticEmail" value="${user.nickname}">
					    </div>
					  </div>
					  <div class="mb-3 row">
					    <label for="staticEmail" class="col-sm-2 col-form-label text-right" >생년월일</label>
					    <div class="col-sm-10">
					      <input type="text" readonly class="form-control-plaintext" id="staticEmail" value="${user.birthday}">
					    </div>
					  </div>
					  <div class="mb-3 row">
					    <label for="staticEmail" class="col-sm-2 col-form-label text-right" >성별</label>
					    <div class="col-sm-10">
					      <input type="text" readonly class="form-control-plaintext" id="staticEmail" value="${user.gender}">
					    </div>
					  </div>
					  <div class="mb-3 row">
					    <label for="staticEmail" class="col-sm-2 col-form-label text-right" >전화번호</label>
					    <div class="col-sm-10">
					      <input type="text" readonly class="form-control-plaintext" id="staticEmail" value="${user.phone_num}">
					    </div>
					  </div>
					  <div class="mb-3 row">
					    <label for="staticEmail" class="col-sm-2 col-form-label text-right" >주소</label>
					    <div class="col-sm-10">
					      <input type="text" readonly class="form-control-plaintext" id="staticEmail" value="${user.address}">
					    </div>
					  </div>
					</div>
				</div>
				<div class="container p-2 my-5">
					<h2>포인트 내역</h2>
					<hr class="hr" />
					<div class="container w-50 my-5" align="center">
						<table class="table table-striped table-sm">
							<thead>
								<tr>
									<th scope="col">title</th>
									<th scope="col">content</th>
									<th scope="col">created_at</th>
									<th scope="col">point</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="num" value="${page.start}" />
								<c:forEach var="pointHistory" items="${pointHistoryList}" varStatus="st">
									<tr id="user${st.index}">
										<td>${pointHistory.title}</td>
										<td>${pointHistory.content}</td>
										<td><fmt:formatDate value="${pointHistory.created_at}"
												type="date" pattern="YY/MM/dd" /></td>
										<td>${pointHistory.point}</td>
									</tr>
									<c:set var="num" value="${num + 1}" />
								</c:forEach>
							</tbody>
						</table>
						<ul class="pagination justify-content-center">
							<c:if test="${page.startPage > page.pageBlock}">
								<li class="page-item"><a class="page-link"
									href="userList?small_code=2&keyword=${searchOption.keyword}&is_deleted=${searchOption.is_deleted}&startDate=${searchOption.startDate}&endDate=${searchOption.endDate}&currentPage=${page.startPage-page.pageBlock}"
									class="pageblock">[이전]</a></li>
							</c:if>
							<c:forEach var="i" begin="${page.startPage}"
								end="${page.endPage}">
								<li class="page-item"><a class="page-link"
									href="userList?small_code=2&keyword=${searchOption.keyword}&is_deleted=${searchOption.is_deleted}&startDate=${searchOption.startDate}&endDate=${searchOption.endDate}&currentPage=${i}"
									class="pageblock">${i}</a></li>
							</c:forEach>
							<c:if test="${page.endPage < page.totalPage}">
								<li class="page-item"><a class="page-link"
									href="userList?small_code=2&keyword=${searchOption.keyword}&is_deleted=${searchOption.is_deleted}&startDate=${searchOption.startDate}&endDate=${searchOption.endDate}&currentPage=${page.startPage+page.pageBlock}"
									class="pageblock">[다음]</a></li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>