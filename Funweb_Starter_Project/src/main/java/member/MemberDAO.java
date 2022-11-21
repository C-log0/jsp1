package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import board.BoardDTO;
import db.JdbcUtil;

public class MemberDAO {
		private int updateCount;

		//회원가입 작업 수행하는 insertMember() 메서드
		//==> 파라미터: MemberDTO 객체(member) 리턴타입 int(insertCount)
		public int insertMember(MemberDTO member) {
			int insertCount = 0;
			
			Connection con = null;
			PreparedStatement pstmt = null;

			con = JdbcUtil.getConnection();
			
			try {
				String sql = "INSERT INTO member VALUES (?,?,?,?,?,?,?,?,?,now())";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, member.getId());
				pstmt.setString(2, member.getPass());
				pstmt.setString(3, member.getName());
				pstmt.setString(4, member.getEmail());
				pstmt.setString(5, member.getMobile());
				pstmt.setString(6, member.getPost_code());
				pstmt.setString(7, member.getAddress1());
				pstmt.setString(8, member.getAddress2());
				pstmt.setString(9, member.getPhone());
				
				insertCount = pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 발생! - insertMember()");
				e.printStackTrace();
			} finally {
				// DB 자원 반환(역순)
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
			return insertCount; //joinPro.jsp로 리턴
	}
		
		// 로그인 판별 작업 수행 또는 
		// 게시물 수정 권한 여부를 판별할 
		// isRightUser() 메서드 
		// => 파라미터 : MemberDTO 객체(member)   리턴타입 : boolean(isRightUser)
		public boolean isRightUser(MemberDTO member) {
			boolean isRightUser = false;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			con = JdbcUtil.getConnection();
			
			try {
				
				//3.
				// 아이디, 패스워드가 일치하는 레코드 검색
				String sql = "SELECT id FROM member WHERE id=? AND pass=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, member.getId()); 
				pstmt.setString(2, member.getPass());
				
				//4.
				rs = pstmt.executeQuery();
				
				// 조회 결과 레코드가 존재할 경우 isLoginSuccess를 true로 변경
				if(rs.next()) {
					isRightUser = true;
				}
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 발생! - loginMember()");
				e.printStackTrace();
			} finally {
				//DB 자원 반환(역순)
			 	JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}	
			
			return isRightUser; // loginPro.jsp로 리턴
			
		}
		
		//회원 정보 조회 selectMember() 메서드
		//=> 파라미터 : 세션 아이디   리턴타입 : MemberDTO(member)
		
		
		public MemberDTO selectMember(String id) {
			MemberDTO member = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			con = JdbcUtil.getConnection();
			
			try {
				//3.
				// 아이디, 패스워드가 일치하는 레코드 검색
				String sql = "SELECT * FROM member WHERE id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id); 
				
				//4.
				rs = pstmt.executeQuery();
				
				// 조회 결과 레코드가 존재할 경우 MemberDTO 객체에 저장
				if(rs.next()) {
					
					//MemberDTO 객체 생성
					member = new MemberDTO();
					
					//MemberDTO 객체에 조회 결과 각 컬럼 데이터 저장
					member.setId(rs.getString("id"));
					member.setPass(rs.getString("pass"));
					member.setName(rs.getString("name"));
					member.setEmail(rs.getString("email"));
					member.setMobile(rs.getString("mobile"));
					member.setPost_code(rs.getString("post_code"));
					member.setAddress1(rs.getString("address1"));
					member.setAddress2(rs.getString("address2"));
					member.setPhone(rs.getString("phone"));
					member.setDate(rs.getDate("date"));
					System.out.println(member.toString());
					
				}
				
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 발생! - loginMember()");
				e.printStackTrace();
			} finally {
				//DB 자원 반환(역순)
			 	JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}	
			
			return member; //
			
		}

