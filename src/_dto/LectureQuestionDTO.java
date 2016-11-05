package _dto;

import java.sql.Timestamp;

public class LectureQuestionDTO {
	private int lec_q_num;
	private int main_lec_code;
	private String u_id;
	private String lec_q_subject;
	private String lec_q_content;
	private Timestamp lec_q_regdate;
	private String lec_c_content;
	private Timestamp lec_c_regdate;
	private String t_id;
	
	public int getLec_q_num() {
		return lec_q_num;
	}
	public void setLec_q_num(int lec_q_num) {
		this.lec_q_num = lec_q_num;
	}
	public int getMain_lec_code() {
		return main_lec_code;
	}
	public void setMain_lec_code(int main_lec_code) {
		this.main_lec_code = main_lec_code;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getLec_q_subject() {
		return lec_q_subject;
	}
	public void setLec_q_subject(String lec_q_subject) {
		this.lec_q_subject = lec_q_subject;
	}
	public String getLec_q_content() {
		return lec_q_content;
	}
	public void setLec_q_content(String lec_q_content) {
		this.lec_q_content = lec_q_content;
	}
	public Timestamp getLec_q_regdate() {
		return lec_q_regdate;
	}
	public void setLec_q_regdate(Timestamp lec_q_regdate) {
		this.lec_q_regdate = lec_q_regdate;
	}
	public String getLec_c_content() {
		return lec_c_content;
	}
	public void setLec_c_content(String lec_c_content) {
		this.lec_c_content = lec_c_content;
	}
	public Timestamp getLec_c_regdate() {
		return lec_c_regdate;
	}
	public void setLec_c_regdate(Timestamp lec_c_regdate) {
		this.lec_c_regdate = lec_c_regdate;
	}
	public String getT_id() {
		return t_id;
	}
	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	
}

