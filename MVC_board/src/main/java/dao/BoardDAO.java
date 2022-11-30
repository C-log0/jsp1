package dao;

import java.sql.Connection;

import vo.BoardBean;

//실제 비즈니스 로직을 수행하는 BoardDAO 클래스 정의
//=> 각 Service 클래스 인스턴스에서 BoardDAO 인스턴스에 접근 시 고유 데이터가 불필요하므로
// BoardDAO 인스턴스는 애플리케이션에서 단 하나만 생성하여 공유해도 된다!
// 따라서, 싱글톤 디자인 패턴을 적용하여 클래스를 정의하면 메모리 낭비를 막을 수 있다!
public class BoardDAO {
	//-------------싱글톤 디자인 패턴을 활용한 BoardDAO 인스턴스 생성 작업--------
	// 1. 외부에서 인스턴스 생성이 불가능하도록 생성자를 private 접근제한자로 선언
	// 2. 자신의 클래스 내에서 직접 인스턴스를 생성하여 멤버변수에 저장
	// 		=> 인스턴스 생성 없이도 클래스가 메모리에 로딩될 때 함께 로딩되도록 static 메서드로 선언
	// 		=> 외부에서 접근하여 함부로 값을 변경할 수 없도록  private 접근제한자로 선언
	// 3. 생성된 인스턴스를 외부로 리턴하는 Getter 메서드 정의
	// 		=> 인스턴스 생성 없이 클래스가 메모리에 로딩될 떄 함께 로딩되도록 static 메서드로 선언
	// 		=> 누구나 접근 가능하도록 public 접근제한자로 선언
	private BoardDAO() {}
	
	private static BoardDAO instance = new BoardDAO();

	public static BoardDAO getInstance() {
		return instance;
	}
	//--------------------------------------------------------------
	// 데이터베이스 접근에 사용할 Connection 객체를 Service 객체로부터 전달받기 위한
	//Connection 타입 멤버변수 선언 및 Setter메서드 정의
	private Connection con;

	public void setConnection(Connection con) {
		this.con = con;
	}
	//--------------------------------------------------------------

	public int insertBoard(BoardBean board) {
		return 0;
	}
	
	
}
