package jsp9_jdbc_dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class jsp8_2DAO {
	
	// [제한자] 리턴타입 메서드명([매개변수...]) {}
	public int insert(jsp8_2DTO dto) {
		
		int insertCount = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			// 1단계 & 2단계
			// => 공통으로 처리하는 jdbcUtil 객체의 getConnection() 메서드를 호출하여
			// DB 연결 후 리턴되는 Connection 타입 객체를 리턴받아 저장
			// 단, getConnection() 메서드는 static 메서드이므로
			// JdbcUtil 클래스의 인스턴스 생성이 불필요(클래스명.메서드명)
			con = JdbcUtil.getConnection();
			
			

			// jsp8_2 테이블에 1개 레코드에 해당하는 모든 데이터 저장
			// 단, 입사일(hire_date)는 SQL 구문의 now() 함수 사용하여 DB 서버의 현재 날짜, 시각정보를 사용
			String sql = "INSERT INTO jsp8_2 VALUES (?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			// 만능문자(?) 데이터 교체를 위해 DTO 객체로부터 데이터 꺼내서 전달
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getPasswd());
			pstmt.setString(4, dto.getJumin());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getJob());
			pstmt.setString(7, dto.getGender());
			pstmt.setString(8, dto.getHobby());
			pstmt.setString(9, dto.getContent());

			insertCount = pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 발생!");
				e.printStackTrace();
			} finally {
				// DB 자원 반환(역순)
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
		}
		
		return insertCount;
	}
	
	
	public ArrayList select() {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		ArrayList list = null;
		
		try {
			con = JdbcUtil.getConnection();
			
			String sql = "SELECT * FROM jsp8_2";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 전체 레코드를 저장할 ArrayList 객체 생성
			list = new ArrayList();
			
			while(rs.next()) {
				// 1개 레코드 정보를 저장할 Jsp8_2DTO 객체 생성 후 데이터 저장
				jsp8_2DTO dto = new jsp8_2DTO();	
				dto.setName(rs.getString("name"));
				dto.setId(rs.getString("id"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setJumin(rs.getString("jumin"));
				dto.setEmail(rs.getString("email"));
				dto.setJob(rs.getString("job"));
				dto.setGender(rs.getString("gender"));
				dto.setHobby(rs.getString("hobby"));
				dto.setContent(rs.getString("content"));
				dto.setHire_date(rs.getDate("hire_date"));
				
				// 전체 레코드를 저장하는 ArrayList 객체(list)에 1개 레코드 저장
				list.add(dto);
			}
		}  catch (SQLException e) {
			System.out.println("DB 연결 실패 또는 SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			// DB 자원 반환(역순)
			try {
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list; // select2.jsp
	}
	
	
	//-----------------------------------------------------------
	// 회원 상세정보 조회 - selectDetail() 메서드
	// => 파라미터 : 아이디(id) 리턴타입 : Jsp8_2DTO(dto)
	
	public jsp8_2DTO selectDetail(String id) {
		jsp8_2DTO dto = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = JdbcUtil.getConnection();
			
			// 아이디가 일치하는 레코드 조회
			String sql = "SELECT * FROM jsp8_2 WHERE id =?";
			 pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id);
			
			// 4단계. SQL 구문 실행 및 결과 처리
			 rs = pstmt.executeQuery();
			

			
			// 조회할 레코드가 복수개(2개 이상)일 경우
			// if 문 대신 while 문을 사용하여 "다음 레코드가 존재할 동안" 반복
			
			if(rs.next()) {
				// 1개 레코드를 저장할 jsp8_2 타입 객체 생성
				dto = new jsp8_2DTO();
				
				//DTO 객체에 1개 레코드 데이터 저장
				dto.setName(rs.getString("name"));
				dto.setId(rs.getString("id"));
//			dto.setPasswd(rs.getString("passwd")); //패스워드는 전달 대상에서 제외
				dto.setJumin(rs.getString("jumin"));
				dto.setEmail(rs.getString("email"));
				dto.setJob(rs.getString("job"));
				dto.setGender(rs.getString("gender"));
				dto.setHobby(rs.getString("hobby"));
				dto.setContent(rs.getString("content"));
			}
		
		} catch (SQLException e) {
			System.out.println("DB 연결 실패 또는 SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
			
		}
		
		return dto;
	
	
	}
	
	
	public int delete(String id) {
		int count = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		//JDBC 4단계
		//0. 데이터베이스 작업에 필요한 String 타입 변수 4개 선언
		String driver="com.mysql.cj.jdbc.Driver";
		String url ="jdbc:mysql://localhost:3306/study_jsp5";
		String user="root";
		String password="1234";
		
		
		try {
			
			
			//3단계. SQL 구문 작성 및 전달
			//jsp8_2 테이블에서 아이디가 일치하는 레코드 삭제
			String sql = "DELETE FROM jsp8_2 WHERE id =?";
			
			 pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1,id);
			
			count = pstmt.executeUpdate();
			
		
		} catch (SQLException e) {
			System.out.println("DB 연결 실패 또는 SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			
			JdbcUtil.close(con);
			JdbcUtil.close(pstmt);
			
		
		}
		return count;

	}
	
	
	
//		// 회원 상세정보 조회 - selectDetail() 메서드
//		// => 파라미터 : 아이디(id) 리턴타입 : Jsp8_2DTO(dto)
//		
//		public jsp8_2DTO selectDetail(String id) {
//			jsp8_2DTO dto = null;
	public boolean login(String id, String passwd) {
		   boolean isLoginSuccess = false;
		   
		   
		   
		// JDBC 작업 4단계.
		   // 0단계. DB 연결에 필요한 정보 문자열 4가지를 변수에 별도로 저장
		   String driver = "com.mysql.cj.jdbc.Driver";
		   String url = "jdbc:mysql://localhost:3306/study_jsp5";
		   String user = "root";
		   String password = "1234";
		   
		   Connection con = null;
		   PreparedStatement pstmt = null;
		   ResultSet rs = null;
		   
		   try {
		      // 1단계. JDBC 드라이버 로드
//		      Class.forName(driver);
		      
		      // 2단계. DB 연결
		      // => 연결 성공 시 java.sql.Connection 타입 객체 리턴됨
//		      con = DriverManager.getConnection(url, user, password);
			   
			   //1&2단계
			   con = JdbcUtil.getConnection();
		      
		      //3단계.
		      String sql = "SELECT * FROM jsp8_2 WHERE id = ? AND passwd =?";
		      pstmt = con.prepareStatement(sql);
		      pstmt.setString(1, id);
		      pstmt.setString(2, passwd);
		      
		      //4단계.
		      rs = pstmt.executeQuery();
		      
		      
		      
		      while(rs.next()) {
		         isLoginSuccess =true;
		      }
		      
		   } catch (SQLException e) {
		      System.out.println("DB 연결 실패 또는 SQL 구문 오류 발생!");
		      e.printStackTrace();
		   } finally {
		      // DB 자원 반환(역순)
		      try {
		         rs.close();
		         pstmt.close();
		         con.close();
		      } catch (SQLException e) {
		         e.printStackTrace();
		      }
		   }   
		    
		   return isLoginSuccess;
		} 


	}





