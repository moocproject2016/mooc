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
	private static int getAuthNum(){	return (int)(Math.random()*100000); } // ������ȣ ���� �޼���
	
	  public static int sendSleepMail(String to){
	        Properties properties = new Properties();
	        properties.put("mail.smtp.user", "mooc.project.2016"); // ���� ����
	        properties.put("mail.smtp.host", "smtp.gmail.com");
	        properties.put("mail.smtp.port", "465");
	        properties.put("mail.smtp.starttls.enable", "true");
	        properties.put("mail.smtp.auth", "true");
	        properties.put("mail.smtp.debug", "true");
	        properties.put("mail.smtp.socketFactory.port", "465");
	        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	        properties.put("mail.smtp.socketFactory.fallback", "false");
	        authNum=getAuthNum();
	        
	       //smtp ������ ������ ���� ����

	        try {
	            Authenticator auth = new senderAccount();
	            Session session = Session.getInstance(properties, auth);
	            //session.setDebug(true); // ������ ������ �� ���� ��Ȳ�� �ֿܼ� ����Ѵ�.
	            MimeMessage msg = new MimeMessage(session);//������ ���� ��ü

	            msg.setSubject("mooc project �޸� �����ȳ��Դϴ�.");
	            Address fromAddr = new InternetAddress("kh.java.adm@gmail.com"); // �����»�� EMAIL
	            msg.setFrom(fromAddr);//������ ���
	            Address toAddr = new InternetAddress(to);    //�޴»�� EMAIL
	            msg.addRecipient(Message.RecipientType.TO, toAddr);      //�޴� ���    
	            msg.setContent(to+"�� �̷α��ν� ���̵� Ż��ó���˴ϴ�.", "text/plain;charset=KSC5601"); 
	            //���۳��� ���ڵ�Ÿ��
	            Transport.send(msg); //���� 

	        } catch (Exception e) {     e.printStackTrace();    }
	        	return authNum;
	    }
	  
	  
    public static int sendMail(String to){
        Properties properties = new Properties();
        properties.put("mail.smtp.user", "mooc.project.2016"); // ���� ����
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.debug", "true");
        properties.put("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.socketFactory.fallback", "false");
        authNum=getAuthNum();
        
       //smtp ������ ������ ���� ����

        try {
            Authenticator auth = new senderAccount();
            Session session = Session.getInstance(properties, auth);
            //session.setDebug(true); // ������ ������ �� ���� ��Ȳ�� �ֿܼ� ����Ѵ�.
            MimeMessage msg = new MimeMessage(session);//������ ���� ��ü

            msg.setSubject("mooc project ���� �����Դϴ�.");
            Address fromAddr = new InternetAddress("kh.java.adm@gmail.com"); // �����»�� EMAIL
            msg.setFrom(fromAddr);//������ ���
            Address toAddr = new InternetAddress(to);    //�޴»�� EMAIL
            msg.addRecipient(Message.RecipientType.TO, toAddr);      //�޴� ���    
            msg.setContent("���� ������ȣ�� "+authNum+"�Դϴ�.", "text/plain;charset=KSC5601"); 
            //���۳��� ���ڵ�Ÿ��
            Transport.send(msg); //���� 

        } catch (Exception e) {     e.printStackTrace();    }
        	return authNum;
    }
    private static class senderAccount extends Authenticator {
        public PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication("mooc.project.2016", "mooc2016"); 
            // @gmail.com ������ ���� ID, PASS ������ ���̵�� �佺����
        }
    }
    
    
    @SuppressWarnings("rawtypes")
	public static int sendPwdMail(String to){
    	
    	Properties properties = new Properties();
        properties.put("mail.smtp.user", "mooc.project.2016"); // ���� ����
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.debug", "true");
        properties.put("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.socketFactory.fallback", "false");
        authNum=getAuthNum();
        
       //smtp ������ ������ ���� ����

        try {
            Authenticator auth = new senderAccount();
            Session session = Session.getInstance(properties, auth);
            //session.setDebug(true); // ������ ������ �� ���� ��Ȳ�� �ֿܼ� ����Ѵ�.
            MimeMessage msg = new MimeMessage(session);//������ ���� ��ü

            msg.setSubject("mooc project �ӽ� ��й�ȣ�Դϴ�.");
            Address fromAddr = new InternetAddress("kh.java.adm@gmail.com"); // �����»�� EMAIL
            msg.setFrom(fromAddr);//������ ���
            Address toAddr = new InternetAddress(to);    //�޴»�� EMAIL
            msg.addRecipient(Message.RecipientType.TO, toAddr);      //�޴� ���    
            msg.setContent("�ӽ� ��й�ȣ�� "+authNum+"�Դϴ�.", "text/plain;charset=KSC5601"); 
            //���۳��� ���ڵ�Ÿ��
            Transport.send(msg); //���� 
            
        } catch (Exception e) {     e.printStackTrace();    }
        
			return authNum;
    }
}
