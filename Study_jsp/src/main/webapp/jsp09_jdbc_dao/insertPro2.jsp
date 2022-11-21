<%@page import="jsp9_jdbc_dao.jsp8_2DAO"%>
<%@page import="jsp9_jdbc_dao.jsp8_2DTO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	/*
	jsp8_2 테이블 생성
	---------------------------
	아이디(id) - 문자 10자 UN NN
	비밀번호(passwd) - 문자 16자 NN
	주민번호(jumin) - 문자 14자 UN NN
	이메일(email) - 문자 50자 UN NN
	직업(job) - 문자 10자 NN
	성별(gender) - 문자 1자 NN
	취미(hobby) - 문자 10자 NN
	가입동기(content) - 문자 100자 NN
	가입일(hire_date) - 날짜(DATE) NN
	
	CREATE TABLE jsp8_2 (
		name VARCHAR(10) NOT NULL,
		id VARCHAR(10) UNIQUE NOT NULL,
		passwd VARCHAR(16) NOT NULL,
		jumin VARCHAR(14) UNIQUE NOT NULL,
		email VARCHAR(50) UNIQUE NOT NULL,
		job VARCHAR(10) NOT NULL,
		gender VARCHAR(1)NOT NULL,
		hobby VARCHAR(10) NOT NULL,
		content VARCHAR(100) NOT NULL,
		hire_date DATE NOT NULL
	);
	*/
	
	request.setCharacterEncoding("UTF-8");
	
	//insertForm2.jsp 페이지로부터 전달받은 폼 파라미터 가져와서 변수에 저장 
	
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String jumin = request.getParameter("jumin1") + "-" + request.getParameter("jumin2");
	String email = request.getParameter("email1") + "@" + request.getParameter("email2") ;
	String job = request.getParameter("job");
	String gender = request.getParameter("gender");
	//취미는 체크박스 형태로 복수개의 동일한 이름을 갖는 파라미터로 전달될 수 있으므로
	//request 객체의 getParameterValues() 메서드를 호출하여 복수개의 파라미터를 
	//String[]타입 배열로 관리 가능 
	
	String hobby = " ";
	String[] arrHobbies = request.getParameterValues("hobby");
	
	//	for(int i=0; i< arrHobbies.length; i++){
	//		hobby += arrHobbies[i] + "/";
	//	}
	
	//향상된 for문 사용 시
	for(String strHobby : arrHobbies){
		hobby += strHobby + "/";
	}
	
	String content = request.getParameter("content");
	
	
	//	out.println(id + "<br>" + passwd + "<br>" + jumin + "<br>" 
	//				+ email + "<br>" + job + "<br>" + gender + "<br>" + hobby + "<br>" +content);
	
	
	//---------------------------------------------------------------------
	//회원가입에 필요한 정보를 jsp8_2DTO 객체에 저장
	
	// 데이터베이스에 사용될 데이터(파라미터)를 studentDTO
	//1. StudentDTO 클래스 인스턴스 생성
	jsp8_2DTO dto = new jsp8_2DTO();
	//2. Student
	dto.setName(name);
	dto.setId(id);
	dto.setPasswd(passwd);
	dto.setJumin(jumin);
	dto.setEmail(email);
	dto.setJob(job);
	dto.setGender(gender);
	dto.setHobby(hobby);
	dto.setContent(content);

	//------------------------------------------------------------------
	//jsp8_2DAO 객체의 insert() 메서드를 호출하여 회원가입 작업 요청
	//=> 파라미터 : jsp8_2DTO 객체      리턴타입 : int(insertCount)
	
	jsp8_2DAO dao = new jsp8_2DAO();
	
	int insertCount = dao.insert(dto);
	
	
	
	
	
	
	
	
	//jsp8_2 테이블에 1개 레코드에 해당하는 모든 데이터 저장 
	//단, 입사일(hire_date) SQL 구문의 now() 함수 사용하여 DB 서버의 현재 날짜, 시각정보를 사용 
	
	//insert 완료 후 성공 시 select2.jsp 페이지로 이동하고 
	//(select2.jsp) 페이지에서 jsp8_2 테이블의 모든 레코드 조회하여 웹페이지에 출력 
	
	
	
if(insertCount > 0) { // 성공
	response.sendRedirect("select2.jsp");
} else { // 실패
	%>
	<script>
		alert("회원 가입 실패!");
		history.back();
	</script>
	<%
}
%>




	
	
	
