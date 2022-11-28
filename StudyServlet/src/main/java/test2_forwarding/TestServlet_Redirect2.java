package test2_forwarding;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//프로젝트 루트의 test2_forwarding 폴더에서 jsp 파일을 실행하면
//현재 경로는 http://localhost:8080/StudyServlet/test2_forwarding 이 된다!
//따라서, 해당 경로에서 요청한 서블릿 주소는 "/test2_forwarding/서블릿주소" 로 매핑해야함 
@WebServlet("/test2_forwarding/redirectServlet")
public class TestServlet_Redirect2 extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("TestServlert_Redirect - doProcess()");
		
		// test6 에서 전달받은 파라미터(이름, 나이) 가져와서 변수에 저장 후 출력
		request.setCharacterEncoding("UTF-8");
		
		String name = request.getParameter("name");
		int age= Integer.parseInt(request.getParameter("age"));
		System.out.println("이름 : " + name);
		System.out.println("나이 : " + age);
		// -----------------------------------------------------------------------
		// 현재 서블릿 클래스에서 작업 완료 후 test_redirect_result.jsp 로 포워딩
		// => Redirect 방식 포워딩 수행
		// => response 객체의 sendRedirect() 메서드 호출하여 포워딩 할 페이지 전달
		// => 현재 서블릿 주소 : http://localhost:8080/StudyServlet/test2_forwarding/redirectServlet?name=%ED%99%8D%EA%B8%B8%EB%8F%99&age=20
		//    따라서, 현재 위치에서 test2_forwarding 디렉토리의 test_redirect.result.jsp 파일 지정 시
		//    파일명만 지정해도 된다! (현재 URL 에 디렉토리명까지 포함되어 있기 때문)
		response.sendRedirect("test_redirect_result.jsp");
		
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	
}
