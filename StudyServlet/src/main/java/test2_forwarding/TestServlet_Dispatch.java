package test2_forwarding;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/dispatchServlet")
public class TestServlet_Dispatch extends HttpServlet {
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("TestServlet_Dispatch - doProcess()");
		
		// test6 에서 전달받은 파라미터(이름, 나이) 가져와서 변수에 저장 후 출력
		request.setCharacterEncoding("UTF-8");
		
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		System.out.println("이름 : " + name);
		System.out.println("나이 : " + age);
		// -----------------------------------------------------------------------
		// 현재 서블릿 클래스에서 작업 완료 후 webapp/test6_dispatch_result.jsp 로 포워딩
		// => Dispatch 방식 포워딩 수행
		// 1. request 객체의 getRequestDispatcher() 메서드를 호출 
		//    => 파라미터 : 포워딩 할 페이지 전달, 리턴타입 : javax.servlet.RequestDispatcher
		// webapp/test6_dispatch_result.jsp 페이지로 포워딩 시
//		RequestDispatcher dispatcher = request.getRequestDispatcher("test6_dispatch_result.jsp");
		
		// webapp/test2_forwarding/test_dispatch_result.jsp 페이지로 포워딩 시
		RequestDispatcher dispatcher = request.getRequestDispatcher("test2_forwarding/test_dispatch_result.jsp");
		
		// 2. RequestDispatcher 객체의 forward() 메서드를 호출하여 포워딩 작업 수행
		//    => 파라미터 : request, response 객체
		dispatcher.forward(request, response);
		
		// -----------------------------------------------------------------------
		// Dispatch(Dispatcher) 방식 포워딩 특징
		// 1. 포워딩 시 지정한 주소가 웹브라우저 주소표시줄에 표시되지 않고
		//    이전 요청 주소가 그대로 유지됨(= 주소표시줄 주소가 변경되지 않음)
		// => 이전 요청 주소인 http://localhost:8080/StudyServlet/dispatchServlet 주소가
		//    변경되지 않은채로 test6_dispatch_result.jsp 페이지로 포워딩함
		// 2. 이전 요청 시 생성된 request 객체를 포워딩 시점에서 함께 전달하므로
		//    포워딩 후에도 기존 request 객체(response 포함)가 그대로 유지됨
		//    따라서, 원래 저장되어 있던 파라미터 등의 데이터도 그대로 유지됨
		//    (= 새 페이지에서도 공유 가능함)
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
