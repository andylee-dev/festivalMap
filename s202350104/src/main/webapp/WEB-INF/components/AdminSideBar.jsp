<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- <nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Festimap</a>
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
</nav> -->

<!-- <div class="flex-shrink-0 p-3 col-md-3 border" style="width: 280px;">
 --><div class="sidebar border border-right col-md-3 col-lg-2 p-0 bg-body-tertiary">
        <a href="/" class="d-flex align-items-center pb-3 mb-3 link-body-emphasis text-decoration-none border-bottom">
          <svg class="bi pe-none me-2" width="30" height="24"><use xlink:href="#bootstrap"/></svg>
          <span class="fs-5 fw-semibold">Festimap</span>
        </a>
        <ul class="list-unstyled ps-0">
          <li class="mb-1">
            <button onclick="location.href='/admin'" class="btn d-inline-flex rounded border-0 collapsed" aria-expanded="true" >
	 	관리자 홈
            </button>
            
          <li class="mb-1">
            <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#user-collapse" aria-expanded="false">
              회원
            </button>
            <div class="collapse" id="user-collapse">
              <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                <li><a href="/admin/userList" class="link-body-emphasis d-inline-flex text-decoration-none rounded">일반회원</a></li>
                <li><a href="/admin/bizUserList" class="link-body-emphasis d-inline-flex text-decoration-none rounded">비즈니스회원</a></li>
              </ul>
            </div>
          </li>
          <li class="mb-1">
            <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#content-collapse" aria-expanded="false">
              지역정보
            </button>
            <div class="collapse" id="content-collapse">
              <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                <li><a href="/admin/festival" class="link-body-emphasis d-inline-flex text-decoration-none rounded">축제</a></li>
                <li><a href="/admin/restaurant" class="link-body-emphasis d-inline-flex text-decoration-none rounded">맛집</a></li>
                <li><a href="/admin/accomodation" class="link-body-emphasis d-inline-flex text-decoration-none rounded">숙박</a></li>
                <li><a href="/admin/spot" class="link-body-emphasis d-inline-flex text-decoration-none rounded">명소</a></li>
                <li><a href="/admin/experience" class="link-body-emphasis d-inline-flex text-decoration-none rounded">체험</a></li>
              </ul>
            </div>
          </li>
          <li class="mb-1">
            <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#course-collapse" aria-expanded="false">
              코스
            </button>
            <div class="collapse" id="course-collapse">
              <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">코스리스트</a></li>
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">코스등록</a></li>
              </ul>
            </div>
          </li>
          <li class="mb-1">
            <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#cs-collapse" aria-expanded="false">
              고객센터
            </button>
            <div class="collapse" id="cs-collapse">
              <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">FAQ</a></li>
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">1:1문의</a></li>
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">신고</a></li>
              </ul>
            </div>
          </li>
          <li class="mb-1">
              <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="board-collapse" aria-expanded="false">
                커뮤니티
            </button>
            <div class="collapse" id="board-collapse">
              <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">리뷰</a></li>
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">게시판</a></li>
              </ul>
            </div>
          </li>
          <li class="mb-1">
              <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#point-collapse" aria-expanded="false">
                포인트
            </button>
            <div class="collapse" id="#point-collapse">
              <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">포인트 관리</a></li>
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">포인트 내역</a></li>
              </ul>
            </div>
          </li>
          <li class="mb-1">
              <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="tag-collapse" aria-expanded="false">
                태그관리
            </button>
            <div class="collapse" id="tag-collapse">
              <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">태그리스트</a></li>
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">회원태그</a></li>
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">게시판태그</a></li>
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">컨텐츠태그</a></li>
              </ul>
            </div>
          </li>
          <li class="mb-1">
              <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed" data-bs-toggle="collapse" data-bs-target="#admin-collapse" aria-expanded="false">
                관리자 설정
            </button>
            <div class="collapse" id="#admin-collapse">
              <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">관리자리스트</a></li>
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">공통코드관리</a></li>
                <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">지역코드관리</a></li>
              </ul>
            </div>
          </li>
        </ul>

        <hr>
        <div class="dropdown">
          <a href="#" class="d-flex align-items-center link-body-emphasis text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
            <img src="https://github.com/mdo.png" alt="" width="32" height="32" class="rounded-circle me-2">
            <strong>mdo</strong>
          </a>
          <ul class="dropdown-menu text-small shadow">
            <li><a class="dropdown-item" href="#">New project...</a></li>
            <li><a class="dropdown-item" href="#">Settings</a></li>
            <li><a class="dropdown-item" href="#">Profile</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Sign out</a></li>
          </ul>
        </div>
      </div>