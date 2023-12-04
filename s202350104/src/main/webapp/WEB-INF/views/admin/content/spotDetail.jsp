<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>명소 상세 정보</title>
		<link rel="stylesheet" type="text/css" href="/css/adminContentsDetail.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			
			function approveConfirm() {
				var contentId = Number(${spot.content_id}); 
				var status = "${spot.status}";
				if(confirm("승인하시겠습니까?")) {
					location.href="../content/spotApprove?contentId="+contentId+"&currentPage=${currentPage}&status="+status;
				}
			}
			function approveConfirm1() {
				var contentId = Number(${spot.content_id}); 
				var status = "${spot.status}";
				if(confirm("승인대기로 변경하시겠습니까?")) {
					location.href="../content/spotApprove?contentId="+contentId+"&currentPage=${currentPage}&status="+status;
				}
			}
			
			function deleteConfirm() {
				var contentId = Number(${spot.content_id}); 
				var is_deleted = "${spot.is_deleted}";
				if(confirm("삭제하시겠습니까?")) {
					location.href="../content/spotDelete?contentId="+contentId+"&currentPage=${currentPage}&is_deleted="+is_deleted;
				}
			}
			function deleteConfirm1() {
				var contentId = Number(${spot.content_id}); 
				var is_deleted = "${spot.is_deleted}";
				if(confirm("복원하시겠습니까?")) {
					location.href="../content/spotDelete?contentId="+contentId+"&currentPage=${currentPage}&is_deleted="+is_deleted;
				}
			}
			
			/* 모달에서 반려 했을 경우 동작하는 핸들러.*/
			function submitRejectForm() {
				// Status 0으로 만들기.
				document.getElementById('statusInput').value = 0;
				$(".form-input ,.check-duple").prop("disabled", false);

				$('#exampleModal').modal('hide');
				    
				const banReason = document.getElementById('message-text').value;
				const modalTitleText = document.getElementById('modal-title').innerText;
				$("#ban-title").val(modalTitleText);
				$("#ban-content").val(banReason);
				   
				document.getElementById('update-form').submit();
			}

			/* 모달에서 승인 했을 경우 동작하는 핸들러.*/
			function submitAcceptForm() {
				document.getElementById('statusInput').value = 1;
				$(".form-input ,.check-duple").prop("disabled", false);
				alert("승인처리를 했습니다.");
				document.getElementById('update-form').submit();
			}
			
			function getSigungu(pArea){
				var pSigungu = ${spot.sigungu}
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
		<style type="text/css">
		
		#detail-top-container {
			position: absolute;
			width: 250px;
			height: 83px;
			border-radius: 10px;
			border: 1px solid #000;
			flex-shrink: 0;
			top: -35px; /* B의 상단에 A를 위치시키기 위해 top을 0으로 설정 */
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
			word-wrap: break-word;
		}	
		
		#detail-top-id2{
			color: #BDEB50;
			font-family: Noto Sans;
			font-size: 16px;
			font-style: normal;
			font-weight: 600;
			line-height: normal;
			letter-spacing: -0.48px;
			padding-top: 5px;
			word-wrap: break-word;
		}	
		
		#detail-top-id3{
			color: red;
			font-family: Noto Sans;
			font-size: 16px;
			font-style: normal;
			font-weight: 600;
			line-height: normal;
			letter-spacing: -0.48px;
			padding-top: 5px;
			word-wrap: break-word;
		}
		
		#detail-main-container {
			position: relative;
			border: 1px solid #000;
			border-radius: 10px;
			background-color: white;
		}
		.detail-body-container {
			justify-content: center;
			padding-right: 0;
			padding-left: 0;
			margin-right: 0;
			margin-left: 0;
		}
		.form-label{
			color: #000;
			font-family: Noto Sans;
			font-size: 16px;
			font-style: normal;
			font-weight: 600;
			line-height: normal;
		}
		h1 {
			color: black;
			font-size: 32px;
			font-family: Noto Sans;
			font-weight: 600;
			word-wrap: break-word
		}
		h3 {
			color: #FF4379;
			font-size: 24px;
			font-family: Noto Sans;
			font-weight: 600;
			word-wrap: break-word
		}
		
		.btn-primary2 {
		    background-color: #9BDB04; 
		    border-color: #9BDB04; 
		    color: white;
		}
		
		.btn-primary2:hover {
		    background-color: #52525C ; 
		    border-color: #52525C; 
		    color: #9BDB04;
		}
		</style>
		
	</head>
	<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-10 p-0">
			
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-pencil-square "></i>
						<label  class="admin-header-title ">명소 상세 정보 </label>					
					</div>
				</div>
				
				<div class="container my-5" id="detail-body-container">
				<div>
				<h1>명소 관리</h1>
				<hr class="hr" />
				</div>
				<div>
				<h3 style="color: #FF4379 ">명소별 상세 정보</h3>
				</div>
				<div class="my-5">
				<div class="" id="detail-main-container">	
					<div class="container d-flex justify-content-around" id="detail-top-container">
								<label id="detail-top-text">명소 ㅣ </label>
								<label id="detail-top-text" >${spot.content_id} ㅣ</label>
								<c:choose>
									<c:when test="${spot.is_deleted == 1}">
									<label id="detail-top-id3" >삭제(게시X)</label>
									</c:when>
									<c:when test="${spot.status == 0}">
									<label id="detail-top-id" >승인대기</label>
									</c:when>
									<c:when test="${spot.status == 1}">
									<label id="detail-top-id2" >승인(게시중)</label>
									</c:when>
								</c:choose>
					</div>
					<!-- Section2: Table -->
					<div class="container p-5" id="form-container">
					<form action="spotUpdate" method="post" id="update-form">
						<input type="hidden" name="status" id="statusInput" value="${spot.status }">
						<input type="hidden" name="big_code" value="${spot.big_code }">
						<input type="hidden" name="small_code" value="${spot.small_code }">
						<input type="hidden" name="target_id" value="${spot.id }">
						<input type="hidden" name="title" id="ban-title" >
						<input type="hidden" name="content" id="ban-content">
						<div class="mb-3">
						  <label for="content_id" class="form-label">컨텐츠 ID</label>
						  <input type="text" class="form-control" id="content_id" value="${spot.content_id} " readonly>
						</div>	
						<div class="mb-3" id="detail-content-title">
						  <label for="small_code" class="form-label">명소 종류</label>
								<select class="form-select" aria-label="small_code">
									<c:forEach var="code" items="${listCodes}">
										<c:if test="${code.big_code == 14 && code.small_code != 999}">
											<option value="${code.small_code}" ${code.small_code== spot.small_code? 'selected' : '' } disabled>${code.content}</option>
									</c:if>
							 	</c:forEach>
							</select>
						</div>	
						<div class="mb-3 ">
						  <label for="title" class="form-label">명소 이름</label>
						  <input type="text" class="form-control" id="title" value="${spot.title} " readonly>
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
								                    <option value="${areas.area}" ${areas.area == spot.area? 'selected':''}>${areas.content}</option>
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
								                    <option value="${areas.sigungu}" ${areas.sigungu == spot.sigungu? 'selected':''}>${areas.content}</option>
								                </c:if>
								            </c:forEach>
								        </select>
								    </div>
										<div class="col-2">
								    		<input type="text" class="form-control" name="postcode" id="postcode" value="${spot.postcode}" readonly>
								    	</div>
								    	<div class="col-6">
								    		<input type="text" class="form-control" name="address" id="address" value="${spot.address}" readonly>
								    	</div>
								  </div>
							</div>	   	
							<div class="mb-3 ">
						  		<label for="content" class="form-label">개요</label>
								<textarea rows="5" class="form-control" name="content" id="content" readonly>${spot.content}</textarea>
							</div>
							<div class="mb-3 ">
						 		<label for="email" class="form-label">email</label>
						  		<input type="text" class="form-control" name="email" id="email" value="${spot.email}" readonly>
							</div>
							<div class="mb-3 ">
						 	 	<label for="phone" class="form-label">전화번호</label>
						  		<input type="text" class="form-control" name="phone" id="phone" value="${spot.phone}" readonly>
							</div>
							<div class="mb-3 ">
						 		<label for="homepage" class="form-label">홈페이지</label>
						  		<input type="text" class="form-control" name="homepage" id="homepage" value="${spot.homepage} " readonly>
							</div>
							<div class="mb-3 ">
						  		<label for="opening_hours" class="form-label">영업시간</label>
						  		<input type="text" class="form-control" name="opening_hours" id="opening_hours" value="${spot.opening_hours} " readonly>
							</div>
							<div class="mb-3 ">
						  		<label for="rest_date" class="form-label">휴무일</label>
						  		<input type="text" class="form-control" name="rest_date" id="rest_date" value="${spot.rest_date} " readonly>
							</div>
							<div class="mb-3 ">
						  		<label for="entrance_fee" class="form-label">입장료</label>
								<input type="text" class="form-control" name="entrance_fee" id="entrance_fee" value="${spot.entrance_fee} " readonly>
							</div>
							<div class="mb-3 ">
						 	 	<label for="img1" class="form-label">이미지</label>
						  		<input type="text" class="form-control" name="img1" id="img1 value="${spot.img1} ">
							</div>
						
							<div class="mb-3 ">
							 <label for="rest_time" class="form-label">태그</label>
								<div class="tag-container">
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                         </div>
			                         <div class="tag-item">
			                             <div>#MZ추천</div>
			                       </div>
			    				</div>
		                   </div>
		                   
		                   <label for="facilities" class="form-label">부대시설</label><br>
								<div class="col-12 d-flex justify-content-between">
						  			<div class="col-2 form-check mx-3">
										<input class="form-check-input" type="checkbox" name="is_wheelchair"
										  	   id="is_wheelchair" value="1" ${spot.is_wheelchair == 1?"checked":""} disabled> 
										<label class="form-check-label" for="is_wheelchair">휠체어대여</label>
									</div>
									<div class="col-2 form-check mx-3">
										<input class="form-check-input" type="checkbox" name="is_restroom"
										  	   id="is_restroom" value="1" ${spot.is_restroom == 1?"checked":""} disabled> 
										<label class="form-check-label" for="is_restroom">장애인화장실</label>
									</div>
									<div class="col-2 form-check mx-3">
										<input class="form-check-input" type="checkbox" name="is_pet"
												  id="is_pet" value="1" ${spot.is_pet == 1?"checked":""} disabled> 
										<label class="form-check-label" for="is_pet">반려동물</label>
									</div>
									<div class="col-2 form-check mx-3">
										<input class="form-check-input" type="checkbox" name="is_parking"
												  id="is_parking" value="1" ${spot.is_parking == 1?"checked":""} disabled> 
										<label class="form-check-label" for="is_parking">주차시설</label>
									</div>
									<div class="col-2 form-check mx-3">
										<input class="form-check-input" type="checkbox" name="is_stroller"
												  id="is_stroller" value="1" ${spot.is_stroller == 1?"checked":""} disabled> 
										<label class="form-check-label" for="is_stroller">유모차대여</label>
									</div>
								</div>
								<div class="mb-3 ">
						  			<label for="user_id" class="form-label">등록자ID</label>
									<input type="text" class="form-control" name="user_id" id="user_id" value="${spot.user_id} " readonly>
								</div>
								<div class="mb-3 ">
						  			<label for="created_at" class="form-label">등록일</label>
						  			<fmt:formatDate value="${spot.created_at}" type="date" pattern="YY/MM/dd"/>
								</div>
					
								<hr class="hr" />			
						
								 <div class="d-flex justify-content-between">
						 
						 		<c:choose>
									 <c:when test="${spot.is_deleted == 1}">
							 			<div class="col-6 mb-3" >
		                        			<button type="button" class="form-control btn btn-primary w-100" onclick="deleteConfirm1()">복원</button>
		                        		</div>
		                       		 <div class="col-6 mb-3">
		                        			<button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/spot?currentPage=1'">취소</button>
		                        		</div>
		                   		 </c:when>
							 		<c:when test="${spot.status == 0}">
							 			<div class="col-6 mb-3" >
		                             		 <button type="button" class="form-control btn btn-primary w-100" onclick="approveConfirm()">승인(게시하기)</button>
		                          		</div>
		                          		<div class="col-3 mb-3">
		                              		<button type="button" class="btn btn-outline-secondary w-100" data-bs-toggle="modal" data-bs-target="#exampleModal">반려(사유선택)</button>
		                         		 </div>
		                         		 <div class="col-3 mb-3">
		                             		<button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/spot?currentPage=1'">목록</button>
		                          		</div>
									 </c:when>
									 <c:when test="${spot.status == 1}">
							 			<div class="col-6 mb-3">
		                               		 <button type="button" class="form-control btn btn-primary2 w-100" onclick="location.href='../content/spotUpdateForm?contentId=${spot.content_id}&currentPage=${currentPage}'">수정하기</button>
		                            		 </div>
		                            		 <div class="col-2 mb-3">
		                              		  <button type="button" class="btn btn-outline-secondary w-100" onclick="approveConfirm1()">반려전환</button>
		                            		 </div>
		                            		 <div class="col-2 mb-3">
		                             		 <button type="button" class="btn btn-outline-secondary w-100" onclick="deleteConfirm()">삭제</button>
		                          		   </div>
		                        		  <div class="col-1 mb-3">
		                             		<button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/spot?currentPage=1'">목록</button>
		                          		</div>		
							 		</c:when>
								</c:choose>
							</div>
							
						</form>
					</div>
				</div>
				</div>
			</div>
		</main>
		</div>
	</div>
	<div class="modal fade " id="exampleModal" tabindex="-1" aria-labelledby="label" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="modal-title">반려 전환</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <div class="mb-3">
            <label class="col-form-label">반려사유</label>
 			<textarea class="form-control" id="message-text"></textarea>
           </div>
     </div>
	   <div class="form-row d-flex justify-content-around modal-footer">
        <button type="button" onclick="submitRejectForm()" class="btn btn-primary col-4">반려</button>
        <button type="button" class="btn btn-outline-secondary col-4" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>	
	</body>
</html>