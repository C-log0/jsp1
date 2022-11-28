package test3_student;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/test3_student/WriteForm")
public class WriteFormServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("WriteFormServlet - doGet()");
		
		// test3_student 디렉토리의 writeForm.jsp 페이지로 포워딩
		// => 포워딩 될 새 주소(writeForm.jsp)를 숨기기 위해 
		//    기존 서블릿 주소를 유지해야하므로 Dispatch 방식으로 포워딩
		RequestDispatcher dispatcher = request.getRequestDispatcher("writeForm.jsp");
		dispatcher.forward(request, response);
		
		// => Dispatch 방식으로 포워딩 했을 경우
		//    기존 서블릿 주소(http://localhost:8080/StudyServlet/test3_student/WriteForm)가
		//    새 주소로 변경되지 않고 그대로 유지됨
		//    즉, 포워딩 되는 실제 jsp 파일명(디렉토리 구조 포함)이 URL 에 노출되지 않음
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("WriteFormServlet - doPost()");
	}

}
