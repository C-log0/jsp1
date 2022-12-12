<%@page import="board.FreeBoardDTO"%>
<%@page import="board.FreeBoardDAO"%>
<%@page import="board.BoardReplyDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardReplyDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

// 글번호, 페이지번호 파라미터 가져오기
int idx = Integer.parseInt(request.getParameter("idx"));
String pageNum = request.getParameter("pageNum");

//만약, pageNum 값이 null 일 경우 "1" 값으로 변경
if(pageNum == null) {
	pageNum = "1";
}

FreeBoardDAO dao = new FreeBoardDAO();

// FreeBoardDAO 객체의 updateReadcount() 메서드를 호출하여 게시물 조회수 증가 작업 수행
// => 파라미터 : 글번호(idx)   리턴타입 : void
dao.updateReadcount(idx);

// FreeBoardDTO 객체의 selectFileBoard() 메서드를 호출하여 게시물 1개 조회 작업 수행
//=> 파라미터 : 글번호(idx)   리턴타입 : FreeBoardDTO(freeboard)
FreeBoardDTO freeboard = dao.selectFileBoard(idx);
// System.out.println(freeboard);

// textarea 에 표시할 데이터 줄바꿈 기능 넣기
freeboard.setContent(freeboard.getContent().replaceAll(System.getProperty("line.separator"), "<br>"));

// 날짜 표시 형식 변경
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

// 게시판 타입을 변수에 저장
String board_type = "free";
%>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/free_content.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"></div>
		<!-- 왼쪽 메뉴 -->
		<jsp:include page="../inc/left.jsp" />
		<!-- 본문 내용 -->
	<article>
		<h1>Free Board</h1>
		<table id = "free_content">
			<!-- BoardDTO 객체에 저장된 데이터 표시 -->
			<tr>
				<td>글번호</td>
				<td><%=freeboard.getIdx() %></td>
				<td>글쓴이</td>
				<td><%=freeboard.getName() %></td>
			</tr>
			<tr>
				<td>작성일</td>
				<td><%=sdf.format(freeboard.getDate()) %></td>
				<td>조회수</td>
				<td><%=freeboard.getReadcount() %></td>
			</tr>
			<tr>
				<td>제목</td>
				<td colspan="3"><%=freeboard.getSubject() %></td>
			</tr>
			<tr>
				<td>파일</td>
				<td colspan ="3">
					<!-- 실제 파일과 연결하여 파일 다운로드 하이퍼링크 생성
						=> <a href="경로/실제파일명" download="다운로드할파일명">원본파일명</a> -->
				<a href = "../upload/<%=freeboard.getReal_file() %>" download="<%=freeboard.getOriginal_file() %>"><%=freeboard.getOriginal_file() %></a>
			</tr>
			<tr>
				<td height="300">내용</td>
				<td colspan="3"><%=freeboard.getContent() %></td>
			</tr>
		</table>
	
	<div id="table_search">
				<!-- 세션 아이디 존재할	 경우에만 글수정, 글삭제 버튼 표시 -->
				<%if(session.getAttribute("sId") != null) { %>
					<input type="button" value="글수정" class="btn" 
							onclick="location.href='free_update.jsp?idx=<%=idx%>&pageNum=<%=pageNum%>'"> 
					<input type="button" value="글삭제" class="btn" 
							onclick="location.href='free_delete.jsp?idx=<%=idx%>&pageNum=<%=pageNum%>'">
				<%} %> 
				<input type="button" value="글목록" class="btn" 
						onclick="location.href='free.jsp?pageNum=<%=pageNum%>'">
			</div>

			<div class="clear"></div>
			
			<div id="replyArea">
				<!-- insertForm 영역(댓글 작성 영역) - 세션 아이디 존재 시에만 표시 -->
				<%if(session.getAttribute("sId") != null) { %>
					<div id="insertForm">
						<form action="content_reply_writePro.jsp" method="post">
							<!-- 글번호, 게시판타입, 페이지번호를 함께 전달 -->
							<input type="hidden" name="ref_idx" value="<%=idx%>">
							<input type="hidden" name="board_type" value="<%=board_type%>">
							<input type="hidden" name="pageNum" value="<%=pageNum%>">
							<textarea rows="3" cols="50" name="content" id="replyTextarea"></textarea> 
							<input type="submit" value="등록" id="replySubmit">
						</form>
					</div>
				<%} %>
				<!-- replyViewArea 영역(댓글 표시 영역) -->
				<div id="replyViewArea">
					<%
					// 페이징 처리를 위한 값 설정 생략 => driver.jsp & notice.jsp 와 동일
					// 페이징 처리를 위해 조회 시 필요한 값 임의 설정
					int startRow = 0; // 계산 생략
					int listLimit = 5;
					
					// BoardReplyDAO - selectReplyList() 메서드를 호출하여 댓글 목록 가져오기
					// => 파라미터 : 게시물글번호, 게시판타입, startRow, listLimit 
					//    리턴타입 : List<BoardReplyDTO>(replyList)
					BoardReplyDAO replyDao = new BoardReplyDAO();
					List<BoardReplyDTO> replyList = replyDao.selectReplyList(idx, board_type, startRow, listLimit);
					
					// List 객체 크기만큼 반복
					for(BoardReplyDTO replyBoard : replyList) {
						%>
						<a href="reply_deletePro.jsp?idx=<%=replyBoard.getIdx()%>&pageNum=<%=pageNum%>
								&ref_idx=<%=replyBoard.getRef_idx()%>&board_type=<%=replyBoard.getBoard_type()%>">
						<img src= "../images/center/delete.png" width="10px" height="10px"></a>
						
						<span id="replyContent"><%=replyBoard.getContent() %></span>
						<span id="replyId"><%=replyBoard.getId() %></span>
						<span id="replyDate"><%=sdf.format(replyBoard.getDate()) %></span><br>
						<%
					}
					%>
				</div>
				
				<div id="replyPageArea">
					1  2  3  4
				</div>	
			</div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
	
	
</body>
</html>