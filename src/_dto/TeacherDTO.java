package _dto;

public class TeacherDTO {
	private String t_id;
	private String t_education;
	private String t_certificate;
	private String t_prize;
	private String t_skill;
	private String t_other;
	private int t_flag;
	
	public void setT_id(String t_id){this.t_id=t_id;}
	public void setT_education(String t_education){this.t_education=t_education;}
	public void setT_certificate(String t_certificate){this.t_certificate=t_certificate;}
	public void setT_prize(String t_prize){this.t_prize=t_prize;}
	public void setT_skill(String t_skill){this.t_skill=t_skill;}
	public void setT_other(String t_other){this.t_other=t_other;}
	public void setT_flag(int t_flag){this.t_flag=t_flag;}
	public String getT_id(){return t_id;}
	public String getT_education(){return t_education;}
	public String getT_certificate(){return t_certificate;}
	public String getT_prize(){return t_prize;}
	public String getT_skill(){return t_skill;}
	public String getT_other(){return t_other;}
	public int getT_flage(){return t_flag;}
	
}
