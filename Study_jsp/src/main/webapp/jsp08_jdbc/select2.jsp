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
<script type="text/javascript">//++++++++++++++++++++++++++++1018+++++++++++
	function confirmDelete(id){
		//confirm dialog 사용하여 "XXX회원을 삭제하시겠습니까?" 확인 요청
		//=> 결과값이 true 일 경우 location.href='delete2.jsp' 페이지 이동
		let result = confirm(name + "회원을 삭제하시겠습니까?");
		if(result){
			location.href = "delete2.jsp?id=" + id; //변수를 선언하기 전이라 오류 발생 => 변수 위치를 위로 변경하거나 
		}
	}
</script>
</head>
<body>
	<h1>회원목록</h1>

	<%
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
	
	// 3단계. SQL 구문 작성 및 전달
	// SELECT 구문을 사용하여 student 테이블의 모든 레코드 검색
	String sql = "SELECT * FROM jsp8_2 ";
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	// 4단계. SQL 구문 실행 및 결과 처리
	ResultSet rs = pstmt.executeQuery();
	

	
	// 조회할 레코드가 복수개(2개 이상)일 경우
	// if 문 대신 while 문을 사용하여 "다음 레코드가 존재할 동안" 반복
	%>
	
	<table border="1">
		<tr>
			<th width = "100">이름</th>
			<th width = "100">아이디</th>
			<th width = "200">이메일</th>
			<th width = "50">성별</th>
			<th width = "150">가입일</th>
			<th width = "150"></th>
		</tr>	
	
	
	<%
	while(rs.next()) {

		String name = rs.getString(1);
		String id = rs.getString(2); // 첫번째 컬럼(1번 인덱스) 데이터 가져와서 변수에 저장
		String passwd = rs.getString(3);
		String jumin = rs.getString(4);
		String email = rs.getString(5);
		String job = rs.getString(6);
		String gender = rs.getString(7);
		String hobby = rs.getString(8);
		String content = rs.getString(9);
		String hire_date = rs.getString(10);
		
		// 테이블 내에 회원 목록 출력
		
		%>	
		<tr>
			<td><%=name %></td>
			<td><%=id %></td>
			<td><%=email %></td>
			<td><%=gender %></td>
			<td><%=hire_date %></td>
			<td>
				<input type="button" value = "상세정보" onclick ="location.href='select2_detail.jsp?id=<%=id%>'">
				<input type="button" value = "삭제" onclick ="confirmDelete('<%=id %>')">
			</td>
		</tr>
		<%	
	}
	%>		
	</table>		
	
</body>
</html>