package test;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * 웹에서의 요청을 처리할 수 있는 클래스(= 서블릿 클래스) 정의
 * - javax.servlet.http.HttpServlet 클래스를 상속받아 정의
 * - 단, 서블릿 기능을 사용하기 위한 라이브러리는 기본 라이브러리가 아니므로
 *   servlet-api.jar 파일 필수! (톰캣 라이브러리에 기본 제공됨)
 * - 서블릿 클래스에서 특정 서블릿 주소 요청에 대한 처리를 수행하려면 서블릿 주소 매핑 필수!
 *   1) web.xml(배포서술자) 파일을 통해 매핑 수행하는 방법
 *   2) 서블릿 클래스 선언부 상단에 @WebServlet 어노테이션을 사용하여 매핑 수행하는 방법
 *      => @WebServlet("/서블릿주소")
 * - 주소 지정 방법
 *   1) 단일 패턴 : /패턴명 형태로 작성하고, 해당 패턴과 일치하는 URL 하나만 정확하게 감지
 *                  단, 단일 패턴을 복수개 지정할 수도 있음
 *   2) 다중 패턴 : *.패턴명 형태로 작성하고, xxx.패턴명 형태로 패턴명 부분만 일치하면
 *                  복수개의 URL 을 모두 감지하여 매핑 가능함
 * => 주의! 매핑된 서블릿 주소가 중복될 경우 오류가 발생하여 톰캣 시작이 불가능하다!
 */

public class TestMyServlet extends HttpServlet{
	/*
	 * 서블릿 클래스 내에는 GET&POST 방식 요청에 대한 처리를 위해 doGet(), doPost() 메서드 정의
	 * => HttpServlet 클래스로부터 상속받아 오버라이딩
	 * => 만약, 둘 중 하나의 메서드라도 정의하지 않았을 때
	 *    해당 메서드에 일치하는 요청 방식으로 요청이 발생하면
	 *    응답 메세지로 405(허용되지 않는 메서드) 오류가 발생함!
	 *    (단, 매핑되는 서블릿 주소가 없을 경우에는 404(찾을 수 없는 페이지) 오류 발생!)
	 */

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// GET 방식 요청이 발생할 경우 자동으로 호출되는 메서드
		System.out.println("GET 방식 요청에 대한 doGet()메서드 호출됨!");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// POST 방식 요청이 발생할 경우 자동으로 호출되는 메서드
		System.out.println("POST 방식 요청에 대한 doPost()메서드 호출됨!");
	}
	
}


