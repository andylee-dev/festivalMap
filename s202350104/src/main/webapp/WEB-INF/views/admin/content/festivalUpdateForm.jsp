<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>축제 정보 수정</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/css/bootstrap.min.css" rel="stylesheet" />
 	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/js/bootstrap.bundle.min.js" type="module"></script>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<style>
		  .form-control-focus {
		  color: #212529;
		  background-color: #fff;
		  border-color: #86b7fe;
		  outline: 0;
		  box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
		}
		
		.was-validated :valid + .form-control-focus {
		  border-color: #198754;
		  box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.25);
		}
		
		.was-validated :invalid + .form-control-focus {
		  border-color: #dc3545;
		  box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25);
		}
		</style>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<!-- 지역 코드 넣는 코드  Start-->	
		<script src="/js/updateArea.js"></script>
		<script type="text/javascript">
			document.addEventListener("DOMContentLoaded", function() {
				updateAreaOptions();
				$(".area-dropdown").change(function() {
					const selectedArea = $(this).val();
					if (selectedArea) {
						updateSigunguOptions(selectedArea);
					} else {
						$(".sigungu-dropdown").empty().append("<option value=''>전체</option>");
					}
				});
			});
		</script>
		<!-- 지역 코드 넣는 코드  End-->	
		
		<script type="module">
   			import Tags from "https://cdn.jsdelivr.net/gh/lekoala/bootstrap5-tags@master/tags.js";
    		Tags.init("select");
 		</script>
	</head>
	<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">축제 정보 수정</h1>
				</div>
				
				<!-- Section2: Table -->		
				<div class="border p-3 m-3">
					<form action="festivalUpdate" method="post">
						<%-- <input type="hidden" name="user_id" value="<%= loggedId %>"> --%>
						<input type="hidden" name="currentPage" value="${currentPage}">
						<input type="hidden" name="status" value="${festival.status}">
						<table class="table table-striped table-sm">
							<tr>
								<th>컨텐츠 ID</th>
								<td><input type="hidden" name="content_id" value="${festival.content_id}">${festival.content_id}</td>
							</tr>
							<tr>
								<th>분류</th>
								<td>
									<input type="hidden" name="big_code" value="11">[Festival] ${festival.scode_content}<br>
									<select id="small_code" name="small_code">
										<c:forEach var="code" items="${listCodes}">
											<c:if test="${code.big_code == 11 && code.small_code != 999}">
												<option value="${code.small_code}" ${code.small_code == festival.small_code? 'selected' : '' }>${code.content}</option>
											</c:if>
										</c:forEach>
									</select></td>
							</tr>
							<tr>
								<th>축제명</th>
								<td><input type="text" name="title" value="${festival.title}" required="required"></td>
							</tr>
							<tr>
								<th>시작일</th>
								<td><input type="date" name="start_date" value="${festival.start_date}"></td>
							</tr>
							<tr>
								<th>종료일</th>
								<td><input type="date" name="end_date" value="${festival.end_date}"></td>
							</tr>
							<tr>
								<th>진행시간</th>
								<td><input type="text" name="hours" value="${festival.hours}"></td>
							</tr>
							<tr>
								<th>주최자</th>
								<td><input type="text" name="sponsor" value="${festival.sponsor}"></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><input type="tel" name="phone" placeholder="010 - 0000 - 0000"
									pattern="\d{2,3}-\d{3,4}-\d{4}" value="${festival.phone}"></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type="email" name="email" value="${festival.email}"></td>
							</tr>
							<tr>
								<th>장소명</th>
								<td><input type="text" name="eventplace" value="${festival.eventplace}"></td>
							</tr>
							<tr>
								<th>지역</th>
								<td>${festival.area_content} ${festival.sigungu_content} <br>
									<%-- <select id="area" name="area" onchange="getSigungu(this.value)">
										<option value="0">전체</option>
										<c:forEach var="areas" items="${listAreas}">
											<c:if test="${areas.sigungu == 999}">
												<option value="${areas.area}" ${areas.area == festival.area? 'selected':''}>${areas.content}</option>
											</c:if>
										</c:forEach>
									</select>
									<select name="sigungu" id="sigungu_list_select">
										<option value="0">전체</option>
										<c:forEach var="areas" items="${listSigungu}">
											<c:if test="${areas.sigungu != 999 && areas.sigungu != null}">
												<option value="${areas.sigungu}" ${areas.sigungu == festival.sigungu? 'selected':''}>${areas.content}</option>
											</c:if>
										</c:forEach>
									</select> --%>
									<div class="container">
										<select name="area" class="area-dropdown"></select>
										<select name="sigungu"  class="sigungu-dropdown"></select>
								  	</div>
								</td>
							</tr>
							<tr>
								<th>주소</th>
								<td><%-- postcode & address --%></td>
							</tr>
							<tr>
								<th>개요</th>
								<td><textarea rows="10" cols="60" name="content" maxlength="4000" 
									placeholder="축제에 대한 설명을 4000자 이내로 입력해주세요">${festival.content}</textarea></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea rows="10" cols="60" name="overview" maxlength="2000" 
									placeholder="축제 내용에 대한 설명을 2000자 이내로 입력해주세요  ">${festival.overview}</textarea></td>
							</tr>
							<tr>
								<th>이용요금</th>
								<td><input type="text" name="cost" value="${festival.cost}"></td>
							</tr>
							<tr>
								<th>홈페이지</th>
								<td><input type="text" name="homepage" value="${festival.homepage}"></td>
							</tr>
							<tr>
								<th>이미지</th>
								<td><!-- 이미지 추가/삭제할 수 있는 폼 만들기 img1 img2 img3 --></td>
							</tr>
							<tr>
								<th>태그</th>
								<td>
									<div class="container">
										<div class="row mb-3 g-3">
						      			  <div class="col-md-4">
						         			 <select class="form-select" id="validationTagsClear" name="tagsClear[]" multiple data-allow-clear="true">
						            			<option selected disabled hidden value="">태그를 선택해주세요.</option>
									            <c:forEach var="tag" items="${listTags}">
									            	<option value="${tag.id}" data-badge-style="info">${tag.name}</option>
									            </c:forEach>
									          </select>
									          <div class="invalid-feedback">유효한 태그를 선택해주세요.</div>
									        </div>
									      </div>
						  			</div>
								</td>
							</tr>
							<tr>
								<th>가능 여부</th>
								<td>
									<input type="checkbox" name="is_parking" value="1" ${festival.is_parking == 1? 'checked':''}>주차시설<br>
									<input type="checkbox" name="is_stroller" value="1" ${festival.is_stroller == 1? 'checked':''}>유모차대여<br>
									<input type="checkbox" name="is_wheelchair" value="1" ${festival.is_wheelchair == 1? 'checked':''}>휠체어대여<br>
									<input type="checkbox" name="is_restroom" value="1" ${festival.is_restroom == 1? 'checked':''}>장애인화장실
								</td>
							</tr>
							<tr>
								<th>등록자</th>
								<td>
									<input type="text" name="user_id" value="${festival.user_id}">
								</td>
							</tr>
						</table>
						<div align="center">
							<button type="submit" class="btn btn-outline-secondary" onclick="return confirm('수정하시겠습니까?')">수정</button>
							<button type="reset" class="btn btn-outline-secondary" onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
						</div>
					</form>
				</div>		
			</main>
		</div>
		</div>
	</body>
</html>