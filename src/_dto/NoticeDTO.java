package _dto;

import java.sql.Timestamp;

public class NoticeDTO {
	
	private int notice_num;
	private String notice_subject;
	private int notice_type;
	private String notice_content;
	private String notice_file;
	private Timestamp notice_regdate;
	public int getNotice_num() {
		return notice_num;
	}
	public String getNotice_subject() {
		return notice_subject;
	}
	public int getNotice_type() {
		return notice_type;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public String getNotice_file() {
		return notice_file;
	}
	public Timestamp getNotice_regdate() {
		return notice_regdate;
	}
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}
	public void setNotice_subject(String notice_subject) {
		this.notice_subject = notice_subject;
	}
	public void setNotice_type(int notice_type) {
		this.notice_type = notice_type;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public void setNotice_file(String notice_file) {
		this.notice_file = notice_file;
	}
	public void setNotice_regdate(Timestamp notice_regdate) {
		this.notice_regdate = notice_regdate;
	}
	
	
	
}
