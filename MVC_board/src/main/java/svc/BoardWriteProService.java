package svc;

import java.sql.Connection;

import dao.BoardDAO;
import db.JdbcUtil;
import vo.BoardBean;

//
//
//
public class BoardWriteProService {

	public boolean registBoard(BoardBean board) {
		System.out.println("BoardWrtieProService - registBoard()");
		
		// 1. 글쓰기 작업 요청 처리 결과를 저장할 boolean 타입 변수 선언
		boolean isWriteSuccess = false;
		
		// 2. jdbcUtil 객체로부터 Connection Pool에 저장된 Connection 객체 가져오기
		//
		//
		Connection con = JdbcUtil.getConnection();
		
		// 3. BoardDAO 클래스로부터 BoardDAO 객체 가져오기 (공통) 
		// => 
		BoardDAO dao = BoardDAO.getInstance(); //new~ 대신
		
		//4. BoardDAO 객체의 setConnection() 메서드를 호출하여 Connection 객체 전달(공통)
		dao.setConnection(con);
		
		//5. BoardDAO 객체의 xxx() 메서드를 호출하여 xxx작업 수행 요청 및 결과 리턴받기
		// 		insertBoard() 메서드 호출하여 글쓰기 작업 요청 및 결과 리턴받기
		// => 파라미터 : BoardBean 객체 리턴타입 : int(insertCount)
		int insertCount = dao.insertBoard(board);
		
		//6. 작업 처리 결과에 따른 트랜잭션 처리
		if(insertCount >0) { //성공 시
			
			JdbcUtil.commit(con);
			
			//
			isWriteSuccess = true;
		} else { // 실패 시
			//
			//
		}
		
		//작업 요청 처리 결과 리턴
		return isWriteSuccess;
	}

}
