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
	
	// 아이다가 일치하는 레코드 조회
	String sql = "SELECT * FROM jsp8_2 WHERE id =?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1,id);
	
	// 4단계. SQL 구문 실행 및 결과 처리
	ResultSet rs = pstmt.executeQuery();
	

	
	// 조회할 레코드가 복수개(2개 이상)일 경우
	// if 문 대신 while 문을 사용하여 "다음 레코드가 존재할 동안" 반복
	
	if(rs.next()) {

		String name = rs.getString(1);
// 		String id = rs.getString(2); // 첫번째 컬럼(1번 인덱스) 데이터 가져와서 변수에 저장
		String passwd = rs.getString(3);
		String jumin = rs.getString(4);
		String email = rs.getString(5);
		String job = rs.getString(6);
		String gender = rs.getString(7);
		String hobby = rs.getString(8);
		String content = rs.getString(9);
		Date hire_date = rs.getDate(10);
		
		%>
		
		<table border="1">
			<tr><td>이름</td>
			<td><%=name %></td>
			</tr>
			<tr>
				<td>ID</td>
				<td><%=id %>
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><%=password %>
					
				</td>
			</tr>
			<tr>
				<td>비밀번호확인</td>
				<td><%=password %>
					
				</td>
			</tr>
			<tr>
				<td>주민번호</td>
				<td><%=jumin %>
					
				</td>
			</tr>
			<tr>
				<td>E-Mail</td>
				<td><%=email %>
					
				</td>
			</tr>
			<tr>
				<td>직업</td>
				<td><%=job %>
				
				</td>
			</tr>
			<tr>
				<td>성별</td>
				<td><%=gender %>
					
				</td>
			</tr>
			<tr>
				<td>취미</td>
				<td><%=job%>
					
				</td>
			</tr>
			<tr>
				<td>가입동기</td>
				<td><%=content %>
					
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

	}
		%>
	
	
	
	
</body>
</html>