
<%@page import="jsp9_jdbc_dao.jsp8_2DTO"%>
<%@page import="jsp9_jdbc_dao.jsp8_2DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 로그인 화면에서 전달받은 폼 파라미터(아이디, 패스워드) 가져오기
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");
// out.println("아이디 : " + id + ", 패스워드 : " + passwd);

// Jsp8_2DAO 객체 생성 후 login() 메서드를 호출하여 아이디, 패스워드 판별 작업 수행
// => 파라미터 : 아이디, 패스워드     리턴타입 : boolean(isLoginSuccess)
jsp8_2DAO dao = new jsp8_2DAO();
boolean isLoginSuccess = dao.login(id, passwd);

// -----------------------------------------------
// Jsp8_2DTO 객체에 아이디, 패스워드를 저장할 경우
// => 파라미터 : Jsp8_2DTO 객체(dto)     리턴타입 : boolean(isLoginSuccess)
// Jsp8_2DTO dto = new Jsp8_2DTO();
// dto.setId(id);
// dto.setPasswd(passwd);
// boolean isLoginSuccess = dao.login(dto);
// -----------------------------------------------

// 로그인 판별 결과 처리
if(isLoginSuccess ==true){ // 로그인 성공
	session.setAttribute("sId", id);
	
	response.sendRedirect("index.jsp");
} else { // 로그인 실패
	%>
	<script>
		alert("로그인 실패!");
		history.back();
	</script>
	<%
}

%>














