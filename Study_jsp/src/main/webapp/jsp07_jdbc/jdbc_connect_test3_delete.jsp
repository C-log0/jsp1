
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
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
	//JDBC 4단계
	//0. 데이터베이스 작업에 필요한 String 타입 변수 4개 선언
	String driver="com.mysql.cj.jdbc.Driver";
	String url ="jdbc:mysql://localhost:3306/study_jsp5";
	String user="root";
	String password="1234";
	
	
	//1단계. 드라이버 클래스 로드
	Class.forName(driver);
	
	//2단계. DB연결
	Connection con = DriverManager.getConnection(url, user, password);
	
	
	//3단계. SQL 구문 작성 및 전달
	//delete 구문을 사용하여 번호가 4이고 이름이'조인성'인 레코드 삭제
// 	int idx=4;
// 	String name="조인성";
	int idx=2;
	String name="이순신";
	
	String sql = "DELETE FROM student WHERE idx=? AND name=?";
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, idx);//첫번째(1번 인덱스) 만능문자(:?)에 int 타입 변수 idx값 전달
	pstmt.setString(2, name);
	//4단계. SQL 구문 실행 및 결과 처리
	
	int count = pstmt.executeUpdate();
	%>
	
	<h3>회원 삭제 성공! -  <%=count %>개 레코드</h3>
</body>
</html>