<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <%
  //세션에 저장된 세션 아이디("sId") 가져와서 변수 sId에 저장
  String sId = (String)session.getAttribute("sId");
//Sysyem.out.println(sId);

  %>
  <script>
  		function confirm_logout(){
  			//Confirm Dialog 를 활용하여 "로그아웃 하시겠습니까?" 질문 처리
  			let result = confirm("로그아웃 하시겠습니까?");
  			
  			//선택된 결과값이 true일 경우 logout.jsp 페이지로 이동
  			if(result) {
  				location.href = "../member/logout.jsp";
  			}
  		}
  </script>

<header>
  <!-- login join -->
  <div id="login">
  	<!-- 세션 아이디가 존재하지 않으면, login, join 링크 표시 -->
  	<!-- 세션 아이디가 존재하면, 아이디, logout 링크 표시 -->
  	<% if(sId == null){ %>
 		<a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a>
  	<%} else { %>
<%--   		<a href="../member/member_info.jsp"><%=sId %>님</a> | <a href="../member/logout.jsp">logout</a></div> --%>
  		<a href="../member/member_info.jsp?id=<%=sId %>"><%=sId %>님</a> | <a href="javascript:confirm_logout()">logout</a>
			
			<!-- 세션아이디가 "admin"일 경우 "관리자 페이지(admin/admin_main.jsp)"링크 표시 -->
			<%if(sId.equals("admin")) { %>
			| <a href = "../admin/admin_main.jsp">관리자페이지</a>
			<%}%>
			
  	<% } %>
  	</div>
  <div class="clear"> </div>
  <!-- 로고들어가는 곳 -->
  <div id="logo"><img src="../images/logo.gif"></div>
  <!-- 메뉴들어가는 곳 -->
  <nav id="top_menu">
  	<ul>
  		<li><a href="../main/main.jsp">HOME</a></li>
  		<li><a href="../company/welcome.jsp">COMPANY</a></li>
  		<li><a href="../company/welcome.jsp">SOLUTIONS</a></li>
  		<li><a href="../center/notice.jsp">CUSTOMER CENTER</a></li>
  		
  		<li><% if(sId==null || sId.equals("")){ %>				
				<a href="javascript:void(0)" onclick="alert('잘못된 접근입니다!')">CONTACT US</a>
				<%} else {%>
				<a href="../mail/mailForm.jsp">CONTACT US</a>
				<% } %>
				
			</li>
  	</ul>
  </nav>
</header>