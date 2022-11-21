package jsp11_dbcp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

//DAO 
public class StudentDAO {
	
	public int insert(StudentDTO student) {
		System.out.println("StudentDAO - insert()");
		
		int insertCount = 0;
		
		// 데이터베이스 작업에 필요한 클래스 타입 변수 선언
		// => try, catch, finally 블록 등 여러 블록에 걸쳐 변수를 사용하기 위함
		Connection con = null;
		PreparedStatement pstmt = null;
		
		// JdbcUtil 클래스에서 DBCP 를 통해 관리하는 Connection 객체 리턴받기
		con = JdbcUtil.getConnection();
		
		try {
			// study_jsp5 데이터베이스의 student 테이블에 데이터 추가(INSERT)
			String sql = "INSERT INTO student VALUES (?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, student.getIdx());
			pstmt.setString(2, student.getName());
			
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println(" SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return insertCount; // insertPro.jsp 로 리턴
	}
	
	// 회원 목록 조회 작업을 수행하는 select() 메서드 정의
	// => 파라미터 : 없음    리턴타입 : java.util.List<StudentDTO>
	public List<StudentDTO> select() {
		// 데이터베이스 작업에 사용되는 객체 타입 변수 선언
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		con = JdbcUtil.getConnection();
		
		List<StudentDTO> studentList = null;
		
		try {
			// SELECT 구문을 사용하여 student 테이블의 모든 레코드 검색
			String sql = "SELECT * FROM student";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			studentList = new ArrayList<StudentDTO>();
			
			while(rs.next()) {
				int idx = rs.getInt("idx");
				String name = rs.getString("name");
//				
				StudentDTO student = new StudentDTO();
				student.setIdx(idx);
				student.setName(name);
				
				studentList.add(student);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		// 전체 레코드가 저장된 ArrayList 객체 리턴 => select.jsp
		return studentList;
		
	}
	
}

