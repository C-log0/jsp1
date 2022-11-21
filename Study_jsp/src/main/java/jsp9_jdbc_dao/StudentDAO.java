package jsp9_jdbc_dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

//DAO 
public class StudentDAO {
	//<메서드 정의 기본 문법>
	//[제한자] 리턴타입 메서드명([매개변수...]) {}
	
	//insertForm.jsp 페이지에서 
	public int insert(StudentDTO student) {
		System.out.println("StudentDAO - insert()"); //호출하여 확인하기
		
		
		int insertCount = 0;
		
		//데이터베이스 작업에 필요한 클래스 타입 변수 선언
		// => trym catch, finally 블록 등 여러 블록에 걸쳐 변수를 사용하기 위함
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			//jdbc작업 4단계
			//0단계
			String driver = "com.mysql.cj.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/study_jsp5";
			String user = "root";
			String password = "1234";
			
			//1단계
			Class.forName(driver); //ctrl+shift+o => 자바에서는 자동으로 import 가능(jsp는 안됨)
			
			//2단계
			con = DriverManager.getConnection(url, user, password);
			
			
			// 3단계. SQL 구문 작성 및 전달
			// SELECT 구문을 사용하여 student 테이블의 모든 레코드 검색
			String sql = "INSERT INTO student VLAUES(?,?)";
			pstmt = con.prepareStatement(sql);
			//만능문자를 치환할 데이터는 StudentDTO 객체에 저장되어 있음 => Getter사용
			pstmt.setInt(1,student.getIdx());//idx 데이터 가져와서 전달
			pstmt.setString(2, student.getName());//NAME 데이터 가져와서 전달
			
			//SQL 구문 실행 후 리턴되는 결과값을 변수에 저장 후 리턴
			insertCount = pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로드 실패!");
			e.printStackTrace();
			
		} catch (SQLException e) {
			System.out.println("DB연결 실패 또는 SQL 구문 오류 발생!");
			e.printStackTrace();
		} finally {
			//데이터베이스 자원을 반환하기 위한 코드를 작성하는 블럭
			//=> connection, preparedStatement, resultSet등의 객체의 close()
			try {//alt+shift+s => try/catch
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		return insertCount; // insertPro.jsp 로 리턴
		
	}
	// 회원 목록 조회 작업을 수행하는 select() 메서드 정의
	// => 파라미터 : 없음   리턴타입 : java.util.ArrayList
	
	public ArrayList select() {
		
		// JDBC 4단계
		// 0단계. 데이터베이스 작업에 필요한 String 타입 변수 4개 선언
		String driver = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/study_jsp5";
		String user = "root";
		String password = "1234";
		
		
		//데이터베이스 작업에 사용되는 객체 타입 변수 선언(하고 아래에서는 지움)
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		 ArrayList studentList = null; //try문 밖에 있어야 함
		
		//alt+shift+z => try/catch block
		try {
			// 1단계. 드라이버 클래스 로드
			Class.forName(driver);
			
			// 2단계. DB 연결
			 con = DriverManager.getConnection(url, user, password);
			
			// 3단계. SQL 구문 작성 및 전달
			// SELECT 구문을 사용하여 student 테이블의 모든 레코드 검색
			String sql = "SELECT * FROM student";
			 pstmt = con.prepareStatement(sql);
			
			// 4단계. SQL 구문 실행 및 결과 처리
			// SELECT 구문을 사용하여 student 테이블의 모든 레코드 
			// 리턴되는 결과값을 java.sql.ResultSet 타입 변수에 저장
			 rs = pstmt.executeQuery();

			 
			 //전체 레코드를 저장할 ArrayList 객체 생성
			 // => 반복문(while) 내에서 생서되는 StudentDTO 객체를 반복 저장해야 하므로
			 // while 문보다 위쪽(앞쪽)에서 
			 studentList = new ArrayList();
			 
			 
			 
			 //while문을 사용하여 다음 레코드가 존재할 동안 반복
			 while(rs.next()) {
				 //각 레코드의 컬럼데이터를 가져와서 변수에 저장 후 출력
				 int idx = rs.getInt("idx");
				 String name = rs.getString("name");
//				 System.out.println(idx + ", " + name);
				 
				 //=>위의 변수들을 모으면 1개 레코드에 해당하는 데이터가 됨
				 // 따라서, 1개 레코드를 관리할 수 있는 studentDTO  객체에 저장 가능
				 //studentDTO 객체(student) 생성 후 데이터 저장
				 StudentDTO student = new StudentDTO();
				 student.setIdx(idx);
				 student.setName(name);
				 
				// 전체 레코드를 저장 가능한 ArrayList객체에
				// 1개 레코드가 저장된 StudentDTO 객체 추가(저장)
				
				studentList.add(student); // studentDTO => object 타입으로 업캐스팅 됨
				
				 
			 }
			 
			 
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로드 실패!");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("DB연결 실패 또는 SQL구문 오류 발생!");
			e.printStackTrace();
		} finally {// 예외 발생 여부와 관계없이 무조건 마지막에 실행되는 블록
			try {
				rs.close();
				pstmt.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		//전체 레코드가 저장된  ArrayList 객체 리턴 => select.jsp
		return studentList;
		
		
	}//class 끝
	
	
}