package _dto;

public class LectureNote {
	private int sub_lec_code;
	private int lec_data_code;
	private String lec_data_name;
	private String lec_data_type;
	private String lec_data_path;
	private int page_size;
	public int getPage_size(){
		return page_size;
	}
	public void setPage_size(int page_size){
		this.page_size=page_size;
	}
	public int getSub_lec_code() {
		return sub_lec_code;
	}
	public void setSub_lec_code(int sub_lec_code) {
		this.sub_lec_code = sub_lec_code;
	}
	public int getLec_data_code() {
		return lec_data_code;
	}
	public void setLec_data_code(int lec_data_code) {
		this.lec_data_code = lec_data_code;
	}
	public String getLec_data_name() {
		return lec_data_name;
	}
	public void setLec_data_name(String lec_data_name) {
		this.lec_data_name = lec_data_name;
	}
	public String getLec_data_type() {
		return lec_data_type;
	}
	public void setLec_data_type(String lec_data_type) {
		this.lec_data_type = lec_data_type;
	}
	public String getLec_data_path() {
		return lec_data_path;
	}
	public void setLec_data_path(String lec_data_path) {
		this.lec_data_path = lec_data_path;
	}
}
