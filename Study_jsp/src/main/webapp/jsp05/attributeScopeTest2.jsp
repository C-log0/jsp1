<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>attributeScopeTest2.jsp</h1>
	
	<!-- 영역 객체에 속성값을 저장한 페이지에서 저장된 값 확인하기-->
	<!-- getAttribute(String name) -->
	
	<h3>pageContext 객체 값 : <%=pageContext.getAttribute("pageValue") %></h3>
	<h3>request 객체 값 : <%=request.getAttribute("requestValue") %></h3>
	<h3>session 객체 값 : <%=session.getAttribute("sessionValue") %></h3>
	<h3>application 객체 값 : <%=application.getAttribute("applicationValue") %></h3>
	
	<%
	//attributeScopeTest2.jsp 페이지로 이동(=포워딩)하는 방법
	//1. response 객체의 sendRedirect() 메서드를 호출하여 이동 : Redirect 방식 포워딩
// 	response.sendRedirect("attributeScopeTest2.jsp");
	//=> pageContext, request 객체 : 데이터 없음(null)
	//
	
	//2. pageContext객체의 forword()메서드를
	pageContext.forward("attributeScopeTest2.jsp");
	//
	%>

</body>
</html>