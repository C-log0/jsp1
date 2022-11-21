<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>학생 추가</h1>
	<!--  -->
	<form action = "insertPro.jsp" method="get">
		<table border="1">
			<tr><th>번호</th><td><input type="text" name ="idx"></td></tr>
			<tr><th>이름</th><td><input type="text" name ="name"></td></tr>
			<tr><td colspan="2"><input type="submit" value ="추가"></td></tr>
		</table>
	</form>
</body>
</html>