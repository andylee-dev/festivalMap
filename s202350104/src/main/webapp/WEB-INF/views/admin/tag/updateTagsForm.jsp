<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>태그 수정</title>
		<style type="text/css">
			.detail-body-container {
				justify-content: center;
				padding-right: 0;
				padding-left: 0;
				margin-right: 0;
				margin-left: 0;
			}
			
			h1 {
				color: #000;
				font-family: Noto Sans;
				font-size: 32px;
				font-style: normal;
				font-weight: 600;
				line-height: normal;
				letter-spacing: -0.96px;
			}
			
			#detail-main-container {
				position: relative;
				border: 1px solid #000;
				border-radius: 10px;
				background-color: white;
			}
			
			#detail-top-container {
				position: absolute;
				width: 250px;
				height: 83px;
				border-radius: 10px;
				border: 1px solid #000;
				flex-shrink: 0;
				top: -40px; /* B의 상단에 A를 위치시키기 위해 top을 0으로 설정 */
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
				white-space: nowrap; /* 줄바꿈을 방지 */
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
				white-space: nowrap; /* 줄바꿈을 방지 */
			}
			
			
			.form-label{
				color: #000;
				
				font-family: Noto Sans;
				font-size: 16px;
				font-style: normal;
				font-weight: 600;
				line-height: normal;
			}
			
			.form-input[disabled] {
				color: #000;
				border: 0px solid #F4F4F4;
				border-radius: 10px;
				background: #F4F4F4;
				font-family: Noto Sans;
				font-size: 24px;
				font-style: normal;
				font-weight: 400;
				line-height: normal;
				letter-spacing: -0.72px;
			}
			
			.form-input {
				color: #000;
				border: 1px solid ;
				border-radius: 10px;
				font-family: Noto Sans;
				font-size: 24px;
				font-style: normal;
				font-weight: 400;
				line-height: normal;
				letter-spacing: -0.72px;
			}
		</style>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function deleteTag() {
				if(confirm("정말 삭제하시겠습니까?")) {
					location.href="deleteTags?tagId=${tags.id}";
				}
			}
		</script>
	</head>
	<body>
		<div class="container-fluid">
			<div class="row">
				<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
				<main class="col-10 overflow-auto p-0">
					<!-- Section1: Title -->
					<div class="admin-header-container">
						<div class="container m-4">
							<i class="title-bi bi bi-grid-fill "></i>
						<label  class="admin-header-title ">태그 관리</label>
						</div>
					</div>
					
					<!-- Section2: Insert Form -->		
					<div id="detail-body-container" class="container col-9 my-5">
						<div>
							<h1>태그수정</h1>
						</div>
						<div>
							<hr>
						</div>
						<div class="my-5">
							<div class="" id="detail-main-container">
								<div class="container p-5 mx-3" id="form-container">
									<form action="updateTagsResult" method="post">
										<div class="form-row d-flex justify-content-between">
											<div class="col-md-11 mb-3 px-2">
												<label for="id" class="form-label">번호</label>
												<input type="text" class="form-control form-input" id="id"
												 name="id" value="${tags.id}" disabled>
											</div>
										</div>
										<div class="form-row d-flex justify-content-between">
											<div class="col-md-11 mb-3 px-2">
												<label for="name" class="form-label">이름</label>
												<input type="text" class="form-control form-input" id="name"
												 name="name" value="${tags.name}">
											</div>
										</div>
										<div class="form-row d-flex justify-content-between">
											<div class="col-md-11 mb-3 px-2">
												<label for="group_name" class="form-label">태그그룹</label>
												<input type="text" name="group_name" class="form-control form-input" id="searchForm" 
												 placeholder="키워드를 입력해주세요." autocomplete="off" list="autoTags" value="${tags.group_name}">
												<datalist id="autoTags">
													<c:forEach var="tag" items="${listAllTags}">
														<option id="${tag.id}" value="${tag.name}">
													</c:forEach>
												</datalist>
											</div>
										</div>
										<div align="center" class="mt-3">
											<button type="submit" class="btn btn-primary" onclick="return confirm('정말 수정하시겠습니까?')">수정</button>
											<button type="button" class="btn btn-outline-secondary" onclick="deleteTag()">삭제</button>
											<button type="button" class="btn btn-outline-secondary" onclick="location.href='list'">목록</button>
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