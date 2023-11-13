<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans&display=swap" rel="stylesheet">    
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link
  href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
  rel="stylesheet"
  integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
  crossorigin="anonymous"
/>
<script
  src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
  crossorigin="anonymous"
></script>
<style type="text/css">
:root {
    --bs-font-sans-serif: 'Noto Sans KR', sans-serif;
    --bs-btn-font-family: var(--bs-font-sans-serif);
}
    body {
    min-height: 100vh;
    min-height: -webkit-fill-available;
  }
  
  html {
    height: -webkit-fill-available;
  }
  
  
  .dropdown-toggle { outline: 0; }
  
  .btn-toggle {
    padding: .25rem .5rem;
    font-weight: 600;
    color: var(--bs-emphasis-color);
    background-color: transparent;
  }
  .btn-toggle:hover,
  .btn-toggle:focus {
    color: rgba(var(--bs-emphasis-color-rgb), .85);
    background-color: var(--bs-tertiary-bg);
  }
  
  .btn-toggle::before {
    width: 1.25em;
    line-height: 0;
    content: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='rgba%280,0,0,.5%29' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M5 14l6-6-6-6'/%3e%3c/svg%3e");
    transform-origin: .5em 50%;
  }
  
  [data-bs-theme="dark"] .btn-toggle::before {
    content: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='rgba%28255,255,255,.5%29' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M5 14l6-6-6-6'/%3e%3c/svg%3e");
  }
  
  .btn-toggle[aria-expanded="true"] {
    color: rgba(var(--bs-emphasis-color-rgb), .85);
  }
  .btn-toggle[aria-expanded="true"]::before {
    transform: rotate(90deg);
  }
  
  .btn-toggle-nav a {
    padding: .1875rem .5rem;
    margin-top: .125rem;
    margin-left: 1.25rem;
  }
  .btn-toggle-nav a:hover,
  .btn-toggle-nav a:focus {
    background-color: var(--bs-tertiary-bg);
  }
  
.sidebar {
	height: 100vh; /* 사이드바의 높이를 화면의 높이와 동일하게 설정 */
  overflow-y: auto; /* 사이드바의 내용이 화면을 넘어갈 경우 스크롤바를 표시 */
  background-color: #EEFFC2 !important;
}

.btn-toggle {
  color: black !important;
  background-color: #EEFFC2 !important;
  border: none;
  width: 100%;
  height: 45px;
  margin-bottom: 5px;
}

.btn-toggle:hover,
.btn-toggle:focus {
  background-color: #FF4379 !important;
  color: white !important;
}

.btn-toggle[aria-expanded="true"] {
  background-color: #FF4379 !important;
  color: white !important;
}

.admin-header-container {
	background: black;
    display: flex;
    align-items: center;
    height:110px;
    justify-content: left;
}

.title-bi {
	margin: 20px;
    align-items: center;
	font-weight: 800;
	font-size: 28px;	
	color: #EEFFC2;
}

.admin-header-title {
	color: #EEFFC2;
	font-size: 24px;
	font-family: Noto Sans;
	font-weight: 800;
    align-items: center;
}

</style>
<script>
function toggleTab(tabId) {
    var tabs = ["user-tab", "content-tab", "course-tab", "cs-tab", "notice-tab", "community-tab", "point-tab", "tag-tab", "admin-tab"];
    var collapses = ["user-collapse", "content-collapse", "course-collapse", "cs-collapse", "notice-collapse", "community-collapse", "point-collapse", "tag-collapse", "admin-collapse"];
    for (var i = 0; i < tabs.length; i++) {
        if (tabs[i] == tabId && document.getElementById(tabs[i]).getAttribute('aria-expanded') == 'false') {
            document.getElementById(tabs[i]).setAttribute('aria-expanded', 'true'); 
            document.getElementById(collapses[i]).style.transition = "height 0.2s ease-out";
            document.getElementById(collapses[i]).classList.add('show'); 
        } else if (tabs[i] == tabId && document.getElementById(tabs[i]).getAttribute('aria-expanded') == 'true') {
            document.getElementById(collapses[i]).style.transitionDuration = "0s";
            continue;
        } else {
            document.getElementById(tabs[i]).setAttribute('aria-expanded', 'false'); 
            document.getElementById(collapses[i]).style.transition = "height 0.5s ease-out";
            document.getElementById(collapses[i]).classList.remove('show'); 
        }
    }
}
</script>
    