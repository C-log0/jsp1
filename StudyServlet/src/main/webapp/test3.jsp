<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>test3.jsp</h1>
	<form action="myServlet3" method="get">
		<input type="submit" value="myServlet3 서블릿 주소 요청(GET)">
	</form>
	
	<form action="myServlet3" method="POST">
		<input type="submit" value="myServlet3 서블릿 주소 요청(POST)">
	</form>
	
	<hr>
	<!-- 위에서 복붙 -->
	<form action="Servlet3_Write.test" method="POST">
		<input type="submit" value="myServlet3 서블릿 주소 요청(POST)">
	</form>
	
	<form action="Servlet3_List.test" method="POST">
		<input type="submit" value="Servlet3_List.test 서블릿 주소 요청(POST)">
	</form>
	
	
	
</body>
</html>