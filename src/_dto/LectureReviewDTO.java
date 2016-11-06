package _dto;

import java.sql.Timestamp;

public class LectureReviewDTO {
	
	private int main_lec_code;
	private String u_id;
	private String lec_r_subject;
	private String lec_r_content;
	private float lec_r_score;
	private Timestamp lec_r_regdate;
	private String t_id;
	private String search;
	private String select;
	
	
	
	public String getSearch() {
		return search;
	}
	public String getSelect() {
		return select;
	}
	public void setSearch(String search) {
		this.search = search;
	}
	public void setSelect(String select) {
		this.select = select;
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
	public String getLec_r_subject() {
		return lec_r_subject;
	}
	public void setLec_r_subject(String lec_r_subject) {
		this.lec_r_subject = lec_r_subject;
	}
	public String getLec_r_content() {
		return lec_r_content;
	}
	public void setLec_r_content(String lec_r_content) {
		this.lec_r_content = lec_r_content;
	}
	public float getLec_r_score() {
		return lec_r_score;
	}
	public void setLec_r_score(float lec_r_score) {
		this.lec_r_score = lec_r_score;
	}
	public Timestamp getLec_r_regdate() {
		return lec_r_regdate;
	}
	public void setLec_r_regdate(Timestamp lec_r_regdate) {
		this.lec_r_regdate = lec_r_regdate;
	}
	public String getT_id() {
		return t_id;
	}
	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	
	
}
