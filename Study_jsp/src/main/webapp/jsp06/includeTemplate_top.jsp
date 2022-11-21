<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%
	String id = (String)session.getAttribute("sId");
	%>    
	<h4>includeTemplate_top.jsp</h4>
	<div align="right">
		<h5>
			<!-- 로그인 성공, 실패에 따른 작업 수행(= 다른 링크 표시) -->
			<!-- 세션 아이디가 없을 경우(null) 로그인, 회원가입 링크 표시 -->
			<!-- 세션 아이디가 있을 경우(null 아님) 세션 아이디, 로그아웃 링크 표시 -->
			<%if(id == null) { %>
				<a href="#">로그인</a> | 
				<a href="#">회원가입</a>
			<%} else { %>
				<%=id %> 님 | <a href="#">로그아웃</a>
			<%} %>
		</h5>
	</div>
	<div align="center">
		<a href="">상단메뉴1</a>&nbsp;&nbsp;&nbsp;
		<a href="">상단메뉴2</a>&nbsp;&nbsp;&nbsp;
		<a href="">상단메뉴3</a>&nbsp;&nbsp;&nbsp;
		<a href="">상단메뉴4</a>&nbsp;&nbsp;&nbsp;
		<a href="">상단메뉴5</a>
	</div>
</body>
</html>