		// 회원 수정 작업 수행 - updateMember() 메서드 
		// => 파라미터 : MemberDTO 객체(member), 패스워드 변경 여부(isChangePass)
		//    리턴타입 : int(updateCount)
	public int updateMember(MemberDTO member, boolean isChangePass) {
			int insertCount = 0;
			
			Connection con = null;
			PreparedStatement pstmt = null;

			con = JdbcUtil.getConnection();
			
			try {
				// 패스워드 변경 여부에 따른 각각의 SQL 구문 작성
				String sql = "";
				
				if(isChangePass) {//패스워드 변경
					sql = "UPDATE member" 
									+ "SET" 
										+"pass=?,"
										+ "name=?" 
										+ "email=?" 
										+ "mobile=?,"
										+ "post_code=?," 
										+ "adress1=?,"
										+ "adress2=?," 
										+ "phone=?,"
									+ "WHERE id=?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, member.getPass());
					pstmt.setString(2, member.getName());
					pstmt.setString(3, member.getEmail());
					pstmt.setString(4, member.getMobile());
					pstmt.setString(5, member.getPost_code());
					pstmt.setString(6, member.getAddress1());
					pstmt.setString(7, member.getAddress2());
					pstmt.setString(8, member.getPhone());
					pstmt.setString(9, member.getId());
				} else { //패스워드 미변경
					sql = "UPDATE member" 
								+ "SET" 
									+ "name=?" 
									+ "email=?" 
									+ "mobile=?,"
									+ "post_code=?," 
									+ "adress1=?,"
									+ "adress2=?," 
									+ "phone=?,"
								+ "WHERE id=?";
				
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, member.getName());
					pstmt.setString(2, member.getEmail());
					pstmt.setString(3, member.getMobile());
					pstmt.setString(4, member.getPost_code());
					pstmt.setString(5, member.getAddress1());
					pstmt.setString(6, member.getAddress2());
					pstmt.setString(7, member.getPhone());
					pstmt.setString(8, member.getId());
				}
					
				updateCount = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 발생! - insertMember()");
				e.printStackTrace();
			} finally {
				// DB 자원 반환(역순)
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
			
			return updateCount; 
		}
	
	//모든 회원 목록 조회 selectMemberList()
	//=> 파라미터 : 없음   리턴타입 : java.util.list
	public List<MemberDTO> selectMemberList(){
		//리턴할 List타입 변수 선언
		List<MemberDTO> memberList = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			//3.
			// 아이디, 패스워드가 일치하는 레코드 검색
			String sql = "SELECT * FROM member";
			pstmt = con.prepareStatement(sql);
			
			//4.
			rs = pstmt.executeQuery();
			
			// 조회 결과 레코드가 존재할 경우 MemberDTO 객체에 저장
			memberList = new ArrayList<MemberDTO>();
			
			
			while(rs.next()) {
				
				//MemberDTO 객체 생성
				MemberDTO member = new MemberDTO();
				
				//MemberDTO 객체에 조회 결과 각 컬럼 데이터 저장
				member.setId(rs.getString("id"));
				member.setPass(rs.getString("pass"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setMobile(rs.getString("mobile"));
				member.setPost_code(rs.getString("post_code"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setPhone(rs.getString("phone"));
				member.setDate(rs.getDate("date"));
//			System.out.println(member.toString());
				
				//전체 레코드를 저장하는 List객체에 레코드 MemberDTO 객체 추가
				//제네릭 타입에 의해 MemberDTO 타입 객체만 추가 가능함
				memberList.add(member);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return memberList;
			
	}
	
	//회원 삭제를 위한 deleteMember() 메서드 
	//=> 파라미터 : 아이디(id) 리턴타입 : int(deleteCount)
	
	public int deleteMember(String id) {
		int deleteCount =0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		con = JdbcUtil.getConnection();
		
		
			try {
				//3.
				// 아이디, 패스워드가 일치하는 레코드 검색
				String sql = "DELETE FROM member WHERE id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				
				deleteCount = pstmt.executeUpdate();
			
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 발생! - deleteMember()");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt);
				JdbcUtil.close(con);
			}
			
			
		
		return deleteCount;
	}
	
	
}
	
		
	