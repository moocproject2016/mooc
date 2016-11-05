package _dto;

import java.sql.Timestamp;

public class ProgressDTO {
	private int main_lec_code;
	private int sub_lec_code;
	private String u_id;
	private int std_percent;
	private Timestamp std_date;
	private int w_lec_state;
	private Timestamp w_std_date;
	public int getMain_lec_code() {
		return main_lec_code;
	}
	public int getSub_lec_code() {
		return sub_lec_code;
	}
	public String getU_id() {
		return u_id;
	}
	public int getStd_percent() {
		return std_percent;
	}
	public Timestamp getStd_date() {
		return std_date;
	}
	public int getW_lec_state() {
		return w_lec_state;
	}
	public Timestamp getW_std_date() {
		return w_std_date;
	}
	public void setMain_lec_code(int main_lec_code) {
		this.main_lec_code = main_lec_code;
	}
	public void setSub_lec_code(int sub_lec_code) {
		this.sub_lec_code = sub_lec_code;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public void setStd_percent(int std_percent) {
		this.std_percent = std_percent;
	}
	public void setStd_date(Timestamp std_date) {
		this.std_date = std_date;
	}
	public void setW_lec_state(int w_lec_state) {
		this.w_lec_state = w_lec_state;
	}
	public void setW_std_date(Timestamp w_std_date) {
		this.w_std_date = w_std_date;
	}
	
	
}
