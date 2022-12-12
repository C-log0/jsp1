package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.JdbcUtil;
import vo.BoardBean;
import vo.MemberBean;

public class MemberDAO {
	// ------------ 싱글톤 디자인 패턴을 활용한 MemberDAO 인스턴스 생성 작업 -------------
	private MemberDAO() {}
	
	private static MemberDAO instance = new MemberDAO();
	
	public static MemberDAO getInstance() {
		return instance;
	}

	// ----------------------------------------------------------------------------------
	// 데이터베이스 접근에 사용할 Connection 객체를 Service 객체로부터 전달받기 위한
	// Connection 타입 멤버변수 선언 및 Setter 메서드 정의
	private Connection con;

	public void setConnection(Connection con) {
		this.con = con;
	}
	
	//-----------------------------------------------------------------------------------
	public int insertMember(MemberBean member) {
		int insertCount = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "INSERT INTO member VALUES (?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getId());
			pstmt.setString(3, member.getPasswd());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getGender());
			System.out.println(member);
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - insertMember()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			
		}
		
		return insertCount;
	}
	// 로그인
			public int selectMember(MemberBean member) {
				int selectCount = 0;
				
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				try {
					String sql ="SELECT * FROM member WHERE id=? AND passwd=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, member.getId());
					pstmt.setString(2, member.getPasswd());
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						selectCount = 1;
					}
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
				}
				
				
				
				return selectCount;
			}
			
	

}
