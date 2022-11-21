<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>applicationTest.jsp</h1>
	<!-- 
	application 객체
	- 웹 어플리케이션 서버(WAS = 웹 컨테이너 = 톰캣)에 대한 
	- 서버 당 하나의 application 객체가 생성됨
	=> 어플리케이션 전체 영역에서 하나의 객체를 공유함
	
	 -->
	 <h3>서버 정보 : <%=application.getServerInfo() %></h3>
	 <h3>서버 루트의 물리적 경로 정보 : <%=application.getRealPath("/") %></h3>
	 <h3>서버 컨텍스트(프로젝트) 경로 정보 : <%=application.getContextPath() %></h3>
</body>
</html>