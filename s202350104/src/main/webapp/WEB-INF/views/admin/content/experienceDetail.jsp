<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>체험 상세 정보</title>
		 <link rel="stylesheet" type="text/css" href="/css/adminContentsDetail.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function deleteConfirm() {
				if(confirm("정말 삭제하시겠습니까?")) {
					location.href="../content/experienceDelete?contentId=${experience.content_id}";
				}
			}
			
			function approveConfirm() {
				var contentId = Number(${experience.content_id});
				if(confirm("승인하시겠습니까?")) {
					location.href="../content/experienceApprove?contentId="+contentId+"&currentPage=${currentPage}";
				}
			}
			
			function openRejectionPopup(contentId) {
			    window.open("rejectionFoam?contentId=" + contentId, "_blank", "width=600, height=400, top=100, left=100");
			}
			
			function getSigungu(pArea){
				var pSigungu = ${experience.sigungu}
				$.ajax(
						{
							url:"<%=request.getContextPath()%>/getSigungu/"+pArea,
							dataType:'json',
							success:function(areas) {
								$('#sigungu_select option').remove();
								str = "<option value='999'>전체</option>";
								$(areas).each(
									function() {
										if(this.sigungu != 999 && this.content != null) {
											strOption = "<option value='"+this.sigungu+"' ${"+this.sigungu+" == "+pSigungu+"? 'selected':''}>"+this.content+"</option>";
											str += strOption;
										}
									}		
								)
								$('#sigungu_select').append(str);
							}
						}		
				)
			}
		</script>
					
	</head>
	<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
		<main class="col-10 p-0">
			<div class="admin-header-container">
				<div class="container m-4">
					<i class="title-bi bi bi-pencil-square "></i>
				<label  class="admin-header-title ">축제 상세 정보 </label>					
				</div>
			</div>	
			<div class="container my-5">
				<h1>체험 관리</h1>
				<hr class="hr" />
				<h3 style="color: #FF4379 ">체험별 상세 정보</h3>
					<div class="container border p-5">
						<div class="mb-3 ">
						  <label for="content_id" class="form-label">컨텐츠 ID</label>
						  <input type="text" class="form-control" id="content_id" value="${experience.content_id} " readonly>
						</div>	
						<div class="mb-3 ">
						  <label for="small_code" class="form-label">체험 종류</label>
							<select class="form-select" aria-label="small_code">
								<c:forEach var="smallCode" items="${listSmallCode}">
									<c:if test="${smallCode.small_code != 999}">
										<option value="${smallCode.small_code}" ${smallCode.small_code == experience.small_code? 'selected' : '' } disabled>${smallCode.content}</option>
									</c:if>
							 	</c:forEach>
							</select>
						</div>			
						<div class="mb-3 ">
						  <label for="title" class="form-label">체험 이름</label>
						  <input type="text" class="form-control" id="title" value="${experience.title} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="content" class="form-label">개요</label>
						  <textarea class="form-control" id="content" rows="5" readonly>${experience.content}</textarea>
						</div>		
						
						<div class="mb-3 ">
							<label for="content" class="form-label ">지역</label>
								<div class="row">
								    <div class="col-2">
								        <!-- 첫 번째 그리드 -->
								        <select class="form-select" id="area" name="area" onchange="getSigungu(this.value)" disabled>
								            <option value="">전체</option>
								            <c:forEach var="areas" items="${listAreas}">
								                <c:if test="${areas.sigungu == 999}">
								                    <option value="${areas.area}" ${areas.area == experience.area? 'selected':''}>${areas.content}</option>
								                </c:if>
								            </c:forEach>
								        </select>
								    </div>
								    <div class="col-2">
								        <!-- 두 번째 그리드 -->
								        <select class="form-select" id="sigungu_select" name="sigungu" disabled>
								            <option value="999">전체</option>
								            <c:forEach var="areas" items="${listSigungu}">
								                <c:if test="${areas.sigungu != 999 && areas.sigungu != null}">
								                    <option value="${areas.sigungu}" ${areas.sigungu == experience.sigungu? 'selected':''}>${areas.content}</option>
								                </c:if>
								            </c:forEach>
								        </select>
								    </div>
								    <div class="col-6">
								    <input type="text" class="form-control" id="address" value="${experience.address} " readonly>
								    </div>
								</div>
						</div>			
						<div class="mb-3 ">
						  <label for="email" class="form-label">email</label>
						  <input type="text" class="form-control" id="address" value="${experience.email} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="phone" class="form-label">전화번호</label>
						  <input type="text" class="form-control" id="address" value="${experience.phone} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="homepage" class="form-label">홈페이지</label>
						  <input type="text" class="form-control" id="address" value="${experience.homepage} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for=created_at class="form-label">작성일</label>
						  <input type="text" class="form-control" id="created_at" value="<fmt:formatDate value="${experience.created_at}" pattern="YYYY/MM/dd"/>" readonly>
						</div>
						<div class="mb-3 ">
						  <label for="capacity" class="form-label">수용인원</label>
						  <input type="text" class="form-control" id="capacity" value="${experience.capacity} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="age" class="form-label">체험연령</label>
						  <input type="text" class="form-control" id="capacity" value="${experience.age} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="inform" class="form-label">체험안내</label>
						  <input type="text" class="form-control" id="capacity" value="${experience.inform} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="open_time" class="form-label">개장시간</label>
						  <input type="text" class="form-control" id="open_time" value="${experience.open_time} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="rest_time" class="form-label">휴무일</label>
						  <input type="text" class="form-control" id="rest_time" value="${experience.rest_time} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="cost" class="form-label">비용안내</label>
						  <input type="text" class="form-control" id="cost" value="${experience.cost} " readonly>
						</div>
						  
						  <label for="facilities" class="form-label">부대시설</label><br>
						<div class="col-sm-8 mx-3 d-flex">
						  	<div class="form-check mx-2">
								<input class="form-check-input" type="radio" name="is_credit"
								id="is_credit" value="1" ${experience.is_credit == 1?"checked":""} disabled> 
								<label class="form-check-label" for="is_credit">카드여부</label>
							</div>
							<div class="form-check mx-2">
								<input class="form-check-input" type="radio" name="is_pet"
								id="is_pet" value="1" ${experience.is_pet == 1?"checked":""} disabled> 
								<label class="form-check-label" for="is_pet">반려동물</label>
							</div>
							<div class="form-check mx-2">
							<input class="form-check-input" type="radio" name="is_parking"
								id="is_parking" value="1" ${experience.is_parking == 1?"checked":""} disabled> 
								<label class="form-check-label" for="is_parking">주차시설</label>
							</div>
							<div class="form-check mx-2">
							<input class="form-check-input" type="radio" name="is_stroller"
								id="is_stroller" value="1" ${experience.is_stroller == 1?"checked":""} disabled> 
								<label class="form-check-label" for="is_stroller">유모차대여</label>
							</div>
						</div>						
					
					
					</div>
				
			</div>
		</main>
		</div>
	</div>	
	</body>
</html>