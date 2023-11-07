<%@page import="com.oracle.s202350104.configuration.Role"%>
<%@page import="org.springframework.security.core.authority.SimpleGrantedAuthority"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
// 현재 사용자의 인증 정보를 가져옵니다.
String username ="";
Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
if (authentication != null){
	username = authentication.getName();
}
	%>

