package action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.MemberJoinProService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberJoinProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MemberJoinProAction");
		
		ActionForward forward = null;
		
		try {
			// 전달받은 파라미터 데이터를 MemberBean 클래스 인스턴스 생성 후 저장
			MemberBean member = new MemberBean();
			 
			member.setName(request.getParameter("name"));
			member.setId(request.getParameter("id"));
			member.setPasswd(request.getParameter("passwd"));
			member.setEmail(request.getParameter("email1") + "@" + request.getParameter("email2"));
			member.setGender(request.getParameter("gender"));
			
			System.out.println(member); // MemberBean의 toSting() 출력
			
			//----------------------------------------------------
			// MemberJoinProService 클래스 인스턴스 생성 후
			// joinMember() 메서드를 호출
			// => 파라미터 : MemberBean 객체   리턴타입 : boolean
			MemberJoinProService service = new MemberJoinProService();
			boolean isJoinSuccess = service.joinMember(member);
			
			// 처리 결과 판별
			if(!isJoinSuccess) { // 실패 시
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("alert('가입 실패!')");
				out.println("history.back()");
				out.println("</script>");
				} else { // 성공시
					forward = new ActionForward();
					forward.setPath("index.jsp");
					forward.setRedirect(true);
				}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		return forward;
	}

}
