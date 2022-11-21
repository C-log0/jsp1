<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 세션 유지시간 -->
	<h3>현재 세션 유지시간 : <%=session.getMaxInactiveInterval() %> 초</h3>
	
	<!-- 변경된 세션 유지시간 -->
	<%session.setMaxInactiveInterval(10); %>
	<h3>변경 후 세션 유지시간 : <%=session.getMaxInactiveInterval() %> 초</h3>

	<h1>sessionTest1.jsp</h1>
	<h3>새 세션 여부 : <%=session.isNew() %></h3>
	<h3>세션 아이디 : <%=session.getId() %></h3>
	<h3>세션 생성 시간 : <%=new Date(session.getCreationTime()) %></h3>
	<h3>세션 마지막 접근 시간 : <%=new Date(session.getLastAccessedTime()) %></h3>
	
	<hr>
	<!-- 세션 강제 초기화(=세션 객체를 제거) -->
	<%session.invalidate();%>
	<h3>새 세션 여부 : <%=session.isNew() %></h3> <!-- 이 코드 실행 시 오류 발생! -->
	<!-- 
	세션 정보 초기화(삭제) 후에는 삭제한 페이지에서 세션 객체에 접근 불가능
	=> 새로운 세션 생성 전 까지 접근 불가
	=> e다른 페이지로 이동하는 등의 작업 수행하여 서버와 통신 수행하면 새 세션 객체가 생성됨
	 -->
</body>
</html>