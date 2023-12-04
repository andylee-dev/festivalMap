<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/MemberCheck.jsp" %>
<header id="topbar" class="d-flex justify-content-center">
	<nav class="navbar app-navbar navbar-expand-md navbar-light fixed-top justify-content-between ">
		<div class="container d-flex justify-content-between">
			<div>
				<a class="navbar-brand" href="/">
					<img src="/asset/logo.png" width="170" height="70" alt="Logo">
				</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
			</div>
			<div class="collapse navbar-collapse justify-content-center " id="navbarSupportedContent">
				<ul class="navbar-nav">
				        <li class="nav-item"><a class="nav-link app-nav-link mx-1" aria-current="page" href="/festival">축제</a></li>
				        <li class="nav-item"><a class="nav-link app-nav-link mx-1" href="/restaurant">맛집</a></li>
						<li class="nav-item"><a class="nav-link app-nav-link mx-1" href="/accomodation">숙박</a></li>
						<li class="nav-item"><a class="nav-link app-nav-link mx-1" href="/spot">명소</a></li>
						<li class="nav-item"><a class="nav-link app-nav-link mx-1" href="/experience">체험</a></li>
						<li class="nav-item"><a class="nav-link app-nav-link mx-1" href="/course">코스</a></li>
						<li class="nav-item"><a class="nav-link app-nav-link mx-1" href="/freeBoardList">커뮤니티</a></li>							
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">
							관리자 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="/admin">관리자홈</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="/user/bizPage">내정보</a></li>
							<li><a class="dropdown-item" href="/user/bizPage/content">내 컨텐츠 등록</a></li>
							<li><a class="dropdown-item" href="/user/myPage/qnaList">1:1문의</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="/user/myPage">내정보</a></li>
							<li><a class="dropdown-item" href="/user/myPage/myLike">내 찜 목록</a></li>
							<li><a class="dropdown-item" href="/user/myPage/myTag">내 관심사</a></li>
							<li><a class="dropdown-item" href="/user/myPage/myPost">내 게시글</a></li>
							<li><a class="dropdown-item" href="/user/myPage/qnaList">1:1문의</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="/join">회원가입</a></li>
							<li><a class="dropdown-item" href="/login">로그인</a></li>
							<li><a class="dropdown-item" href="/user/idSearch">아이디찾기</a></li>
							<li><a class="dropdown-item" href="/user/passwordSearch">비밀번호찾기</a></li>
							<li><a class="dropdown-item" href="/idSearch">아이디찾기</a></li>
							<li><a class="dropdown-item" href="/passwordSearch">비밀번호찾기</a></li>
						</ul></li>
				</ul>
			</div>
			<div>
			<%
				Collection<SimpleGrantedAuthority> authorities =(Collection<SimpleGrantedAuthority>) authentication.getAuthorities();
				if (authorities != null && authorities.stream().anyMatch(a -> a.getAuthority().contains("ADMIN"))){
			%>	
				<a href="/admin">관리자 페이지</a>&nbsp;
				<a href="/logout">로그아웃 </a>
				
			<%
				} else if (authorities != null && authorities.stream().anyMatch(a -> a.getAuthority().contains("BIZ"))){
			%>		
			    <a href="/user/bizPage">비즈니스 페이지</a>&nbsp;
				<a href="/logout">로그아웃  </a>
			<%
				} else if (authorities != null && authorities.stream().anyMatch(a -> a.getAuthority().contains("USER"))){
			%>
				<a href="/user/myPage">마이페이지</a>&nbsp;
				<a href="/logout">로그아웃  </a>
			<%
				}else{
			%>
					<a href="/login">로그인   </a>&nbsp;
					<a href="/join">회원가입</a>	
			<% 
				}
			%>	
			
			</div>

		</div>
	</nav>
</header>
