<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
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
	String sql = "SELECT * FROM student";
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	// 4단계. SQL 구문 실행 및 결과 처리
	// PreparedStatement 객체의 executeQuery() 메서드를 호출하여 SELECT 구문 실행하고
	// 리턴되는 결과값을 java.sql.ResultSet 타입 변수에 저장
	ResultSet rs = pstmt.executeQuery();
	
	/*
	SELECT 구문 실행 성공 시 다음 형태의 테이블 구조가 ResultSet 타입 객체로 관리됨
	- 커서(Cursor) 라는 개념의 포인터가 항상 테이블의 첫번째 레코드 위에 위치
	- 커서를 위 아래로 이동시키면서 커서가 위치한 곳의 레코드에 접근 가능
	  => ResultSet 객체의 next() 메서드를 호출하여 커서를 다음 레코드로 이동
	     이 때, 다음 레코드가 존재하면 true 리턴하고, 존재하지 않으면 false 리턴
	+------+--------+
	| idx  | name   |  <- 현재 커서(Cursor) 위치
	+------+--------+
	|    1 | 김길동 |  <- rs.next() 메서드 한 번 호출 시 커서 위치(레코드 있음 = true 리턴)
	|    2 | 이순신 |  <- rs.next() 메서드 두 번 호출 시 커서 위치(레코드 있음 = true 리턴)
	|    3 | 강감찬 |  <- rs.next() 메서드 세 번 호출 시 커서 위치(레코드 있음 = true 리턴)
	+------+--------+  <- rs.next() 메서드 네 번 호출 시 커서 위치(레코드 없음 = false 리턴)
	*/
	// ResultSet 객체의 next() 메서드를 호출하여 커서를 다음 레코드로 이동시키기
	// => 레코드가 3개이므로 rs.next() 메서드를 3번 호출할 동안 true 리턴, 4번째에 false 리턴
// 	out.println(rs.next() + "<br>");
// 	out.println(rs.next() + "<br>");
// 	out.println(rs.next() + "<br>");
// 	out.println(rs.next() + "<br>");

	// ResultSet 객체의 getXXX() 메서드를 호출하여 접근한 레코드의 특정 컬럼 데이터 리턴
	// => 이 때, 파라미터로 접근할 컬럼의 인덱스(1부터 시작) 또는 컬럼명을 전달
	// => 주의! 컬럼명을 직접 지정할 경우 오타에 주의!
// 	out.println(rs.next() + "<br>");
// 	out.println(rs.getInt(1) + "<br>"); // 컬럼인덱스 1번에 대한 정수 데이터 전달받아 출력
// 	out.println(rs.getInt("idx") + "<br>"); // 컬럼명 "idx" 에 대한 정수 데이터 전달받아 출력
// 	out.println(rs.next() + "<br>");
// 	out.println(rs.getInt(1) + "<br>");
// 	out.println(rs.next() + "<br>");
// 	out.println(rs.getInt(1) + "<br>");
// 	out.println(rs.next() + "<br>");
// 	out.println(rs.getInt(1) + "<br>"); 
	// => 4번째 레코드는 존재하지 않으므로 레코드 접근 시 오류 발생

	// 만약, 조회 결과가 단일 레코드(1개 레코드)일 경우 
	// if 문을 사용하여 rs.next() 결과가 true 일 때 레코드에 접근하여 데이터를 가져올 수 있다!
// 	if(rs.next()) { // 커서를 한 줄 내린 다음 레코드 존재 여부 판별
// 		out.println("다음 레코드 존재함!");
// 	} else {
// 		out.println("다음 레코드 존재하지 않음!");
// 	}
	
	// 조회할 레코드가 복수개(2개 이상)일 경우
	// if 문 대신 while 문을 사용하여 "다음 레코드가 존재할 동안" 반복
	while(rs.next()) {
// 		out.println("다음 레코드 존재함!<br>");

		// 커서가 위치한 레코드의 각 컬럼에 접근하여 데이터 가져오기
		// => 1번 컬럼 : int 타입, 2번 컬럼 : VARCHAR 타입
		// ResultSet 객체의 getXXX() 메서드를 호출하여 각 컬럼 데이터 가져오기
		// => 이 때, getXXX() 메서드의 XXX 은 컬럼 타입에 대한 자바 데이터타입명 사용
		//    (pstmt.setXXX() 의 XXX 과 동일한 방식)
		// => 파라미터로 접근할 컬럼의 인덱스(1부터 시작) 또는 컬럼명을 전달
		int idx = rs.getInt(1); // 첫번째 컬럼(1번 인덱스) 데이터 가져와서 변수에 저장
// 		int idx = rs.getInt("idx"); // 컬럼명 "idx" 데이터 가져와서 변수에 저장
		String name = rs.getString(2);
// 		String name = rs.getString("name");
		out.println(idx + ", " + name + "<br>");
	}
	
	
	%>
	
	<table border="1">
		<tr>
			<th>번호</th><th>이름</th>
		<%
		while(rs.next()) {
		int idx = rs.getInt(1); // 첫번째 컬럼(1번 인덱스) 데이터 가져와서 변수에 저장
		String name = rs.getString(2);
		%>
		<tr>
			<td><%=idx %></td><td><%=name %></td>
		</tr>
		<%
		}
		%>
		</table>
	
</body>
</html>