<%@page import="board.FreeBoardDAO"%>
<%@page import="board.FreeBoardDTO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//----------------------- 파일 업로드 관련 처리 ---------------------------------
String uploadPath = "/upload";
String realPath = request.getServletContext().getRealPath(uploadPath);
int fileSize = 1024 * 1024 * 10;

MultipartRequest multi = new MultipartRequest(
		request, 
		realPath,
		fileSize, 
		"UTF-8", 
		new DefaultFileRenamePolicy()
);

FreeBoardDTO freeboard = new FreeBoardDTO();
freeboard.setName(multi.getParameter("name"));
freeboard.setPass(multi.getParameter("pass"));
freeboard.setSubject(multi.getParameter("subject"));
freeboard.setContent(multi.getParameter("content"));

String fileElement = multi.getFileNames().nextElement().toString();
freeboard.setOriginal_file(multi.getOriginalFileName(fileElement));
freeboard.setReal_file(multi.getFilesystemName(fileElement));
// System.out.println(fileBoard);

// 글번호, 페이지번호 파라미터도 가져와서 변수에 저장(request 객체 사용 아님!)
int idx = Integer.parseInt(multi.getParameter("idx"));
freeboard.setIdx(idx);
String pageNum = multi.getParameter("pageNum");

// 수정 업로드 할 파일을 선택하지 않았을 경우(= 파일이 null 일 경우) 판별
boolean isNewFile = false; // 새 파일이 업로드(수정) 됐는지 여부를 저장할 변수 선언

if(freeboard.getOriginal_file() == null) {
	// 기존 업로드 파일명을 FileBoardDTO 객체에 저장(덮어쓰기)
	freeboard.setOriginal_file(multi.getParameter("old_original_file"));
	freeboard.setReal_file(multi.getParameter("old_real_file"));
} else {
	// 새 파일을 업로드 한다는 표시(true 값)를 isNewFile 변수에 저장
	isNewFile = true;
}

// System.out.println(fileBoard);

// FileBoardDAO 객체의 updateFileBoard() 메서드를 호출하여 글수정 작업 수행
// => 파라미터 : FileBoardDTO 객체    리턴타입 : int(updateCount)
FreeBoardDAO dao = new FreeBoardDAO();
int updateCount = dao.updateFileBoard(freeboard);

// 수정 성공 실패 판별
if(updateCount > 0) { // 수정 성공 시
	// 새 파일 업로드 여부 판별
	if(isNewFile) { // 새 파일 업로드 시
		// 기존 파일(old_real_file 값에 해당하는 파일) 삭제
		File f = new File(realPath, multi.getParameter("old_real_file"));
	
		if(f.exists()) {
			f.delete(); 
		}
	}
	
	// 글 상세보기 페이지로 이동(글번호, 페이지번호)
	response.sendRedirect("free_content.jsp?idx=" + idx + "&pageNum=" + pageNum);
} else { // 수정 실패 시
	// 새 파일 업로드 여부 판별
	if(isNewFile) { // 새 파일 업로드 시
		// 실패한 게시물에 대한 업로드 한 파일 삭제(등록된 새 파일 삭제)
		File f = new File(realPath, freeboard.getReal_file());
		
		if(f.exists()) {
			f.delete(); 
		}
	}
	%>
	<script>
		alert("글수정 실패!");
		history.back();
	</script>
	<%
}

%>