<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

request.setCharacterEncoding("utf-8");

//폼 파라미터를 가져와서 저장

	String id = request.getParameter("id");
	String pass = request.getParameter("pass");

// 	out.println("아이디:"+id+"패스워드:"+pass);


//MemberDTO 객체에 아이디, 패스워드 저장

	MemberDTO member = new MemberDTO();
	
	member.setId(id);
	member.setPass(pass);
	
	//MemberDAO 객체의 loginMember() 메서드를 호출하여 로그인 판별 작업 수행
	//=> 파라미터: MemberDTO 객체(member)   리턴타입 : boolean(isLoginSuccess)
	MemberDAO dao = new MemberDAO();
	boolean isLoginSuccess =dao.isRightUser(member); //메서드 재사용!
	
	//로그인 결과 판별
	//성공 시 세션 객체(session)에 로그인 성공 아이디를 "sId" 속성명으로 저장 후
	//메인페이지로 이동
	//실패 시 "로그인 실패!" 출력 후 이전 페이지로 돌아가기
		
	
	if(!isLoginSuccess){ //로그인 실패
		%>
		<script>
			alert("로그인 실패!")
			history.back();
		</script>
		<%	
	} else { 
		session.setAttribute("sId", id);
		response.sendRedirect("../main/main.jsp");
	}

%>