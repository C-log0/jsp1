package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.MemberListService;
import svc.MemberLoginProService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MemberListAction");
		
		ActionForward forward = null;
		
		
			// 전달받은 파라미터 데이터를 MemberBean 클래스 인스턴스 생성 후 저장
			MemberBean member = new MemberBean();
			
			member.setName(request.getParameter("name"));
			member.setId(request.getParameter("id"));
			member.setPasswd(request.getParameter("passwd"));
			member.setEmail(request.getParameter("email"));
			member.setGender(request.getParameter("gender"));
			System.out.println(member); // MemberBean의 toSting() 출력
			
			//----------------------------------------------------
			// MemberListService 클래스 인스턴스 생성 후
			// getMemberList() 메서드를 호출
			MemberListService service = new MemberListService();
			ArrayList list = service.getMemberList(member);
			
			
		
		return forward;
	}

}
