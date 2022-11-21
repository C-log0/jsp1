<%@page import="java.util.List"%>
<%@page import="jsp11_dbcp.StudentDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<h1>test4_result.jsp - JSTL</h1>
	<%--
	request 객체의 속성값을 가져올 때 request.getAttribute() 메서드를 사용했으며,
	EL 문법을 통해 가져올 때 ${속성명} 형식을 사용하여 데이터 꺼낼 수 있다!
	=> page, request, session, application 영역을 차례대로 검사하여 일치하는 속성을 꺼낸다!
	--%>
	<h3>
		번호 : ${idx }<br>
		이름 : ${name }
	</h3>
	<hr>
	
	<%-- 스크립틀릿을 활용하여 일반적인 for문을 통해 i값이 1 ~ 10까지 1씩 증가하면서 반복 --%>
	<%for(int i = 1; i <= 10; i++) { %>
		<%=i %>&nbsp;
	<%} %>
	<hr>
	<%--
	JSTL 의 <c:forEach> 태그를 활용한 반복문
	1) 제어변수를 활용하여 시작값 ~ 종료값까지 증감값만큼 증감을 통해 반복하는 문장
	<c:forEach var="변수명" begin="시작값" end="종료값" step="증감값">
		// 반복문 내에서 실행할 문장들...
	</c:forEach>
	--%>
	<c:forEach var="i" begin="1" end="10" step="1">
		<%-- 제어변수로 사용되는 i 값을 EL 을 통해 사용 가능 --%>
		${i }&nbsp;
	</c:forEach>
	<hr>
	<%
	String[] names = (String[])request.getAttribute("names");
	for(String item : names) {
		%>
		<%=item %>&nbsp;
		<%
	}
	%>
	<hr>
	<%--
	2) 객체에 접근하여 객체 내의 데이터를 차례대로 접근하는 forEach문(= 향상된 for문)
	<c:forEach var="객체 데이터 저장 변수" items="복수개 데이터 저장된 객체" varStatus="상태변수">
	</c:forEach>
	--%>
	<%-- names 배열에 접근하여 이름을 차례대로 출력 --%>
	<c:forEach var="item" items="${names }" varStatus="status">
		<%-- names 라는 이름의 객체(배열 포함)에서 값을 차례대로 꺼내서 item 변수에 저장 --%>
		<%-- varStatus 속성은 반복되는 객체의 인덱스 값이 자동으로 저장됨 --%>
		${status.index } 번 배열 데이터 : ${item }<br>
	</c:forEach>
	<hr>
	<%-- List 객체(studentList) 에 저장된 StudentDTO 객체를 차례대로 접근 --%>
	<%
// 	List<StudentDTO> studentList = (List<StudentDTO>)request.getAttribute("studentList");
// 	for(StudentDTO student : studentList) {
// 		out.println(student.getIdx() + ", " + student.getName() + "<br>");
// 	}
	%>
	<%-- <c:forEach> 문 사용 --%>
	<c:forEach var="student" items="${studentList }">
		<%-- StudentDTO 객체에 접근 시 var 로 선언한 변수명.멤버변수명으로 접근(private 무관) --%>
		<%-- 내부적으로 StudentDTO 객체의 getXXX() 메서드가 호출됨 --%>
		<%-- 따라서, DTO 클래스에는 반드시 멤버변수와 Getter/Setter 정의 필수! --%>
		${student.idx }, ${student.name }<br>
	</c:forEach>
</body>
</html>

	