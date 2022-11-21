
<%@page import="jsp9_jdbc_dao.StudentDAO"%>
<%@page import="jsp9_jdbc_dao.StudentDTO"%>
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
</head>
<body>

	<%
	
	//POST방식에 대한 한글 처리
	request.setCharacterEncoding("UTF-8");
	
	//insertForm.jsp 페이지로부터 전달받은 파라미터(idx, name)가져와서 변수에 저장
	//=> Integer.parseInt()메서드를 활용하여 
	//(주의! 파라미터로 전달하는 문자열은 반드시 정수 형태의 문자열이어야 한다)
	int idx = Integer.parseInt(request.getParameter("idx"));
	String name = request.getParameter("name");
	
// 	out.println(idx + "," + name);

	//--------------------------------------------------------------------------
	// 데이터베이스에 사용될 데이터(파라미터)를 studentDTO
	//1. StudentDTO 클래스 인스턴스 생성
	StudentDTO student = new StudentDTO();
	//2. Student
	student.setIdx(idx);
	student.setName(name);
	
	
	//--------------------------------------------------------------------------
	//데이터베이스 작업에 사용될 StudentDAO 인스턴스 생성
	
	StudentDAO dao = new StudentDAO();
	//studentDAO 인스턴스의 insert() 메서드를 호출하여 회원 추가 작업 수행
	// => 파라미터 : StudentDTO 객체(student), 리턴타입 int(insertCOunt)
	int insertCount = dao.insert(student);
	
	
	
	
	//jdbc작업 4단계
	//0단계
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/study_jsp5";
	String user = "root";
	String password = "1234";
	
	//1단계
	Class.forName(driver);
	
	//2단계
	Connection con = DriverManager.getConnection(url, user, password);
	
	
	//study_jsp5 데이터베이스의 student 폴더에 데이터 추가(INSERT)
	//=>리턴되는 추가 작업 결과 변수(count) 에 저장
	String sql = "INSERT INTO student VALUES (?,?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	pstmt.setInt(1,idx);
	pstmt.setString(2, name);
	
	//데이터 추가 작업 실패 시
	//=>자바스크립트를 사용하여 "학생 추가 실패!" 출력 후 이전페이지로 돌아가기
	//아니면(=추가 작업 성공 시)
	//select.jsp 페이지로 이동
	int count = pstmt.executeUpdate();

	
	if(count > 0){ //작업 성공 시
		response.sendRedirect("select.jsp");
	} else {//실패 시
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