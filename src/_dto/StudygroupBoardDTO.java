package _dto;

import java.sql.Timestamp;

public class StudygroupBoardDTO {

	private int stg_b_num;
	private int stg_code;
	private String stg_b_type;
	private String stg_b_subject;
	private String stg_b_content;
	private String stg_b_data;
	private String u_id;
	private Timestamp stg_b_regdate;
	
  	private String searchBType;
	private String searchBType1;
	private String searchBValue1;
	
	public String getSearchBType() {
		return searchBType;
	}
	public void setSearchBType(String searchBType) {
		this.searchBType = searchBType;
	}
	public String getSearchBType1() {
		return searchBType1;
	}
	public void setSearchBType1(String searchBType1) {
		this.searchBType1 = searchBType1;
	}
	public String getSearchBValue1() {
		return searchBValue1;
	}
	public void setSearchBValue1(String searchBValue1) {
		this.searchBValue1 = searchBValue1;
	}
	
	
	public int getStg_b_num() {
		return stg_b_num;
	}
	public int getStg_code() {
		return stg_code;
	}
	public String getStg_b_type() {
		return stg_b_type;
	}
	public String getStg_b_subject() {
		return stg_b_subject;
	}
	public String getStg_b_content() {
		return stg_b_content;
	}
	public String getStg_b_data() {
		return stg_b_data;
	}
	public String getU_id() {
		return u_id;
	}
	public Timestamp getStg_b_regdate() {
		return stg_b_regdate;
	}
	public void setStg_b_num(int stg_b_num) {
		this.stg_b_num = stg_b_num;
	}
	public void setStg_code(int stg_code) {
		this.stg_code = stg_code;
	}
	public void setStg_b_type(String stg_b_type) {
		this.stg_b_type = stg_b_type;
	}
	public void setStg_b_subject(String stg_b_subject) {
		this.stg_b_subject = stg_b_subject;
	}
	public void setStg_b_content(String stg_b_content) {
		this.stg_b_content = stg_b_content;
	}
	public void setStg_b_data(String stg_b_data) {
		this.stg_b_data = stg_b_data;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public void setStg_b_regdate(Timestamp stg_b_regdate) {
		this.stg_b_regdate = stg_b_regdate;
	}
	



}

