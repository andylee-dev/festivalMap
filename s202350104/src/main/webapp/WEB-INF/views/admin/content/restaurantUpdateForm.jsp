<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Restaurant updateForm</title>
		<link rel="stylesheet" type="text/css" href="/css/adminContentsDetail.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function getSigungu(pArea){
				var pSigungu = ${restaurant.sigungu}
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
				<h1>맛집 수정</h1>
				<hr class="hr" />
				</div>
				<div>
				<h3 style="color: #FF4379 ">맛집정보 수정하기</h3>
				</div>
				<div class="my-5">
				<div class="" id="detail-main-container">
					<div class="container d-flex justify-content-around" id="detail-top-container">
								<label id="detail-top-text">맛집 ㅣ </label>
								<label id="detail-top-text" >${restaurant.content_id} ㅣ</label>
								<c:choose>
									<c:when test="${restaurant.status == 0}">
									<label id="detail-top-id" >승인대기</label>
									</c:when>
									<c:when test="${restaurant.status == 1}">
									<label id="detail-top-id2" >승인(게시중)</label>
									</c:when>
								</c:choose>
					</div>
					<div class="container p-5" id="form-container">
					<form action="restaurantUpdate" method="post">
						<div class="mb-3">
						  <label for="content_id" class="form-label">컨텐츠 ID</label>
						  <input type="hidden" class="form-control" name="id" id="content_id" value="${restaurant.content_id} ">
						  <input type="hidden" name="status" value="${restaurant.status }">
						  <input type="hidden" name="is_deleted" value="${restaurant.is_deleted }">
						</div>	
						<div class="mb-3" id="detail-content-title">
						  <label for="small_code" class="form-label">맛집 종류</label>
							<select class="form-select" aria-label="small_code" name="small_code">
								<c:forEach var="smallCode" items="${listSmallCode}">
									<c:if test="${smallCode.small_code != 999}">
										<option value="${smallCode.small_code}" ${smallCode.small_code == restaurant.small_code? 'selected' : '' }>${smallCode.content}</option>
									</c:if>
							 	</c:forEach>
							</select>
						</div>			
						<div class="mb-3 ">
						  <label for="title" class="form-label">맛집 이름</label>
						  <input type="text" class="form-control" name="title" id="title" value="${restaurant.title} ">
						</div>
						<div class="mb-3 ">
							<label for="content" class="form-label ">지역</label>
								<div class="row">
								    <div class="col-2">
								        <select class="form-select" id="area" name="area" onchange="getSigungu(this.value)">
								            <option value="">전체</option>
								            <c:forEach var="areas" items="${listAreas}">
								                <c:if test="${areas.sigungu == 999}">
								                    <option value="${areas.area}" ${areas.area == restaurant.area? 'selected':''}>${areas.content}</option>
								                </c:if>
								            </c:forEach>
								        </select>
								    </div>
								    <div class="col-2">
								        <select class="form-select" id="sigungu_select" name="sigungu">
								            <option value="999">전체</option>
								            <c:forEach var="areas" items="${listSigungu}">
								                <c:if test="${areas.sigungu != 999 && areas.sigungu != null}">
								                    <option value="${areas.sigungu}" ${areas.sigungu == restaurant.sigungu? 'selected':''}>${areas.content}</option>
								                </c:if>
								            </c:forEach>
								        </select>
								    </div>
								    <div class="col-8">
								    <input type="text" class="form-control" name="address" id="address" value="${restaurant.address} ">
								    </div>
								</div>
						</div>
						<div class="mb-3 ">
						  <label for="postcode" class="form-label">우편번호</label>
						  <input type="text" class="form-control" name="postcode" id="postcode" value="${restaurant.postcode} " >
						</div>
						<div class="mb-3 ">
						  <label for="phone" class="form-label">전화번호</label>
						  <input type="text" class="form-control" name="phone" id="phone" value="${restaurant.phone} " >
						</div>
						<div class="mb-3 ">
						  <label for="first_menu" class="form-label">대표메뉴</label>
						  <input type="text" class="form-control" name="first_menu" id="first_menu" value="${restaurant.first_menu} " >
						</div>
						<div class="mb-3 ">
						  <label for="menu" class="form-label">추천메뉴</label>
						  <input type="text" class="form-control" name="menu" id="menu" value="${restaurant.menu} " >
						</div>
						<div class="mb-3 ">
						  <label for="content" class="form-label">개요</label>
						  <textarea class="form-control" name="content" id="content" rows="5" placeholder="맛집에 대한 설명을 간략하게 작성해주세요." >${restaurant.content}</textarea>
						</div>		
						<div class="mb-3 ">
						  <label for="open_time" class="form-label">영업시간</label>
						  <input type="text" class="form-control" name="open_time" id="open_time" value="${restaurant.open_time} " >
						</div>
						<div class="mb-3 ">
						  <label for="rest_date" class="form-label">휴무일</label>
						  <input type="text" class="form-control" name="rest_date" id="rest_date" value="${restaurant.rest_date} " >
						</div>
						<div class="mb-3 ">
						  <label for=created_at class="form-label">작성일</label>
						  <input type="text" class="form-control" name="created_at" id="created_at" value="<fmt:formatDate value="${restaurant.created_at}" pattern="YYYY/MM/dd"/>" >
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
								<input class="form-check-input" type="checkbox" name="is_smoking"
								id="is_credit" value="1" ${restaurant.is_smoking == 1?"checked":""} > 
								<label class="form-check-label" for="is_credit">흡연가능</label>
							</div>
							<div class="col-3 form-check">
								<input class="form-check-input" type="checkbox" name="is_packing"
								id="is_pet" value="1" ${restaurant.is_packing == 1?"checked":""} > 
								<label class="form-check-label" for="is_packing">포장가능</label>
							</div>
							<div class="col-3 form-check">
							<input class="form-check-input" type="checkbox" name="is_parking"
								id="is_parking" value="1" ${restaurant.is_parking == 1?"checked":""} > 
								<label class="form-check-label" for="is_parking">주차가능</label>
							</div>
						</div>
												
						<!-- <div class="mt-3">
						  <label for="formFileMultiple" class="form-label">등록 이미지</label>
						  <input class="form-control" type="file" id="formFileMultiple" multiple>
						</div> -->	
							
						<hr class="hr" />			
						
						
						
						<div class="d-flex justify-content-between">
							<div class="col-6 mb-3" >
	                        	<button type="submit" class="form-control btn btn-primary2 w-100" onclick="return confirm('수정하시겠습니까?')">수정</button>
	                        </div>
	                        <div class="col-3 mb-3">
	                        	<button type="reset" class="btn btn-outline-secondary w-100" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
	                        </div>
	                        <div class="col-2 mb-3">
	                        	<button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/restaurantDetail?contentId=${restaurant.content_id}&currentPage=${currentPage}'">취소</button>
	                        </div>
						</div>
						
						<%-- <div>
							<button type="submit" class="btn btn-outline-secondary" onclick="return confirm('수정하시겠습니까?')">수정</button>
							<button type="reset" class="btn btn-outline-secondary" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
							<button type="button" class="btn btn-outline-secondary" onclick="location.href='../content/restaurantDetail?contentId=${restaurant.content_id}&currentPage=${currentPage}'">취소</button>
						</div> --%>
				
						 
						 <%-- <div class="d-flex justify-content-between">
						 	<c:if test="${restaurant.status == 0}">
	                          <div class="col-6 mb-3" >
	                              <button type="button" class="form-control btn btn-primary w-100" onclick="approveConfirm()">승인(게시하기)</button>
	                          </div>
	                            <div class="col-2 mb-3">
	                                <button type="button" class="btn btn-outline-secondary w-100" onclick="">대기(임시저장)</button>
	                          </div>
	                          <div class="col-2 mb-3">
	                              <button type="button" class="btn btn-outline-secondary w-100" onclick="openRejectionPopup(${restaurant.content_id})">반려(사유선택)</button>
	                          </div>
	                          <div class="col-1 mb-3">
	                              <button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/restaurant?currentPage=1'">삭제</button>
	                          </div>
	                          </c:if>
	                          <c:if test="${restaurant.status == 1}">
	                             <div class="col-6 mb-3">
	                                <button type="button" class="form-control btn btn-primary2 w-100" onclick="location.href='../content/restaurantUpdateForm?contentId=${restaurant.content_id}&currentPage=${currentPage}'">수정하기</button>
	                             </div>
	                             <div class="col-2 mb-3">
	                                <button type="button" class="btn btn-outline-secondary w-100" onclick="">승인대기전환</button>
	                             </div>
	                             <div class="col-2 mb-3">
	                                <button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/restaurant?currentPage=1'">반려전환</button>
	                             </div>
	                          <div class="col-1 mb-3">
	                             <button type="button" class="btn btn-outline-secondary w-100" onclick="deleteConfirm()">삭제</button>
	                          </div>
	                          </c:if>
	                      </div> --%>
							
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