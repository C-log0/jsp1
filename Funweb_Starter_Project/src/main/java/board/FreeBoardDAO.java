package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.JdbcUtil;

public class FreeBoardDAO {
	
	private Connection con;
	private PreparedStatement pstmt, pstmt2;
	private ResultSet rs;
	
// 글쓰기 작업 수행 - insertFileBoard()
//=> 파라미터 : FreeBoardDTO 객체    리턴타입 : int(insertCount)
	public int insertFileBoard(FreeBoardDTO freeboard) {
		int insertCount = 0;
		
		con = JdbcUtil.getConnection();
		
		try {
			int idx = 1;
			
			// freeboard 테이블에 데이터 추가(INSERT)
			String sql = "SELECT MAX(idx) FROM freeboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 조회 결과가 있을 경우
				// 조회된 글번호 + 1 값을 새 글 번호로 저장
				// => 주의! getInt("컬럼명") 사용 시 "idx" 가 아닌 "MAX(idx)" 이름 지정 필요
				idx = rs.getInt(1) + 1; // 컬럼인덱스 활용
			}
			
			// freeboard 테이블에 데이터 추가(INSERT)
			sql = "INSERT INTO freeboard VALUES(?,?,?,?,?,?,?,now(),0)";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, idx);
			pstmt2.setString(2, freeboard.getName());
			pstmt2.setString(3, freeboard.getPass());
			pstmt2.setString(4, freeboard.getSubject());
			pstmt2.setString(5, freeboard.getContent());
			pstmt2.setString(6, freeboard.getOriginal_file());
			pstmt2.setString(7, freeboard.getReal_file());
			
			insertCount = pstmt2.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - insertFileBoard()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(pstmt2);
			JdbcUtil.close(con);
		}
		
		return insertCount;
	}
	
	// 조회수 증가 작업 수행 - updateReadcount()
	// => 파라미터 : 글번호(idx)   리턴타입 : void
	public void updateReadcount(int idx) {
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "UPDATE freeboard SET readcount=readcount+1 WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - updateReadcount()");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
					
	
	}
	
//  게시물 1개 조회 작업 수행 - selectFileBoard()
// => 파라미터 : 글번호(idx)   리턴타입 : FreeBoardDTO(freeBoard)
public FreeBoardDTO selectFileBoard(int idx) {
	FreeBoardDTO freeboard = null;
	
	con = JdbcUtil.getConnection();
	
	try {
		String sql = "SELECT * FROM freeboard WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, idx);
		rs=pstmt.executeQuery();
		
		if(rs.next()) {
			freeboard = new FreeBoardDTO(); // 객체 생성
			// 데이터 저장
			freeboard.setIdx(rs.getInt("idx"));
			freeboard.setName(rs.getString("name"));
			freeboard.setPass(rs.getString("pass"));
			freeboard.setSubject(rs.getString("subject"));
			freeboard.setContent(rs.getString("content"));
			freeboard.setOriginal_file(rs.getString("original_file"));
			freeboard.setReal_file(rs.getString("real_file"));
			freeboard.setDate(rs.getTimestamp("date"));
			freeboard.setReadcount(rs.getInt("readcount"));
			
			System.out.println(freeboard);
		}
	} catch (SQLException e) {
		System.out.println("SQL 구문 오류! - selectFileBoard()");
		e.printStackTrace();
	} finally {
		JdbcUtil.close(rs);
		JdbcUtil.close(pstmt);
		JdbcUtil.close(con);
	}
	return freeboard;
}

//updateFileBoard() 메서드를 호출하여 글수정 작업 수행
//=> 파라미터 : FileBoardDTO 객체    리턴타입 : int(updateCount)

public int updateFileBoard(FreeBoardDTO freeboard) {
	int updateCount = 0;
	
	con = JdbcUtil.getConnection();
	
	try {
		String sql = "UPDATE freeboard SET subject=?, content=?, original_file=?, real_file=? WHERE idx=? AND pass=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, freeboard.getSubject());
		pstmt.setString(2, freeboard.getContent());
		pstmt.setString(3, freeboard.getOriginal_file());
		pstmt.setString(4, freeboard.getReal_file());
		pstmt.setInt(5, freeboard.getIdx());
		pstmt.setString(6, freeboard.getPass());
		
		updateCount = pstmt.executeUpdate();
	} catch (SQLException e) {
		System.out.println("SQL 구문 오류! - updateFileBoard()");
		e.printStackTrace();
	} finally {
		// 자원 반환
		JdbcUtil.close(pstmt);
		JdbcUtil.close(con);
	}
	
	return updateCount;
	}

