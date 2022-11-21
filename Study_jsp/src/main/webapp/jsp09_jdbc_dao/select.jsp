
<%@page import="java.util.ArrayList"%>
<%@page import="jsp9_jdbc_dao.StudentDTO"%>
<%@page import="java.sql.Array"%>
<%@page import="jsp9_jdbc_dao.StudentDAO"%>
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
	// => 파라미터 : 없음      리턴타입 : ???
	StudentDAO dao = new StudentDAO();
	ArrayList studentList = dao.select();
	
	//배열과 마찬가지로 Array List 객체로for문을 통해 차례로 
	//=> 이 때, 배열의 length 속성 대신 ARrayList
	for(int i = 0; i < studentList.size(); i++){ //length 대신 size()메서드 사용 / 배열 형태studentList[i] => studentList.get(i)
		//ArrayList 객체의 get()메서드를 호출하여 지정된 인덱스의 요소(객체 꺼내기)
// 		Object o = studentList.get(i);
// 	o.getIdx();//object 타입으로 업캐스팅 후에는 StudentDTO 객체 메서드 호출 불가
	//반드시  
// 	StudentDTO student = (StudentDTO)o; //다운캐스팅

	//위의 코드를 한 줄로 결합
	StudentDTO student = (StudentDTO)studentList.get(i);
	
	%>
			<!-- ==================================== -->
			<tr>
				<!-- StudentDTO 객체의 getXXX()메서드를 호출하여 -->
				<td><%=student.getIdx() %></td> <td><%=student.getName() %></td>
			</tr>	
	
	<%
	}
	%>
	
	
	</table>
	
</body>
</html>

	