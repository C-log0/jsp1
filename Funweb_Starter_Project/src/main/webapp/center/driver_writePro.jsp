<%@page import="java.io.File"%>
<%@page import="board.FileBoardDAO"%>
<%@page import="board.FileBoardDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// request.setCharacterEncoding("UTF-8");

// 주의! 기존 일반 폼 파라미터를 가져오는 request.getParameter() 메서드 사용 불가! 
// => null 값 전달됨
// out.println(request.getParameter("name")); // null 출력됨

//------------------------- 파일 업로드 관련 처리 ---------------------------------
// 1. 업로드 할 파일이 저장될 프로젝트 상의 경로(= 가상 디렉토리)를 문자열로 지정
//    => webapp/upload 디렉토리 생성(webapp 이 뷰페이지의 최상위 디렉토리이므로 "/upload" 지정)
String uploadPath = "/upload";

// 2. 업로드 할 파일 최대 크기를 정수형으로 지정
// 만약, 파일 업로드 가능한 최대 크기를 5MB 로 지정할 경우
// int fileSize = 10485760; // 차후 유지보수 과정에서 파일 크기 변경 시 불편함
// => 파일 크기 지정 시 byte 단위부터 연산 과정을 차례대로 기술하면 유지보수 시 편리함
int fileSize = 1024 * 1024 * 10; // MB 단위(10MB)
// byte(기본 = 1 Byte) -> KB(1024 Byte) -> MB(1024 KB) -> 10MB 단위로 변환

// 3. 현재 프로젝트(서블릿)를 처리하는 객체를 서블릿 컨텍스트(Servlet Context) 라고 하며,
//    이 서블릿 컨텍스트를 객체 형태로 가져오기(request 객체의 getServletContext() 메서드 사용)
ServletContext context = request.getServletContext();
// 4. 프로젝트 상의 가상 업로드 디렉토리에 대한 실제 업로드 디렉토리 알아내기
//    => ServletContext 객체의 getRealPath() 메서드 사용
//       (파라미터로 이클립스 상의 가상 업로드 디렉토리 문자열 전달)
String realPath = context.getRealPath(uploadPath);
out.println(realPath);
// 이클립스가 관리하는 톰캣 서버의 관리 폴더 내부에 있는 실제 업로드 폴더 위치
// D:\Shared\JSP\workspace_jsp5\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Funweb_Starter_Project\ upload

//5. MultipartRequest 객체 생성
//파일 업로드가 포함된 게시물 작성 시 전달받은 파라미터는 request 객체를 통해 전달되지만
//request.getParameter() 메서드를 통해 가져올 수는 없다!
//대신, MultipartRequest 객체의 getParameter() 메서드를 호출하여 파라미터 가져올 수 있다!
// => 주의! 파일 업로드 시  form 태그에 enctype=""
MultipartRequest multi = new MultipartRequest(
		request, //1) 실제 요청 정보가 포함된 request객체	
		realPath, //2) 실제 업로드 되는 폴더 경로(서버마다 달라질 수 있음-탐색 필요)
		fileSize, // 3) 업로드 파일 최대 크기 (기본 단위 : Byte, )
		"UTF-8", //4) 한글 파일명 처리를 위한 인코딩
		new DefaultFileRenamePolicy()
);
//=> MultipartRequest 객체 생성 시점에 파일 업로드가 수행됨

//6. FileBoardDTO 객체 생성하여 업로드 파라미터 데이터 저장
	FileBoardDTO fileBoard = new FileBoardDTO();
	fileBoard.setName(multi.getParameter("name"));	
	fileBoard.setPass(multi.getParameter("pass"));	
	fileBoard.setSubject(multi.getParameter("subject"));	
	fileBoard.setContent(multi.getParameter("content"));
	//단, 파일명을 가져올 때는 단순히 getParameter() 메서드로 처리 불가
	//
	//
	String fileElement = multi.getFileNames().nextElement().toString();
// 	out.println(fileElement); // original_file 출력됨
	//2)
	//2-1) 원본 파일명: getORiginalFileName() 메서드 활용

	fileBoard.setOriginal_file(multi.getOriginalFileName(fileElement));
	fileBoard.setReal_file(multi.getFilesystemName(fileElement));
// 	out.println("원본 파일명: "+ fileBoard.getOriginal_file() + "실제 파일명 : " + fileBoard.getReal_file());
// 	out.println(fileBoard);
	
	//FileBoardDAO 객체의 insertFileBoard() 메서드를 호출하여 글쓰기 작업 수행
	// => 파라미터 : FileBoardDTO 객체   리턴타입 : int(insertCount)
	
	FileBoardDAO dao = new FileBoardDAO();
	 int insertCount = dao.insertFileBoard(fileBoard);
	
	                                                                         
	//글쓰기 결과 판별 
	//실패 시 자바스크립트를 사용하여 "글쓰기 실패!" 출력 후 이전페이지로 돌아가기
	// 아니면, 게시물목록(driver.jsp)로 이동
		if(insertCount>0){
			response.sendRedirect("driver.jsp");
			
		} else {
			
			//기존 파일 삭제
			File f = new File(realPath, fileBoard.getReal_file()); //위와 동일
					
			if(f.exists()){
				f.delete();
			}
			%>
			<script>
				alert("글쓰기 실패");
				history.back();
				
			</script>
			
		<%
		}
		
			
	%>

