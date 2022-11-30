<%@page import="board.FreeBoardDAO"%>
<%@page import="board.FreeBoardDTO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

//------------------------- 파일 업로드 관련 처리 ---------------------------------
// 1. 업로드 할 파일이 저장될 프로젝트 상의 경로(=가상 디렉토리)를 문자열로 지정
String uploadPath = "/upload";
// 2. 서블릿 컨텍스트(현재 프로젝트를 처리하는 객체) 가져오기
ServletContext context = request.getServletContext();
// 3. 프로젝트 상의 가상 업로드 디렉토리에 관한 실제 업로드 디렉토리 알아내기
String realPath = context.getRealPath(uploadPath);
out.println(realPath);
//4. 업로드 할 파일 최대 크기를 정수형으로 지정
int fileSize = 1024 * 1024 * 10; //(10MB)
//5. MultipartRequest 객체 생성
MultipartRequest multi = new MultipartRequest(
	request,
	realPath,
	fileSize,
	"UTF-8",
	new DefaultFileRenamePolicy()
);

// 6. FreeBoardDTO 객체 생성하여 업로드 파라미터 데이터 저장
// 주의! request.getParameter 대신 multi.getParmeter을 써야 한다
FreeBoardDTO freeboard = new FreeBoardDTO();
freeboard.setName(multi.getParameter("name"));
freeboard.setPass(multi.getParameter("pass"));
freeboard.setSubject(multi.getParameter("subject"));
freeboard.setContent(multi.getParameter("content"));

// 1) 파일명을 관리하는 객체에 접근하여 파일명 목록 중 첫번째 파일명에 대한 속성명 가져오기
String fileElement = multi.getFileNames().nextElement().toString();
// 2) 1번 과정에서 가져온 속성명을 활용하여 원본 파일명과 실제 업로드 된 파일명 가져오기
freeboard.setOriginal_file(multi.getOriginalFileName(fileElement));
freeboard.setReal_file(multi.getFilesystemName(fileElement));
out.println("원본 파일 명 : " + freeboard.getOriginal_file() + "실제 파일 명 : " +freeboard.getReal_file());
out.println(freeboard);


//FreeBoardDAO 객체의 insertFileBoard() 메서드를 호출하여 글쓰기 작업 수행
//=> 파라미터 : FreeBoardDTO 객체    리턴타입 : int(insertCount)
FreeBoardDAO dao = new FreeBoardDAO();
int insertCount = dao.insertFileBoard(freeboard);


//글쓰기 결과 판별
if(insertCount > 0) {
	response.sendRedirect("free.jsp");
} else {
	// 업로드 한 파일 삭제
	File f = new File(realPath, freeboard.getReal_file());
	
	if(f.exists()) {
		f.delete(); 
	}
	%>
	<script>
		alert("글쓰기 실패!");
		history.back();
	</script>
	<%
}

%>






















%>