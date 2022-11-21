<%@page import="member.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%	
//세션 아이디가 null 이거나 "admin"이 아닐 경우 "잘못된 접근입니다!" 출력 후 메인페이지로 이동
	String sId = (String)session.getAttribute("sId");
	if(sId == null || !sId.equals("admin")) {
		response.sendRedirect("../main/main.jsp");
	}
	%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script type="text/javascript">
		function confirmDelete(id) {
			// confirm dialog 사용하여 "XXX 회원을 삭제하시겠습니까?" 확인 요청
			// => 결과값이 true 일 경우 location.href='delete2.jsp' 페이지 이동
			let result = confirm(id + " 회원을 삭제하시겠습니까?");
			
			if(result) {
				location.href = "../member/member_delete.jsp?id=" + id;
			}
		}
	</script>
</head>
<body>
	<h1>admin_main.jsp - 관리자 페이지</h1>
	
	<table border="1">
		<tr>
			<th width="100">아이디</th>
			<th width="100">이름</th>
			<th width="200">E-Mail</th>
			<th width="50">전화번호</th>
			<th width="100">가입일</th>
			<th width="150"></th>
		</tr>
		
	<!-- member 테이블의 모든 레코드 조회하여 테이블에 출력  -->
	<%
	//MemberDAO 객체의 selectMemberList() 메서드를 호출하여 모든 회원 목록 조회
	//=> 파라미터 : 없음   리턴타입 : java.util.list
	// 단, 리턴타입 List는 제네릭 타입으로 MemberDTO 타입으로 지정
	MemberDAO dao = new MemberDAO();
	List<MemberDTO> memberList = dao.selectMemberList();
	
	//for문을 사용하여 List객체 크기만큼 반복
// 	for(int i = 0; i <= memberList.size() ; i++){ //i를 아래에서 일부만 사용하고 싶을 때 
// 		//List 객체에서 MemberDTO 객체를 꺼내서 변수에 저장
// 		//제네릭타입으로 MemberDTO 타입이 고정되므로 꺼낼 때 (형변환)다운캐스팅 할 필요 없음
// 		MemberDTO member = memberList.get(i);  
// 	}
	//향상된 for문을 사용하여 List 객체에서 MemberDTO 객체 꺼내기(윗문장과 동일)
	for(MemberDTO member:memberList){
		%>
		<!-- 아이디, 이름, 이메일, 전화번호, 가입일 출력 -->
		<tr>		
			<td><%=member.getId() %></td>
			<td><%=member.getName() %></td>
			<td><%=member.getEmail() %></td>
			<td><%=member.getMobile() %></td>
			<td><%=member.getDate() %></td>
			<td>
					<input type="button" value="상세정보" onclick="location.href='../member/memver_info.jsp?id=<%=member.getId()%>'">
					<input type="button" value="삭제" onclick="confirmDelete('<%=member.getId()%>')">
			</td>
			 
		</tr>
		<%
	}
	
	%>

	</table>
</body>
</html>