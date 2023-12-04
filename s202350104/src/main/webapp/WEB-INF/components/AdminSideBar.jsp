<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link href="/css/adminSidebar.css" rel="stylesheet" type="text/css">

<div class="sidebar d-flex shadow col-md-2 col-lg-2 p-1 bg-body-tertiary col-2 justify-content-center">
			<div class="col-10  justify-content-center align-items-center ">

		<a href="/" class="d-flex col-10 justify-content-center align-items-center p-3 m-3">
			<img src="/asset/logo.png" width="170" height="70" alt="Logo">
		</a>
		<ul class="list-unstyled ps-0">
<!-- 			<li class="mb-1">
				<button location.href='/admin'" class="btn d-inline-flex rounded border-0 ">관리자 홈</button>
 -->			<li class="mb-1">
				<button id="user-tab" onclick="toggleTab('user-tab')" class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
					data-bs-toggle="collapse" data-bs-target="#user-collapse" aria-expanded="false">회원</button>
				<div class="collapse" id="user-collapse">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="/admin/user/userList?small_code=2"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">일반회원</a></li>
						<li><a href="/admin/user/bizUserList"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">비즈니스회원</a></li>
						<li><a href="/admin/user/favoriteList"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">찜
								목록</a></li>
					</ul>
				</div>
			</li>
			<li class="mb-1">
				<button id="content-tab" onclick="toggleTab('content-tab')"
					class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed
					text-black fs-6 fw-normal font-family-Noto Sans"
					data-bs-toggle="collapse" data-bs-target="#content-collapse" aria-expanded="false">지역정보</button>
				<div class="collapse" id="content-collapse">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="/admin/content/festival"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">축제</a></li>
						<li><a href="/admin/content/restaurant"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">맛집</a></li>
						<li><a href="/admin/content/accomodation"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">숙박</a></li>
						<li><a href="/admin/content/spot"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">명소</a></li>
						<li><a href="/admin/content/experience"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">체험</a></li>
					</ul>
				</div>
			</li>
			<li class="mb-1">
				<button id="course-tab" onclick="toggleTab('course-tab')"
					class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
					data-bs-toggle="collapse" data-bs-target="#course-collapse" aria-expanded="false">코스</button>
				<div class="collapse" id="course-collapse">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="/admin/course/list"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">코스리스트</a></li>
					</ul>
				</div>
			</li>
			<li class="mb-1">
				<button id="cs-tab" onclick="toggleTab('cs-tab')" class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
					data-bs-toggle="collapse" data-bs-target="#cs-collapse" aria-expanded="false">고객센터</button>
				<div class="collapse" id="cs-collapse">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="/admin/cs/qna"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">1:1문의</a></li>
						<li><a href="/admin/cs/report"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">신고</a></li>
					</ul>
				</div>
			</li>
			<li class="mb-1">
				<button id="notice-tab" onclick="toggleTab('notice-tab')" 
					class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
					data-bs-toggle="collapse" data-bs-target="#notice-collapse" aria-expanded="false">공지</button>
				<div class="collapse" id="notice-collapse">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="/admin/notice/notice"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">공지</a></li>
						<li><a href="/admin/notice/banner"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">배너</a></li>
						<li><a href="/admin/notice/event"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">이벤트</a></li>
					</ul>
				</div>
			</li>
			<li class="mb-1">
				<button id="community-tab" onclick="toggleTab('community-tab')" 
					class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
					data-bs-toggle="collapse" data-bs-target="#community-collapse" aria-expanded="false">커뮤니티</button>
				<div class="collapse" id="community-collapse">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="/admin/community/review"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">리뷰</a></li>
						<li><a href="/admin/community/board"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">자유게시판</a></li>
						<li><a href="/admin/community/magazin"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">이달의소식</a></li>
					</ul>
				</div>
			</li>
			<li class="mb-1">
				<button id="point-tab" onclick="toggleTab('point-tab')" 
					class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
					data-bs-toggle="collapse" data-bs-target="#point-collapse" aria-expanded="false">포인트</button>
				<div class="collapse" id="point-collapse">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="/admin/point/point"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">포인트
								관리</a></li>
						<li><a href="/admin/point/pointhistory"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">포인트
								내역</a></li>
					</ul>
				</div>
			</li>
			<li class="mb-1"> 
				<button id="tag-tab" onclick="toggleTab('tag-tab')" class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
					data-bs-toggle="collapse" data-bs-target="#tag-collapse" aria-expanded="false">태그관리</button>
				<div class="collapse" id="tag-collapse">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="/admin/tag/list"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">태그리스트</a></li>
						<li><a href="/admin/tag/userTag"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">회원태그</a></li>
						<li><a href="/admin/tag/boardTag?smallCodeStr=2"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">게시판태그</a></li>
						<li><a href="/admin/tag/contentTag?bigCodeStr=11"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">컨텐츠태그</a></li>
						<li><a href="/admin/tag/courseTag?smallCodeStr=1"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">코스태그</a></li>
					</ul>
				</div>
			</li>
			<li class="mb-1">
				<button id="admin-tab" onclick="toggleTab('admin-tab')" 
					class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
					data-bs-toggle="collapse" data-bs-target="#admin-collapse" aria-expanded="false">관리자 설정</button>
				<div class="collapse" id="admin-collapse">
					<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
						<li><a href="/admin/admin/adminList"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">관리자리스트</a></li>
						<li><a href="/admin/admin/commonCode"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">공통코드관리</a></li>
						<li><a href="/admin/admin/areaCode"
								class="link-body-emphasis d-inline-flex text-decoration-none rounded">지역코드관리</a></li>
					</ul>
				</div>
			</li>
		</ul>

		<hr>
<!-- 		<div class="dropdown">
			<a href="#" class="d-flex align-items-center link-body-emphasis text-decoration-none dropdown-toggle"
				data-bs-toggle="dropdown" aria-expanded="false"> <img src="https://github.com/mdo.png" alt="" width="32"
					height="32" class="rounded-circle me-2"> <strong>mdo</strong>
			</a>
			<ul class="dropdown-menu text-small shadow">
				<li><a class="dropdown-item" href="#">New project...</a></li>
				<li><a class="dropdown-item" href="#">Settings</a></li>
				<li><a class="dropdown-item" href="#">Profile</a></li>
				<li>
					<hr class="dropdown-divider">
				</li>
				<li><a class="dropdown-item" href="#">Sign out</a></li>
			</ul>
		</div> -->
        <div class="col-10 mt-auto d-flex">
            <div class="px-1 bg-pink rounded-1 col-12 align-items-center">
                <div class="col-5 row justify-content-center align-items-center d-flex">
                    <div class="p-1 col-5 justify-content-center align-items-center d-flex">
                        <div class="px-0.5 py-0.5 col-8 justify-content-center align-items-center d-flex">
                        
                        </div>
                    </div>
                    <div class="p-1 col-7 justify-content-center align-items-center d-flex">
                        <p class="text-white fs-6 fw-semibold font-family-Poppins col-9 m-0 px-3 py-2">Logout</p>
                    </div>
                </div>
            </div>
        </div>

	</div>
	</div>
