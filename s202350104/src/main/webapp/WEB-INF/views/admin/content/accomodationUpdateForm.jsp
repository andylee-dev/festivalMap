<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>숙박 상세 정보</title>
		<link rel="stylesheet" type="text/css" href="/css/adminContentsDetail.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function getSigungu(pArea){
				var pSigungu = ${accomodation.sigungu}
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
				<h1>숙박 관리</h1>
				<hr class="hr" />
				</div>
				<div>
				<h3 style="color: #FF4379 ">숙소별 상세 정보</h3>
				</div>
				<div class="my-5">
				<div class="" id="detail-main-container">
					<div class="container d-flex justify-content-around" id="detail-top-container">
								<label id="detail-top-text">숙박 ㅣ </label>
								<label id="detail-top-text" >${accomodation.content_id} ㅣ</label>
								<c:choose>
									<c:when test="${accomodation.is_deleted == 1}">
									<label id="detail-top-id3" >삭제(게시X)</label>
									</c:when>
									<c:when test="${accomodation.status == 0}">
									<label id="detail-top-id" >승인대기</label>
									</c:when>
									<c:when test="${accomodation.status == 1}">
									<label id="detail-top-id2" >승인(게시중)</label>
									</c:when>
								</c:choose>				
					</div>
					<div class="container p-5" id="form-container">
					<form action="accomodation/update" method="post">
						<div class="mb-3">
						  <label for="content_id" class="form-label">컨텐츠 ID</label>
						  <input type="hidden" name="status" value="${accomodation.status}">
						  <input type="hidden" name="currentPage" value="${currentPage}">
						  <input type="text" class="form-control" id="content_id" name="content_id" value="${accomodation.content_id} " readonly>
						</div>	
						<div class="mb-3" id="detail-content-title">
						  <label for="small_code" class="form-label">숙박 종류</label>
							<input type="hidden" name="big_code" value="13">
							<select class="form-select" aria-label="small_code" name="small_code" required="required">
								<c:forEach var="smallCode" items="${listCodes}">
									<c:if test="${smallCode.big_code == 13 && smallCode.small_code != 999}">
										<option value="${smallCode.small_code}" ${smallCode.small_code == accomodation.small_code? 'selected' : '' }>${smallCode.content}</option>
									</c:if>
							 	</c:forEach>
							</select>
						</div>			
						<div class="mb-3 ">
						  <label for="title" class="form-label">숙소 이름</label>
						  <input type="text" class="form-control" name="title" id="title" value="${accomodation.title} " >
						</div>
						 <div class="mb-3 ">
							<label for="content" class="form-label ">지역</label>
								<div class="row">
								    <div class="col-2">
								        <!-- 첫 번째 그리드 -->
								        <select class="form-select" id="area" name="area" onchange="getSigungu(this.value)" >
								            <option value="">전체</option>
								            <c:forEach var="areas" items="${listAreas}">
								                <c:if test="${areas.sigungu == 999}">
								                    <option value="${areas.area}" ${areas.area == accomodation.area? 'selected':''}>${areas.content}</option>
								                </c:if>
								            </c:forEach>
								        </select>
								    </div>
								    <div class="col-2">
								        <!-- 두 번째 그리드 -->
								        <select class="form-select" id="sigungu_select" name="sigungu" >
								            <option value="999">전체</option>
								            <c:forEach var="areas" items="${listSigungu}">
								                <c:if test="${areas.sigungu != 999 && areas.sigungu != null}">
								                    <option value="${areas.sigungu}" ${areas.sigungu == accomodation.sigungu? 'selected':''}>${areas.content}</option>
								                </c:if>
								            </c:forEach>
								        </select>
								    </div>
								    	<div class="col-2">
								    		<input type="text" class="form-control" name="postcode" id="postcode" value="${accomodation.postcode}" >
								    	</div>
								    	<div class="col-6">
										    <input type="text" class="form-control" name="address" id="address" value="${accomodation.address} " >
								    	</div>
								</div>
						</div>
						<div class="mb-3 ">
						  <label for="content" class="form-label">개요</label>
						  <textarea class="form-control" name="content" id="content" rows="5" >${accomodation.content}</textarea>
						</div>		
						<div class="mb-3 ">
						  <label for="email" class="form-label">email</label>
						  <input type="text" name="email" class="form-control" id="email" value="${accomodation.email} " >
						</div>
						<div class="mb-3 ">
						  <label for="phone" class="form-label">전화번호</label>
						  <input type="text" name="phone" class="form-control" id="phone" value="${accomodation.phone} " >
						</div>
						<div class="mb-3 ">
						  <label for="homepage" class="form-label">홈페이지</label>
						  <input type="text" name="homepage" class="form-control" id="homepage" value="${accomodation.homepage} " >
						</div>
						<div class="mb-3 ">
						  <label for=created_at class="form-label">작성일</label>
						  <input type="text" name="created_at" class="form-control" id="created_at" value="<fmt:formatDate value="${accomodation.created_at}" pattern="YYYY/MM/dd"/>" >
						</div>
						<div class="mb-3 ">
						  <label for="room_count" class="form-label">객실수</label>
						  <input type="text" name="room_count" class="form-control" id="room_count" value="${accomodation.room_count} " >
						</div>
						<div class="mb-3 ">
						  <label for="reservation_url" class="form-label">예약처</label>
						  <input type="text" name="reservation_url" class="form-control" id="reservation_url" value="${accomodation.reservation_url} " >
						</div>						
						<div class="mb-3 ">
						  <label for="refund" class="form-label">환불규정</label>
						  <input type="text" name="refund" class="form-control" id="refund" value="${accomodation.refund} " >
						</div>
						<div class="mb-3 ">
						  <label for="check_in" class="form-label">입실시간</label>
						  <input type="text" name="check_in" class="form-control" id="check_in" value="${accomodation.check_in} " >
						</div>
						<div class="mb-3 ">
						  <label for="check_out" class="form-label">퇴실시간</label>
						  <input type="text" name="check_out" class="form-control" id="check_out" value="${accomodation.check_out} " >
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
						  	<div class="col-3 form-check mx-3">
								<input class="form-check-input" type="radio" name="is_credit"
								id="is_cook" value="1" ${accomodation.is_cook == 1?"checked":""} > 
								<label class="form-check-label" for="is_credit">조리가능</label>
							</div>
							<div class="col-3 form-check mx-3">
								<input class="form-check-input" type="radio" name="is_pet"
								id="is_pickup" value="1" ${accomodation.is_pickup == 1?"checked":""} > 
								<label class="form-check-label" for="is_pet">픽업가능</label>
							</div>
							<div class="col-3 form-check mx-3">
							<input class="form-check-input" type="radio" name="is_parking"
								id="is_parking" value="1" ${accomodation.is_parking == 1?"checked":""} > 
								<label class="form-check-label" for="is_parking">주차가능</label>
							</div>
						</div>
						
							
							
						<hr class="hr" />			
						
						 <div class="d-flex justify-content-between">
							<div class="col-6 mb-3" >
	                        	<button type="submit" class="form-control btn btn-primary w-100" onclick="return confirm('등록 하시겠습니까?')">등록</button>
	                        </div>
	                        <div class="col-3 mb-3">
	       	                 	<button type="reset" class="btn btn-outline-secondary w-100" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
	                        </div>
	                        <div class="col-2 mb-3">
	                        	<button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/accomodation'">취소</button>
	                        </div>
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