<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//로그아웃 처리
//=> 세션 초기화를 통해 저장된 세션 아이디 제거(redirect)
session.invalidate();

//메인 페이지로 포워딩
response.sendRedirect("sessionTest3_main.jsp");
%>
