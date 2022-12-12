package svc;

import java.sql.Connection;

import dao.MemberDAO;
import db.JdbcUtil;
import vo.MemberBean;

public class MemberLoginProService {

	public int loginMember(MemberBean member) {
		System.out.println("MemberJoinProService - loginMember()");
		
		int isLoginSuccess = 0;
		Connection con = JdbcUtil.getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		// MemberDAO 객체의 xxx() 메서드를 호출하여 xxx 작업 수행 요청 및 결과 리턴받기
		//    loginMember() 메서드를 호출하여 글쓰기 작업 요청 및 결과 리턴받기
		// => 파라미터 : MemberBean 객체   리턴타입 : int(loginMember)
		int selectCount = dao.selectMember(member);
		
		if(selectCount > 0) { // 성공 시
			// INSERT 작업 성공했을 경우의 트랜잭션 처리(commit) 을 위해
			// JdbcUtil 클래스의 commit() 메서드를 호출하여 commit 작업 수행
			// => 파라미터 : Connection 객체
			JdbcUtil.commit(con);
			
			// 작업 처리 결과를 성공으로 표시하여 리턴하기 위해 isLoginSuccess 를 1 로 변경
			isLoginSuccess = 1;
		} else {
			JdbcUtil.rollback(con);
		}
		return isLoginSuccess;
	}
	
}
