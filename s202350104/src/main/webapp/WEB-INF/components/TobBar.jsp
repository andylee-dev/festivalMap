<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<header id="main_menu">
	<!-- <nav class="navbar navbar-expand-md navbar-light fixed-top">-->
	<nav class="navbar navbar-expand-lg">
		<div class="container-fluid">
			<a class="navbar-brand" href="main.do">Navbar</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">
							축제 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="festival">축제리스트</a></li>
							<li><a class="dropdown-item" href="festival/detail">축제상세</a>
							</li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">
							맛집 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="restaurant">맛집리스트</a></li>
							<li><a class="dropdown-item" href="restaurant/detail">맛집상세</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">
							숙박 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="accomodation">숙박리스트</a></li>
							<li><a class="dropdown-item" href="accomodation/detail">숙박상세</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">
							명소 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="spot">명소리스트</a></li>
							<li><a class="dropdown-item" href="spot/detail">명소상세</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">
							체험 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="experience">체험리스트</a></li>
							<li><a class="dropdown-item" href="experience/detail">체험상세</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">
							코스 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="courses">코스리스트</a></li>
							<li><a class="dropdown-item" href="courses/detail">코스상세</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">
							커뮤니티 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemList.do">자유게시판</a></li>
							<li><a class="dropdown-item" href="itemList.do">공지사항</a></li>
							<li><a class="dropdown-item" href="itemList.do">여행꾹꾹</a></li>
							<li><a class="dropdown-item" href="itemList.do">이달의 소식</a></li>
							<li><a class="dropdown-item" href="itemList.do">이벤트</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">
							인증인가 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemList.do">회원가입</a></li>
							<li><a class="dropdown-item" href="itemList.do">로그인</a></li>
							<li><a class="dropdown-item" href="itemList.do">아이디찾기</a></li>
							<li><a class="dropdown-item" href="itemList.do">비밀번호찾기</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">
							마이페이지 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemList.do">내정보</a></li>
							<li><a class="dropdown-item" href="itemList.do">내 축제</a></li>
							<li><a class="dropdown-item" href="itemList.do">내 관심사</a></li>
							<li><a class="dropdown-item" href="itemList.do">1:1문의</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">
							비즈니스 페이지 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemList.do">내정보</a></li>
							<li><a class="dropdown-item" href="itemList.do">내 컨텐츠 등록</a></li>
							<li><a class="dropdown-item" href="itemList.do">1:1문의</a></li>
						</ul></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">
							관리자 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="/admin">관리자홈</a></li>
							<li><a class="dropdown-item" href="orderInsertForm.do">주문등록</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>
</header>