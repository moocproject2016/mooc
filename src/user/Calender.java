package user;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class Calender {
	   public int isDate(int y, int m) {
		    
	          m -= 1;
	          int d=1;
	          Calendar c = Calendar.getInstance();
	          c.setLenient(false); //일자/시각의 해석을 엄밀하게 실시할지 어떨지를 설정합니다.
	          
	          while(true){
	        	  d++;
	        	  try {
	              
	        		  c.set(y, m, d); //시간달 년을 샛시킨다.
	        		  Date dt = c.getTime(); //시간을 얻는다
	              
	        	  } catch(IllegalArgumentException e) {
	        		  break;
	        	  }
	          }
	          return d;
	   }
	  public String getTitle(Calendar cal){          
	          SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월"); //타이틀에 들어갈 시간과 달
	          return sdf.format(cal.getTime());//타음을 반환시킨다.
	  }

}
