<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.my-page-sidebar {
	background-color: #FF4379;
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
	background-color: #171717; /* 마우스를 올렸을 때의 배경색 */
}

.my-page-nav-link.active {
	background-color: #171717 !important; /* 마우스를 올렸을 때의 배경색 */
}

.title-bi{
 font-size: 20px;
}
</style>
<div
	class="d-flex flex-column flex-shrink-0 p-0 sidebar my-page-sidebar"
	style="width: 280px;">
	<ul class="nav flex-column mt-5 pt-4">
		<li class="nav-item my-page-nav-item">
			<div>
				<a href="/user/myPage"
					class="nav-link my-page-nav-link px-3 ${currentPageUrl eq '/user/myPage' ? 'active' : 'text-white'}"
					aria-current="page"> <i class="title-bi bi bi-gear-fill px-3"></i>
					계정관리
				</a>
			</div>
		</li>
		<li class="nav-item my-page-nav-item">
			<div>
				<a href="/user/myPage/myLike"
					class="nav-link my-page-nav-link px-3 ${currentPageUrl eq '/user/myPage/myLike' ? 'active' : 'text-white'}">
					<i class="title-bi bi bi-geo-fill px-3"></i>내 찜 목록
				</a>
			</div>
		</li>

		<li class="nav-item my-page-nav-item">
			<div>
				<a href="/user/myPage/myTag"
					class="nav-link my-page-nav-link px-3 ${currentPageUrl eq '/user/myPage/myTag' ? 'active' : 'text-white'}">
					<i class="title-bi bi bi-tags-fill px-3"></i>내 관심사
				</a>
			</div>
		</li>
		<li class="nav-item my-page-nav-item">
			<div>
				<a href="/user/myPage/myPost"
					class="nav-link my-page-nav-link px-3 ${currentPageUrl eq '/user/myPage/myPost' ? 'active' : 'text-white'}">
					<i class="title-bi bi bi-journal-richtext px-3"></i>내 게시글
				</a>
			</div>

		</li>
		<li class="nav-item my-page-nav-item">
			<div>
				<a href="/user/myPage/qnaList"
					class="nav-link my-page-nav-link px-3 ${currentPageUrl eq '/user/myPage/qnaList' ? 'active' : 'text-white'}">
					<i class="title-bi bi bi-wechat px-3"></i>1:1 문의
				</a>
			</div>
		</li>
	</ul>
</div>
