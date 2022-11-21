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
	// => student 테이블에 번호(idx)와 이름(name) 추가
// 	String sql = "INSERT INTO student VALUES (3, '강감찬')";
// 	PreparedStatement pstmt = con.prepareStatement(sql);
	
	// 외부로부터 추가할 레코드의 데이터를 입력받아 변수에 저장했다고 가정
	int idx = 3;
	String name = "강감찬";
	
	// SQL 구문(INSERT) 작성 시 변수값을 SQL 구문에 전달하는 방법 2가지
	// 1) SQL 구문 작성 시 문자열 결합을 통해 변수값을 구분에 포함시키는 방법(추천X)
	// => CREATE 구문 등을 사용할 경우에는 사용하기도 하나 데이터 추가 시 잘 사용하지 않음
	// => 다른 데이터타입을 제외하고 문자 데이터의 경우 작은따옴표로 둘러싸서 표현해야하므로
	//    변수 결합 시 작은따옴표는 그대로 유지해야함
// 	String sql = "INSERT INTO student VALUES (" + idx + ", '" + name + "')";
// 	PreparedStatement pstmt = con.prepareStatement(sql);

	// 2) SQL 구문 작성 시 데이터가 위치할 부분을 만능문자(Wildcard) 파라미터인 ? 기호로 먼저 채우고
	//    나중에 별도로 만능문자 부분에 데이터를 교체하는 작업을 사용하는 방법(추천!!!!)
	// 2-1) SQL 구문 내에 데이터 부분을 만능문자(?)로 표기
	String sql = "INSERT INTO student VALUES (?,?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	// 2-2) PreparedStatement 객체의 setXXX() 메서드를 호출하여 만능문자를 데이터로 교체
	//      => setXXX() 메서드의 XXX 은 교체할 데이터의 자바 데이터타입 이름 사용
	//      ex) 정수형 데이터 교체할 경우 메서드명 : setInt()
	//          문자열 데이터 교체할 경우 메서드명 : setString()
	//      => 첫번째 파라미터 : 만능문자 순서번호, 두번째 파라미터 : 교체할 데이터
	//      => 주의! 모든 만능문자에 모든 데이터가 전달되어야한다! 아니면 오류 발생
	//         (java.sql.SQLException: No value specified for parameter 2 => 2번 파라미터 데이터 없음)
	pstmt.setInt(1, idx); // 첫번째(1번 인덱스) 만능문자에 int 타입 변수 idx 값 전달
	pstmt.setString(2, name); // 두번째(2번 인덱스) 만능문자에 String 타입 변수 name 값 전달
	
	// 4단계. SQL 구문 실행 및 결과 처리
	int insertCount = pstmt.executeUpdate();
	%>
	<h3>회원 추가 성공! - <%=insertCount %> 개 레코드</h3>
</body>
</html>