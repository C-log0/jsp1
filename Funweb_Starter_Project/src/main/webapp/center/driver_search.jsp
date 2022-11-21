<%@page import="board.FileBoardDTO"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// board 테이블의 게시물 목록 조회
FileBoardDAO dao = new FileBoardDAO();

// BoardDAO 객체의 selectBoardList() 메서드를 호출하여 게시물 목록 조회
// => 파라미터 : 없음, 리턴타입 : List<BoardDTO>(boardList)
// (단, 임시로 페이징 처리 없이 전체 목록 조회)
// List<BoardDTO> boardList = dao.selectBoardList();
// ------------------------------------------------------------------------------
// 페이징 처리에서 사용되는 게시물 목록 조회를 위한 계산 작업
// 1. 한 페이지에서 표시할 게시물 목록 수 설정
int listLimit = 10; // 한 페이지에서 표시할 게시물 목록을 10개로 제한

// 2. 현재 페이지 번호 설정(pageNum 파라미터 사용)
// => pageNum 파라미터가 존재하면 해당 값을 저장하고, 아니면 기본 값 1 사용
int pageNum = 1;
if(request.getParameter("pageNum") != null) {
	pageNum = Integer.parseInt(request.getParameter("pageNum"));
}
// System.out.println(pageNum);

/*
3. 현재 페이지에서 목록으로 표시할 첫 게시물의 행(레코드) 번호 계산
   => (현재 페이지번호 - 1) * 페이지 당 게시물 목록 갯수
------------------------------------------------------------------------------------
pageNum(페이지번호)  listLimit(게시물 수)    startRow(시작행번호)   endRow(끝행번호)
------------------------------------------------------------------------------------
        1                    10              (1 - 1) * 10 =  0행        (~ 9행)
        2                    10              (2 - 1) * 10 = 10행       (~ 19행)
        3                    10              (3 - 1) * 10 = 20행       (~ 29행)
*/
int startRow = (pageNum - 1) * listLimit;
   
  
//파라미터로 전달받은 검색어(keyword) 가져와서 변수에 저장
String keyword = request.getParameter("keyword");

//만약, 전달받은 검색어가 NULL 이면 널스트링으로 변경
if(keyword == null ){
	keyword = "";
}



// FileBoardDAO 객체의 selectFileBoardList() 메서드를 호출하여 검색어가 포함된 게시물 목록 조회
// => 파라미터 : 시작행번호, 페이지 당 게시물 목록 수, 검색어
// => 리턴타입 : List<BoardDTO>(boardList)
List<FileBoardDTO> boardList = dao.selectFileBoardList(startRow, listLimit, keyword);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/driver.jsp</title>
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
			<h1>Notice</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Write</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
				<!-- 글목록을 반복 표시할 위치 -->
				<!-- List 객체(boardList) 크기만큼 반복 -->
				<%
// 				for(int i = 0; i < boardList.size(); i++) {
// 					BoardDTO board = boardList.get(i);
// 				}
				
				// 향상된 for문 활용
				for(FileBoardDTO fileboard : boardList) {
				%>
				<!-- 제목 행을 클릭 시 글 상세 정보 표시(driver_content.jsp)로 이동 -->
				<!-- 파라미터로 글 번호(idx)값 전달 -->
					<tr onclick="location.href='driver_content.jsp?idx=<%=fileboard.getIdx()%>&pageNum=<%=pageNum %>'">
						<td><%=fileboard.getIdx() %></td>
						<td class="left"><%=fileboard.getSubject() %></td>
						<td><%=fileboard.getName() %></td>
						<%
						// 작성일자(날짜 및 시각) 표시 형식 변경을 위해 java.text.SimpleDateFormat 객체 활용
						// => 생성자 파라미터로 표시 형식 문자열을 사용한 패턴 지정
						//    ex) 연연-월월-일일 시시:분분 형식 지정 시 "yy-MM-dd HH:mm" 패턴 활용하면
						//        "22-11-02 11:27" 형태로 표시됨
						SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
						// => 패턴이 저장된 SimpleDateFormat 객체의 format() 메서드를 호출하여 변환할 날짜를 전달 시
						//    전달된 날짜가 해당 패턴에 맞게 변환됨 => 출력 위치에서 즉시 사용 가능
 						%>
						<td><%=sdf.format(fileboard.getDate()) %></td> <!-- 출력 날짜 형식 변환 -->
						<td><%=fileboard.getReadcount() %></td>
					</tr>
				<%
				}
				%>
			</table>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn" onclick="location.href='notice_write.jsp'">
			</div>
			<div id="table_search">
				<form action="notice_search.jsp" method="get">
					<input type="text" name="keyword" value ="<%=keyword %> class="input_box">
					<input type="submit" value="Search" class="btn">
				</form>
			</div>

			<div class="clear"></div>
			<div id="page_control">
				<%
				// 한 페이지에서 표시할 페이지 목록(번호) 갯수 계산
				// 1. BoardDAO 객체의 selectListCount() 메서드를 호출하여 전체 게시물 수 조회(페이지 목록 계산에 사용)
				// => 파라미터 : 없음, 리턴타입 : int(listCount)
				int listCount = dao.selectListCount(keyword);
				System.out.println("총 게시물 수 : " + listCount);
				
				// 2. 한 페이지에서 표시할 페이지 목록 갯수 설정
				int pageListLimit = 10; // 한 페이지에서 표시할 페이지 목록을 3개로 제한
				
				// 3. 전체 페이지 목록 수 계산
				// => 전체 게시물 수를 페이지 당 게시물 목록 수로 나눈 몫 계산
				// ex) 총 게시물 수 11개 일 때 페이지 수 : 2(10개 출력 후 남은 1개 1페이지 필요)
				//     총 게시물 수 21개 일 때 페이지 수 : 3(10개 * 2 출력 후 남은 1개 1페이지 필요)
				//     총 게시물 수 30개 일 때 페이지 수 : 3(10개 * 3 출력 후 남은 게시물 없음)
