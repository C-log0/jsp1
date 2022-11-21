<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%
	// JDBC 4단계
	// 0단계. 데이터베이스 작업에 필요한 String 타입 변수 4개 선언
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/study_jsp5";
	String user = "root";
	String password = "1234";
	
	// 1단계. 드라이버 클래스 로드
	Class.forName(driver);
	
	// 2단계. DB 연결
	Connection con = DriverManager.getConnection(url, user, password);
	
	// 3단계. SQL 구문 작성 및 전달
	// SELECT 구문을 사용하여 student 테이블의 모든 레코드 검색
	String sql = "SELECT * FROM student";
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	// 4단계. SQL 구문 실행 및 결과 처리
	// PreparedStatement 객체의 executeQuery() 메서드를 호출하여 SELECT 구문 실행하고
	// 리턴되는 결과값을 java.sql.ResultSet 타입 변수에 저장
	ResultSet rs = pstmt.executeQuery();
	
	%>
	
	<table border="1">
		<tr>
			<th>번호</th><th>이름</th></tr>
		<%
		while(rs.next()) {
		int idx = rs.getInt(1); // 첫번째 컬럼(1번 인덱스) 데이터 가져와서 변수에 저장
		String name = rs.getString(2);
		%>
		<tr>
			<td><%=idx %></td><td><%=name %></td>
		</tr>
		<%
		}
		%>
		
		</table>
	
	
</body>
</html>