<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>컨텐츠 태그 추가</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function getSmallCode(pBcode) {
				$.ajax(
						{
							url:"/getSmallCode",
							dataType:'json',
							success:function(code) {
								$('#scode_list_select option').remove();
								str = "<option value='999'>전체</option>";
								$(code).each(
									function() {
										if(pBcode == this.big_code && this.small_code != 999 && this.content != null) {
											strOption = "<option value='"+this.small_code+"'> "+this.content+"</option>";
											str += strOption;
										}
									}
								)
								$('#scode_list_select').append(str);
							}
						}		
				)
			}
			
			function getContent(pScode) {
				var pBcode = $('#bcode_list_select').val();
				$.ajax(
						{
							url:"/getContent",
							data: { big_code = pBcode,
									small_code = pScode
								   },
							dataType:'json',
							success:function(code) {
								$('#content_list_select').remove();
								str = "<option value=''>전체</option>";
								$(code).each(
									function() {
										if( pBcode == this.big_code && pScode == this.small_code && this.content != null) {
											strOption = "<option value='"+this.content_id+"'> "+this.content+"</option>";
											str += strOption;
										}
									}		
								)
								$('#content_list_select').append(str);
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
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">컨텐츠 태그 추가</h1>
				</div>
				
				<!-- Section2: Insert Form -->		
				<div class="border p-3 m-3">
					<c:if test="${msg != null}">${msg}</c:if>
					<form action="insertTagsFormContent" method="post">
						<select name="big_code" id="bcode_list_select" onchange="getSmallCode(this.value)">
							<option value="">전체</option>
							<c:forEach var="code" items="${listCodes}">
								<c:if test="${code.small_code == 999}">
									<option value="${code.big_code}">${code.content}</option>
								</c:if>
							</c:forEach>
						</select>
						<select name="small_code" id="scode_list_select" onchange="getContent(this.value)"><!-- ajax getSmallCode --></select>
						<select name="content" id="content_list_select"><!-- ajax getContent --></select>
						<input type="button" value="검색">
					</form>
				</div>
			</main>
		</div>
		</div>
	</body>
</html>