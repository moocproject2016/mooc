package user;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class Calender {
	   public int isDate(int y, int m) {
		    
	          m -= 1;
	          int d=1;
	          Calendar c = Calendar.getInstance();
	          c.setLenient(false); //����/�ð��� �ؼ��� �����ϰ� �ǽ����� ����� �����մϴ�.
	          
	          while(true){
	        	  d++;
	        	  try {
	              
	        		  c.set(y, m, d); //�ð��� ���� ����Ų��.
	        		  Date dt = c.getTime(); //�ð��� ��´�
	              
	        	  } catch(IllegalArgumentException e) {
	        		  break;
	        	  }
	          }
	          return d;
	   }
	  public String getTitle(Calendar cal){          
	          SimpleDateFormat sdf = new SimpleDateFormat("yyyy�� MM��"); //Ÿ��Ʋ�� �� �ð��� ��
	          return sdf.format(cal.getTime());//Ÿ���� ��ȯ��Ų��.
	  }

}
