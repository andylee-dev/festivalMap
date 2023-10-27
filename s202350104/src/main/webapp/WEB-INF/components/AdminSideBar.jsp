<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
           	 회원관리
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">일반회원 리스트</a></li>
            <li><a class="dropdown-item" href="#">행사담당자 리스트</a></li>
          </ul>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
           	 지역정보
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">축제</a></li>
            <li><a class="dropdown-item" href="#">맛집</a></li>
            <li><a class="dropdown-item" href="#">숙박</a></li>
            <li><a class="dropdown-item" href="#">명소</a></li>
            <li><a class="dropdown-item" href="#">체험</a></li>
          </ul>
        </li>
        
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">코스관리</a>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
           	 고객센터
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">FAQ</a></li>
            <li><a class="dropdown-item" href="#">1:1문의</a></li>
            <li><a class="dropdown-item" href="#">신고</a></li>
          </ul>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
           	 공지 및 알림
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">공지</a></li>
            <li><a class="dropdown-item" href="#">배너</a></li>
            <li><a class="dropdown-item" href="#">이벤트</a></li>
          </ul>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
           	 커뮤니티
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">리뷰</a></li>
            <li><a class="dropdown-item" href="#">자유게시판</a></li>
          </ul>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
           	 포인트
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">포인트 관리</a></li>
            <li><a class="dropdown-item" href="#">포인트 내역</a></li>
          </ul>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
           	 태그관리
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">태그리스트</a></li>
            <li><a class="dropdown-item" href="#">회원태그</a></li>
            <li><a class="dropdown-item" href="#">게시판태그</a></li>
            <li><a class="dropdown-item" href="#">컨텐츠태그</a></li>
          </ul>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
           	 관리자 설정
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">관리자 리스트</a></li>
            <li><a class="dropdown-item" href="#">관리자 등록</a></li>
          </ul>
        </li>
        
      </ul>
      
      <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
        
    </div>
  </div>
</nav>