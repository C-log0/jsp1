package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.JdbcUtil;

public class BoardDAO {
	Connection con = null;
	PreparedStatement pstmt = null, pstmt2 = null;
	ResultSet rs = null;
	
	// 글쓰기 작업 수행(INSERT) insertBoard() 메서드 
	// => 파라미터 : BoardDTO 객체    리턴타입 : int(insertCount)
	public int insertBoard(BoardDTO board) {
		int insertCount = 0;
		
		con = JdbcUtil.getConnection();

		try {
			// --------------------------------------------------------------------------------
			// 새 글 번호 계산을 위해 기존 board 테이블의 모든 번호(idx) 중 가장 큰 번호 조회
			// => 조회 결과 + 1 값을 새 글 번호로 지정하고, 조회 결과가 없으면 기본값 1 로 설정
			// => MySQL 구문의 MAX() 함수 사용(SELECT MAX(컬럼명) FROM 테이블명)
			int idx = 1; // 새 글 번호
			
			String sql = "SELECT MAX(idx) FROM board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 조회 결과가 있을 경우(= 기존 게시물이 하나라도 존재할 경우)
				// (만약, 게시물이 존재하지 않을 경우 DB 에서 NULL 로 표기, rs.next() 가 false)
				idx = rs.getInt(1) + 1; // 기존 게시물 번호 중 가장 큰 번호(= 조회 결과) + 1
			}
			System.out.println("새 글 번호 : " + idx);
			// --------------------------------------------------------------------------------
			// 게시물 등록(INSERT) 작업 수행
			sql = "INSERT INTO board VALUES (?,?,?,?,?,now(),0)";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, idx); // 위에서 생성한 새 글 번호 활용
			pstmt2.setString(2, board.getName());
			pstmt2.setString(3, board.getPass());
			pstmt2.setString(4, board.getSubject());
			pstmt2.setString(5, board.getContent());
			
			insertCount = pstmt2.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - insertBoard()");
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
	
