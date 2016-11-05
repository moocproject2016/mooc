package _dto;

import java.sql.Timestamp;

public class mainlectureDTO {
	private int main_lec_code;
	private int sub_ctg_code;
	private String t_id;
	private String main_lec_subject;
	private String main_lec_image;
	private String main_lec_content;
	private Timestamp main_lec_regdate;
	private int main_lec_flag;
	private String u_id;
	private String u_name;
	private String sub_ctg_name;
	private int main_sub_count;
	private Timestamp reg_lec_date;
	
	private int LikeTeacherCount;
	private int LikeLectureCount;
	private int ReviewLecCount;
	
	
	
	public int getReviewLecCount() {
		return ReviewLecCount;
	}
	public void setReviewLecCount(int reviewLecCount) {
		ReviewLecCount = reviewLecCount;
	}
	public int getLikeTeacherCount() {
		return LikeTeacherCount;
	}
	public void setLikeTeacherCount(int likeTeacherCount) {
		LikeTeacherCount = likeTeacherCount;
	}
	public int getLikeLectureCount() {
		return LikeLectureCount;
	}
	public void setLikeLectureCount(int likeLectureCount) {
		LikeLectureCount = likeLectureCount;
	}
	public String getSub_ctg_name() {
		return sub_ctg_name;
	}
	public void setSub_ctg_name(String sub_ctg_name) {
		this.sub_ctg_name = sub_ctg_name;
	}
	public int getMain_sub_count() {
		return main_sub_count;
	}
	public void setMain_sub_count(int main_sub_count) {
		this.main_sub_count = main_sub_count;
	}
	
	public String getU_name() {
		return u_name;
	}
	public void setU_name(String u_name) {
		this.u_name = u_name;
	}
	public void setMain_lec_code(int main_lec_code){this.main_lec_code=main_lec_code;}
	public void setSub_ctg_code(int sub_ctg_code){this.sub_ctg_code=sub_ctg_code;}
	public void setT_id(String t_id){this.t_id=t_id;}
	public void setU_id(String u_id){this.u_id=u_id;}
	public void setMain_lec_subject(String main_lec_subject){this.main_lec_subject=main_lec_subject;}
	public void setMain_lec_image(String main_lec_image){this.main_lec_image=main_lec_image;}
	public void setMain_lec_content(String main_lec_content){this.main_lec_content=main_lec_content;}
	public void setMain_lec_regdate(Timestamp main_lec_regdate){this.main_lec_regdate=main_lec_regdate;}
	public void setMain_lec_flag(int main_lec_flag){this.main_lec_flag=main_lec_flag;}
	public void setReg_lec_date(Timestamp reg_lec_date){this.reg_lec_date=reg_lec_date;}
	
	public int getMain_lec_code(){return main_lec_code;}
	public int getSub_ctg_code(){return sub_ctg_code;}
	public String getT_id(){return t_id;}
	public String getU_id(){return u_id;}
	public String getMain_lec_subject(){return main_lec_subject;}
	public String getMain_lec_image(){return main_lec_image;}
	public String getMain_lec_content(){return main_lec_content;}
	public Timestamp getMain_lec_regdate(){return main_lec_regdate;}
	public int getMain_lec_flag(){return main_lec_flag;}
	public Timestamp getReg_lec_date(){return reg_lec_date;}
			

}
