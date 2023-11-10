<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <div class="d-flex flex-column flex-shrink-0 p-3 text-bg-dark sidebar" style="width: 280px;">
    <a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
      <span class="fs-4">BizPage</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <a href="/user/bizPage" class="nav-link ${currentPage eq '/user/bizPage' ? 'active' : 'text-white'} "aria-current="page">
          계정관리${page}
        </a>
      </li>
      <li>
        <a href="/user/bizPage/content" class="nav-link ${currentPage eq '/user/bizPage/content' ? 'active' : 'text-white'}">
          내 컨텐츠
        </a>
      </li>
      <li>
        <a href="/user/myPage/qnaList" class="nav-link  ${currentPage eq '/user/bizPage/qna' ? 'active' : 'text-white'}">
     1:1문의
        </a>
      </li>
    </ul>
 </div>	