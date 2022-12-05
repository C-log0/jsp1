package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.BoardDeleteProService;
import vo.ActionForward;

public class BoardDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		
		// 글번호, 패스워드 파라미터 가져오기
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		String board_pass = request.getParameter("board_pass");
//				System.out.println(board_num + ", " + board_pass);
		
		try {
			// BoardDeleteProService 클래스의 인스턴스 생성 및 isBoardWriter() 메서드 호출하여
			// 글 삭제 가능 여부(= 패스워드 일치 여부) 판별 요청
			// => 파라미터 : 글번호, 패스워드    리턴타입 : boolean(isBoardWriter)
			BoardDeleteProService service = new BoardDeleteProService();
			boolean isBoardWriter = service.isBoardWriter(board_num, board_pass);
//				System.out.println(isBoardWriter);
			
			// 만약, 게시물 삭제 권한이 없는 경우(= 패스워드 틀림)
			// 자바스크립트 사용하여 "삭제 권한이 없습니다!" 출력 후 이전페이지로 돌아가기
			// 아니면, 삭제 작업 요청 수행
			if(!isBoardWriter) { // 삭제 권한 없음
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('삭제 권한이 없습니다!')");
				out.println("history.back()");
				out.println("</script>");
			} else { // 삭제 권한 있음
				// BoardDeleteProService 클래스의 removeBoard() 메서드를 호출하여 글 삭제 작업 수행
				//  => 파라미터 : 글번호(board_num)    리턴타입 : boolean(isDeleteSuccess)
				boolean isDeleteSuccess = service.removeBoard(board_num);
				
				// 삭제 결과를 판별하여 실패 시 자바스크립트 오류 메세지 출력 및 이전페이지로 이동하고
				// 성공 시 ActionForward 객체를 통해 "BoardList.bo" 페이지로 포워딩
				// (=> URL 에 페이지 번호를 붙여서 요청)
				
				if(!isDeleteSuccess) { // 삭제 실패 시 
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('삭제 실패!')");
					out.println("history.back()");
					out.println("</script>");
					
				} else { // 삭제 성공 시
					forward = new ActionForward();
					forward.setPath("BoardList.bo?pageNum=" + request.getParameter("pageNum"));
					forward.setRedirect(true);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return forward;
	}

}



