package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import svc.MemberJoinProService;
import svc.MemberLoginProService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberLoginProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MemberLoginProAction");
		
		ActionForward forward = null;
		
		try {
			// 전달받은 파라미터 데이터를 MemberBean 클래스 인스턴스 생성 후 저장
			MemberBean member = new MemberBean();
			 
			member.setId(request.getParameter("id"));
			member.setPasswd(request.getParameter("passwd"));
			System.out.println(member); // MemberBean의 toSting() 출력
			
			//----------------------------------------------------
			// MemberLoginProService 클래스 인스턴스 생성 후
			// loginMember() 메서드를 호출
			// => 파라미터 : MemberBean 객체   리턴타입 : boolean
			MemberLoginProService service = new MemberLoginProService();
			int isLoginSuccess = service.loginMember(member);
			
			// 처리 결과 판별
			if(isLoginSuccess == 0) { // 실패 시
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("alert('로그인 실패!')");
				out.println("history.back()");
				out.println("</script>");
				} else { // 성공시
					
					HttpSession session = request.getSession();
					session.setAttribute("sid", member.getId());
					
					forward = new ActionForward();
					forward.setPath("index.jsp");
					forward.setRedirect(true);
				
				}
		} catch (IOException e) {
			System.out.println("sql 구문 오류 -");
			e.printStackTrace();
		}
		
		
		return forward;
	}

}
