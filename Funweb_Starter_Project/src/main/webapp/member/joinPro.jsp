<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//join.jsp 페이지로부터 전달받은 폼 파라미터를 사용하여 funweb.member 테이블에 레코드 추가

request.setCharacterEncoding("utf-8");


//	  CREATE TABLE member(
//	  		id VARCHAR(16) PRIMARY KEY,
//	  		pass VARCHAR(16) NOT NULL,
//	  		name VARCHAR(20) NOT NULL,
//	  		email VARCHAR(20) UNIQUE NOT NULL,
//	  		post_code VARCHAR(10) NOT NULL,
//	  		address1 VARCHAR(100) NOT NULL,
//	  		address2 VARCHAR(100) NOT NULL,
//	  		phone VARCHAR(20) NOT NULL,
//	  		mobile VARCHAR(20) UNIQUE NOT NULL,
//	  		date DATE NOT NULL,
//	  );
	

//1. 폼 파라미터 가져와서 저장(MemberDTO 객체 dto) 후 확인
		
		MemberDTO member = new MemberDTO();
		
		member.setId(request.getParameter("id"));
		member.setPass(request.getParameter("pass"));
		member.setName(request.getParameter("name"));
		member.setEmail(request.getParameter("email"));
		member.setPost_code(request.getParameter("post_code"));
		member.setAddress1(request.getParameter("address1"));
		member.setAddress2(request.getParameter("address2"));
		member.setPhone(request.getParameter("phone"));
		member.setMobile(request.getParameter("mobile"));
		 
		out.println(member.toString());
		
		//MemberDAO 객체의 insertMember() 메서드를 호출하여 회원가입 작업 수행
		// => 파라미터 : MemberDTO 객체(member) 리턴타입 :int(insertCount)
		MemberDAO dao = new MemberDAO();
		
		int insertCount = dao.insertMember(member);
		
		// 회원 가입 결과 판별
		// 실패 시 자바스크립트를 사용하여 "회원 가입 실패!" 출력 후 이전페이지로 돌아가기
		// 아니면, 메인페이지(main.jsp)로 이동
		if(insertCount > 0){ //성공
// 			response.sendRedirect("../main/main.jsp");
			 %>
				<script>
					alert("회원 가입을 축하합니다!\n3000 포인트가 적립되었습니다!");
					location.href="../main/main.jsp";
				</script>
			<%	
		} else {//실패 
			%>
		<script>
			alert("회원 가입 실패!")
			history.back());
		</script>
		<%	
		}
%>