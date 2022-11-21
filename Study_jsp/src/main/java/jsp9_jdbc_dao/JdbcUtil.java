package jsp9_jdbc_dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//데이터베이스 작업 준비 및 해제(자원반환) 작업을 공통으로 수행할 jdbcUtil 클래스 정의

public class JdbcUtil {
	//1. 데이터베이스 접근을 통해 Connection 객체를 생성하여 외부로 리턴하는
	// getConnection() 메서드 정의(데이터베이스 작업 1단계 & 2단계 수행)
	//=> 파라미터 : 없음    리턴타입 : java.sql.Connection(con)
	//
	//
	
	public static Connection getConnection() {
		//데이터베이스 연결 객체를 저장할 Connection 타입 변수 선언
		Connection con = null;
		
		// JDBC 작업 4단계.
			// 0단계. DB 연결에 필요한 정보 문자열 4가지를 변수에 별도로 저장
			String driver = "com.mysql.cj.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/study_jsp5";
			String user = "root";
			String password = "1234";
	
			try {
				// 1단계. JDBC 드라이버 로드
				Class.forName(driver);

				// 2단계. DB 연결
				// => 연결 성공 시 java.sql.Connection 타입 객체 리턴됨
				con = DriverManager.getConnection(url, user, password);
			} catch (ClassNotFoundException e) {
				System.out.println("드라이버 클래스 로드 실패!");
				e.printStackTrace();
			} catch (SQLException e) {
				System.out.println("DB 연결 실패!");
				e.printStackTrace();
			}
		//주의! Connection 객체는 외부로 리턴해야 하므로 close() 메서드 호출하지 않는다!
		
		
		//데이터베이스 연결 객체가 저장된 Connection 타입 변수값 리턴
		return con;
	}
	
	//데이터베이스 자원 반환을 공통으로 수행할 close() 메서드 정의
	//=> 파라미터 : Connection 타입(con) 또는 PreparedStatement 타입(pstmp) 또는 
	//				ResultSet타입(rs)
	// => 각각의 파랑미터를 따로 전달받아 각각 close() 작업을 수행하도록 메서드 따로 정의
	// 단, 각각의 메서드 이름은 모두 close()로 정의하고 파라미터만 다르게 지정
	//=> (메서드 오버로딩 = )
	//=> 인스턴스 생성 없이도 메서드 호출이 가능하도록 static 메서드로 정의
	public static void close(PreparedStatement pstmt) {
		
		
		try {
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public static void close(ResultSet rs) {
		try {
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public static void close(Connection con) {
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
}
