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
</head>
<body>
	<%
	// POST 방식에 대한 한글 처리
	request.setCharacterEncoding("UTF-8");
	
	// insertForm.jsp 페이지로부터 전달받은 파라미터(idx, name) 가져와서 변수에 저장
	// => Integer.parseInt() 메서드를 활용하여 지정한 문자열 데이터를 정수로 변환하여 리턴
	//    (주의! 파라미터로 전달하는 문자열은 반드시 정수 형태의 문자열이어야한다!)
	int idx = Integer.parseInt(request.getParameter("idx"));
	String name = request.getParameter("name");
// 	out.println(idx + ", " + name);

	// JDBC 작업 4단계.js
	// 0단계. DB 연결에 필요한 정보 문자열 4가지를 변수에 별도로 저장
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/study_jsp5";
	String user = "root";
	String password = "1234";
	
	// 1단계. JDBC 드라이버 로드
	Class.forName(driver);
	
	// 2단계. DB 연결
	// => 연결 성공 시 java.sql.Connection 타입 객체 리턴됨
	Connection con = DriverManager.getConnection(url, user, password);
	
	// study_jsp5 데이터베이스의 student 테이블에 데이터 추가(INSERT)
	// => 리턴되는 추가 작업 결과 변수(count)에 저장
	String sql = "INSERT INTO student VALUES (?,?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, idx);
	pstmt.setString(2, name);
	
	int count = pstmt.executeUpdate();
	
	// 데이터 추가 작업 실패 시
	// => 자바스크립트를 사용하여 "학생 추가 실패!" 출력 후 이전페이지로 돌아가기
	// 아니면(= 추가 작업 성공 시)
	// => select.jsp 페이지로 이동(Redirect 방식)
	if(count > 0) { // 작업 성공 시
		response.sendRedirect("select.jsp");
	} else { // 작업 실패 시
		%>
		<script type="text/javascript">
			alert("학생 추가 실패!");
			history.back();
		</script>
		<%
	}
	%>
</body>
</html>