	// 전체 게시물 수 조회 selectListCount()
	// => 파라미터 : 없음, 리턴타입 : int(listCount)
	public int selectListCount() {
		int listCount = 0;
		
		con = JdbcUtil.getConnection();
		
		try {
			// 특정 컬럼 또는 전체 컬럼(*)에 해당하는 레코드 수 조회하기 위해
			// MySQL 의 COUNT() 함수 활용(SELECT COUNT(컬럼명 또는 *) FROM 테이블명)
			String sql = "SELECT COUNT(idx) FROM board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - selectListCount()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return listCount;
	}
	
	// 전체 게시물 수 조회 selectListCount() => 검색어 기능 추가
	// => 파라미터 : 검색어(keyword), 리턴타입 : int(listCount)
	public int selectListCount(String keyword) {
		int listCount = 0;
		
		con = JdbcUtil.getConnection();
		
		try {
			// 특정 컬럼 또는 전체 컬럼(*)에 해당하는 레코드 수 조회하기 위해
			// MySQL 의 COUNT() 함수 활용(SELECT COUNT(컬럼명 또는 *) FROM 테이블명)
			// => 제목 검색 기능 추가
			String sql = "SELECT COUNT(idx) FROM board "
							+ "WHERE subject LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - selectListCount()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return listCount;
	}
	
	// 게시물 목록 조회 selectBoardList()
	// => 파라미터 : 없음, 리턴타입 : List<BoardDTO>(boardList)
	// (단, 임시로 페이징 처리 없이 전체 목록 조회)
	public List<BoardDTO> selectBoardList() {
		List<BoardDTO> boardList = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			// board 테이블의 모든 레코드 조회(idx 컬럼 기준 내림차순 정렬)
			String sql = "SELECT * FROM board ORDER BY idx DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 전체 레코드를 저장할 ArrayList 객체 생성
			boardList = new ArrayList<BoardDTO>();
			
			while(rs.next()) {
				// 1개 레코드를 저장할 BoardDTO 객체 생성
				BoardDTO board = new BoardDTO();
				board.setIdx(rs.getInt("idx"));
				board.setName(rs.getString("name"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setDate(rs.getTimestamp("date"));
				board.setReadcount(rs.getInt("readcount"));
//				System.out.println(board);
				
				// 전체 레코드 저장하는 List 객체에 1개 레코드 저장된 BoardDTO 객체 추가
				boardList.add(board);
			}
//			System.out.println(boardList);
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - selectBoardList()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return boardList;
	}
	
	// 게시물 목록 조회 selectBoardList() - 게시물 목록 갯수 제한 추가
	// => 파라미터 : 시작행번호, 페이지 당 게시물 목록 수
	//    리턴타입 : List<BoardDTO>(boardList)
	public List<BoardDTO> selectBoardList(int startRow, int listLimit) {
		List<BoardDTO> boardList = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			// board 테이블의 모든 레코드 조회
			// => idx 컬럼 기준 내림차순 정렬(ORDER BY 컬럼명 정렬방식)
			// => 시작행번호부터 게시물 목록 수 만큼으로 갯수 제한(LIMIT 시작행번호,목록수)
			//    (단, 시작행번호 첫번째는 0부터 시작)
			//    (또한, LIMIT 에 파라미터 하나만 사용 시 목록 갯수로 사용됨)
			String sql = "SELECT * FROM board ORDER BY idx DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);
			rs = pstmt.executeQuery();
			
			// 전체 레코드를 저장할 ArrayList 객체 생성
			boardList = new ArrayList<BoardDTO>();
			
			while(rs.next()) {
				// 1개 레코드를 저장할 BoardDTO 객체 생성
				BoardDTO board = new BoardDTO();
				board.setIdx(rs.getInt("idx"));
				board.setName(rs.getString("name"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setDate(rs.getTimestamp("date"));
				board.setReadcount(rs.getInt("readcount"));
//				System.out.println(board);
				
				// 전체 레코드 저장하는 List 객체에 1개 레코드 저장된 BoardDTO 객체 추가
				boardList.add(board);
			}
//			System.out.println(boardList);
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - selectBoardList()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return boardList;
	}
	
	// 게시물 목록 조회 selectBoardList() - 검색 기능 추가
	// => 파라미터 : 시작행번호, 페이지 당 게시물 목록 수, 검색어(keyword)
	//    리턴타입 : List<BoardDTO>(boardList)
	public List<BoardDTO> selectBoardList(int startRow, int listLimit, String keyword) {
		List<BoardDTO> boardList = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			// board 테이블의 모든 레코드 조회
			// => 제목에 검색어를 포함하는 레코드 조회(WHERE subject LIKE '%검색어%')
			//    (단, 쿼리에 직접 '%?%' 형태로 작성 시 ? 문자를 파라미터로 인식하지 못함
			//    (따라서, setXXX() 메서드에서 문자열 결합으로 "%" + "검색어" + "%" 로 처리)
			String sql = "SELECT * FROM board WHERE subject LIKE ? ORDER BY idx DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, listLimit);
			rs = pstmt.executeQuery();
			
			// 전체 레코드를 저장할 ArrayList 객체 생성
			boardList = new ArrayList<BoardDTO>();
			
			while(rs.next()) {
				// 1개 레코드를 저장할 BoardDTO 객체 생성
				BoardDTO board = new BoardDTO();
				board.setIdx(rs.getInt("idx"));
				board.setName(rs.getString("name"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setDate(rs.getTimestamp("date"));
				board.setReadcount(rs.getInt("readcount"));
//				System.out.println(board);
				
				// 전체 레코드 저장하는 List 객체에 1개 레코드 저장된 BoardDTO 객체 추가
				boardList.add(board);
			}
//			System.out.println(boardList);
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - selectBoardList()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return boardList;
	}
	
	// 조회수 증가 작업 수행 - updateReadcount()
	// => 파라미터 : 글번호(idx)   리턴타입 : void
	public void updateReadcount(int idx) {
		con = JdbcUtil.getConnection(); // Connection 객체 가져오기
		
		try {
			// board 테이블에서 글번호(idx)가 일치하는 게시물(레코드)의
			// 조회수(readcount) 값을 1만큼 증가 - UPDATE
			String sql = "UPDATE board "
							+ "SET readcount=readcount+1 "
							+ "WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - updateReadcount()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		// 리턴 데이터 없음 - notice_content.jsp
	}
	
	//  게시물 1개 조회 작업 수행 - selectBoard()
	// => 파라미터 : 글번호(idx)   리턴타입 : BoardDTO(board)
	public BoardDTO selectBoard(int idx) {
		BoardDTO board = null;
		
		con = JdbcUtil.getConnection(); // Connection 객체 가져오기
		
		try {
			// board 테이블에서 글번호(idx) 가 일치(조건) 하는 레코드(전체 컬럼 데이터) 조회
			// => 조회 결과가 존재할 경우 BoardDTO 객체 생성 후 데이터 저장
			String sql = "SELECT * FROM board WHERE idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery(); // SQL 구문 실행
			
			// 조회결과 존재 여부 판별
			if(rs.next()) { // 조회 결과 존재할 경우
				board = new BoardDTO(); // BoardDTO 객체 생성
				// 데이터 저장
				board.setIdx(rs.getInt("idx"));
				board.setName(rs.getString("name"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				
				// textarea 에 표시할 데이터는 문자열 치환(replace) 기능을 통해
				// 줄바꿈 기호를 "<br>" 태그로 치환해야한다!
				// => String 객체의 replaceAll() 메서드 사용
				//    (파라미터 : 찾을 문자열, 바꿀 문자열)
				//    => 또한, 줄바꿈 기호 찾을 경우 System.getProperty("line.separator")
//				board.setContent(
//						rs.getString("content").replaceAll(System.getProperty("line.separator"), "<br>"));
				// => DAO 에서 수행하는 대신 뷰페이지(JSP)에서 수행해도 동일함 
				board.setContent(rs.getString("content"));
				
				board.setDate(rs.getTimestamp("date"));
				board.setReadcount(rs.getInt("readcount"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - selectBoard()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return board; // notice_content.jsp 로 리턴
	}
	
	// 게시물 수정 작업 수행 - updateBoard()
	// => 파라미터 : BoardDTO(board)    리턴타입 : int(updateCount)
	public int updateBoard(BoardDTO board) {
		int updateCount = 0;
		
		con = JdbcUtil.getConnection();
		
		try {
			// board 테이블에서 글번호(idx)가 일치하는 레코드의 패스워드를 검사하여
			// 패스워드가 일치할 경우 이름, 제목, 내용 변경(패스워드 일치여부까지 확인 가능)
			// => 글번호와 패스워드가 일치하는 레코드의 내용 변경으로 통합
			String sql = "UPDATE board "
							+ "SET name=?, subject=?, content=? "
							+ "WHERE idx=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getName());
			pstmt.setString(2, board.getSubject());
			pstmt.setString(3, board.getContent());
			pstmt.setInt(4, board.getIdx());
			pstmt.setString(5, board.getPass());
			
			updateCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - updateBoard()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return updateCount;
	}
	
	// 글 삭제 작업 수행 - deleteBoard()
	// => 파라미터 : 글번호, 패스워드   리턴타입 : int(deleteCount)
	public int deleteBoard(int idx, String pass) {
		int deleteCount = 0;
		
		con = JdbcUtil.getConnection();
		
		try {
			// board 테이블에서 글번호와 패스워드가 일치하는 레코드 삭제(DELETE)
			String sql = "DELETE FROM board "
						+ "WHERE idx=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.setString(2, pass);
			
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - deleteBoard()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return deleteCount;
	}
	
	// BoardDAO 객체의  selectRecentBoardList() 메서드를 호출하여
		//최근 게시물 5개 목록 조회 후 표시
		//=> 파라미터 : 없음   리턴타입 : List<BoardDTO>(boardList)
	
	public List<BoardDTO> selectRecentBoardList(){
		
		List<BoardDTO> boardList = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			String sql = "SELECT * FROM board ORDER BY idx DESC LIMIT 5";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery(); // SQL 구문 실행
			
			boardList = new ArrayList<BoardDTO>();
			
			// 조회결과 존재 여부 판별
			while(rs.next()) { // 조회 결과 존재할 경우
				BoardDTO board = new BoardDTO(); // BoardDTO 객체 생성
				// 데이터 저장
				board.setIdx(rs.getInt("idx"));
				board.setName(rs.getString("name"));
				board.setPass(rs.getString("pass"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setDate(rs.getTimestamp("date"));
				board.setReadcount(rs.getInt("readcount"));
//			System.out.println(board);
				boardList.add(board);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
			
		
		return boardList;
		
	}
	
}
















