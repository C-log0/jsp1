<%@page import="board.BoardReplyDAO"%>
<%@page import="java.io.File"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
// 세션 아이디 가져와서 sId 변수에 저장
String sId = (String)session.getAttribute("sId");
// 세션 아이디가 없거나 "admin" 이 아닐 경우 
// "잘못된 접근입니다!" 출력 후 이전페이지로 돌아가기
if(sId == null || !sId.equals("admin")) {
//		System.out.println("세션 아이디 없음!");
	%>
	alert("잘못된 접근입니다!");
	history.back();
	<%
}
%>	

<%


// 파라미터 가져와서 확인
int idx=Integer.parseInt(request.getParameter("idx"));
String pageNum = request.getParameter("pageNum");
int ref_idx = Integer.parseInt(request.getParameter("ref_idx"));
String board_type = request.getParameter("board_type");

System.out.println(idx + pageNum + ref_idx + board_type);



// FileBoardDAO 객체의 deleteBoard() 메서드를 호출하여 글 삭제 작업 수행
// => 파라미터 : 글번호, 패스워드   리턴타입 : int(deleteCount)
// => SQL : board 테이블에서 글번호와 패스워드가 일치하는 레코드 삭제(DELETE)
BoardReplyDAO dao = new BoardReplyDAO();
int deleteCount = dao.deleteBoard(idx);


	if(deleteCount>0) {
	response.sendRedirect(board_type+ "_content.jsp?idx=" + ref_idx + "&pageNum" + pageNum);
		
	} else {
		%>
		<script>
			alert("댓글삭제 실패!");
			history.back();
			
		</script>
		
	<%
	}
	
%>	

    