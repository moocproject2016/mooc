package user;
import java.util.Properties;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailAuthentication {
	
	private static int authNum;
	private static int getAuthNum(){	return (int)(Math.random()*100000); } // 랜덤번호 생성 메서드
	
	  public static int sendSleepMail(String to){
	        Properties properties = new Properties();
	        properties.put("mail.smtp.user", "mooc.project.2016"); // 구글 계정
	        properties.put("mail.smtp.host", "smtp.gmail.com");
	        properties.put("mail.smtp.port", "465");
	        properties.put("mail.smtp.starttls.enable", "true");
	        properties.put("mail.smtp.auth", "true");
	        properties.put("mail.smtp.debug", "true");
	        properties.put("mail.smtp.socketFactory.port", "465");
	        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	        properties.put("mail.smtp.socketFactory.fallback", "false");
	        authNum=getAuthNum();
	        
	       //smtp 서버에 접속할 정보 저장

	        try {
	            Authenticator auth = new senderAccount();
	            Session session = Session.getInstance(properties, auth);
	            //session.setDebug(true); // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
	            MimeMessage msg = new MimeMessage(session);//메일을 담을 객체

	            msg.setSubject("mooc project 휴면 계정안내입니다.");
	            Address fromAddr = new InternetAddress("kh.java.adm@gmail.com"); // 보내는사람 EMAIL
	            msg.setFrom(fromAddr);//보내는 사람
	            Address toAddr = new InternetAddress(to);    //받는사람 EMAIL
	            msg.addRecipient(Message.RecipientType.TO, toAddr);      //받는 사람    
	            msg.setContent(to+"님 미로그인시 아이디가 탈퇴처리됩니다.", "text/plain;charset=KSC5601"); 
	            //전송내용 인코딩타입
	            Transport.send(msg); //전송 

	        } catch (Exception e) {     e.printStackTrace();    }
	        	return authNum;
	    }
	  
	  
    public static int sendMail(String to){
        Properties properties = new Properties();
        properties.put("mail.smtp.user", "mooc.project.2016"); // 구글 계정
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.debug", "true");
        properties.put("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.socketFactory.fallback", "false");
        authNum=getAuthNum();
        
       //smtp 서버에 접속할 정보 저장

        try {
            Authenticator auth = new senderAccount();
            Session session = Session.getInstance(properties, auth);
            //session.setDebug(true); // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
            MimeMessage msg = new MimeMessage(session);//메일을 담을 객체

            msg.setSubject("mooc project 메일 인증입니다.");
            Address fromAddr = new InternetAddress("kh.java.adm@gmail.com"); // 보내는사람 EMAIL
            msg.setFrom(fromAddr);//보내는 사람
            Address toAddr = new InternetAddress(to);    //받는사람 EMAIL
            msg.addRecipient(Message.RecipientType.TO, toAddr);      //받는 사람    
            msg.setContent("메일 인증번호는 "+authNum+"입니다.", "text/plain;charset=KSC5601"); 
            //전송내용 인코딩타입
            Transport.send(msg); //전송 

        } catch (Exception e) {     e.printStackTrace();    }
        	return authNum;
    }
    private static class senderAccount extends Authenticator {
        public PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication("mooc.project.2016", "mooc2016"); 
            // @gmail.com 제외한 계정 ID, PASS 전송할 아이디와 페스워드
        }
    }
    
    
    @SuppressWarnings("rawtypes")
	public static int sendPwdMail(String to){
    	
    	Properties properties = new Properties();
        properties.put("mail.smtp.user", "mooc.project.2016"); // 구글 계정
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.debug", "true");
        properties.put("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.socketFactory.fallback", "false");
        authNum=getAuthNum();
        
       //smtp 서버에 접속할 정보 저장

        try {
            Authenticator auth = new senderAccount();
            Session session = Session.getInstance(properties, auth);
            //session.setDebug(true); // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
            MimeMessage msg = new MimeMessage(session);//메일을 담을 객체

            msg.setSubject("mooc project 임시 비밀번호입니다.");
            Address fromAddr = new InternetAddress("kh.java.adm@gmail.com"); // 보내는사람 EMAIL
            msg.setFrom(fromAddr);//보내는 사람
            Address toAddr = new InternetAddress(to);    //받는사람 EMAIL
            msg.addRecipient(Message.RecipientType.TO, toAddr);      //받는 사람    
            msg.setContent("임시 비밀번호는 "+authNum+"입니다.", "text/plain;charset=KSC5601"); 
            //전송내용 인코딩타입
            Transport.send(msg); //전송 
            
        } catch (Exception e) {     e.printStackTrace();    }
        
			return authNum;
    }
}
