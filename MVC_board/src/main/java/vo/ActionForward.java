package vo;



public class ActionForward {
	private String path; // 포워딩할 주소(url)
	private boolean isRedirect; // 포워딩 방식 지정(true : redirect , false : dispatch)
	
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public boolean isRedirect() {
		return isRedirect;
	}
	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}
	
	
}
