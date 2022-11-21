<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>sessionTest2_set.jsp</h1>
	<%
	//첫번째 파라미터(속성명 = 키) = 저장할 데이터를 저장할 떄 사용할 이름
	//객체의 변수명과 동일한 역할 수행
	session.setAttribute("sessionValue1", "첫번째 세션값");
	session.setAttribute("sessionValue2", "두번째 세션값");
	%>
	<h1> 세션값 생성 완료!</h1>
	<!-- 
	임시 ) session 객체로부터 저장된 데이터 꺼내기
	=> session객체의 getAttribute("속성명")
	=> 파라미터 : 저장된 데이터를 가리키는 ㅣ이름(속성명)
	=>
	 -->
	 <h3>세션값1 : <%=session.getAttribute("sessionValue1") %></h3>
	 <h3>세션값2 : <%=session.getAttribute("sessionValue2") %></h3>
</body>
</html>