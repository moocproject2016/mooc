package _dto;

import java.sql.Timestamp;

public class QnAListDTO {
	private int q_num;
	private String u_id;
	private String q_subject;
	private String q_content;
	private Timestamp q_regdate;
	private String c_content;
	private Timestamp c_regdate;
	
	public int getQ_num() {return q_num;}
	public void setQ_num(int q_num) 
	{	this.q_num = q_num;}
	
	public String getU_id() {return u_id;}
	public void setU_id(String u_id) {this.u_id = u_id;}
	
	public String getQ_subject() {return q_subject;}
	public void setQ_subject(String q_subject) {this.q_subject = q_subject;}
	
	public String getQ_content() {return q_content;}
	public void setQ_content(String q_content) {this.q_content = q_content;}
	
	public Timestamp getQ_regdate() {return q_regdate;}
	public void setQ_regdate(Timestamp q_regdate) {this.q_regdate = q_regdate;}
	
	public String getC_content() {return c_content;}
	public void setC_content(String c_content) {this.c_content = c_content;}
	
	public Timestamp getC_regdate() {return c_regdate;}
	public void setC_regdate(Timestamp c_regdate) {this.c_regdate = c_regdate;}
	
	

}
