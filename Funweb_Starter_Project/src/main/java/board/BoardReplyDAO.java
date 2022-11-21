package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.JdbcUtil;

public class BoardReplyDAO {
	
	private Connection con;
	private PreparedStatement pstmt, pstmt2;
	private ResultSet rs;
	
	// 댓글 쓰기
	public int insertReplyBoard(BoardReplyDTO board) {
		int insertCount = 0;
		
		con = JdbcUtil.getConnection();

		try {
			// 댓글 등록(INSERT) 작업 수행
			// INSERT INTO board_reply VALUES (null, '아이디', '내용', now(), 글번호, '게시판타입');
			String sql = "INSERT INTO board_reply VALUES (null,?,?,now(),?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board.getId());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getRef_idx()); // 댓글을 작성하는 게시물 번호
			pstmt.setString(4, board.getBoard_type());
			
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - insertReplyBoard()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		return insertCount;
	}
	
	// 댓글 목록 조회 - selectReplyList()
	// => 파라미터 : 게시물글번호, 게시판타입, startRow, listLimit 
	//  리턴타입 : List<BoardReplyDTO>(replyList)
	public List<BoardReplyDTO> selectReplyList(
			int ref_idx, String board_type, int startRow, int listLimit) {
		List<BoardReplyDTO> replyList = null;
		
		con = JdbcUtil.getConnection();
		
		try {
			// board_reply 테이블의 모든 레코드 조회
			// => 조건 : 게시판 타입(board_type 컬럼)이 일치하고, 원본글번호가 일치하는 목록 조회
			// => idx 컬럼 기준 내림차순 정렬(ORDER BY 컬럼명 정렬방식)
			// => 시작행번호부터 게시물 목록 수 만큼으로 갯수 제한(LIMIT 시작행번호,목록수)
			//    (단, 시작행번호 첫번째는 0부터 시작)
			//    (또한, LIMIT 에 파라미터 하나만 사용 시 목록 갯수로 사용됨)
			String sql = "SELECT * FROM board_reply "
						+ "WHERE board_type=? AND ref_idx=? "
						+ "ORDER BY idx DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board_type);
			pstmt.setInt(2, ref_idx);
			pstmt.setInt(3, startRow);
			pstmt.setInt(4, listLimit);
			rs = pstmt.executeQuery();
			
			// 전체 레코드를 저장할 ArrayList 객체 생성
			replyList = new ArrayList<BoardReplyDTO>();
			
			while(rs.next()) {
				// 1개 레코드를 저장할 BoardReplyDTO 객체 생성
				BoardReplyDTO board = new BoardReplyDTO();
				board.setIdx(rs.getInt("idx"));
				board.setId(rs.getString("id"));
				board.setContent(rs.getString("content"));
				board.setDate(rs.getTimestamp("date"));
				board.setRef_idx(rs.getInt("ref_idx"));
				board.setBoard_type(rs.getString("board_type"));
				System.out.println(board);
				
				// 전체 레코드 저장하는 List 객체에 1개 레코드 저장된 BoardReplyDTO 객체 추가
				replyList.add(board);
			}
//			System.out.println(replyList);
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - selectReplyList()");
			e.printStackTrace();
		} finally {
			// 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(con);
		}
		
		
		return replyList;
	}

	// 글 삭제 작업 수행 - deleteBoard()
		// => 파라미터 : 글번호,    리턴타입 : int(deleteCount)
	
	
		public int deleteBoard(int idx) {
			int deleteCount = 0;
			
			con = JdbcUtil.getConnection();
			
			try {
				// board 테이블에서 댓글번호와 일치하는 레코드 삭제(DELETE)
				String sql = "DELETE FROM board_reply "
							+ "WHERE idx=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, idx);
				
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
	
	
}













