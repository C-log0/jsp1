package test4_board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/BoardWriteForm")
public class BoardWriteFormServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("WriteFormServlet - doGet()");
		
		//test4_board의 qna_board_write_sample.jsp 페이지로 포워딩
		// => 주소 변경 없이 포워딩 = Dispatch 방식
		RequestDispatcher dispatcher = request.getRequestDispatcher("test4_board/qna_board_write_sample.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
