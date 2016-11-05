package _dto;

import java.sql.Timestamp;

public class studyNoteDTO
{
	private int sub_lec_code;
	private String u_id;
	private String note_type;
	private String origin_path;
	private String note_path;
	private Timestamp note_date;
	private int sub_lec_chapter;
	private String sub_lec_subject;
	private int main_lec_code;
	private String main_lec_subject;
	
	public void setSub_lec_code(int sub_lec_code){this.sub_lec_code=sub_lec_code;}
	public void setU_id(String u_id){this.u_id=u_id;}
	public void setNote_type(String note_type){this.note_type=note_type;}
	public void setOrigin_path(String origin_path){this.origin_path=origin_path;}
	public void setNote_path(String note_path){this.note_path=note_path;}
	public void setNote_date(Timestamp note_date){this.note_date=note_date;}
	public void setSub_lec_chapter(int sub_lec_chapter){this.sub_lec_chapter=sub_lec_chapter;}
	public void setMain_lec_code(int main_lec_code){this.main_lec_code=main_lec_code;}
	public void setMain_lec_subject(String main_lec_subject){this.main_lec_subject=main_lec_subject;}
	public void setSub_lec_subject(String sub_lec_subject){this.sub_lec_subject=sub_lec_subject;}
	
	public int getSub_lec_code( ){return sub_lec_code;}
	public String getU_id( ){return u_id;}
	public String getNote_type( ){return note_type;}
	public String getOrigin_path( ){return origin_path;}
	public String getNote_path(){return note_path;}
	public Timestamp getNote_date(){return note_date;}
	public int getSub_lec_chapter(){return sub_lec_chapter;}
	public int getMain_lec_code(){return main_lec_code;}
	public String getSub_lec_subject(){return sub_lec_subject;}
	public String getMain_lec_subject(){return main_lec_subject;}
	

}
