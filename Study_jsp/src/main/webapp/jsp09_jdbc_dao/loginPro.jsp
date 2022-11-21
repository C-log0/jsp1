<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");

// 	out.println("아이디 : " + id + ", 패스워드 :" + passwd);

	//login() 메서드에서 Select 구문을 사용하여 전달받은 아이디, 패스워드가 일치하는
	//레코드가 존재하는지 조회
	// => 조회할 컬럼 : 무관(특정 컬럼 또는 *)
	// 조건 : 아이디가 같고 패스워드가 같음
	String sql = "SELECT * FROM jsp8_2 WHERE id = 'XXX' AND passwd = 'YYY'";
	
	
	
%>

