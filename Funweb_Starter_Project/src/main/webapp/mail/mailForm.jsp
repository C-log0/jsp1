<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
MemberDAO dao = new MemberDAO();

String sId=(String)session.getAttribute("sId");
MemberDTO member = dao.selectMember(sId);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>CONTACT US</h1>
	<form action="mailPro.jsp" method="post">
		<table border="1">
		<input type="hidden" name = "name" value = "<%=member.getName()%>">
		<input type="hidden" name = "sender" value = "<%=member.getEmail()%>">
		<input type="hidden" name = "mobile" value = "<%=member.getMobile() %>">
			
			<tr>
				<th>제목</th>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" rows="20" cols="40"></textarea></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="메일발송"></td>
			</tr>
		</table>
	</form>
</body>
</html>