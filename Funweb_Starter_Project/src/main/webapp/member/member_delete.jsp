
<%@page import="javax.tools.DocumentationTool.Location"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
	// 세션 아이디 가져와서 변수에 저장
	String sId = (String)session.getAttribute("sId");
	
	// URL파라미터로 전달받은 아이디 가져와서 변수에 저장
	String id = request.getParameter("id");
	// out.println(id);
	
	// 권한이 없을 경우 메인페이지로 이동
	if(sId == null || id == null || id.equals("") || !sId.equals(id) && !sId.equals("admin")) {
		%>
		<script>
			alert("잘못된 접근입니다!");
			location.href = "../main/main.jsp";
		</script>
		<%
	}
	
	//회원 삭제를 위한 MemberDAO 객체의 deleteMember() 메서드 호출
	//=> 파라미터 : 아이디(id) 리턴타입 : int(deleteCount)
	MemberDAO dao =new MemberDAO();
	int deleteCount = dao.deleteMember(id);
	


//삭제 성공 시 
//1) 세션 아이디가 "admin"일 경우 => admin_main.jsp로 이동
//2) 아닐 경우 => main.jsp로 이동
//삭제 실패 시 자바 스크립트를 사용하여 "삭제 실패!" 출력 후 이전페이지로 돌아가기!
	
	if(deleteCount >0) {
		if(sId.equals("admin")) {
			response.sendRedirect("../admin/admin_main.jsp");
		} else {
			session.invalidate();
			response.sendRedirect("../main/main.jsp");
		}
		
	} else { 
		%>
		<script>
		alert("삭제 실패!");
		history.back;
		</script>
		
		<%
	} 
	%>
	
	
	
	
	


