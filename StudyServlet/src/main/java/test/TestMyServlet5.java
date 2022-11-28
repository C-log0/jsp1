package test;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//서블릿 클래스 정의 시 프로젝트명(패키지명) 우클릭 - New - Servlet 메뉴로 생성하면
//상속 및 @WebServlet 어노테이션 지정, doGet() 과 doPost() 오버라이딩까지 자동으로 수행됨
//서블릿 주소 매핑 시 매핑 주소가 복수개 일 수 있음(패턴도 복수개 가능)
//@WebServlet({ "서블릿주소1", "서블릿주소2" })

@WebServlet({ "/myServlet5", "/myServlet5_2" })
public class TestMyServlet5 extends HttpServlet {
       
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("TestMyServlet5 - doProcess()");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
