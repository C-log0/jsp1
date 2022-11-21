<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/join.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script>
  		function confirmLeave(id){
  			//Confirm Dialog 를 활용하여 "탈퇴 하시겠습니까?" 질문 처리
  			let result = confirm("탈퇴 하시겠습니까?");
  			
  			//선택된 결과값이 true일 경우 member_delete.jsp 페이지로 이동(파라미터로 id전달)
  			if(result) {
  				location.href = "../member/member_delete.jsp?id=" + id;
  			}
  		}
  		
  </script>
</head>
<body>

	<%
	// 만약, 세션 아이디가 존재하지 않거나, 세션아이디와 파라미터 아이디가 다르고, 
	// 관리자 아이디(admin)가 아니면
	// "잘못된 접근입니다!" 출력 후 메인페이지로 이동
	String sId = (String)session.getAttribute("sId");
	String id = request.getParameter("id");
	
	
	if(sId == null || id == null || id.equals("") || !sId.equals(id) && !sId.equals("admin")) {
		%>
		<script>
			alert("잘못된 접근입니다!");
			location.href = "../main/main.jsp";
		</script>
		<%
	}
	
	// MemberDAO 객체의 selectMember() 메서드를 호출하여 회원 정보 조회
	// => 파라미터 : 세션아이디    리턴타입 : MemberDTO(member)
	MemberDAO dao = new MemberDAO();
	MemberDTO member = dao.selectMember(sId);
  	%>
	
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<!-- inc/top.jsp 페이지 포함시키기 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->
		  
		<!-- 본문들어가는 곳 -->
		  <!-- 본문 메인 이미지 -->
		  <div id="sub_img_member"></div>
		  <!-- 왼쪽 메뉴 -->
		  <nav id="sub_menu">
		  	<ul>
		  		<li><a href="#">Join us</a></li>
		  		<li><a href="#">Privacy policy</a></li>
		  	</ul>
		  </nav>
		  <!-- 본문 내용 -->
		  <article>
		  	<h1>Member Info</h1>
		  	<form action="member_update.jsp" method="post" id="join" name="fr">
		  		<fieldset>
		  			<legend>Basic Info</legend>
		  			<label>User Id(변경 불가)</label>
		  			<input type="text" name="id" class="id" id="id" required="required" value = "<%=member.getId() %>">
		  			<input type="button" value="dup. check" class="dup" id="btn"><br>
		  			
		  			<label>Old Password</label> <!-- 기존 패스워드 -->
		  			<input type="password" name="oldpass" id="oldpass" required="required" placeholder ="기존패스워드 입력" ><br> 
		  						
		  			<label>New Password</label> <!-- 새 패스워드 -->
		  			<input type="password" name="newpass" id="newpass" placeholder = "변경시에만 입력" ><br> 			
		  			
		  			<label>Retype New Password</label>
		  			<input type="password" name="newpass2"  placeholder = "변경시에만 입력"  ><br>
		  			
		  			<label>Name</label>
		  			<input type="text" name="name" id="name" required="required" value = "<%=member.getName() %>"><br>
		  			
		  			<label>E-Mail</label>
		  			<input type="email" name="email" id="email" required="required"value = "<%=member.getEmail() %>"><br>
		  			
		  			<label>Mobile Phone Number</label>
		  			<input type="text" name="mobile" required="required" value = "<%=member.getMobile() %>"><br>
		  		</fieldset>
		  		
		  		<fieldset>
		  			<legend>Optional</legend>
		  			<label>Post Code</label>
		  			<input type="text" name="post_code" id="post_code" placeholder="우편번호" value = "<%=member.getPost_code() %>">
		  			<input type="button" value="주소검색"><br>
		  			
		  			<label>Address</label>
		  			<input type="text" name="address1" id="address1" placeholder="주소" value = "<%=member.getAddress1() %>">
		  			<input type="text" name="address2" id="address2" placeholder="상세주소" value = "<%=member.getAddress2() %>"><br>
		  			
		  			<label>Phone Number</label>
		  			<input type="text" name="phone" value = "<%=member.getPhone() %>"><br>
		  			
		  		</fieldset>
		  		
		  		<div class="clear"></div>
		  		<div id="buttons">
		  			<input type="submit" value="Update" class="submit">
		  			<input type="reset" value="Cancel" class="cancel">
		  			<input type="button" value="Leave" class="submit" onclick="confirmLeave('<%= member.getId()%>')">
		  		</div>
		  	</form>
		  </article>
		  
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


