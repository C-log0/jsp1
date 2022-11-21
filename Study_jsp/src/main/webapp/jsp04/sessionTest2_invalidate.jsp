<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>sessionTest2_invalidate</h1>
	
	<%
	//세션 초기화 방법
	//=>sesseion.invalidate()
	//=>특정
	session.invalidate();
	%>
	<h1>세션 초기화 완료!</h1>
	<input type="button" value="세션값 확인" onclick="location.href='sessionTest2_get.jsp'">
</body>
</html>