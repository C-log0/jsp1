package test2_forwarding;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//프로젝트 루트에서 jsp 파일을 실행하면
//현재 경로는 http://localhost:8080/StudyServlet 이 된다!
//따라서, 해당 경로에서 요청한 서블릿 주소는 "/서블릿주소" 로 매핑해야함 
@WebServlet("/redirectServlet")
public class TestServlet_Redirect extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("TestServlet_Redirect - doProcess()");
		
		// test6 에서 전달받은 파라미터(이름, 나이) 가져와서 변수에 저장 후 출력
		request.setCharacterEncoding("UTF-8");
		
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		System.out.println("이름 : " + name);
		System.out.println("나이 : " + age);
		// -----------------------------------------------------------------------
		// 현재 서블릿 클래스에서 작업 완료 후 test_redirect_result.jsp 로 포워딩
		// => Redirect 방식 포워딩 수행
		// => response 객체의 sendRedirect() 메서드 호출하여 포워딩 할 페이지 전달
		// => 현재 서블릿 주소 : http://localhost:8080/StudyServlet/redirectServlet?name=%ED%99%8D%EA%B8%B8%EB%8F%99&age=20
		//    따라서, 현재 위치에서 test_redirect.result.jsp 파일 지정(webapp 폴더의 파일)
		response.sendRedirect("test6_redirect_result.jsp");

		// 만약, 컨텍스트 루트(/프로젝트명) 에서 서블릿을 요청한 후
		// 특정 디렉토리 내의 파일을 포워딩 대상으로 지정할 경우
		// "디렉토리명/파일명" 으로 대상을 지정하면 된다!
//		response.sendRedirect("test2_forwarding/test_redirect_result.jsp");
		
		// --------------------------------------------------------------------
		// Redirect 방식 포워딩 특징
		// 1. 포워딩 시 지정한 주소가 표시됨(= 요청받은 새 주소로 변경)
		// => 이전 요청 주소인 http://localhost:8080/StudyServlet 주소에서
		//    http://localhost:8080/StudyServlet/test6_redirect_result.jsp 주소로 변경됨
		// 2. 이전 요청 시 생성된 request 객체가 유지되지 않음(= 새 request 객체 생성됨)
		//    => 따라서, 새 페이지에서 request 객체 데이터 접근 불가!
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
