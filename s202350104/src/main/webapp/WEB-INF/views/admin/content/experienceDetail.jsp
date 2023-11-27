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
		function confirmDelete(contentId) {
	        if (confirm('정말로 이 항목을 삭제하시겠습니까?')) {
	            $.ajax({
	                type: 'POST', // 또는 'POST' 등의 HTTP 메서드 사용 가능
	                url: 'experienceDeleteAjax',
	                data: { contentId: contentId },
	                success: function(result) {
	                    // 성공적으로 삭제된 경우의 처리
	                    alert('삭제되었습니다.');
	                    location.reload();
	                },
	                error: function(xhr, status, error) {
	                    // 오류 발생 시의 처리
	                    alert('삭제에 실패했습니다.');
	                }
	            });
	        } else {
	            // 취소 버튼을 눌렀을 때의 처리
	            // 필요한 로직을 추가하세요.
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
			<div class="admin-header-container">
				<div class="container m-4">
					<i class="title-bi bi bi-pencil-square "></i>
				<label  class="admin-header-title ">축제 상세 정보 </label>	
				</div>
			</div>
				
				
			<div class="container my-5" id="detail-body-container">
				<div>
				<h1>체험 관리</h1>
				<hr class="hr" />
				</div>
				<div>
				<h3 style="color: #FF4379 ">체험별 상세 정보</h3>
				</div>
				<div class="my-5">
				<div class="" id="detail-main-container">
					<div class="container d-flex justify-content-around" id="detail-top-container">
								<label id="detail-top-text">체험 ㅣ </label>
								<label id="detail-top-text" >${experience.content_id} ㅣ</label>
								<c:choose>
									<c:when test="${experience.is_deleted == 1}">
									<label id="detail-top-id3" >삭제(게시X)</label>
									</c:when>
									<c:when test="${experience.status == 0}">
									<label id="detail-top-id" >승인대기</label>
									</c:when>
									<c:when test="${experience.status == 1}">
									<label id="detail-top-id2" >승인(게시중)</label>
									</c:when>
								</c:choose>
					</div>
					<div class="container p-5" id="form-container">
					<form action="experienceUpdate" method="post">
						<div class="mb-3">
						  <label for="content_id" class="form-label">컨텐츠 ID</label>
						  <input type="text" class="form-control" id="content_id" value="${experience.content_id} " readonly>
						</div>	
						<div class="mb-3" id="detail-content-title">
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
						
						<div class="mb-3">
							<label for="email" class="form-label">축제기간</label>
						 		<div class="row">
						  			<div class="col-3">
						  				<input type="date" class="form-control" id="1" value="">
						  				
						  			</div>
						  			<div class="col-3">
						  				<input type="date" class="form-control" id="2" value="">
						  				
						  			</div>
						  			<div class="col-1 ml-50">
						  				<input type="text" class="form-control" id="3" value="00일" readonly>
						  			</div>
						  		</div>
						</div>
						<div class="mb-3 ">
						  <label for="email" class="form-label">주최</label>
						  <input type="text" class="form-control" id="4" value="주최자자자자자자자자자" readonly>
						</div>
						<div class="mb-3" style="background: #F8FCF4;">
						  <div class="row">
						    <div class="col-4 md-4 mb-3">
						      <label for="validationDefault01" class="form-label">담당 부서</label>
						      <input type="text" class="form-control" id="validationDefault01" placeholder="First name" value="디자인협력팀" required>
						    </div>
						    <div class="col-4 md-4 mb-3">
						      <label for="validationDefault02" class="form-label">담당자</label>
						      <input type="text" class="form-control" id="validationDefault02" placeholder="Last name" value="이규현팀장" required>
						    </div>
						    <div class="col-4 md-4 mb-3">
						      <label for="validationDefaultUsername" class="form-label">연락처</label>
						      <input type="text" class="form-control" id="validationDefault02" placeholder="010-0000-0000" value="010-1234-5678" required>
						    </div>
						  
						  <div class="col-6 md-4 mb-3">
						      <label for="validationDefault03" class="form-label">주소</label>
						      <input type="text" class="form-control" id="validationDefault03" placeholder="City" required>
						    </div>
						    <div class="col-6 md-4 mb-3">
						      <label for="validationDefault04" class="form-label">비고</label>
						      <input type="text" class="form-control" id="validationDefault04" placeholder="State" required>
						    </div>
						  </div>
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
								    <div class="col-8">
								    <input type="text" class="form-control" id="address" value="${experience.address} " readonly>
								    </div>
								</div>
						</div>
						<div class="mb-3 ">
						  <label for="content" class="form-label">개요</label>
						  <textarea class="form-control" id="content" rows="5" readonly>${experience.content}</textarea>
						</div>		
						<div class="mb-3 ">
						  <label for="email" class="form-label">email</label>
						  <input type="text" class="form-control" id="address" value="${experience.email} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="phone" class="form-label">전화번호</label>
						  <input type="text" class="form-control" id="phone" value="${experience.phone} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="homepage" class="form-label">홈페이지</label>
						  <input type="text" class="form-control" id="homepage" value="${experience.homepage} " readonly>
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
						  <input type="text" class="form-control" id="age" value="${experience.age} " readonly>
						</div>
						<div class="mb-3 ">
						  <label for="inform" class="form-label">체험안내</label>
						   <textarea class="form-control" id="inform" rows="5" readonly>${experience.inform}</textarea>
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
						  	<div class="col-3 form-check">
								<input class="form-check-input" type="checkbox" name="is_credit"
								id="is_credit" value="1" ${experience.is_credit == 1?"checked":""} disabled> 
								<label class="form-check-label" for="is_credit">카드여부</label>
							</div>
							<div class="col-3 form-check">
								<input class="form-check-input" type="checkbox" name="is_pet"
								id="is_pet" value="1" ${experience.is_pet == 1?"checked":""} disabled> 
								<label class="form-check-label" for="is_pet">반려동물</label>
							</div>
							<div class="col-3 form-check">
							<input class="form-check-input" type="checkbox" name="is_parking"
								id="is_parking" value="1" ${experience.is_parking == 1?"checked":""} disabled> 
								<label class="form-check-label" for="is_parking">주차시설</label>
							</div>
							<div class="col-3 form-check">
							<input class="form-check-input" type="checkbox" name="is_stroller"
								id="is_stroller" value="1" ${experience.is_stroller == 1?"checked":""} disabled> 
								<label class="form-check-label" for="is_stroller">유모차대여</label>
							</div>
						</div>
						
							
							
						<hr class="hr" />			
						
						 <div class="d-flex justify-content-between">
						 
						 <c:choose>
							 <c:when test="${experience.is_deleted == 1}">
							 	<div class="col-6 mb-3" >
		                        	<button type="button" class="form-control btn btn-primary w-100" onclick="">복원</button>
		                        </div>
		                        <div class="col-6 mb-3">
		                        	<button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/experience?currentPage=1'">취소</button>
		                        </div>
		                    </c:when>
							 <c:when test="${experience.status == 0}">
							 	<div class="col-6 mb-3" >
		                              <button type="button" class="form-control btn btn-primary w-100" onclick="approveConfirm()">승인(게시하기)</button>
		                          </div>
		                            <div class="col-2 mb-3">
		                                <button type="button" class="btn btn-outline-secondary w-100" onclick="openRejectionPopup(${experience.content_id})">반려(사유선택)</button>
		                          </div>
		                          <div class="col-2 mb-3">
		                              <button type="button" class="btn btn-outline-secondary w-100" onclick="confirmDelete(${experience.content_id})">삭제</button>
		                          </div>
		                          <div class="col-1 mb-3">
		                              <button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/experience?currentPage=1'">목록</button>
		                          </div>
							 </c:when>
							 <c:when test="${experience.status == 1}">
							 	<div class="col-6 mb-3">
		                                <button type="button" class="form-control btn btn-primary2 w-100" onclick="location.href='../content/experienceUpdateForm?contentId=${experience.content_id}&currentPage=${currentPage}'">수정하기</button>
		                             </div>
		                             <div class="col-2 mb-3">
		                                <button type="button" class="btn btn-outline-secondary w-100" onclick="">반려전환</button>
		                             </div>
		                             <div class="col-2 mb-3">
		                                <button type="button" class="btn btn-outline-secondary w-100" onclick="confirmDelete(${experience.content_id})">삭제</button>
		                             </div>
		                          <div class="col-1 mb-3">
		                             <button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/experience?currentPage=1'">목록</button>
		                          </div>		
							 </c:when>
						</c:choose>
						 
						 	
						 	
						 	
						 	
						 	
						 	
						 	
						 	<%-- <c:if test="${experience.status == 0}">
	                          <div class="col-6 mb-3" >
	                              <button type="button" class="form-control btn btn-primary w-100" onclick="approveConfirm()">승인(게시하기)</button>
	                          </div>
	                            <div class="col-2 mb-3">
	                                <button type="button" class="btn btn-outline-secondary w-100" onclick="">대기(임시저장)</button>
	                          </div>
	                          <div class="col-2 mb-3">
	                              <button type="button" class="btn btn-outline-secondary w-100" onclick="openRejectionPopup(${experience.content_id})">반려(사유선택)</button>
	                          </div>
	                          <div class="col-1 mb-3">
	                              <button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/experience?currentPage=1'">삭제</button>
	                          </div>
	                         </c:if>
	                         <c:if test="${experience.status == 1}">
	                             <div class="col-6 mb-3">
	                                <button type="button" class="form-control btn btn-primary2 w-100" onclick="location.href='../content/experienceUpdateForm?contentId=${experience.content_id}&currentPage=${currentPage}'">수정하기</button>
	                             </div>
	                             <div class="col-2 mb-3">
	                                <button type="button" class="btn btn-outline-secondary w-100" onclick="">반려전환</button>
	                             </div>
	                             <div class="col-2 mb-3">
	                                <button type="button" class="btn btn-outline-secondary w-100" onclick="confirmDelete(${experience.content_id})">삭제</button>
	                             </div>
	                          <div class="col-1 mb-3">
	                             <button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/experience?currentPage=1'">목록</button>
	                          </div>
	                         </c:if> --%>
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