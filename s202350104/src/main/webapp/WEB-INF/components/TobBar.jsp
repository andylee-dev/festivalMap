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
							회원관리 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="sawonList.do">회원조회</a></li>
							<li><a class="dropdown-item" href="sawonInsertForm.do">회원등록</a>
							</li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">
							제품관리 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="itemList.do">제품조회</a></li>
							<li><a class="dropdown-item" href="itemInsertForm.do">제품등록</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">
							거래처관리 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="customList.do">거래처조회</a></li>
							<li><a class="dropdown-item" href="customInsertForm.do">거래처등록</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">
							주문관리 </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="orderList.do">주문조회</a></li>
							<li><a class="dropdown-item" href="orderInsertForm.do">주문등록</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>
</header>