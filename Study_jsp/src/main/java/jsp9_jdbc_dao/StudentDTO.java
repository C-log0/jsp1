package jsp9_jdbc_dao;

//DTO
//=> 이 객체에 데이터를 담아 jsp페이지와dao 객체 사이에서 주고 받는 용도로 사용
public class StudentDTO {
	//1. 데이터를 저장하는데 사용할 인스턴스 멤버변수 선언
	//
	private int idx;
	private String name;

	//2. 멤버변수에 접근할 getter/setter 메서드 정의  => alt+shift+s->r
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

}
