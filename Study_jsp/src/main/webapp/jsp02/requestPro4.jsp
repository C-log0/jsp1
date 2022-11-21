<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>requestPro4.jsp - 로그인 처리</h1>
	<%
	//폼 파라미터(아이디,패스워드) 가져와서 변수에 저장 및 출력 
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	%>
	<h3>아이디 : <%=id %> </h3>
	<h3>패스워드 : <%=passwd %></h3>
	
	<%-- 아이디가 "admin"이고, 패스워드가 "1234"이면 "로그인 성공", 아니면 "로그인 실패" --%>
	<%
// 	if(id.equals("admin")&& passwd.equals("1234")){
// 		out.println("로그인 성공!");
// 	}else{
// 		out.println("로그인 실패!");
// 	}
	%> 
	
	<%-- 로그인 성공 시 requestPro4_responseResult1 페이지로 이동--%>
	<%-- 로그인 실패 시 requestPro4_responseResult2 페이지로 이동--%>
		
 	<% 
 	if(id.equals("admin") && passwd.equals("1234")){
		%>
		<script>
// 			location.href = "requestPro4_responseResult1.jsp";
		</script>
		<%
	} else {
		%>
		<script>
// 			location.href = "requestPro4_responseResult2.jsp";
		</script>
		<%
	}
	%>
	
	<%-- 내장객체인 response 객체를 사용하여 자바 코드를 통한 동일한 이동 작업 수행 --%>
	<%--  --%>
	<% //자바 코드로 이동하는 방법
	if(id.equals("admin")&& passwd.equals("1234")){
		response.sendRedirect("requestPro4_responseResult1.jsp");
	} else {
		response.sendRedirect("requestPro4_responseResult2.jsp");
	}
	%>
	
</body>
</html>