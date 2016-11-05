package _dto;

import java.sql.Timestamp;

public class StudygroupDTO {
	
	private int stg_code;
	private int sub_ctg_code;
	private String u_id;
	private String stg_name;
	private String stg_password;
	private int stg_type;
	private int stg_limit;
	private int stg_count;
	private String stg_purpose;
	private Timestamp stg_regdate;
	private String stg_folder;
	private String sub_ctg_name;
	private String searchType;
	private String searchValue;
	
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	public String getSub_ctg_name() {
		return sub_ctg_name;
	}
	public void setSub_ctg_name(String sub_ctg_name) {
		this.sub_ctg_name = sub_ctg_name;
	}
	
	public int getStg_code() {
		return stg_code;
	}
	public int getSub_ctg_code() {
		return sub_ctg_code;
	}
	public String getU_id() {
		return u_id;
	}
	public String getStg_name() {
		return stg_name;
	}
	public String getStg_password() {
		return stg_password;
	}
	public int getStg_type() {
		return stg_type;
	}
	public int getStg_limit() {
		return stg_limit;
	}

	public int getStg_count() {
		return stg_count;
	}
	public void setStg_count(int stg_count) {
		this.stg_count = stg_count;
	}
	
	public String getStg_purpose() {
		return stg_purpose;
	}
	public Timestamp getStg_regdate() {
		return stg_regdate;
	}
	public String getStg_folder() {
		return stg_folder;
	}
	public void setStg_code(int stg_code) {
		this.stg_code = stg_code;
	}
	public void setSub_ctg_code(int sub_ctg_code) {
		this.sub_ctg_code = sub_ctg_code;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public void setStg_name(String stg_name) {
		this.stg_name = stg_name;
	}
	public void setStg_password(String stg_password) {
		this.stg_password = stg_password;
	}
	public void setStg_type(int stg_type) {
		this.stg_type = stg_type;
	}
	public void setStg_limit(int stg_limit) {
		this.stg_limit = stg_limit;
	}
	public void setStg_purpose(String stg_purpose) {
		this.stg_purpose = stg_purpose;
	}
	public void setStg_regdate(Timestamp stg_regdate) {
		this.stg_regdate = stg_regdate;
	}
	public void setStg_folder(String stg_folder) {
		this.stg_folder = stg_folder;
	}
	
	

	
	
}
