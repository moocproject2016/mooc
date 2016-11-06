package _dto;

import java.sql.Timestamp;

public class LectureDTO {
	//메인 강의
	private int main_lec_code;
	private int sub_ctg_code;
	private String sub_ctg_name;
	private String t_id;
	private String u_id;
	private String main_lec_subject;
	private String main_lec_image;
	private String main_lec_content;
	private Timestamp main_lec_regdate;
	private int main_lec_flag;
	private Timestamp main_lec_deldate;
	private String u_name;
	
	private int LikeTeacherCount;
	private int LikeLectureCount;
	private int ReviewLecCount;
	private int main_sub_count;
	private int ot_link;
	

	//서브 강의
	private int sub_lec_code;
	private int sub_lec_chapter;
	private String sub_lec_subject;
	private String sub_lec_content;
	private String sub_lec_media;
	private int sub_lec_type;
	private Timestamp sub_lec_regdate;
	private int sub_lec_flag;
	private Timestamp sub_lec_deldate;
	
	//실시간강의
	private String live_lec_date;
	private String live_lec_chat;
	private int live_lec_state;
	
	
	//카운트
	private int lecView_count;
	private int subLec_count;
	
	//진도 
	private int w_lec_state;
	private Timestamp w_lec_date;
	
	public int getMain_lec_code() {
		return main_lec_code;
	}
	public int getSub_ctg_code() {
		return sub_ctg_code;
	}
	public String getSub_ctg_name() {
		return sub_ctg_name;
	}
	public String getT_id() {
		return t_id;
	}
	public String getU_id() {
		return u_id;
	}
	public String getMain_lec_subject() {
		return main_lec_subject;
	}
	public String getMain_lec_image() {
		return main_lec_image;
	}
	public String getMain_lec_content() {
		return main_lec_content;
	}
	public Timestamp getMain_lec_regdate() {
		return main_lec_regdate;
	}
	public int getMain_lec_flag() {
		return main_lec_flag;
	}
	public Timestamp getMain_lec_deldate() {
		return main_lec_deldate;
	}
	public String getU_name() {
		return u_name;
	}
	public int getLikeTeacherCount() {
		return LikeTeacherCount;
	}
	public int getLikeLectureCount() {
		return LikeLectureCount;
	}
	public int getReviewLecCount() {
		return ReviewLecCount;
	}
	public int getMain_sub_count() {
		return main_sub_count;
	}
	public int getOt_link() {
		return ot_link;
	}
	public int getSub_lec_code() {
		return sub_lec_code;
	}
	public int getSub_lec_chapter() {
		return sub_lec_chapter;
	}
	public String getSub_lec_subject() {
		return sub_lec_subject;
	}
	public String getSub_lec_content() {
		return sub_lec_content;
	}
	public String getSub_lec_media() {
		return sub_lec_media;
	}
	public int getSub_lec_type() {
		return sub_lec_type;
	}
	public Timestamp getSub_lec_regdate() {
		return sub_lec_regdate;
	}
	public int getSub_lec_flag() {
		return sub_lec_flag;
	}
	public Timestamp getSub_lec_deldate() {
		return sub_lec_deldate;
	}
	public String getLive_lec_date() {
		return live_lec_date;
	}
	public String getLive_lec_chat() {
		return live_lec_chat;
	}
	public int getLive_lec_state() {
		return live_lec_state;
	}
	public int getLecView_count() {
		return lecView_count;
	}
	public int getSubLec_count() {
		return subLec_count;
	}
	public void setMain_lec_code(int main_lec_code) {
		this.main_lec_code = main_lec_code;
	}
	public void setSub_ctg_code(int sub_ctg_code) {
		this.sub_ctg_code = sub_ctg_code;
	}
	public void setSub_ctg_name(String sub_ctg_name) {
		this.sub_ctg_name = sub_ctg_name;
	}
	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public void setMain_lec_subject(String main_lec_subject) {
		this.main_lec_subject = main_lec_subject;
	}
	public void setMain_lec_image(String main_lec_image) {
		this.main_lec_image = main_lec_image;
	}
	public void setMain_lec_content(String main_lec_content) {
		this.main_lec_content = main_lec_content;
	}
	public void setMain_lec_regdate(Timestamp main_lec_regdate) {
		this.main_lec_regdate = main_lec_regdate;
	}
	public void setMain_lec_flag(int main_lec_flag) {
		this.main_lec_flag = main_lec_flag;
	}
	public void setMain_lec_deldate(Timestamp main_lec_deldate) {
		this.main_lec_deldate = main_lec_deldate;
	}
	public void setU_name(String u_name) {
		this.u_name = u_name;
	}
	public void setLikeTeacherCount(int likeTeacherCount) {
		LikeTeacherCount = likeTeacherCount;
	}
	public void setLikeLectureCount(int likeLectureCount) {
		LikeLectureCount = likeLectureCount;
	}
	public void setReviewLecCount(int reviewLecCount) {
		ReviewLecCount = reviewLecCount;
	}
	public void setMain_sub_count(int main_sub_count) {
		this.main_sub_count = main_sub_count;
	}
	public void setOt_link(int ot_link) {
		this.ot_link = ot_link;
	}
	public void setSub_lec_code(int sub_lec_code) {
		this.sub_lec_code = sub_lec_code;
	}
	public void setSub_lec_chapter(int sub_lec_chapter) {
		this.sub_lec_chapter = sub_lec_chapter;
	}
	public void setSub_lec_subject(String sub_lec_subject) {
		this.sub_lec_subject = sub_lec_subject;
	}
	public void setSub_lec_content(String sub_lec_content) {
		this.sub_lec_content = sub_lec_content;
	}
	public void setSub_lec_media(String sub_lec_media) {
		this.sub_lec_media = sub_lec_media;
	}
	public void setSub_lec_type(int sub_lec_type) {
		this.sub_lec_type = sub_lec_type;
	}
	public void setSub_lec_regdate(Timestamp sub_lec_regdate) {
		this.sub_lec_regdate = sub_lec_regdate;
	}
	public void setSub_lec_flag(int sub_lec_flag) {
		this.sub_lec_flag = sub_lec_flag;
	}
	public void setSub_lec_deldate(Timestamp sub_lec_deldate) {
		this.sub_lec_deldate = sub_lec_deldate;
	}
	public void setLive_lec_date(String live_lec_date) {
		this.live_lec_date = live_lec_date;
	}
	public void setLive_lec_chat(String live_lec_chat) {
		this.live_lec_chat = live_lec_chat;
	}
	public void setLive_lec_state(int live_lec_state) {
		this.live_lec_state = live_lec_state;
	}
	public void setLecView_count(int lecView_count) {
		this.lecView_count = lecView_count;
	}
	public void setSubLec_count(int subLec_count) {
		this.subLec_count = subLec_count;
	}
	public int getW_lec_state() {
		return w_lec_state;
	}
	public Timestamp getW_lec_date() {
		return w_lec_date;
	}
	public void setW_lec_state(int w_lec_state) {
		this.w_lec_state = w_lec_state;
	}
	public void setW_lec_date(Timestamp w_lec_date) {
		this.w_lec_date = w_lec_date;
	}
	
	
}
