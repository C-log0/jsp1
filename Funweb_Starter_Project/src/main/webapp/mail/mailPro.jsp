<%@page import="mail.GoogleMailAuthenticator"%>
<%@page import="javax.mail.Message.RecipientType"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Transport"%>
<%@page import="java.util.Date"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// mail_form.jsp 페이지로부터 전달받은 파라미터 가져와서 확인
request.setCharacterEncoding("UTF-8");

String name = request.getParameter("name");
String sender = request.getParameter("sender");
String receiver = "hz0123hz@gmail.com";
String title = request.getParameter("title");
String content = request.getParameter("content");
String mobile = request.getParameter("mobile");
System.out.println(name + ", " + sender + ", " + receiver + ", " + title + ", " + content + ", "+ mobile);

try {
	// ------------------------ 메일 전송을 위한 설정 작업 ------------------------------
	// 메일 전송 프로토콜 : SMTP(Simple Mail Transfer Protocol)
	// => 기본 포트(Well-known poer)는 25번이지만, Gmail 은 587번 포트 사용
	// 1. 시스템(서버 = 톰캣)의 속성 정보(= 서버 정보)를 java.util.Properties 객체로 리턴받기
	Properties properties = System.getProperties();
	// 2. Properties 객체를 활용하여 메일 전송에 필요한 기본 설정 정보를 서버 속성 정보에 추가
	// => Properties 객체의 put() 메서드 사용
	// 메일 전송에 사용할 메일 서버 지정(구글, 네이버, 아웃룩 등)
	properties.put("mail.smtp.host", "smtp.gmail.com"); // 구글(GMail) SMTP 서버 주소
	properties.put("mail.smtp.auth", "true"); // SMTP 서버에 대한 인증 여부 설정
	properties.put("mail.smtp.port", "587"); // SMTP 서비스 포트 설정
	// 메일 인증 관련 정보 설정
	properties.put("mail.smtp.starttls.enable", "true"); // TLS 인증 프로토콜 사용 여부 설정
	properties.put("mail.smtp.ssl.protocols", "TLSv1.2"); // 인증 프로토콜 버전 설정
	// => 만약, TLS 버전 관련 문제 발생(could not convert socket to TLS) 시 
	
	// 3. 메일 서버 인증 정보를 생성하는 사용자 정의 클래스 인스턴스 생성
	Authenticator authenticator = new GoogleMailAuthenticator();
	
	// 4. 자바 메일 전송을 수행하는 작업의 기본 단위를 javax.mail.Session 객체로 관리하므로
	// Session 클래스의 getDefaultInstance() 메서드를 호출하여 Session 객체 얻어오기
	// (주의! 웹에서 사용하는 기본 세션 객체는 java.servlet.http.HttpSession 타입으로 다르다!)
	// => 파라미터 : Properties 객체, Authenticator 객체
	Session mailSession = Session.getDefaultInstance(properties, authenticator);
	
	// 5. 서버 정보와 인증 정보를 포함하는 javax.mail.MimeMessage 객체 생성
	// => 파라미터 : javax.mail.Session 객체 전달
	// => 생성된 MimeMessage 객체를 통해 전송할 메일에 대한 정보 생성
	Message mailMessage = new MimeMessage(mailSession);
	
	// 6. 전송할 메일에 대한 정보 설정
	// 1) 발신자 정보 설정을 위한 InternetAddress 객체 생성
	// => 단, 상용 메일 서버(구글, 네이버 등)의 경우 스팸 메일 정책으로 인해 발신자 주소 변경 불가
	// => 파라미터 : 발신자 주소, 발신자 이름
	Address senderAddress = new InternetAddress(sender, name);
	// 2) 수신자 정보 설정을 위한 InternetAddress 객체 생성
	// => 파라미터 : 수신자 주소
	Address receiverAddress = new InternetAddress(receiver);
	// 3) Message 객체를 통해 전송할 메일에 대한 내용 정보 설정
	// 3-1) 메일 헤더 정보 설정
	mailMessage.setHeader("content-type", "text/html; charset=UTF-8");
	// 3-2) 발신자 정보 설정
	mailMessage.setFrom(senderAddress);
	// 3-3) 수신자 정보 설정
	// => addRecipient() 메서드를 사용하여 수신자 정보 설정
	//    파라미터 : 수신 타입(기본 수신자이므로 TO 상수 활용), 수신자 정보 객체
	mailMessage.addRecipient(RecipientType.TO, receiverAddress);
	// 3-4) 메일 제목 설정
	mailMessage.setSubject(title);
	// 3-5) 메일 본문 설정
	mailMessage.setContent(content, "text/html; charset=UTF-8");
	// 3-6) 메일 전송 날짜 및 시각 정보 설정
	//      => java.util.Date 객체 생성을 통해 시스템 시각 정보 사용
	mailMessage.setSentDate(new Date());
	
	// 7. 메일 전송
	// javax.mail.Transport 클래스의 static 메서드 send() 호출
	// => 파라미터 : Message 객체
	Transport.send(mailMessage);
	out.println("<h3>메일이 정상적으로 발송되었습니다!</h3>");
} catch(Exception e) {
	e.printStackTrace();
	out.println("<h3>SMTP 서버 설정 또는 서비스 문제 발생!</h3>");
}
%>




