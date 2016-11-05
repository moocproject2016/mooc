package _dto;

import java.sql.Timestamp;

public class LecNoticeDTO {
	private int lec_n_num;
	private int main_lec_code;
	private String main_lec_subject;
	private String t_id;
	private int lec_n_type;
	private String lec_n_subject;
	private String lec_n_content;
	private String lec_n_file;
	private Timestamp lec_n_regdate;
	private String searchKey;
	private String searchValue;
	

	public int getLec_n_num() {
		return lec_n_num;
	}
	public int getMain_lec_code() {
		return main_lec_code;
	}
	public String getMain_lec_subject() {
		return main_lec_subject;
	}
	public String getT_id() {
		return t_id;
	}
	public int getLec_n_type() {
		return lec_n_type;
	}
	public String getLec_n_subject() {
		return lec_n_subject;
	}
	public String getLec_n_content() {
		return lec_n_content;
	}
	public String getLec_n_file() {
		return lec_n_file;
	}
	public Timestamp getLec_n_regdate() {
		return lec_n_regdate;
	}
	public String getSearchKey() {
		return searchKey;
	}
	public String getSearchValue() {
		return searchValue;
	}
	
	public void setLec_n_num(int lec_n_num) {
		this.lec_n_num = lec_n_num;
	}
	public void setMain_lec_code(int main_lec_code) {
		this.main_lec_code = main_lec_code;
	}
	public void setMain_lec_subject(String main_lec_subject) {
		this.main_lec_subject = main_lec_subject;
	}
	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	public void setLec_n_type(int lec_n_type) {
		this.lec_n_type = lec_n_type;
	}
	public void setLec_n_subject(String lec_n_subject) {
		this.lec_n_subject = lec_n_subject;
	}
	public void setLec_n_content(String lec_n_content) {
		this.lec_n_content = lec_n_content;
	}
	public void setLec_n_file(String lec_n_file) {
		this.lec_n_file = lec_n_file;
	}
	public void setLec_n_regdate(Timestamp lec_n_regdate) {
		this.lec_n_regdate = lec_n_regdate;
	}
	
	public void setSearchKey(String searchKey) {
		this.searchKey = searchKey;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	
	
}
