<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
// 세션 아이디 가져오기
// String sId = (String)session.getAttribute("sId");

// 글번호, 페이지번호 파라미터 가져오기
// => 단, 페이지번호는 다음 페이지로 전달하는 용도로만 사용하므로 String 타입 사용도 가능
int idx = Integer.parseInt(request.getParameter("idx"));
// String pageNum = request.getParameter("pageNum");
String pageNum = "1";
if(request.getParameter("pageNum")!=null) {
	pageNum = request.getParameter("pageNum");
}

BoardDAO dao = new BoardDAO();

// BoardDAO 객체의 updateReadcount() 메서드를 호출하여 게시물 조회수 증가 작업 수행
// => 파라미터 : 글번호(idx)   리턴타입 : void
dao.updateReadcount(idx);

// BoardDAO 객체의 selectBoard() 메서드를 호출하여 게시물 1개 조회 작업 수행
// => 파라미터 : 글번호(idx)   리턴타입 : BoardDTO(board)
BoardDTO board = dao.selectBoard(idx);

// textarea 에 표시할 데이터는 문자열 치환(replace) 기능을 통해
// 줄바꿈 기호를 "<br>" 태그로 치환해야한다!
// => String 객체의 replaceAll() 메서드 사용
//    (파라미터 : 찾을 문자열, 바꿀 문자열)
//    => 또한, 줄바꿈 기호 찾을 경우 System.getProperty("line.separator")
board.setContent(board.getContent().replaceAll(System.getProperty("line.separator"), "<br>"));

// 날짜 표시 형식을 "xxxx-xx-xx xx:xx:xx"(년-월-일 시:분:초) 형식으로 변경
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // ex) 2022-11-07 09:23:00

// ===============================================================================
// JSTL 과 EL 을 사용하여 BoardDTO 객체 데이터 출력하기
// 자바 객체(BoardDTO 객체)를 JSTL 과 EL 로 접근하기 위해 pageContext 객체에 저장
pageContext.setAttribute("board", board);
// ===============================================================================
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_content.jsp</title>
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
			<h1>Notice Content</h1>
			<table id="notice_content">
				<!-- BoardDTO 객체에 저장된 데이터 표시(EL 활용) -->
				<tr>
					<td>글번호</td>
					<td>${board.idx }</td>
					<td>글쓴이</td>
					<td>${board.name }</td>
				</tr>
				<tr>
					<td>작성일</td>
					<td>${board.date }</td>
					<td>조회수</td>
					<td>${board.readcount }</td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3">${board.subject }</td>
				</tr>
				<tr>
					<td height="300">내용</td>
					<td colspan="3">${board.content }</td>
				</tr>
			</table>

			<div id="table_search">
				<!-- 글수정, 글삭제 버튼은 세션 아이디가 null 이 아니고 "admin" 일 때 표시 -->
				<%-- JSTL 과 EL 을 사용하여 동일한 판별 작업 수행 --%>
				<%-- session 객체는 EL 에서 sessionScope 객체로 접근 --%>
				<c:if test="${not empty sessionScope.sId and sessionScope.sId eq 'admin'}">
					<input type="button" value="글수정" class="btn" 
							onclick="location.href='notice_update.jsp?idx=${param.idx }&pageNum=${param.pageNum }'"> 
					<input type="button" value="글삭제" class="btn" 
							onclick="location.href='notice_delete.jsp?idx=${param.idx }&pageNum=${param.pageNum }'">
				</c:if>
				<input type="button" value="글목록" class="btn" 
						onclick="location.href='notice.jsp?pageNum=${param.pageNum }'">
			</div>

			<div class="clear"></div>
			
			<div id="replyArea">
				<!-- insertForm 영역(댓글 작성 영역) - 세션 아이디 존재 시에만 표시 -->
				<c:if test="${not empty sessionScope.sId }">
					<div id="insertForm">
						<form action="content_reply_writePro.jsp" method="post">
							<!-- 글번호, 게시판타입, 페이지번호를 함께 전달 -->
							<input type="hidden" name="ref_idx" value="${param.idx }">
							<input type="hidden" name="board_type" value="notice">
							<input type="hidden" name="pageNum" value="${param.pageNum }">
							<textarea rows="3" cols="50" name="content"></textarea> 
							<input type="submit" value="등록">
						</form>
					</div>
				</c:if>
				<!-- replyViewArea 영역(댓글 표시 영역) -->
				<div id="replyViewArea">
					안녕하세요. 댓글입니다.  관리자  22-11-15 09:17<br>
					안녕하세요. 댓글입니다.  관리자  22-11-15 09:17<br>
					안녕하세요. 댓글입니다.  관리자  22-11-15 09:17<br>
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


