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
<script src="/js/pagenation.js"></script>
<link href="/css/global.css" rel="stylesheet" type="text/css">
<link href="/css/admin.css" rel="stylesheet" type="text/css">
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
    