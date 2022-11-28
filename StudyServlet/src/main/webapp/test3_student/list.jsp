

<%@page import="java.util.List"%>
<%@page import="test3_student.StudentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
<h1>학생 목록</h1>
	<table border="1">
		<tr>
			<th>번호</th><th>이름</th>
		</tr>
		
	<%
	// request 객체에 저장된 List<StudentDTO> 객체 (studentList) 가져오기
	List<StudentDTO> studentList = (List<StudentDTO>)request.getAttribute("studentList");
	
	for(int i = 0; i < studentList.size(); i++) {
		StudentDTO student = (StudentDTO)studentList.get(i);
		%>
		<tr>
			<!-- StudentDTO 객체의 getXXX() 메서드를 호출하여 데이터 꺼내기 -->
			<td><%=student.getIdx() %></td><td><%=student.getName() %></td>
		</tr>	
		<%
	}
	%>
			
	</table>
	
</body>
</html>

	