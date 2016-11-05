package _dto;

import java.sql.Timestamp;

public class BlackListDTO {
	
	private String t_id;
	private String u_id;
	private Timestamp report_date;
	private int main_lec_code;
	private int sub_lec_code;
	private String u_comment;
	private int t_flag;
	public String getT_id() {return t_id;}
	public void setT_id(String t_id) {this.t_id = t_id;}
	
	public String getU_id() {return u_id;}
	public void setU_id(String u_id) {this.u_id = u_id;}
	
	public Timestamp getReport_date() {return report_date;}
	public void setReport_date(Timestamp report_date) {this.report_date = report_date;}
	
	public int getMain_lec_code() {return main_lec_code;}
	public void setMain_lec_code(int main_lec_code) {this.main_lec_code = main_lec_code;}
	
	public int getSub_lec_code() {return sub_lec_code;}
	public void setSub_lec_code(int sub_lec_code) {this.sub_lec_code = sub_lec_code;}
	
	public String getU_comment() {return u_comment;}
	public void setU_comment() {this.u_comment = u_comment;}
	
	public int getT_flag() {return t_flag;}
	public void setT_flag(int t_flag) {this.t_flag = t_flag;}

}
