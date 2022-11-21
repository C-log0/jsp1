<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
	//URL파라미터로 전달받은 아이디 가져와서 변수에 저장
	String id = request.getParameter("id");
	// out.println(id);
	
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
	//jsp8_2 테이블에서 아이디가 일치하는 레코드 삭제
	String sql = "DELETE FROM jsp8_2 WHERE id =?";
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	pstmt.setString(1,id);
	
	int count = pstmt.executeUpdate();
	


//삭제 성공 시 select2.jsp 페이지로 이동
//삭제 실패 시 자바 스크립트를 사용하여 "삭제 실패!" 출력 후 이전페이지로 돌아가기!
	
	if(count >0){
		response.sendRedirect("select2.jsp");
	} else {%>
		alert("삭제 실패!");
		history.back;
	<%} %>
	
	
	
	
	


