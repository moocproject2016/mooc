package _dto;

import java.sql.Timestamp;

public class LikeLecture_joinDTO {
	private String u_id;
	private int main_lec_code;
	private int main_lec_code_1;
	private int sub_ctg_code;
	private String t_id;
	private String main_lec_subject;
	private String main_lec_image;
	private String main_lec_content;
	Timestamp main_lec_regdate;
	
	private String lec_q_content;
	
	private int lec_q_num;
	private String lec_q_subject;
	private Timestamp lec_q_regdate;
	
	
	
	public String getlec_q_content() {
		return lec_q_content;
	}
	public void setlec_q_content(String lec_q_content) {
		this.lec_q_content = lec_q_content;
	}
	public Timestamp getLec_q_regdate() {
		return lec_q_regdate;
	}
	public void setLec_q_regdate(Timestamp lec_q_regdate) {
		this.lec_q_regdate = lec_q_regdate;
	}
	public String getLec_q_subject() {
		return lec_q_subject;
	}
	public void setLec_q_subject(String lec_q_subject) {
		this.lec_q_subject = lec_q_subject;
	}
	public int getLec_q_num() {
		return lec_q_num;
	}
	public void setLec_q_num(int lec_q_num) {
		this.lec_q_num = lec_q_num;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public int getMain_lec_code() {
		return main_lec_code;
	}
	public void setMain_lec_code(int main_lec_code) {
		this.main_lec_code = main_lec_code;
	}
	public int getMain_lec_code_1() {
		return main_lec_code_1;
	}
	public void setMain_lec_code_1(int main_lec_code_1) {
		this.main_lec_code_1 = main_lec_code_1;
	}
	public int getSub_ctg_code() {
		return sub_ctg_code;
	}
	public void setSub_ctg_code(int sub_ctg_code) {
		this.sub_ctg_code = sub_ctg_code;
	}
	public String getT_id() {
		return t_id;
	}
	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	public String getMain_lec_subject() {
		return main_lec_subject;
	}
	public void setMain_lec_subject(String main_lec_subject) {
		this.main_lec_subject = main_lec_subject;
	}
	public String getMain_lec_image() {
		return main_lec_image;
	}
	public void setMain_lec_image(String main_lec_image) {
		this.main_lec_image = main_lec_image;
	}
	public String getMain_lec_content() {
		return main_lec_content;
	}
	public void setMain_lec_content(String main_lec_content) {
		this.main_lec_content = main_lec_content;
	}
	public Timestamp getmain_lec_regdate() {
		return main_lec_regdate;
	}
	public void setmain_lec_regdate(Timestamp main_lec_regdate) {
		this.main_lec_regdate = main_lec_regdate;
	}
	public int getMain_lec_flag() {
		return main_lec_flag;
	}
	public void setMain_lec_flag(int main_lec_flag) {
		this.main_lec_flag = main_lec_flag;
	}
	public Timestamp getMain_lec_deldate() {
		return main_lec_deldate;
	}
	public void setMain_lec_deldate(Timestamp main_lec_deldate) {
		this.main_lec_deldate = main_lec_deldate;
	}
	private int main_lec_flag;
	Timestamp main_lec_deldate;
}
