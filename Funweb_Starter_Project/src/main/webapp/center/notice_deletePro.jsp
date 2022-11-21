<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 파라미터 가져와서 확인
int idx =Integer.parseInt(request.getParameter("idx"));
String pageNum = request.getParameter("pageNum");
System.out.println(idx + ", " + pageNum + "pass");

String pass = request.getParameter("pass");
// System.out.println(idx + "," + pageNum + "," + pass);

// BoardDAO 객체의 deleteBoard() 메서드를 호출하여 글 삭제 작업 수행
// => 파라미터 : 글번호, 패스워드   리턴타입 : int(deleteCount)
// => SQL : board 테이블에서 글번호와 패스워드가 일치하는 레코드 삭제(DELETE)
BoardDAO dao = new BoardDAO();
int deleteCount = dao.deleteBoard(idx, pass);

// 삭제 결과 판별
// 성공 시 글 목록 페이지(notice.jsp)로 이동하고
// (=> 파라미터로 페이지번호 전달 필요)
// 아니면(실패 시) 자바스크립트로 "글 삭제 실패!" 출력 후 이전페이지로 돌아가기



// 삭제 결과 판별
// 성공 시 상세 조회 페이지(notice_content.jsp)로 이동하고
// 아니면(실패 시) 자바스크립트로 "글 삭제 실패!" 출력 후 이전페이지로 돌아가기

		if(deleteCount>0){
		response.sendRedirect("notice.jsp?pageNum=" + pageNum);
		
	} else {
		%>
		<script>
			alert("글삭제 실패");
			history.back();
			
		</script>
		
	<%
	}
	
		
%>	

    