package test;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/test4/myServlet_backup")
public class TestMyServlet4_backup extends HttpServlet {
	// doGet(), doPost() 메서드 파라미터로 request 와 response 객체를 전달받는
	// HttpServletRequest request, HttpServletResponse response 타입 파라미터 선언되어 있음
	// => JSP 페이지에서 사용하던 내장 객체와 동일한 객체
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("TestMyServlet4 - doGet()");
		
		// test4.jsp 페이지에서 GET 방식 요청으로 전달받은 파라미터값(이름, 나이) 가져오기
		// => request 객체의 getParameter() 메서드 사용
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
				
		System.out.println("이름 : " + name);
		System.out.println("나이 : " + age);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("TestMyServlet4 - doPost()");
		
		// test4.jsp 페이지에서 POST 방식 요청으로 전달받은 파라미터값(이름, 나이) 가져오기
		// => request 객체의 getParameter() 메서드 사용
		// => 단, POST 방식 요청의 경우 한글 파라미터 처리를 위한 인코딩 방식 설정 필요!
		request.setCharacterEncoding("UTF-8");
		
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
				
		System.out.println("이름 : " + name);
		System.out.println("나이 : " + age);
	}
	
}