//글 삭제 작업 수행 - deleteFileBoard()
// => 파라미터 : 글번호, 패스워드   리턴타입 : int(deleteCount)
	public int deleteFileBoard(int idx, String pass) {
		int deleteCount = 0;
		
		con = JdbcUtil.getConnection();
		
		try {
			// freeboard 테이블에서 글번호와 패스워드가 일치하는 레코드 삭제(DELETE)
			String sql = "DELETE FROM freeboard "
						+ "WHERE idx=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, pass);
			
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - deleteFileBoard()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return deleteCount;
	}
	
	
	// 업로드 된 파일 삭제를 위해 selectRealFile() 메서드 호출하여 실제 업로드 된 파일명 조회
	// => 주의! 레코드 삭제 전 미리 조회 필요(파라미터 : 글번호(idx), 리턴타입 : String)
	public String selectRealFile(int idx) {
		String realFile ="";
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT real_file FROM freeboard WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				realFile = rs.getString(1);
				
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - selectRealFile()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return realFile;
		
}
	
	// 전체 게시물 수 조회 selectFileBoardListCount()
			// => 파라미터 : keyword, 리턴타입 : int(listCount)
			public int selectFileBoardListCount(String keyword) {
				int listCount = 0;
				
				con = JdbcUtil.getConnection();
				
				try {
					// 특정 컬럼 또는 전체 컬럼(*)에 해당하는 레코드 수 조회하기 위해
					// MySQL 의 COUNT() 함수 활용(SELECT COUNT(컬럼명 또는 *) FROM 테이블명)
					String sql = "SELECT COUNT(idx) FROM freeboard";
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();

					if(rs.next()) {
						listCount = rs.getInt(1);
					}
				} catch (SQLException e) {
					System.out.println("SQL 구문 오류! - selectFileBoardListCount()");
					e.printStackTrace();
				} finally {
					// 자원 반환
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(con);
				}
				
				return listCount;
			}
			
			// selectFreeBoardList() 메서드를 호출하여 게시물 목록 조회
			// => 파라미터 : 시작행번호, 페이지 당 게시물 목록 수,  검색어(keyword)
			// => 리턴타입 : List<FreeBoardDTO>(freeBoardList)
			
			public List<FreeBoardDTO> selectFreeBoardList(int startRaw, int listLimit, String keyword) {
				List<FreeBoardDTO> freeBoardList = null;
				
				con = JdbcUtil.getConnection();
				
				
				try {
					String sql = "SELECT * FROM freeboard WHERE subject LIKE ? ORDER bY idx DESC LIMIT ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyword + "%");
					pstmt.setInt(2, startRaw);
					pstmt.setInt(3, listLimit);
					rs = pstmt.executeQuery();
					
					// 전체 레코드를 저장할 ArrayList 객체 생성
					freeBoardList = new ArrayList<FreeBoardDTO>();
					
					while(rs.next()) {
						// 1개 레코드를 저장할 BoardDTO 객체 생성
						FreeBoardDTO freeboard = new FreeBoardDTO();
						freeboard.setIdx(rs.getInt("idx"));
						freeboard.setName(rs.getString("name"));	
						freeboard.setPass(rs.getString("pass"));
						freeboard.setSubject(rs.getString("subject"));
						freeboard.setContent(rs.getString("content"));
						freeboard.setOriginal_file(rs.getString("original_file"));
						freeboard.setReal_file(rs.getString("real_file"));
						freeboard.setDate(rs.getTimestamp("date"));
						freeboard.setReadcount(rs.getInt("readcount"));
						
						freeBoardList.add(freeboard);
					}
				} catch (SQLException e) {
					System.out.println("SQL 구문 오류! - selectFreeBoardList()");
					e.printStackTrace();
				}finally {
					JdbcUtil.close(rs);
					JdbcUtil.close(pstmt);
					JdbcUtil.close(con);
					
				}
				
				return freeBoardList;
			}
}


