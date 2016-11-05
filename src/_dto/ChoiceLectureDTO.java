package _dto;


public class ChoiceLectureDTO 
{
	private int main_lec_code;
	private String u_id;
	private String main_lec_subject;
	private int sub_lec_chapter;
	private int sub_lec_code;
	private String sub_lec_subject;
	private String ssd_date;
	private String ssd_content;
	private String month;
	private String day;
	private String ssd_num;
	private String ssd_type;
	private String ssd_done;
	
	public void setMain_lec_code(int main_lec_code){this.main_lec_code=main_lec_code;}
	public void setU_id(String u_id){this.u_id=u_id;}
	
	public int getMain_lec_code(){return main_lec_code;}
	public String getU_id(){return u_id;}
	
	public void setMain_lec_subject(String main_lec_subject){this.main_lec_subject=main_lec_subject;}
	public String getMain_lec_subject(){return main_lec_subject;}
	
	public void setSub_lec_chapter(int sub_lec_chapter){this.sub_lec_chapter=sub_lec_chapter;}
	public int getSub_lec_chapter(){return sub_lec_chapter;}
	
	public void setSub_lec_subject(String sub_lec_subject){this.sub_lec_subject=sub_lec_subject;}
	public String getSub_lec_subject(){return sub_lec_subject;}
	
	public void setSub_lec_code(int sub_lec_code){this.sub_lec_code=sub_lec_code;}
	public int getSub_lec_code(){return sub_lec_code;}
	
	public void setSsd_date(String ssd_date){this.ssd_date=ssd_date;}
	public String getSsd_date(){return ssd_date;}
	
	public void setSsd_content(String ssd_content){this.ssd_content=ssd_content;}
	public String getSsd_content(){return ssd_content;}
	
	public void setMonth(String month){this.month=month;}
	public String getMonth(){return month;}
	
	public void setDay(String day){this.day=day;}
	public String getDay(){return day;}
	
	public void setSsd_num(String ssd_num){this.ssd_num=ssd_num;}
	public String getSsd_num(){return ssd_num;}
	
	public void setSsd_type(String ssd_type){this.ssd_type=ssd_type;}
	public String getSsd_type(){return ssd_type;}
	
	public void setSsd_done(String ssd_done){this.ssd_done=ssd_done;}
	public String getSsd_done(){return ssd_done;}
}
