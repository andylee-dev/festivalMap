<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	<main>
		<div class="d-flex">
			<div class="col-2">
				<%@ include file="/WEB-INF/components/BizPageSideBar.jsp"%>
			</div>
			<div class="container p-5 col-10">
				<c:if test="${ experience != NULL  }">
					<%@ include
						file="/WEB-INF/views/user/bizPage/contentDetail/experienceDetail.jsp"%>
				</c:if>
				<c:if test="${ festival != NULL  }">
					<%@ include
						file="/WEB-INF/views/user/bizPage/contentDetail/festivalDetail.jsp"%>
				</c:if>
				<c:if test="${ restaurant != NULL  }">
					<%@ include
						file="/WEB-INF/views/user/bizPage/contentDetail/restaurantDetail.jsp"%>
				</c:if>
				<c:if test="${ accomodation != NULL  }">
					<%@ include
						file="/WEB-INF/views/user/bizPage/contentDetail/accomodationDetail.jsp"%>
				</c:if>
				<c:if test="${ spot != NULL  }">
					<%@ include
						file="/WEB-INF/views/user/bizPage/contentDetail/spotDetail.jsp"%>
				</c:if>
			</div>
		</div>
	</main>
</body>
</html>