<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>requestPro1.jsp - request 객체</h1>
	<h1>request 객체 처리 페이지</h1>
	<%
	/*
	
	
	*/
	request.setCharacterEncoding("UTF-8"); //POST방식일 때 데이터 처리하는 응답 페이지에 입력 시, 한글 깨지지 않음
	//단, 반드시 파라미터값을 가져오는 코드(getParameter())보다 먼저 수행되어어야 함!
	
	//1. 파라미터중 파라미터명(name속성값\)이 "name"인값 가져와서
	String strName = request.getParameter("name");
	// 스크립틀릿 내에서 웹브라우저에 데이터 출력할 경우 out.println()사용
// 	out.println("이름 : " + strName + "<br>");
	
	//2. 파라미터중 파라미터명이 "age"인 값 가져와서 String타입 strAge에 저장
	String strAge = request.getParameter("age");
// 	out.println("나이 : " + strAge + "<br>");
	
	//3. 파라미터중 파라미터명이 "gender"인 값 가져와서 String타입 strGender에 저장
	String strGender = request.getParameter("gender");
// 	out.println("성별 : " + strGender + "<br>");
	
	//4. 파라미터중 파라미터명이 "gender"인 값 가져와서 String타입 strGender에 저장
// 	String strHobby = request.getParameter("hobby");
// 	out.println("취미 : " + strHobby + "<br>");
	//주의! 복수개의 데이터가 하나의 파라미터명으로 전달되는 경우(ex.체크박스)
	//getParameter() 메서드 대신 getParameterValues() 메서드를 호출하여
	//복수개의 동일한 이름의 파라미터를 String[]타입으로 리턴받아 처리해야함
	String[] strHobbies = request.getParameterValues("hobby");
// 	out.println("취미 : " + strHobbies + "<br>");
	//=> 주의! 체크박스 항목을 하나도 체크하지 않을 경우 "hobby" 라는 파라미터가 없으므로
	//strHobbies 배열(변수)에는 null값이 하나도
	
	%>
	
	<table border = "1">
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
			<th>취미</th>
				<!-- strHobbies 배열 접근 시 최대 3개의 항목 접근 가능 -->
<%-- 				<%=strHobbies[0] %> <%=strHobbies[1] %> <%=strHobbies[2] %> --%>
				<!-- 주의! 배열 크기가 3미만일 경우 인덱스 직접 지정 시 오류 발생 가능성 있음 -->
				<!-- java.lang.ArrayIndexOutOfBoundsException: Index 1 out of bounds for length 1 오류 -->
				<!-- 반드시, 배열 접근 시 for문을 사용하여 배열 -->
				<!--  -->
				<%
// 					for(int i = 0; i < strHobbies.length; i++) {
// 						out.println(strHobbies[i] + " ");
						
// 					}
				%>
				
				<%--
				만약, strHobbies가 null이면 자바스크립트를 사용하여 
				"취미 선택 필수!" 메세지 출력 후 이전페이지로 돌아가기
				--%>
				<%if(strHobbies == null) { %>
					<script type="text/javascript">
<!-- // 						alert("취미 선택 필수!"); -->
<!-- // 						history.back(); -->
<!-- 					</script> -->
				<%} %>

			<%
			//만약, strHobbies가 null 이면 "없음" 문자열 출력하고,
			//체크 항목이 하나라도 존재할 경우에만 반복문을 통해 항목 출력
			
			if(strHobbies == null){
				out.println("없음");
			} else {
				for(int i = 0; i < strHobbies.length; i++){
					out.println(strHobbies[i] + " ");
				}
				
			}
			%>

			<td>
				
			</td>
		</tr>
		<tr>
			<!-- submit 버튼("전송")생성  => 클릭 시 require-->
			<td colspan ="2" align="center">
				<input type = "button" value = "뒤로가기" onclick = "history.back()">
			</td>
		</tr>
			
		
	</table>

</body>
</html>