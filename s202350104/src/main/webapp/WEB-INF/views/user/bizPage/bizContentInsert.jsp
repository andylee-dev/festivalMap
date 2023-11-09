<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
    .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
        background-color: #F8FCF4 !important; /* 원하는 배경색으로 변경 */
        color: #00000 !important; /* 원하는 텍스트 색상으로 변경 */
    }

    .tab-pane.fade.show.active {
        background-color: #F8FCF4; /* 원하는 배경색으로 변경 */
    }


</style>
</head>
<body>
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<div class="d-flex">
		<%@ include file="/WEB-INF/components/BizPageSideBar.jsp" %>
		<div id="exTab3" class="container p-5">	
			<nav>
			  <div class="nav nav-tabs " id="nav-tab" role="tablist">
			    <button class="nav-link active" id="nav-festival-tab" data-bs-toggle="tab" data-bs-target="#nav-festival" type="button" role="tab" aria-controls="nav-festival" aria-selected="true">축제</button>
			    <button class="nav-link" id="nav-restaurant-tab" data-bs-toggle="tab" data-bs-target="#nav-restaurant" type="button" role="tab" aria-controls="nav-restaurant" aria-selected="false">맛집</button>
			    <button class="nav-link" id="nav-accomodation-tab" data-bs-toggle="tab" data-bs-target="#nav-accomodation" type="button" role="tab" aria-controls="nav-accomodation" aria-selected="false">숙박</button>
			    <button class="nav-link" id="nav-experience-tab" data-bs-toggle="tab" data-bs-target="#nav-experience" type="button" role="tab" aria-controls="nav-experience" aria-selected="false">체험</button>
			    <button class="nav-link" id="nav-spot-tab" data-bs-toggle="tab" data-bs-target="#nav-spot" type="button" role="tab" aria-controls="nav-spot" aria-selected="false">맛집</button>
			  </div>
			</nav>
			<div class="tab-content" id="nav-tabContent">
			  <div class="tab-pane fade show active" id="nav-festival" role="tabpanel" aria-labelledby="nav-festival-tab" tabindex="0">
			  	<div class="container">
			  		<%@ include file="/WEB-INF/views/admin/content/festivalInsertForm.jsp" %>
			  	</div>
			  </div>
			  <div class="tab-pane fade" id="nav-restaurant" role="tabpanel" aria-labelledby="nav-restaurant-tab" tabindex="0">
			  	맛집 등록 폼				  
			  </div>
			  <div class="tab-pane fade" id="nav-accomodation" role="tabpanel" aria-labelledby="nav-accomodation-tab" tabindex="0">
			  	<%@ include file="/WEB-INF/views/admin/content/accomodationInsertForm.jsp" %>
			  
			  </div>
			  <div class="tab-pane fade" id="nav-experience" role="tabpanel" aria-labelledby="nav-experience-tab" tabindex="0">
			  	체험 등록 폼		  	
			  </div>
			  <div class="tab-pane fade" id="nav-spot" role="tabpanel" aria-labelledby="nav-spot-tab" tabindex="0">
			  	명소 등록 폼	
			  </div>
			</div>
		</div>
	</div>
</body>
</html>