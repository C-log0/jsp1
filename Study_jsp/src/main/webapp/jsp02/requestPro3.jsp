<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>requestPro3.jsp</h1>
	<h1>request 객체 처리 페이지</h1>
	
	<% 
	
	request.setCharacterEncoding("UTF-8");
	
	String strName = request.getParameter("name");
// 	 	out.println("이름 : " + strName + "<br>");
	
	String strAge = request.getParameter("age");
//  		out.println("나이 : " + strAge + "<br>");
	
	String strGender = request.getParameter("gender");
//  		out.println("성별 : " + strGender + "<br>");
 	
 	String strGrade = request.getParameter("grade");
//  		out.println("학년 : " + strGrade + "<br>");
	
	String[] strHobbies = request.getParameterValues("hobby"); 
//  		out.println("취미 : " + strHobbies + "<br>");
	
	%>
	
	<table border="1">
		<tr>
			<th>이름</th>
			<td><%=strName %></td>
		</tr>
		<tr>
			<th>나이</th>
			<td><%=strAge %></td>
		</tr>
		<tr>
			<th>성별</th>
			<td><%=strGender %></td>
		</tr>
		<tr>
			<th>학년</th>
			<td><%=strGrade %></td>
		</tr>
		<tr>
			<th>취미</th>
			<td>
				<!-- strHobbies 배열 접근 시 최대 3개의 항목 접근 가능 -->
<%-- 				<%=strHobbies[0] %> <%=strHobbies[1] %> <%=strHobbies[2] %> --%>
				<!-- 주의! 배열 크기가 3 미만일 경우 인덱스 직접 지정 시 오류 발생 가능성 있음 -->
				<!-- java.lang.ArrayIndexOutOfBoundsException: Index 2 out of bounds for length 2 -->
				<!-- 반드시, 배열 접근 시 for 문을 사용하여 배열 크기만큼 반복하면서 접근해야함 -->
				<!-- hobby 파라미터 없을 경우 strHobbies.length 접근 시 NullPointerException 이라는 오류 발생함 -->
				<%
// 				for(int i = 0; i < strHobbies.length; i++) {
// 					out.println(strHobbies[i] + " ");
// 				}
				%>
				
				<%-- 
				만약, strHobbies 가 null 이면 자바스크립트를 사용하여
				"취미 선택 필수!" 메세지 출력 후 이전페이지로 돌아가기
				--%>
<%-- 				<%if(strHobbies == null) { %> --%>
					<script type="text/javascript">
// 						alert("취미 선택 필수!");
// 						history.back();
					</script>
<%-- 				<%} %> --%>

				<%
				// 만약, strHobbies 가 null 이면 "없음" 문자열 출력하고,
				// 체크 항목이 하나라도 존재할 경우에만 반복문을 통해 항목 출력
				if(strHobbies == null) {
					out.println("없음");	
				} else {
					for(int i = 0; i < strHobbies.length; i++) {
						out.println(strHobbies[i] + " ");
					}
				}
				%>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" value="뒤로가기" onclick="history.back()">
			</td>
		</tr>
	</table>
</body>
</html>