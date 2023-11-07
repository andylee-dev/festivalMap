<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <div class="d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary sidebar" style="width: 280px;">
    <a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
      <svg class="bi pe-none me-2" width="40" height="32"><use xlink:href="#bootstrap"/></svg>
      <span class="fs-4">Sidebar</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <a href="/user/myPage" class="nav-link active" aria-current="page">
          계정관리
        </a>
      </li>
      <li>
        <a href="/user/myPage/myLike" class="nav-link text-white">
          내 찜 목록
        </a>
      </li>
      <li>
        <a href="/user/myPage/myTag" class="nav-link text-white">
          내 관심사
        </a>
      </li>
      <li>
        <a href="/user/myPage/myPost" class="nav-link text-white">
          내 게시글
        </a>
      </li>
      <li>
        <a href="/user/myPage/qnaList" class="nav-link text-white">
     1:1 문의
        </a>
      </li>
    </ul>
 </div>	