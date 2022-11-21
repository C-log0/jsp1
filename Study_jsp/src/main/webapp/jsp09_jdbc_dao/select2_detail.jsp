<%@page import="jsp9_jdbc_dao.jsp8_2DTO"%>
<%@page import="jsp9_jdbc_dao.jsp8_2DAO"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script type="text/javascript">

	function confirmDelete(id){
		let result = confirm("삭제하시겠습니까?");
		
		if(result) {
			location.href = "delete2.jsp?id=" + id;
		}
	}
	</script>
</head>
<body>

	<h1>회원 상세 정보</h1>
	
	<%
	//URL파라미터로 전달받은 아이디 가져와서 변수에 저장
	String id = request.getParameter("id");
	// out.println(id);
	
	
	//만약, 전달받은 아이디가 세션 아이디("sId")와 다르고
	//세션 아이디가 "admin"이 아닐 경우
	//자바 스크립트를 사용하여 "잘못된 접근입니다!" 출력 후 메인페이지로 이동
	String sId = (String)session.getAttribute("sId");
	
	if(!id.equals(sId) && !sId.equals("admin")){
		%>
		<script>
			alert("잘못된 접근입니다!")
			location.href = "index.jsp";
		</script>
		
	<%} 

	// 회원상세정보 조회를 수행하기 위해
	// jsp8_2DAO 객체 생성 후 selectDetail() 메서드 호출
	// => 파라미터 : 아이디(id) 리턴타입 : jsp8_2DTO(dto)
	jsp8_2DAO dao = new jsp8_2DAO();
	jsp8_2DTO dto = dao.selectDetail(id);
	
	
	//만약, 조회 결과가 있을 경우(jsp8_2DTO 객체가 null이 아닐 경우) 테이블에 데이터 출력
	if (dto != null){
		
		
		%>
		
		<table border="1">
			<tr><td>이름</td>
			<td><%=dto.getName() %></td>
			</tr>
			<tr>
				<td>ID</td>
				<td><%=dto.getId() %>
				</td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td>비밀번호</td> -->
<%-- 				<td><%=password %> --%>
					
<!-- 				</td> -->
<!-- 			</tr> -->
			
			<tr>
				<td>주민번호</td>
				<td><%=dto.getJumin() %>
					
				</td>
			</tr>
			<tr>
				<td>E-Mail</td>
				<td><%=dto.getEmail() %>
					
				</td>
			</tr>
			<tr>
				<td>직업</td>
				<td><%=dto.getJob() %>
				
				</td>
			</tr>
			<tr>
				<td>성별</td>
				<td><%=dto.getGender() %>
					
				</td>
			</tr>
			<tr>
				<td>취미</td>
				<td><%=dto.getHobby()%>
					
				</td>
			</tr>
			<tr>
				<td>가입동기</td>
				<td><%=dto.getContent() %>
					
				</td>
			</tr>
			<tr>
				<td>가입일</td>
				<td><%=dto.getHire_date() %>
					
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="삭제" onclick="confrimDelete('<%=id %>')">
					<input type="button" value="이전" onclick="history.back()">
				</td>
			</tr>
		</table>
	
	<% 

	}//if문 끝(43번 라인 끝)
		%>
	
	
	
	
</body>
</html>