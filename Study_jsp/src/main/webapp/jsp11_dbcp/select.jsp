
<%@page import="jsp11_dbcp.StudentDAO"%>
<%@page import="jsp11_dbcp.StudentDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jsp11_dbcp.StudentDTO"%>
<%@page import="java.sql.Array"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
<h1>학생 목록</h1>
	<table border="1">
		<tr>
			<th>번호</th><th>이름</th>
		</tr>
		
	<%
		// 학생 목록 조회를 위해 StudentDAO 인스턴스 생성 후 select() 메서드 호출
		// => 파라미터 : 없음      리턴타입 : java.util.List<StudentDTO>
		StudentDAO dao = new StudentDAO();
		List<StudentDTO> studentList = dao.select();
		
		// 배열과 마찬가지로 ArrayList 객체로 for문을 통해 차례대로 인덱스에 접근 가능함
		// => 이 때, 배열의 length 속성 대신 ArrayList 객체의 size() 메서드를 통해 크기 확인
		for(int i = 0; i < studentList.size(); i++) {
			// ArrayList 객체의 get() 메서드를 호출하여 지정된 인덱스의 요소(객체) 꺼내기
			// => 이 때, get() 메서드 리턴타입은 Object 타입(업캐스팅 되어 있음)
			// => 인덱스는 배열과 동일하게 사용
// 			Object o = studentList.get(i);
// 			o.getIdx(); // Object 타입으로 업캐스팅 후에는 StudentDTO 객체 메서드 호출 불가
			// 반드시 StudentDTO 타입으로 다운캐스팅 후에 메서드를 호출할 수 있다!
			// Object -> StudentDTO 타입 다운캐스팅을 위해 (StudentDTO) 형변환 연산자 사용
// 			StudentDTO student = (StudentDTO)o;
			
			// 위의 코드를 한 줄로 결합
			StudentDTO student = (StudentDTO)studentList.get(i);
			%>
			<tr>
				<!-- StudentDTO 객체의 getXXX() 메서드를 호출하여 데이터 꺼내기 -->
				<td><%=student.getIdx() %></td><td><%=student.getName() %></td>
			</tr>	
			<%
		}
		%>
			
	</table>
	
</body>
</html>

	