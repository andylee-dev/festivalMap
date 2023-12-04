<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
body {
	position: relative; /* 부모 요소에 position: relative; 설정 */
}

.biz-page-sidebar {
	background-color: #171717;
	position: absolute; /* 사이드바에 position: static; 설정 */
	height: 100%; /* 사이드바의 높이를 부모 요소의 높이와 동일하게 설정 */
	overflow-y: auto; /* 사이드바의 내용이 화면을 넘어갈 경우 스크롤바를 표시 */
}

.my-page-nav-link {
	color: white;
	font-size: 16px;
	font-family: Noto Sans;
	font-weight: 600;
	word-wrap: break-word;
	padding: 20px 0;
}

.my-page-nav-item a {
	align-items: center;
}

.my-page-nav-link:hover {
	background-color: #9BDB04; /* 마우스를 올렸을 때의 배경색 */
	color: #171717 !important;
}

.my-page-nav-link.active {
	background-color: #9BDB04 !important; /* 마우스를 올렸을 때의 배경색 */
	color: #171717 
}

.title-bi {
	font-size: 20px;
}
</style>
<div class="d-flex flex-column flex-shrink-0 p-0 sidebar biz-page-sidebar"
	style="width: 280px;">
	<ul class="nav flex-column mt-5 pt-4">
		<li class="nav-item my-page-nav-item">
			<div>
				<a href="/user/bizPage"
					class="nav-link my-page-nav-link px-3 ${currentPageUrl eq '/user/bizPage' ? 'active' : 'text-white'} "
					aria-current="page"> <i class="title-bi bi bi-gear-fill px-3"></i>
					계정관리
				</a>
			</div>
		</li>
		<li class="nav-item my-page-nav-item">
			<div>

				<a href="/user/bizPage/content"
					class="nav-link my-page-nav-link px-3 ${currentPageUrl eq '/user/bizPage/content' ? 'active' : 'text-white'}">
					<i class="title-bi bi bi-journal-richtext px-3"></i> 내 컨텐츠
				</a>
			</div>
		</li>
		<li class="nav-item my-page-nav-item">
			<div>
				<a href="/user/myPage/qnaList"
					class="nav-link my-page-nav-link px-3  ${currentPageUrl eq '/user/bizPage/qna' ? 'active' : 'text-white'}">
					<i class="title-bi bi bi-wechat px-3"></i>1:1문의
				</a>
			</div>
		</li>
	</ul>
</div>