// 				int maxPage = listCount / listLimit; // 10
				
				//만약, 10개씩 분할 후 
// 				if(listCount % listLimit > 0) {
// 					maxPage++;
// 				}
				
				//삼항 연산자(=조건 연산자)를 활용하여 동일한 계산 수행
				//(조건식 ? 값1 : 값2)
				//=-> 나눗셈 결과에 추가로 1페이지를 더할지 말지 판별하여 다른 값 덧셈
				int maxPage = listCount / listLimit + (listCount % listLimit == 0 ? 0 : 1);
				
// 				System.out.println("전체 페이지 수 : " + maxPage);

				//4. 시작 페이지 번호 계산
				//=> (현재페이지번호 -1 )/페이지 목록 갯수*페이지 목록 갯수 +1
				//ex) 현재페이지 : 1 => 시작페이지 = (1-1) / 10*10 + 1 = 1페이지
				//	  현재페이지 : 2 => 시작페이지 = (2-1) / 10*10 + 1 = 1페이지
				//	  현재페이지 : 10 => 시작페이지 = (10-1) / 10*10 + 1 = 1페이지
				//	  현재페이지 : 15 => 시작페이지 = (15-1) / 10*10 + 1 = 11페이지
				int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
				
				// 5. 끝 페이지 번호 계산
				//  => 시작 페이지  + 페이지 목록개수 -1
				int endPage = startPage + pageListLimit -1;
				
				// 6. 만약, 끝페이지 번호(endPage)가 전체(최대)페이지 번호(maxPAge) 보다
				// 클 경우, 끝페이지 번호를 최대 페이지 번호로 교체
				
			
				if(endPage > maxPage) {
					endPage = maxPage;
				}
				%>
				
								
				
				<!-- 이전페이지(Prev) 버튼 클릭 시 현재 페이지번호 -1값 전달 -->
				<!-- 단, 현재 페이지 번호가 1보다 클 경우 -1값을 전달, 아니면 링크 동작 제거 -->
				<%if(pageNum > 1) { %>
				<a href="driver.jsp?pageNum=<%=pageNum -1%>">Prev</a>
				<% } else { %>
					<a href="javascript:void(0)">Prev</a>
				<%} %>
				
				<!-- 다음페이지(Next) 버튼 클릭 시 현재 페이지번호 +1값 전달 -->
				<!-- 단, 현재 페이지 번호가 전체페이지 번호보다 작을 경우 +1값을 전달, 아니면 링크 동작 제거 -->
				<%if(pageNum < maxPage) { %>
				<a href="driver.jsp?pageNum=<%=pageNum +1%>">Prev</a>
				<% } else { %>
					<a href="javascript:void(0)">Prev</a>
				<%} %>
				
								
				<!-- for문을 사용하여 시작페이지~끝페이지 까지 페이지 번호 표시 -->
				<% for(int i= startPage; i <= endPage; i++) {%>
					<!-- 단, 현재 페이지는 하이퍼링크 제거하고 번호만 표시 -->
					<% if(pageNum == i) { %>
						<a href = "javascript:void(0)"><%=i %></a>
					<%} else { %>
						<a href="driver.jsp?pageNum=<%=i %>"><%=i %></a>
					<%} %>
				<%} %>
				<a href="#">Next</a>
				

			</div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>
