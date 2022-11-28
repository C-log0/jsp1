<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>test4.jsp</h1>
	<form action="test4/myServlet" method="get">
		이름 : <input type="text" name="name"><br>
		나이 : <input type="text" name="age"><br>
		<input type="submit" value="test4/myServlet 서블릿 주소 요청(GET)">
	</form>
	
	<form action="test4/myServlet" method="POST">
		이름 : <input type="text" name="name"><br>
		나이 : <input type="text" name="age"><br>
		<input type="submit" value="test4/myServlet 서블릿 주소 요청(POST)">
	</form>
	
	
	
	
	
</body>
</html>